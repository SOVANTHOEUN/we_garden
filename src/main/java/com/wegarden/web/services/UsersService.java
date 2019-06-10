package com.wegarden.web.services;

import com.wegarden.web.model.user.User;

import java.util.List;

public interface UsersService {
    List<User> getUsersList(int limit, int page, String srch_wd, String userUuid);
    int countUsers(String user_uuid, String srch_wd, String status);
    String userUpdateBalance(String userUuid, String transactionType, Double transactionAmount);
    String updateUserRole(String roleId, String userUuid);
}
