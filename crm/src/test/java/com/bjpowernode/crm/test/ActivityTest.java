package com.bjpowernode.crm.test;

import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.service.impl.ActivityServiceImpl;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

/**
 * 动力节点
 * 2019/11/28
 *
 * 关于命名：
 *      测试类的命名：domain+Test
 *      方法的命名：test+功能
 *
 * 未来的实际项目开发：
 *      我们应该每完成一个业务功能，就应该对这个业务功能编写一份单元测试方法
 *
 * 将来我们一般都是对业务层进行测试
 *
 * @RunWith(SpringJUnit4ClassRunner.class)
 *    由spring去管理JUnit，来进行单元测试
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:spring/applicationContext.xml")
public class ActivityTest {

    @Autowired
    private ActivityService activityService;

    @Test
    public void testSave(){

        System.out.println("测试添加操作1");

        Activity a = new Activity();
        a.setId(UUIDUtil.getUUID());
        a.setName("宣传推广会");

        boolean flag = activityService.saveActivity1(a);

        /*

            断言：
                表示测试的结果取得之后，要和我们提供的一个预期的结果进行比较
                如果比较二者的值是相同的，测试成功，否则测试失败（没有报异常也是失败）

         */

        /*

            测试结果图标总结：
                1.所有功能都是测试通过的，显示绿√
                2.有功能报异常，表示服务器端代码出错，显示红圈感叹号
                3.经过断言测试不符合预期值的，显示黄圈×


         */

        Assert.assertEquals(flag, true);



    }

    @Test
    public void testSelect1(){

        System.out.println("测试查询操作1");


    }

    @Test
    public void testSelect2(){

        System.out.println("测试查询操作2");

    }

    @Test
    public void testSelect3(){

        System.out.println("测试查询操作3---该需求已经改过了");

    }

    @Test
    public void testSelect4(){

        System.out.println("测试查询操作4");

    }

    @Test
    public void testSelect5(){

        System.out.println("测试查询操作5");

    }

    @Test
    public void testSelect6(){

        System.out.println("测试查询操作6");

    }

}














































