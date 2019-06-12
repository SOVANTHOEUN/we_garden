package com.wegarden.web.controller;

import com.wegarden.web.model.stock.*;
import com.wegarden.web.services.StockService;
import com.wegarden.web.util.ExcelGenerator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.*;

@Controller
@RequestMapping("/stock")
public class StockController {
    @Autowired
    private StockService stockService;
    String startDate;
    String endDate;

    @RequestMapping("/index")
    public String home(){
        return "stock_view";
    }

    @RequestMapping("/get_stock_list")
    @ResponseBody
    public Map<String, Object> getStockList(@ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("PRO_UUID") String pro_uuid){
        Map<String, Object> response = new HashMap<>();
        String status       = "1"; // get from view
        List<Stock> userList = stockService.getStockList(srch_wd, status, pro_uuid);
        response.put("DATA_REC", userList);
        return response;
    }

    @PostMapping("/stock_save_pro_amount")
    @ResponseBody
    public Map<String, Object> saveProductAmount(@RequestBody HashMap<String, Object> inRec){
        Map<String, Object> response = new HashMap<>();
        ArrayList arrIn = (ArrayList)inRec.get("IN_REC");
        String actionCode = "";

        for(int i = 0; i < arrIn.size()-1; i++){
            HashMap  objItem = (HashMap)arrIn.get(i);
            String proUuid      = (String)objItem.get("PRO_UUID");
            String stockAmtStr = (String) objItem.get("STOCK_AMT");
            String proPriceStr   = (String)objItem.get("PRO_PRICE");
            double proPrice    = Double.parseDouble(proPriceStr);
            double stockAmt   = Double.parseDouble(stockAmtStr);
            actionCode = stockService.saveProductAmt(proUuid,stockAmt, proPrice);
        }

        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

    @RequestMapping("/save_refrigerator_amount")
    @ResponseBody
    public Map<String, Object> saveRefrigeratorAmount(@ModelAttribute("PRO_UUID") String proUuid, @ModelAttribute("QUANTITY") Integer quantity){
        Map<String, Object> response = new HashMap<>();

        String actionCode = stockService.saveRefrigeratorAmt(proUuid, quantity);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

    @RequestMapping("/get_report_stockin_list")
    @ResponseBody
    public Map<String, Object> getReportStockInList(@ModelAttribute("START_DATE") String sDate, @ModelAttribute("END_DATE") String eDate){
        Map<String, Object> response = new HashMap<>();
        startDate = sDate;
        endDate    = eDate;

        List<StockReport> userList = stockService.getReportStockInList(sDate, eDate);
        response.put("DATA_REC", userList);
        return response;
    }

    @RequestMapping("/get_report_stockout_list")
    @ResponseBody
    public Map<String, Object> getReportStockOutList(@ModelAttribute("START_DATE") String sDate, @ModelAttribute("END_DATE") String eDate){
        Map<String, Object> response = new HashMap<>();

        List<StockReportOut> userList = stockService.getReportStockOutList(sDate, eDate);
        response.put("DATA_REC", userList);
        return response;
    }

    @GetMapping(value = "/download")
    public ResponseEntity<InputStreamResource> excelCustomersReport () throws IOException {
        List<StockReport> stockInList = stockService.getReportStockInList(startDate, endDate);
        String[] header             = { "ITEMS", "UNIT PRICE", "IN-STOCK", "EXPENSE" };
        List<String[]> list         = new ArrayList<>();
        for (int i = 0;i < stockInList.size();i++){
            String unitPriceStr         = stockInList.get(i).getProductPrice().toString();
            String stockExpenseStr  = stockInList.get(i).getStockInExpend().toString();
            BigDecimal stockExpense    = new BigDecimal(stockExpenseStr).setScale(5, RoundingMode.HALF_EVEN);
            BigDecimal unitPrice            = new BigDecimal(unitPriceStr).setScale(5, RoundingMode.HALF_EVEN);
            String[] arr = {
                    stockInList.get(i).getProductName().toString(),
                    "$"+unitPrice.setScale(2, BigDecimal.ROUND_HALF_DOWN).toString(),
                    stockInList.get(i).getStockInQuantity().toString(),
                    "$"+stockExpense.setScale(2, BigDecimal.ROUND_HALF_DOWN).toString()};
            list.add(arr);
        }
        ByteArrayInputStream in = ExcelGenerator.customersToExcel(list,header);
        // return IOUtils.toByteArray(in);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=WeGaden_INSTOCK.xlsx");
        return ResponseEntity
                .ok()
                .headers(headers)
                .body(new InputStreamResource(in));
    }

}
