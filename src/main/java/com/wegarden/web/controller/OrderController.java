package com.wegarden.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/order")
public class OrderController {

    @RequestMapping("/select")
    public String home(){
        System.out.println("order is called...");
        return "order_view";
    }
}
