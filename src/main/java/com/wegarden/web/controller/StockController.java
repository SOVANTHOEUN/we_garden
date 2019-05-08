package com.wegarden.web.controller;

import com.wegarden.web.model.stock.StockReport;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.model.stock.StockReportOut;
import com.wegarden.web.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@Controller
@RequestMapping("/stock")
public class StockController {
    @Autowired
    private StockService stockService;

    @RequestMapping("/index")
    public String home(){
        System.out.println("stock is called...");
        return "stock_view";
    }

    @RequestMapping("/get_stock_list")
    @ResponseBody
    public Map<String, Object> getStockList(@ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("PRO_UUID") String pro_uuid){
        Map<String, Object> response = new HashMap<>();
        String status       = "1"; // get from view
        List<Stock> userList = stockService.getStockList(srch_wd, status, pro_uuid);
        System.out.println("stock list is called...");
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
            Integer stockAmt = (Integer)objItem.get("STOCK_AMT");
            String proPriceStr = (String)objItem.get("PRO_PRICE");
            double proPrice   = Double.parseDouble(proPriceStr);
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

}
