package com.wegarden.web.model.order;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.sql.Date;
import java.text.DateFormatSymbols;

@Entity
public class TeaTimeUserListByTeam {
    @JsonProperty("team_uuid")
    private String teamUuid;

    @JsonProperty("team_name")
    private String teamName;

    @JsonProperty("team_status")
    private String teamStatus;

    @JsonProperty("tea_time_role")
    private String teaTimeRole;

    @Id
    @JsonProperty("user_uuid")
    private String userUuid;

    @JsonProperty("user_en_name")
    private String userEnName;

    @JsonProperty("user_kh_name")
    private String userKhName;

    @JsonProperty("user_kr_name")
    private String userKrName;

    @JsonProperty("user_duty")
    private String userDuty;

    @JsonProperty("user_gender")
    private String userGender;

    @JsonProperty("user_dob")
    private Date userDob;

    @JsonProperty("user_phone_number")
    private String userPhoneNumber;

    @JsonProperty("user_image")
    private String userImage;

    @JsonProperty("user_credit_balance")
    private Double userCreditBalance;

    @JsonProperty("user_username")
    private String userUsername;

    @JsonProperty("user_email")
    private String userEmail;

    @JsonProperty("user_role")
    private String userRole;

    @JsonProperty("user_token")
    private String userToken;

    @JsonProperty("user_created_date")
    private Date userCreatedDate;

    @JsonProperty("user_employment_status")
    private String userEmploymentStatus;

    @JsonProperty("user_status")
    private String userStatus;

    @JsonProperty("position")
    private String position;

    @JsonProperty("position_type")
    private String positionType;

    @JsonProperty("position_uuid")
    private String positionUuid;

    public TeaTimeUserListByTeam(){  }

    public TeaTimeUserListByTeam(String teamUuid, String teamName, String teamStatus, String teaTimeRole, String userUuid, String userEnName, String userKhName, String userKrName, String userDuty, String userGender, Date userDob, String userPhoneNumber, String userImage, Double userCreditBalance, String userUsername, String userEmail, String userRole, String userToken, Date userCreatedDate, String userEmploymentStatus, String userStatus, String position, String positionType, String positionUuid) {
        this.teamUuid = teamUuid;
        this.teamName = teamName;
        this.teamStatus = teamStatus;
        this.teaTimeRole = teaTimeRole;
        this.userUuid = userUuid;
        this.userEnName = userEnName;
        this.userKhName = userKhName;
        this.userKrName = userKrName;
        this.userDuty = userDuty;
        this.userGender = userGender;
        this.userDob = userDob;
        this.userPhoneNumber = userPhoneNumber;
        this.userImage = userImage;
        this.userCreditBalance = userCreditBalance;
        this.userUsername = userUsername;
        this.userEmail = userEmail;
        this.userRole = userRole;
        this.userToken = userToken;
        this.userCreatedDate = userCreatedDate;
        this.userEmploymentStatus = userEmploymentStatus;
        this.userStatus = userStatus;
        this.position = position;
        this.positionType = positionType;
        this.positionUuid = positionUuid;
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

    public String getTeamStatus() {
        return teamStatus;
    }

    public void setTeamStatus(String teamStatus) {
        this.teamStatus = teamStatus;
    }

    public String getTeaTimeRole() {
        return teaTimeRole;
    }

    public void setTeaTimeRole(String teaTimeRole) {
        this.teaTimeRole = teaTimeRole;
    }

    public String getUserUuid() {
        return userUuid;
    }

    public void setUserUuid(String userUuid) {
        this.userUuid = userUuid;
    }

    public String getUserEnName() {
        return userEnName;
    }

    public void setUserEnName(String userEnName) {
        this.userEnName = userEnName;
    }

    public String getUserKhName() {
        return userKhName;
    }

    public void setUserKhName(String userKhName) {
        this.userKhName = userKhName;
    }

    public String getUserKrName() {
        return userKrName;
    }

    public void setUserKrName(String userKrName) {
        this.userKrName = userKrName;
    }

    public String getUserDuty() {
        return userDuty;
    }

    public void setUserDuty(String userDuty) {
        this.userDuty = userDuty;
    }

    public String getUserGender() {
        return userGender;
    }

    public void setUserGender(String userGender) {
        this.userGender = userGender;
    }

    public Date getUserDob() {
        return userDob;
    }

    public void setUserDob(Date userDob) {
        this.userDob = userDob;
    }

    public String getUserPhoneNumber() {
        return userPhoneNumber;
    }

    public void setUserPhoneNumber(String userPhoneNumber) {
        this.userPhoneNumber = userPhoneNumber;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public Double getUserCreditBalance() {
        return userCreditBalance;
    }

    public void setUserCreditBalance(Double userCreditBalance) {
        this.userCreditBalance = userCreditBalance;
    }

    public String getUserUsername() {
        return userUsername;
    }

    public void setUserUsername(String userUsername) {
        this.userUsername = userUsername;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public String getUserToken() {
        return userToken;
    }

    public void setUserToken(String userToken) {
        this.userToken = userToken;
    }

    public Date getUserCreatedDate() {
        return userCreatedDate;
    }

    public void setUserCreatedDate(Date userCreatedDate) {
        this.userCreatedDate = userCreatedDate;
    }

    public String getUserEmploymentStatus() {
        return userEmploymentStatus;
    }

    public void setUserEmploymentStatus(String userEmploymentStatus) {
        this.userEmploymentStatus = userEmploymentStatus;
    }

    public String getUserStatus() {
        return userStatus;
    }

    public void setUserStatus(String userStatus) {
        this.userStatus = userStatus;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getPositionType() {
        return positionType;
    }

    public void setPositionType(String positionType) {
        this.positionType = positionType;
    }

    public String getPositionUuid() {
        return positionUuid;
    }

    public void setPositionUuid(String positionUuid) {
        this.positionUuid = positionUuid;
    }

    @Override
    public String toString() {
        return "TeaTimeUserListByTeam{" +
                "teamUuid='" + teamUuid + '\'' +
                ", teamName='" + teamName + '\'' +
                ", teamStatus='" + teamStatus + '\'' +
                ", teaTimeRole='" + teaTimeRole + '\'' +
                ", userUuid='" + userUuid + '\'' +
                ", userEnName='" + userEnName + '\'' +
                ", userKhName='" + userKhName + '\'' +
                ", userKrName='" + userKrName + '\'' +
                ", userDuty='" + userDuty + '\'' +
                ", userGender='" + userGender + '\'' +
                ", userDob=" + userDob +
                ", userPhoneNumber='" + userPhoneNumber + '\'' +
                ", userImage='" + userImage + '\'' +
                ", userCreditBalance=" + userCreditBalance +
                ", userUsername='" + userUsername + '\'' +
                ", userEmail='" + userEmail + '\'' +
                ", userRole='" + userRole + '\'' +
                ", userToken='" + userToken + '\'' +
                ", userCreatedDate=" + userCreatedDate +
                ", userEmploymentStatus='" + userEmploymentStatus + '\'' +
                ", userStatus='" + userStatus + '\'' +
                ", position='" + position + '\'' +
                ", positionType='" + positionType + '\'' +
                ", positionUuid='" + positionUuid + '\'' +
                '}';
    }
}
