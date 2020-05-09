package com.bjpowernode.crm.workbench.domain;

/**
 * Author:孙康
 * 2019/11/21
 */
public class ActivityRemark {
    private String id;  //
    private String noteContent; //备注信息（“哎呦”，“呵呵”）
    private String createTime;  //  创建时间
    private String createBy;    //  创建人
    private String editTime;    //  修改时间
    private String editBy;  //      修改人
    private String editFlag;    //是否被修改过的标记（0：未修改过  1：修改过）
    private String activityId;  //外键 关联tbl_activity表

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNoteContent() {
        return noteContent;
    }

    public void setNoteContent(String noteContent) {
        this.noteContent = noteContent;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }

    public String getEditFlag() {
        return editFlag;
    }

    public void setEditFlag(String editFlag) {
        this.editFlag = editFlag;
    }

    public String getActivityId() {
        return activityId;
    }

    public void setActivityId(String activityId) {
        this.activityId = activityId;
    }
}
