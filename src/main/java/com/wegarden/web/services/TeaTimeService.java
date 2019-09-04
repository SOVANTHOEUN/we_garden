package com.wegarden.web.services;

import com.wegarden.web.model.order.TeaTimeUsage;
import com.wegarden.web.model.order.TeaTimeUserListByTeam;

import java.util.List;

public interface TeaTimeService {
    List<TeaTimeUsage> getListReportTeaTimeUsage(String month, String year);
    String saveTeamTeaTime(String teamName);
    List<TeaTimeUserListByTeam> getTeamTeaTimeList(String teamUuid);
    String saveTeamMember(String teamUuid, String userUuid);
    String removeTeamMember(String teamUuid, String userUuid);
    String updateTeaTimeLeader(String teamUuid, String userUuid);
    String removeTeamTeaTime(String teamUuid);
}
