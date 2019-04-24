package com.wegarden.web.controller;

import com.wegarden.web.model.user.User;
import com.wegarden.web.services.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/users")
public class UsersController {
    @Autowired
    private UsersService usersService;

    @RequestMapping("/select")
    public String home(){
        System.out.println("users is called");
        return "users_view";
    }

    @RequestMapping("/get_user_list")
    @ResponseBody
    public Map<String, Object> getUsersList(@ModelAttribute("LIMIT") int limit, @ModelAttribute("PAGE_NO") int page_no, @ModelAttribute("SRCH_WD") String srch_wd){
        Map<String, Object> response = new HashMap<>();
        String user_uuid = ""; // get from view soon
        String status       = ""; // get from view soon
        List<User> userList = usersService.getUsersList(limit, page_no, srch_wd);

        System.out.println("limit: "+limit+" & page: "+page_no);
        response.put("DATA_REC", userList);
        response.put("CNT_REC", usersService.countUsers(user_uuid, srch_wd, status));
        return response;
    }
}
