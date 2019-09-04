package com.wegarden.web.model.order;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;

@Entity
public class TeaTimeUsage {
    @Id
    @JsonProperty("team_uuid")
    private String teamUuid;

    @JsonProperty("team_name")
    private String teamName;

    @JsonProperty("team_member_count")
    private Integer teamMemberCount;

    @JsonProperty("team_leader_uuid")
    private String teamLeaderUuid;

    @JsonProperty("team_leader_name")
    private String teamLeaderName;

    @JsonProperty("tea_time_usage")
    private Boolean teaTimeUsage;

    @JsonProperty("order_uuid")
    private String orderUuid;

    @JsonProperty("order_subtotal")
    private Double orderSubtotal;

    public TeaTimeUsage(){  }

    public TeaTimeUsage(String teamUuid, String teamName, Integer teamMemberCount, String teamLeaderUuid, String teamLeaderName, Boolean teaTimeUsage, String orderUuid, Double orderSubtotal) {
        this.teamUuid = teamUuid;
        this.teamName = teamName;
        this.teamMemberCount = teamMemberCount;
        this.teamLeaderUuid = teamLeaderUuid;
        this.teamLeaderName = teamLeaderName;
        this.teaTimeUsage = teaTimeUsage;
        this.orderUuid = orderUuid;
        this.orderSubtotal = orderSubtotal;
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

    public Integer getTeamMemberCount() {
        return teamMemberCount;
    }

    public void setTeamMemberCount(Integer teamMemberCount) {
        this.teamMemberCount = teamMemberCount;
    }

    public String getTeamLeaderUuid() {
        return teamLeaderUuid;
    }

    public void setTeamLeaderUuid(String teamLeaderUuid) {
        this.teamLeaderUuid = teamLeaderUuid;
    }

    public String getTeamLeaderName() {
        return teamLeaderName;
    }

    public void setTeamLeaderName(String teamLeaderName) {
        this.teamLeaderName = teamLeaderName;
    }

    public Boolean getTeaTimeUsage() {
        return teaTimeUsage;
    }

    public void setTeaTimeUsage(Boolean teaTimeUsage) {
        this.teaTimeUsage = teaTimeUsage;
    }

    public String getOrderUuid() {
        return orderUuid;
    }

    public void setOrderUuid(String orderUuid) {
        this.orderUuid = orderUuid;
    }

    public Double getOrderSubtotal() {
        return orderSubtotal;
    }

    public void setOrderSubtotal(Double orderSubtotal) {
        this.orderSubtotal = orderSubtotal;
    }

    @Override
    public String toString() {
        return "TeaTimeUsage{" +
                "teamUuid='" + teamUuid + '\'' +
                ", teamName='" + teamName + '\'' +
                ", teamMemberCount=" + teamMemberCount +
                ", teamLeaderUuid='" + teamLeaderUuid + '\'' +
                ", teamLeaderName='" + teamLeaderName + '\'' +
                ", teaTimeUsage=" + teaTimeUsage +
                ", orderUuid='" + orderUuid + '\'' +
                ", orderSubtotal=" + orderSubtotal +
                '}';
    }
}
