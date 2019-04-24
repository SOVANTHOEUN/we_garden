package com.wegarden.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/test")
public class testContronller {

    @RequestMapping("/index")
    public String home(){
        System.out.println("JHello");
        return "index";
    }


}
