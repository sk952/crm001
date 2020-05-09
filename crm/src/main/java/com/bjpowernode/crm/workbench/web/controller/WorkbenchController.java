package com.bjpowernode.crm.workbench.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * Author:孙康
 * 2019/11/15
 */
@Controller
public class WorkbenchController {
    @RequestMapping("/workbench/toIndex.do")
    public String toIndex(){
                /*

            请求转发到/WEB-INF/jsp/workbench/index.jsp
            （1）使用HttpServletRequest    HttpServletRequest request
            （2）使用ModelAndView
            以上这两种形式在做请求转发的同时，还可以将数据保存到request域对象中

            但是对于我们现在的需求，就是做个转发就可以了，不需要在request域对象中打包数据
            所以我们直接使用SpringMVC已经配置好的视图解析器就可以了

            如果使用视图解析器，我们的返回值需要设置为String类型

         */
            return "/workbench/index";
                

    }                                                         
    @RequestMapping("/workbench/main/toIndex.do")
    public String mainToIndex(){
        return "/workbench/main/index";
    }
}
