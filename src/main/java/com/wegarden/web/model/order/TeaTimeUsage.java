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

    @JsonProperty("leader_uuid")
    private String leaderUuid;

    @JsonProperty("leader_name")
    private String leaderName;

    @JsonProperty("tea_time_usage")
    private Boolean teaTimeUsage;

    @JsonProperty("order_uuid")
    private String orderUuid;

    @JsonProperty("order_subtotal")
    private Double orderSubtotal;

    public TeaTimeUsage(){  }

    public TeaTimeUsage(String teamUuid, String teamName, String leaderUuid, String leaderName, Boolean teaTimeUsage, String orderUuid, Double orderSubtotal) {
        this.teamUuid = teamUuid;
        this.teamName = teamName;
        this.leaderUuid = leaderUuid;
        this.leaderName = leaderName;
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

    public String getLeaderUuid() {
        return leaderUuid;
    }

    public void setLeaderUuid(String leaderUuid) {
        this.leaderUuid = leaderUuid;
    }

    public String getLeaderName() {
        return leaderName;
    }

    public void setLeaderName(String leaderName) {
        this.leaderName = leaderName;
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
                ", leaderUuid='" + leaderUuid + '\'' +
                ", leaderName='" + leaderName + '\'' +
                ", teaTimeUsage=" + teaTimeUsage +
                ", orderUuid='" + orderUuid + '\'' +
                ", orderSubtotal=" + orderSubtotal +
                '}';
    }
}
