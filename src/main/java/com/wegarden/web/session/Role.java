package com.wegarden.web.session;

import org.springframework.security.core.GrantedAuthority;

public class Role implements GrantedAuthority {
    private Integer name;

    public Role() {
    }

    public Role(Integer name) {
        this.name = name;
    }

    @Override
    public String getAuthority() {
        return "ROLE_"+name;
    }

    public Integer getName() {
        return name;
    }

    public void setName(Integer name) {
        this.name = name;
    }
}
