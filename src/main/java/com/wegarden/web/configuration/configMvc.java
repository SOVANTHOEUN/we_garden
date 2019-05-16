package com.wegarden.web.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

 @Configuration
public class configMvc extends WebMvcConfigurerAdapter {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/login").setViewName("login");
        //registry.addViewController("/logout").setViewName("logout");
    }

     public void addResourceHandlers(ResourceHandlerRegistry registry) {
         registry
                 .addResourceHandler("/resources/**")
                 .addResourceLocations("/resources/");
     }
}
