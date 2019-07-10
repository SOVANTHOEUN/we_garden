package com.wegarden.web.controller;

import com.wegarden.web.model.user.BronzeMasterUsage;
import com.wegarden.web.services.BronzeMasterService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/bronze_master")
public class BronzeMasterController {
    @Autowired
    private BronzeMasterService bronzeMasterService;

    @RequestMapping("/index")
    public String home(ModelMap model){
        return "bronzemaster_view";
    }

    @RequestMapping("/get_bronzemaster_list")
    @ResponseBody
    public Map<String, Object> getBronzeMasterList(@ModelAttribute("START_DATE") String sDate){
        Map<String, Object> response = new HashMap<>();
        List<BronzeMasterUsage> bronzeMasterUsageList = bronzeMasterService.getListReportBronzeMasterUsage(sDate);

        response.put("DATA_REC", bronzeMasterUsageList);
        return response;
    }

}
