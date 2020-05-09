package com.bjpowernode.crm.web.listener;

import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

/**
 * Author:孙康
 * 2019/11/28
 */
public class SysInitListener implements ServletContextListener {
/*    @Autowired
    private DicService dicService;*/


    @Override
    public void contextInitialized(ServletContextEvent event) {
        ServletContext application =event.getServletContext();
        System.out.println("全局域对象创建了");
        System.out.println("地址"+application);

        DicService dicService= WebApplicationContextUtils.getWebApplicationContext(application).getBean(DicService.class);

/*        //查询数据字典
        List<DicValue> dvList=dicService.getDicValueList();
        //将数据字典保存到application域对象中
        application.setAttribute("dvList", dvList);*/

        System.out.println("服务器缓存处理数据字典开始");
        Map<String,List<DicValue>> map=dicService.getDicValueList();
        Set<String> set=map.keySet();
        for (String key:set){
            application.setAttribute(key, map.get(key));
        }
        System.out.println("服务器缓存处理数据字典结束");


//        处理阶段和可能性之间的键值对关系
        Map<String,String> pMap = new HashMap<>();

        //处理阶段和可能性之间的键值对关系
        //解析Stage2Possibility.properties
        //ResourceBundle是专业用来解析properties文件的
        //使用ResourceBundle找到的properties文件，后面不能带有后缀名
        ResourceBundle rb = ResourceBundle.getBundle("properties/Stage2Possibility");

        Enumeration<String> e = rb.getKeys();

        while (e.hasMoreElements()){

            //遍历每一个阶段（key）
            String stage = e.nextElement();

            //由key来取得value值
            String possibility = rb.getString(stage);

            System.out.println("stage:"+stage);
            System.out.println("possibility:"+possibility);

            //将遍历出来的所有的键值对保存到map中
            pMap.put(stage, possibility);

        }

        //将pMap保存到application域对象中，成为我们的服务器缓存
        application.setAttribute("pMap", pMap);




    }
}
