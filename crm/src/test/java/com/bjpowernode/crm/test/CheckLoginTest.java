package com.bjpowernode.crm.test;

import com.bjpowernode.crm.utils.Const;
import com.bjpowernode.crm.utils.DateTimeUtil;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 动力节点
 * 2019/11/16
 */
public class CheckLoginTest {

    public static void main(String[] args) {

        //验证失效时间

        //String expireTime = "2018-12-26 10:10:10";

        /*Date date = new Date();
        //System.out.println(date);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String currentSysTime = sdf.format(date);
        int count = expireTime.compareTo(currentSysTime);
        if(count<0){

            System.out.println("账号已失效");

        }*/

        /*String currentSysTime = DateTimeUtil.getSysTime();
        int count = expireTime.compareTo(currentSysTime);
        if(count<0){

            System.out.println("账号已失效");

        }*/


        //验证锁定状态
        /*String lockState = "0";
        if(Const.LOCKSTATE_CLOSE.equals(lockState)){

            System.out.println("账号已锁定");

        }*/

        //验证IP地址
        //浏览器端的ip地址
        String ip = "192.168.1.128";
        //允许访问的ip地址群
        String allowIps = "192.168.1.1,192.168.1.2,192.168.1.3";

        if(!allowIps.contains(ip)){

            System.out.println("ip地址受限");

        }

    }

}






























