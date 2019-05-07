package com.wegarden.web.model.order;

import com.fasterxml.jackson.annotation.JsonProperty;

import javax.persistence.Entity;
import javax.persistence.Id;
import java.util.Date;

@Entity
public class Order {

    @Id
    @JsonProperty("total_in_debt")
    private String totalInDebt;

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
    private String userDob;

    @JsonProperty("user_phone_number")
    private String userPhoneNumber;

    @JsonProperty("user_image")
    private String userImage;

    @JsonProperty("user_credit_balance")
    private String userCreditBalance;

    @JsonProperty("user_username")
    private String userUsername;

    @JsonProperty("user_email")
    private String userEmail;

    @JsonProperty("user_role")
    private String userRole;

    @JsonProperty("user_token")
    private String userToken;

    @JsonProperty("user_created_date")
    private String userCreatedDate;

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

    @JsonProperty("team_uuid")
    private String teamUuid;

    @JsonProperty("team_name")
    private String teamName;

    @JsonProperty("team_remark")
    private String teamRemark;

    @JsonProperty("team_status")
    private String teamStatus;

    @JsonProperty("department_uuid")
    private String departmentUuid;

    @JsonProperty("department_name")
    private String departmentName;

    @JsonProperty("department_remark")
    private String departmentRemark;

    @JsonProperty("department_status")
    private String departmentStatus;

    public Order(){

    }

    public Order(String totalInDebt, String userUuid, String userEnName, String userKhName, String userKrName, String userDuty, String userGender, String userDob, String userPhoneNumber, String userImage, String userCreditBalance, String userUsername, String userEmail, String userRole, String userToken, String userCreatedDate, String userEmploymentStatus, String userStatus, String position, String positionType, String positionUuid, String teamUuid, String teamName, String teamRemark, String teamStatus, String departmentUuid, String departmentName, String departmentRemark, String departmentStatus) {
        this.totalInDebt = totalInDebt;
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
        this.teamUuid = teamUuid;
        this.teamName = teamName;
        this.teamRemark = teamRemark;
        this.teamStatus = teamStatus;
        this.departmentUuid = departmentUuid;
        this.departmentName = departmentName;
        this.departmentRemark = departmentRemark;
        this.departmentStatus = departmentStatus;
    }

    public String getTotalInDebt() {
        return totalInDebt;
    }

    public void setTotalInDebt(String totalInDebt) {
        this.totalInDebt = totalInDebt;
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

    public String getUserDob() {
        return userDob;
    }

    public void setUserDob(String userDob) {
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

    public String getUserCreditBalance() {
        return userCreditBalance;
    }

    public void setUserCreditBalance(String userCreditBalance) {
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

    public String getUserCreatedDate() {
        return userCreatedDate;
    }

    public void setUserCreatedDate(String userCreatedDate) {
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

    public String getDepartmentStatus() {
        return departmentStatus;
    }

    public void setDepartmentStatus(String departmentStatus) {
        this.departmentStatus = departmentStatus;
    }
}