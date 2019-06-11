package com.wegarden.web.services.impl;

import com.wegarden.web.model.user.Team;
import com.wegarden.web.model.user.User;
import com.wegarden.web.repositories.UsersRepository;
import com.wegarden.web.services.UsersService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsersServiceImpl implements UsersService {

    @Autowired
    private UsersRepository usersRepository;

    @Override
    public List<User> getUsersList(int limit, int page, String srch_wd, String userUuid) {
        return usersRepository.getUsersList(limit, page, srch_wd, userUuid);
    }

    @Override
    public int countUsers(String user_uuid, String srch_wd, String status) {
        return usersRepository.countUsers(user_uuid, srch_wd, status);
    }

    @Override
    public String userUpdateBalance(String userUuid, String transactionType, Double transactionAmount) {
        return usersRepository.userUpdateBalance(userUuid, transactionType, transactionAmount);
    }

    @Override
    public String updateUserRole(String roleId, String userUuid) {
        return usersRepository.updateUserRole(roleId,userUuid);
    }

    @Override
    public List<Team> readTeam(String status) {
        return null;
    }
}
