package com.wegarden.web.controller;

import com.wegarden.web.model.order.OrderDetail;
import com.wegarden.web.model.order.TeaTimeUsage;
import com.wegarden.web.model.user.User;
import com.wegarden.web.services.OrderService;
import com.wegarden.web.services.TeaTimeService;
import com.wegarden.web.services.UsersService;
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
@RequestMapping("/teatime")
public class TeaTimeController {
    @Autowired
    private TeaTimeService teaTimeService;
    @Autowired
    private UsersService usersService;
    @Autowired
    private OrderService orderService;


    @RequestMapping("/index")
    public String home(ModelMap model){
        return "teatime_view";
    }

    @RequestMapping("/get_teatime_list")
    @ResponseBody
    public Map<String, Object> getUsersList(@ModelAttribute("MONTH") String month, @ModelAttribute("YEAR") String year){
        Map<String, Object> response = new HashMap<>();
        List<TeaTimeUsage> teaTimeUsageList = teaTimeService.getListReportTeaTimeUsage(month, year);

        response.put("DATA_REC", teaTimeUsageList);
        return response;
    }

    @RequestMapping("/get_user_order_list")
    @ResponseBody
    public Map<String, Object> getUserOrderDetail(@ModelAttribute("TEAM_UUID") String teamUuid, @ModelAttribute("ORDER_UUID") String orderUuid){
        Map<String, Object> response = new HashMap<>();
        List<User> userDetailList           = usersService.getUsersList("", teamUuid, "", 1, 20);
        List<OrderDetail> orderDetailsList  = orderService.getOrderDetailList(orderUuid);


        response.put("DATA_USER_REC",  userDetailList);
        response.put("DATA_ORDER_REC", orderDetailsList);
        return response;
    }

}
