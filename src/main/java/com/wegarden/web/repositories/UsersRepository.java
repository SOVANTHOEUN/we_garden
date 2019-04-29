package com.wegarden.web.repositories;


import com.wegarden.web.model.user.User;

import java.util.List;

public interface UsersRepository {
    List<User> getUsersList(int limit, int page, String srch_wd, String userUuid);
    int countUsers(String user_uuid, String srch_wd, String status);

}
