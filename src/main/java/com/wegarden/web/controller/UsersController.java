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
    public Map<String, Object> getUsersList(@ModelAttribute("LIMIT") int limit, @ModelAttribute("PAGE_NO") int page_no,
                                            @ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("USER_UUID") String userUuid){
        Map<String, Object> response = new HashMap<>();
        String status       = ""; // get from view soon
        List<User> userList = usersService.getUsersList(limit, page_no, srch_wd, userUuid);

        System.out.println("limit: "+limit+" & page: "+page_no);
        response.put("DATA_REC", userList);
        response.put("CNT_REC", usersService.countUsers(userUuid, srch_wd, status));
        return response;
    }

    @RequestMapping("/user_update_balance")
    @ResponseBody
    public Map<String, Object> updateBalance(@ModelAttribute("TRANSACTION_AMOUNT") Double transactionAmount, @ModelAttribute("TRANSACTION_TYPE") String transactionType,
                                             @ModelAttribute("USER_UUID") String userUuid){
        Map<String, Object> response = new HashMap<>();

        String actionCode = usersService.userUpdateBalance(userUuid, transactionType, transactionAmount);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }
        return response;
    }
}
