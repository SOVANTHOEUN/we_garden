package com.wegarden.web.model.user;

public class Team {

    private int id;
    private String name;
    private String remark;
    private String status;
    private String uuid;
    private int department_id;
    private int leader;

    public Team(int id, String name, String remark, String status, String uuid, int department_id, int leader) {
        this.id = id;
        this.name = name;
        this.remark = remark;
        this.status = status;
        this.uuid = uuid;
        this.department_id = department_id;
        this.leader = leader;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public int getDepartment_id() {
        return department_id;
    }

    public void setDepartment_id(int department_id) {
        this.department_id = department_id;
    }

    public int getLeader() {
        return leader;
    }

    public void setLeader(int leader) {
        this.leader = leader;
    }

    @Override
    public String toString() {
        return "Team{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", remark='" + remark + '\'' +
                ", status='" + status + '\'' +
                ", uuid='" + uuid + '\'' +
                ", department_id=" + department_id +
                ", leader=" + leader +
                '}';
    }
}
