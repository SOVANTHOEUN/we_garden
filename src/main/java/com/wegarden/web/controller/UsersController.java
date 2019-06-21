package com.wegarden.web.controller;

import com.wegarden.web.model.user.RoleType;
import com.wegarden.web.model.user.User;
import com.wegarden.web.services.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
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
    public String home(ModelMap model){
        model.addAttribute("data",usersService.readTeam(""));
        System.out.println("data....."+usersService.readTeam(""));
        return "users_view";
    }

    @RequestMapping("/get_user_list")
    @ResponseBody
    public Map<String, Object> getUsersList(@ModelAttribute("LIMIT") int limit, @ModelAttribute("PAGE_NO") int page_no,
                                            @ModelAttribute("SRCH_WD") String srch_wd, @ModelAttribute("USER_UUID") String userUuid){
        Map<String, Object> response = new HashMap<>();
        String status       = "1"; // get from view soon
        List<User> userList = usersService.getUsersList(limit, page_no, srch_wd, userUuid);

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


    @RequestMapping("/update_user_role")
    @ResponseBody
    public String updateUserRoles(@ModelAttribute("ROLE_ID") String roleId, @ModelAttribute("USER_UUID") String userUuid) {
        Map<String, Object> response = new HashMap<>();

        System.out.println("roleId:: "+roleId);
        System.out.println("userUuid:: "+userUuid);
        String actionCode =  usersService.updateUserRole(roleId,userUuid);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }
       return actionCode;
    }

    @RequestMapping("/update_user_team")
    @ResponseBody
    public Map<String, Object> updateUserTeam(@ModelAttribute("team_uuid") String teamUuId, @ModelAttribute("user_uuid") String userUuid) {


        System.out.println("teamUuId:"+teamUuId);
        System.out.println("userUuid:"+userUuid);


        Map<String, Object> response = new HashMap<>();
        String actionCode =  usersService.updateUserTeam(teamUuId,userUuid);
        if (actionCode.equals("00000")){
            response.put("status",true);
        }else {
            response.put("status",false);
        }
        System.out.println(response);
        return response;
    }

    @RequestMapping("/get_user_total_credit")
    @ResponseBody
    public Map<String, Object> getUserTotalCredit() {
        Double remaining_credit =  usersService.getUserTotalCredit();
        Map<String, Object> response = new HashMap<>();

        response.put("REMAINING_CREDIT", remaining_credit);
        return response;
    }

}
