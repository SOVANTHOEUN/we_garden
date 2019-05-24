package com.wegarden.web.controller;

import com.wegarden.web.model.stock.ExcelGenerator;
import com.wegarden.web.model.stock.Refrigerator;
import com.wegarden.web.services.RefrigeratorService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.Array;
import java.util.*;
import java.util.function.Function;

@Controller
@RequestMapping("/refrigerator")
public class RefrigeratorController {
    @Autowired
    private RefrigeratorService refrigeratorService;

    String startDate;
    String endDate;

    @RequestMapping("/index")
    public String home() {
        System.out.println("refrigerator is called...");
        return "refrigerator_view";
    }

    @RequestMapping("/get_refrigerator_list")
    @ResponseBody
    public Map<String, Object> getUsersList(@ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("PRO_UUID") String pro_uuid) {
        Map<String, Object> response = new HashMap<>();
        String status = "1"; // get from view soon
        List<Refrigerator> refrigList = refrigeratorService.getRefrigeratorList(srch_wd, status, pro_uuid);
        response.put("DATA_REC", refrigList);
        return response;
    }

    @PostMapping("/refrigerator_save")
    @ResponseBody
    public Map<String, Object> saveQty(@RequestBody HashMap<String, Object> inRec) {
        Map<String, Object> response = new HashMap<>();
        ArrayList arrIn = (ArrayList) inRec.get("IN_REC");
        String actionCode = "";

        for (int i = 0; i < arrIn.size(); i++) {

            System.out.println( "hththth"+arrIn.size());
            HashMap objItem = (HashMap) arrIn.get(i);
            String proUuid = (String) objItem.get("PRO_UUID");
            Integer stockAmt = (Integer) objItem.get("REFRI_AMT");
            actionCode = refrigeratorService.saveQty(proUuid, stockAmt);
        }

        if (actionCode.equals("00000")) {
            response.put("status", true);
        } else {
            response.put("status", false);
        }

        return response;
    }


    @RequestMapping("/get_report_refrigerator_list")
    @ResponseBody
    public Map<String, Object> getReportStockList(@ModelAttribute("START_DATE") String sDate, @ModelAttribute("END_DATE") String eDate) {
        Map<String, Object> response = new HashMap<>();
        System.out.println("sDate::: " + sDate);
        System.out.println("eDate::: " + eDate);
        startDate=sDate;
        endDate=eDate;

        List<Refrigerator> userList = refrigeratorService.getReportRefrigerator(sDate, eDate);
        response.put("DATA_REC", userList);
        return response;
    }



    @GetMapping(value = "/download")
    public ResponseEntity<InputStreamResource> excelCustomersReport () throws IOException {
        List<Refrigerator> userList = refrigeratorService.getReportRefrigerator(startDate, endDate);
        String[] header             = {"ITEMS", "UNIT-PRICE", "IN-STOCK"};
        List<String[]> list         = new ArrayList<>();

        for (int i = 0;i < userList.size();i++){
            String[] arr = {
                    userList.get(i).productName.toString(),
                    "$"+userList.get(i).productPrice.toString(),
                    userList.get(i).stockInQuantity.toString()};
            list.add(arr);
        }

        ByteArrayInputStream in = ExcelGenerator.customersToExcel(list,header);
        // return IOUtils.toByteArray(in);

        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=Report_WeGaden_in.xlsx");
        return ResponseEntity
                .ok()
                .headers(headers)
                .body(new InputStreamResource(in));
    }

}
