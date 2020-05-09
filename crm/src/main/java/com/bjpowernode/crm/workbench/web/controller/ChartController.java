package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Map;

/**
 * Author:孙康
 * 2019/12/7
 */
@Controller
public class ChartController {
    @Autowired
    private TranService tranService;
    @RequestMapping("/workbench/chart/transaction/toChartTranIndex.do")
    public String toCharTranIndex(){
        return "/workbench/chart/transaction/index";
    }

    @RequestMapping("workbench/chart/transaction/getChartData.do")
    @ResponseBody
    public Map<String,Object> getChartData(){
        Map<String,Object> map=tranService.getChartData();
        return map;
    }
}
