package com.wegarden.web.model.user;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class ReadTeam {
    @Id
    @JsonProperty("team_uuid")
    String teamUuid;
    @JsonProperty("team_name")
    String teamName;
    @JsonProperty("team_remark")
    String teamRemark;
    @JsonProperty("team_leader")
    String teamLeader;
    @JsonProperty("team_status")
    String teamStatus;
    @JsonProperty("department_uuid")
    String departmentUuid;
    @JsonProperty("department_name")
    String departmentName;
    @JsonProperty("department_remark")
    String departmentRemark;
    @JsonProperty("department_first_manager")
    String departmentFirstManager;
    @JsonProperty("department_second_manager")
    String departmentSecondManager;
    @JsonProperty("department_status")
    String departmentStatus;

    public ReadTeam(String teamUuid, String teamName, String teamRemark, String teamLeader, String teamStatus, String departmentUuid, String departmentName, String departmentRemark, String departmentFirstManager, String departmentSecondManager, String departmentStatus) {
        this.teamUuid = teamUuid;
        this.teamName = teamName;
        this.teamRemark = teamRemark;
        this.teamLeader = teamLeader;
        this.teamStatus = teamStatus;
        this.departmentUuid = departmentUuid;
        this.departmentName = departmentName;
        this.departmentRemark = departmentRemark;
        this.departmentFirstManager = departmentFirstManager;
        this.departmentSecondManager = departmentSecondManager;
        this.departmentStatus = departmentStatus;
    }

    public ReadTeam() {
    }

    public String getTeamUuid() {
        return teamUuid;
    }

    public void setTeamUuid(String teamUuid) {
        this.teamUuid = teamUuid;
    }

    public String getTeamName() {
        return teamName;
    }

    public void setTeamName(String teamName) {
        this.teamName = teamName;
    }

    public String getTeamRemark() {
        return teamRemark;
    }

    public void setTeamRemark(String teamRemark) {
        this.teamRemark = teamRemark;
    }

    public String getTeamLeader() {
        return teamLeader;
    }

    public void setTeamLeader(String teamLeader) {
        this.teamLeader = teamLeader;
    }

    public String getTeamStatus() {
        return teamStatus;
    }

    public void setTeamStatus(String teamStatus) {
        this.teamStatus = teamStatus;
    }

    public String getDepartmentUuid() {
        return departmentUuid;
    }

    public void setDepartmentUuid(String departmentUuid) {
        this.departmentUuid = departmentUuid;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getDepartmentRemark() {
        return departmentRemark;
    }

    public void setDepartmentRemark(String departmentRemark) {
        this.departmentRemark = departmentRemark;
    }

    public String getDepartmentFirstManager() {
        return departmentFirstManager;
    }

    public void setDepartmentFirstManager(String departmentFirstManager) {
        this.departmentFirstManager = departmentFirstManager;
    }

    public String getDepartmentSecondManager() {
        return departmentSecondManager;
    }

    public void setDepartmentSecondManager(String departmentSecondManager) {
        this.departmentSecondManager = departmentSecondManager;
    }

    public String getDepartmentStatus() {
        return departmentStatus;
    }

    public void setDepartmentStatus(String departmentStatus) {
        this.departmentStatus = departmentStatus;
    }

    @Override
    public String toString() {
        return "ReadTeam{" +
                "teamUuid='" + teamUuid + '\'' +
                ", teamName='" + teamName + '\'' +
                ", teamRemark='" + teamRemark + '\'' +
                ", teamLeader='" + teamLeader + '\'' +
                ", teamStatus='" + teamStatus + '\'' +
                ", departmentUuid='" + departmentUuid + '\'' +
                ", departmentName='" + departmentName + '\'' +
                ", departmentRemark='" + departmentRemark + '\'' +
                ", departmentFirstManager='" + departmentFirstManager + '\'' +
                ", departmentSecondManager='" + departmentSecondManager + '\'' +
                ", departmentStatus='" + departmentStatus + '\'' +
                '}';
    }
}
