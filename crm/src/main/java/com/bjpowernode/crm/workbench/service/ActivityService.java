package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.vo.PaginationVo;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.ActivityRemark;

import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/21
 */
public interface ActivityService {
    void saveActivity(Activity a);

    Map<String, Object> pageList(Map<String, Object> paramMap);

    PaginationVo<Activity> pageList2(Map<String, Object> map);

    void deleteActivity(String[] ids);

    Map<String, Object> getUserListAndActivity(String id);

    void updateActivity(Activity a);

    List<Activity> getActivityList();

    List<Activity> getActivityListByIds(String[] ids);

    void saveActivityList(List<Activity> aList);

    Activity getActivityListByIdForOwner(String id);

    List<ActivityRemark> getRemarkListByAid(String activityId);

    void deleteRemarkById(String id);

    void saveRemark(ActivityRemark ar);

    void updateRemark(ActivityRemark ar);

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map);

    List<Activity> getActvityListByName(String name);

    boolean saveActivity1(Activity a);
}
