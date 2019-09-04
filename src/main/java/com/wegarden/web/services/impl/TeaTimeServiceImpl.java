package com.wegarden.web.services.impl;

import com.wegarden.web.model.order.TeaTimeUsage;
import com.wegarden.web.model.order.TeaTimeUserListByTeam;
import com.wegarden.web.repositories.TeaTimeRepository;
import com.wegarden.web.services.TeaTimeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TeaTimeServiceImpl implements TeaTimeService {

    @Autowired
    private TeaTimeRepository teaTimeRepository;

    @Override
    public List<TeaTimeUsage> getListReportTeaTimeUsage(String month, String year) {
        return teaTimeRepository.getListReportTeaTimeUsage(month, year);
    }

    @Override
    public String saveTeamTeaTime(String teamName) {
        return teaTimeRepository.saveTeamTeaTime(teamName);
    }

    @Override
    public List<TeaTimeUserListByTeam> getTeamTeaTimeList(String teamUuid) {
        return teaTimeRepository.getTeamTeaTimeList(teamUuid);
    }

    @Override
    public String saveTeamMember(String teamUuid, String userUuid) {
        return teaTimeRepository.saveTeamMember(teamUuid, userUuid);
    }

    @Override
    public String removeTeamMember(String teamUuid, String userUuid) {
        return teaTimeRepository.removeTeamMember(teamUuid, userUuid);
    }

    @Override
    public String removeTeamTeaTime(String teamUuid) {
        return teaTimeRepository.removeTeamTeaTime(teamUuid);
    }

    @Override
    public String updateTeaTimeLeader(String teamUuid, String userUuid) {
        return teaTimeRepository.updateTeaTimeLeader(teamUuid, userUuid);

    }
}
