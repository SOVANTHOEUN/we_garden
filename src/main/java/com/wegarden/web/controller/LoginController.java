package com.wegarden.web.controller;

import com.wegarden.web.model.userData.User;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class LoginController {
    @PostMapping("/login/submit")
    public String loginSumit(@ModelAttribute User user) {
        User getUser = new User();

        if (user.getStatus()==true) {

            Authentication auth = new UsernamePasswordAuthenticationToken(getUser, null, null);
            SecurityContextHolder.getContext().setAuthentication(auth);
            return "redirect:/";
        }
        else
            return "redirect:/";
    }
}
