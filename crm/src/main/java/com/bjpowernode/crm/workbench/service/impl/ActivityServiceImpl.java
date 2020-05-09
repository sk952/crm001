package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.settings.dao.UserDao;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.vo.PaginationVo;
import com.bjpowernode.crm.workbench.dao.ActivityDao;
import com.bjpowernode.crm.workbench.dao.ActivityRemarkDao;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.ActivityRemark;
import com.bjpowernode.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/21
 */
@Service
public class ActivityServiceImpl implements ActivityService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private ActivityDao activityDao;
    @Autowired
    private ActivityRemarkDao activityRemarkDao;

//使用map方式处理返回值
    @Override
    public Map<String, Object> pageList(Map<String, Object> paramMap) {
        //取得dataList
        List<Activity> dataList=activityDao.getActivityListByCondition(paramMap);
        //取得total
        int total=activityDao.getActivityTotalByCondition(paramMap);

        //创建一个map,将dataList和total保存到map中
        Map<String,Object> map=new HashMap<>();
        map.put("dataList", dataList);
        map.put("total", total);
        //返回map
        return map;
    }


//为修改按钮，打开修改市场活动的模态窗口,取得模态窗口中需要的值
    @Override
    public Map<String, Object> getUserListAndActivity(String id) {
//        取得uList
        List<User> uList=userDao.getUserList();
//        取得Activity a
        Activity a=activityDao.getActivityById(id);
//        创建map保存并返回
        Map<String,Object> map=new HashMap<>();
        map.put("uList", uList);
        map.put("a", a);
        
        return map;
    }



    //    删除
    @Override
    public void deleteActivity(String[] ids) {
//        一对多两张表,先删除多，在删除一
//        删除市场活动备注
        activityRemarkDao.deleteRemarkByAids(ids);
//        删除市场活动
        activityDao.deleteActivity(ids);
    }

    //    使用vo方式处理返回值
    @Override
    public PaginationVo<Activity> pageList2(Map<String, Object> map) {
        //取得dataList
        List<Activity> dataList=activityDao.getActivityListByCondition(map);
        //取得total
        int total=activityDao.getActivityTotalByCondition(map);
        //创建一个vo类型的对象，将dataList和total封装到vo对象中
        PaginationVo<Activity> vo=new PaginationVo();
        vo.setDataList(dataList);
        vo.setTotal(total);
        return vo;
    }


    @Override
    public boolean saveActivity1(Activity a) {

        int count = activityDao.saveActivity1(a);

        if(count==1){

            return true;

        }else{

            return false;

        }

    }


    //添加
    @Override
    public void saveActivity(Activity a) {
        activityDao.saveActivity(a);

    }

//    修改

    @Override
    public void updateActivity(Activity a) {
        activityDao.updateActivity(a);
    }

//    导入
    @Override
    public void saveActivityList(List<Activity> aList) {
        activityDao.saveActivityList(aList);

    }

    //选择导出按钮的查询操作
    @Override
    public List<Activity> getActivityListByIds(String[] ids) {
        List<Activity> aList=activityDao.getActivityListByIds(ids);
        return aList;
    }

    //导出按钮的查询操作
    @Override
    public List<Activity> getActivityList() {
        List<Activity> aList=activityDao.getActivityList();
        return aList;
    }


    @Override
    public Activity getActivityListByIdForOwner(String id) {
        Activity a=activityDao.getActivityByIdForOwner(id);
        return a;
    }

    @Override
    public List<ActivityRemark> getRemarkListByAid(String activityId) {
        List<ActivityRemark> arList=activityRemarkDao.getRemarkListByAid(activityId);
        
        return arList;
    }


    /*删除备注*/

    @Override
    public void deleteRemarkById(String id) {
        activityRemarkDao.deleteRemarkById(id);
    }

    @Override
    public void saveRemark(ActivityRemark ar) {
        activityRemarkDao.saveRemark(ar);
    }


    @Override
    public void updateRemark(ActivityRemark ar) {
        activityRemarkDao.updateRemark(ar);
    }


    @Override
    public List<Activity> getActivityListByClueId(String clueId) {
        List<Activity> aList=activityDao.getActivityListByClueId(clueId);
        
        return aList;
    }

    @Override
    public List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map) {
        List<Activity> aList=activityDao.getActivityListByNameAndNotByClueId(map);
        return aList;
    }


    @Override
    public List<Activity> getActvityListByName(String name) {
        List<Activity> aList=activityDao.getActvityListByName(name);
        return aList;
    }
}
