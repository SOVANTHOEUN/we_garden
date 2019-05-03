package com.wegarden.web.controller;

import com.wegarden.web.model.stock.Refrigerator;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.services.RefrigeratorService;
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
@RequestMapping("/refrigerator")
public class RefrigeratorController {
    @Autowired
    private RefrigeratorService refrigeratorService;

    @RequestMapping("/index")
    public String home(){
        System.out.println("refrigerator is called...");
        return "refrigerator_view";
    }

    @RequestMapping("/get_refrigerator_list")
    @ResponseBody
    public Map<String, Object> getUsersList(@ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("PRO_UUID") String pro_uuid){
        Map<String, Object> response = new HashMap<>();
        String status       = "1"; // get from view soon
        List<Stock> refrigList = refrigeratorService.getRefrigeratorList(srch_wd, status, pro_uuid);

        response.put("DATA_REC", refrigList);
        return response;
    }

}
