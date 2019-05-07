package com.wegarden.web.controller;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;

    @RequestMapping("/select")
    public String home(){
        System.out.println("order is called...");
        return "order_view";
    }

    @RequestMapping("/get_order_list")
    @ResponseBody
    public Map<String, Object> getStockList(){
        Map<String, Object> response = new HashMap<>();

        List<Order> orderList = orderService.getOrderList();
        response.put("DATA_REC", orderList);
        return response;
    }
}