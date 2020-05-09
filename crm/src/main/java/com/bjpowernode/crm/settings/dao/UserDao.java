package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.User;

import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/15
 */
public interface UserDao {
    public User login(Map<String,String> map);

    List<User> getUserList();
//    public User login(User user);
}

