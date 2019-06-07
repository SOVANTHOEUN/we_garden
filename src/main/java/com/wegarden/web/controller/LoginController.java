package com.wegarden.web.controller;

import com.wegarden.web.model.userData.Role;
import com.wegarden.web.model.userData.User;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class LoginController {
    @PostMapping("/login/submit")
    public String loginSumit(@ModelAttribute User user) {
            if (user.getStatus()==true && user.getRole().equals("ADMIN") ) {
                Authentication auth = new UsernamePasswordAuthenticationToken(user, null, null);
               // System.out.println(auth.getPrincipal()+"auth.getPrincipal()");
                SecurityContextHolder.getContext().setAuthentication(auth);
                return "redirect:/";
            }
            else
                return "redirect:/";

    }

    @GetMapping("/login")
    public String logint() {
       return "login";
    }
}


