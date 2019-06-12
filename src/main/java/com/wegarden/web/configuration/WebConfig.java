package com.wegarden.web.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.*;

@Configuration
public class WebConfig extends WebMvcConfigurerAdapter implements WebMvcConfigurer {

    @Override
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/login").setViewName("login");
        registry.addViewController("/order/select").setViewName("order_view");
        registry.addViewController("/product/index").setViewName("product_index");
        registry.addViewController("/stock/index").setViewName("stock_index");
        registry.addViewController("/refrigerator/index").setViewName("refrigerator_view");
        registry.addViewController("/users/select/").setViewName("user_view");
    }

    @Override
     public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry
                .addResourceHandler("/resources/**")
                .addResourceLocations("classpath:/static/");
    }

}
