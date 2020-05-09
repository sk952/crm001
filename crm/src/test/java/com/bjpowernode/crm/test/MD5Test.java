package com.bjpowernode.crm.test;

import com.bjpowernode.crm.utils.MD5Util;

/**
 * 动力节点
 * 2019/11/15
 */
public class MD5Test {

    public static void main(String[] args) {

        String pwd = "bjpowernode@126.com";

        pwd = MD5Util.getMD5(pwd);

        System.out.println(pwd);

    }

}
