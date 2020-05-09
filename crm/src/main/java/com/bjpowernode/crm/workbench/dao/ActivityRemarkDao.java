package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.ActivityRemark;

import java.util.List;

/**
 * 动力节点
 * 2019/11/21
 */
public interface ActivityRemarkDao {
    void deleteRemarkByAids(String[] ids);

    List<ActivityRemark> getRemarkListByAid(String activityId);

    void deleteRemarkById(String id);

    void saveRemark(ActivityRemark ar);

    void updateRemark(ActivityRemark ar);
}
