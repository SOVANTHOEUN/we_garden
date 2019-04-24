package com.wegarden.web.controller;

import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.services.StockService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/stock")
public class StockController {
    @Autowired
    private StockService stockService;

    @RequestMapping("/select")
    public String home(){
        System.out.println("stock is called...");
        return "stock_view";
    }

    @RequestMapping("/get_stock_lists")
    @ResponseBody
    public Map<String, Object> getUsersList(@ModelAttribute("SRCH_WD") String srch_wd){
        Map<String, Object> response = new HashMap<>();
        System.out.println("hiiiii; "+srch_wd);
        String status       = "1"; // get from view soon
        List<Stock> userList = stockService.getStocksList(srch_wd, status);

        response.put("DATA_REC", userList);
        return response;
    }
}
