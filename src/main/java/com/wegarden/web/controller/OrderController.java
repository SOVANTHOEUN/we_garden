package com.wegarden.web.controller;

import com.wegarden.web.model.order.Order;
import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.UserOrder;
import com.wegarden.web.model.stock.Stock;
import com.wegarden.web.services.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RequestMapping("/order")
@Controller
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
    public Map<String, Object> getOrderList(){
        Map<String, Object> response = new HashMap<>();

        List<Order> orderList = orderService.getOrderList();
        response.put("DATA_REC", orderList);
        return response;
    }

    @RequestMapping("/user_order")
    @ResponseBody
    public Map<String, Object> getUserOrderList(@ModelAttribute("USER_UUID") String userUuid){
        Map<String, Object> response = new HashMap<>();

        List<UserOrder> userOrderList = orderService.getUserOrderList(userUuid);
        response.put("DATA_REC", userOrderList);
        return response;
    }

    @RequestMapping("/order_detail_list")
    @ResponseBody
    public Map<String, Object> getOrderDetailList(@ModelAttribute("ORDER_UUID") String orderUuid){
        Map<String, Object> response = new HashMap<>();

        List<OrderDetail> orderDetailsList = orderService.getOrderDetailList(orderUuid);
        response.put("DATA_REC", orderDetailsList);
        return response;
    }

    @PostMapping("/order_pay_money")
    @ResponseBody
    public Map<String, Object> payOrderItem(@RequestBody HashMap<String, Object> inRec){
        Map<String, Object> response = new HashMap<>();
        ArrayList arrIn = (ArrayList)inRec.get("IN_REC");
        String actionCode = "";

        for(int i = 0; i <= arrIn.size()-1; i++){
            HashMap  objItem = (HashMap)arrIn.get(i);
            String orderUuid      = (String)objItem.get("ORDER_UUID");
            actionCode = orderService.payOrderItem(orderUuid);
        }

        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }

        return response;
    }

}