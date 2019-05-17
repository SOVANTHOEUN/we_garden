package com.wegarden.web.configuration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.web.authentication.logout.LogoutSuccessHandler;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;


@EnableWebSecurity
@Configuration
public class SecurityConfig extends WebSecurityConfigurerAdapter implements ApplicationContextAware {


   @Autowired
   private LogoutSuccessHandler logoutSuccessHandler;

   @Override
    public void configure(WebSecurity web) throws Exception {
        web
                .ignoring()
                .antMatchers("/js/**","/css/**","/fonts/**","/images/**"); // #3
    }

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
                .csrf().disable()
                 .authorizeRequests()
                 .antMatchers(  "/login/**").permitAll()
                 .anyRequest().authenticated()
                 .and()
                .formLogin()
                .loginPage("/login");

        http.logout()
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessHandler(logoutSuccessHandler);





//        http.logout().logoutSuccessUrl("/login");
//                .defaultSuccessUrl("/",true)
////                .loginPage("/login")
//                .permitAll()
//                .and()
//                .logout()
//                .permitAll();
    }

}
