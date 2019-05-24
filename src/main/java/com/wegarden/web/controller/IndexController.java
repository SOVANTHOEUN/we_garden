package com.wegarden.web.controller;

import com.wegarden.web.model.CountTotalIncome;
import com.wegarden.web.services.IndexService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/home")
@Controller
public class IndexController {

    @Autowired
    private IndexService indexService;

    @RequestMapping("/count_item")
    @ResponseBody
    public Map<String, Object> countItem(@ModelAttribute("TYPE") String type){
        Map<String, Object> response = new HashMap<>();

        int countOrder           = indexService.countOrder(type);
        int countEmployee    = indexService.countEmployee(type);
        int countStock           = indexService.countStock();
        int countRefrigerator = indexService.countRefrigerator();

        List<CountTotalIncome> totalIncomesObj = indexService.countTotalIncome();
        double totalIncomes   = 0;
        double totalTeaTimeOrder = totalIncomesObj.get(0).getTeaTimeIncome();
        double bronzeMasterOrder  = totalIncomesObj.get(0).getBronzeMasterIncome();
        double totalExpend     = indexService.countTotalExpend();

        double creditIncome     = totalIncomesObj.get(0).getCreditIncome();
        double cashIncome       = totalIncomesObj.get(0).getCashIncome();
        totalIncomes                  = creditIncome + cashIncome;

        response.put("COUNT_ORDER", countOrder);
        response.put("COUNT_EMPLOYEE", countEmployee);
        response.put("COUNT_STOCK", countStock);
        response.put("COUNT_REFRIGERATOR", countRefrigerator);

        response.put("TOTAL_EXPEND", totalExpend);
        response.put("TOTAL_INCOME", totalIncomes);
        response.put("TOTAL_TEATIME_ORDER", totalTeaTimeOrder);
        response.put("TOTAL_BRONZEMASTER_ORDER", bronzeMasterOrder);
        return response;
    }

}