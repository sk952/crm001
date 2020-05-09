package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Activity;

import java.util.List;
import java.util.Map;

/**
 * 动力节点
 * 2019/11/21
 */
public interface ActivityDao {
    void saveActivity(Activity a);

    List<Activity> getActivityListByCondition(Map<String, Object> paramMap);

    int getActivityTotalByCondition(Map<String, Object> paramMap);

    void deleteActivity(String[] ids);

    Activity getActivityById(String id);

    void updateActivity(Activity a);

    List<Activity> getActivityList();

    List<Activity> getActivityListByIds(String[] ids);

    void saveActivityList(List<Activity> aList);

    Activity getActivityByIdForOwner(String id);

    int saveActivity1(Activity a);

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map);

    List<Activity> getActvityListByName(String name);
}
