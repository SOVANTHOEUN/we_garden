package com.wegarden.web.controller;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.services.IndexService;
import com.wegarden.web.services.OrderService;
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
//        int countTeaTimeOrder = indexService.();

        response.put("COUNT_ORDER", countOrder);
        response.put("COUNT_EMPLOYEE", countEmployee);
        response.put("COUNT_STOCK", countStock);
        response.put("COUNT_REFRIGERATOR", countRefrigerator);
        return response;
    }

}