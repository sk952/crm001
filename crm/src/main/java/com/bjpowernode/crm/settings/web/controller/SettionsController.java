package com.bjpowernode.crm.settings.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Author:孙康
 * 2019/11/18
 */
@Controller
public class SettionsController {
    @RequestMapping("/settings/toIndex.do")
    public String toIndex(){
        return "/settings/index";
    }
}
