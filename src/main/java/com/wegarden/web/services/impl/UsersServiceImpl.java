package com.wegarden.web.services.impl;

import com.wegarden.web.model.user.ReadTeam;
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
    public List<User> getUsersList(String userUuid, String teamUuid, String srch_wd, int page_no, int limit) {
        return usersRepository.getUsersList(userUuid, teamUuid, srch_wd, page_no, limit);
    }

    @Override
    public int countUsers(String userUuid, String teamUuid, String srch_wd, String status) {
        return usersRepository.countUsers(userUuid, teamUuid, srch_wd, status);
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
    public List<ReadTeam> readTeam(String status)
    {
        return usersRepository.readTeam(status);
    }

    @Override
    public String updateUserTeam(String teamUuid, String userUuid) {
        return usersRepository.updateUserTeam(teamUuid,userUuid);
    }

    @Override
    public Double getUserTotalCredit() {
        return usersRepository.getUserTotalCredit();
    }
}
