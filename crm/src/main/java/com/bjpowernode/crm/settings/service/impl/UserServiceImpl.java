package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.exception.LoginException;
import com.bjpowernode.crm.settings.dao.UserDao;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.utils.Const;
import com.bjpowernode.crm.utils.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/15
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User login(String loginAct, String loginPwd, String ip)throws LoginException {
        Map<String,String> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);

        //验证账号密码是否正确，通过dao层执行sql语句来验证，为我们返回User
        User user = userDao.login(map);

        /*

            判断user是否为null

         */

        //user==null说明账号密码不正确
        if(user==null){

            throw new LoginException("账号密码错误");

        }

        //如果程序能够顺利的走到该行，说明上面没有抛异常，说明账号密码是正确的
        //需要继续向下验证

        //验证失效时间
        String expireTime = user.getExpireTime();
        if(expireTime.compareTo(DateTimeUtil.getSysTime())<0){

            throw new LoginException("账号已失效");

        }

        //验证锁定状态
        String lockState = user.getLockState();
        if(lockState!=null){


            if(Const.LOCKSTATE_CLOSE.equals(lockState)){

                throw new LoginException("账号已锁定");

            }

        }

        //验证ip地址
        String allowIps = user.getAllowIps();
        if(allowIps!=null){

            if(!allowIps.contains(ip)){

                throw new LoginException("ip地址受限");

            }

        }


        /*

            如果程序能够走到该行，说明上面4处抛异常，都没有执行
            登录成功
            为控制器返回user对象

         */
        return user;
    }

    @Override
    public List<User> getUserList() {
        List<User> uList=userDao.getUserList();
        return uList;
    }
}
