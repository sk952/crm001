package com.bjpowernode.crm.test;

import java.util.UUID;

/**
 * 动力节点
 * 2019/11/14
 */
public class UUIDTest {

    public static void main(String[] args) {

        /*

            主键：
                int/long 整型 可以自动递增

                insert into tbl_student(name,age) values(?,?)

                id         name
                1           zs
                2           ls
                3           ww
                4           zl
                5           sq

                (1) 主键自动递增涉及到表的添加删除的效率问题（实际操作的是两张表）
               （2）数据库移植相关的问题

                在实际项目开发中，更推荐使用字符串类型的主键
                主键：

                    非空+唯一

                    如何确保字符串主键的唯一性？

                    随机数 9374528759389
                    时间 20191114102146123+9374528759389


                UUID是未来最常见的主键生成机制，该机制是由java.util包为我们提供的工具类
                该形式生成的是由数字，字母和"-"组成的36位的随机串
                这36位的随机串一定是全世界唯一的

            问题：

            1.UUID为什么是全世界唯一的？
            随机数
            时间
            当前生成UUID所在硬件的机器编码


            2.在数据库表中，应该为UUID赋予什么类型？
            字符串

            varchar(32)

            char(32)


         */

        UUID uuid = UUID.randomUUID();

        String str = uuid.toString();

        str = str.replaceAll("-", "");

        System.out.println(str);
        System.out.println(str.length());

    }

}





































