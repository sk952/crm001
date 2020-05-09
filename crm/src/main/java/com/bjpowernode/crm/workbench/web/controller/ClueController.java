package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.HandleFlag;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.sun.org.apache.xpath.internal.operations.Mod;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/28
 */
@Controller
@RequestMapping("workbench/clue")
public class ClueController {
    @Autowired
    private UserService userService;
    @Autowired
    private ClueService clueService;
    @Autowired
    private ActivityService activityService;

    @RequestMapping("/toClueIndex.do")
    public String toClueIndex(){
        return "/workbench/clue/index";
    }


    @RequestMapping("/getUserList.do")
    @ResponseBody
    public List<User> getUserList(){
        List<User> uList=userService.getUserList();
        return uList;
        
    }

//    保存按钮
    @RequestMapping("/saveClue.do")
    @ResponseBody
    public Map<String,Object> saveClue(Clue c, HttpSession session){
        c.setId(UUIDUtil.getUUID());

        String createTime= DateTimeUtil.getSysTime();
        String createBy=((User)session.getAttribute("user")).getName();

        c.setCreateBy(createBy);
        c.setCreateTime(createTime);

        clueService.saveClue(c);

        return HandleFlag.successTrue();

    }
//     查看详细信息页
    @RequestMapping("/toClueDetail.do")
    public ModelAndView toClueDetail(String id){
        Clue c=clueService.getClueByIdForOwner(id);
        ModelAndView mav=new ModelAndView();
        mav.addObject("c", c);
        mav.setViewName("/workbench/clue/detail");
        return mav;
    }


    @RequestMapping("/getActivityListByClueId.do")
    @ResponseBody
    public List<Activity> getActivityListByClueId(String clueId){
        List<Activity> aList=activityService.getActivityListByClueId(clueId);
        return aList;

    }


    @RequestMapping("/unbund.do")
    @ResponseBody
    public Map<String,Object> unbund(String id){
        clueService.deleteRelationById(id);
        return HandleFlag.successTrue();

    }


    @RequestMapping("/getActivityListByNameAndNotByClueId.do")
    @ResponseBody
//    public List<Activity> getActivityListByNameAndNotByClueId(String aname,String clueId){
    public List<Activity> getActivityListByNameAndNotByClueId(@RequestParam Map<String,Object> map){
        List<Activity> aList=activityService.getActivityListByNameAndNotByClueId(map);
        return aList;

    }


//添加关联
    @RequestMapping("/bund.do")
    @ResponseBody
    public Map<String,Object> bund(String clueId,String[] activityIds){
        clueService.saveRelation(clueId,activityIds);
        return HandleFlag.successTrue();
    }

//跳转转换
    @RequestMapping("/toConvert.do")
    public ModelAndView toConvert(Clue c){
        ModelAndView mav=new ModelAndView();
        mav.addObject("c", c);
        mav.setViewName("/workbench/clue/convert");

        return mav;
    }

//    转换中 搜索市场活动的那个查询
    @RequestMapping("/getActvityListByName.do")
    @ResponseBody
    public List<Activity> getActvityListByName(String name){
        List<Activity> aList=activityService.getActvityListByName(name);
        return aList;
    }


    @RequestMapping("convert.do")
    public  String  convert(String clueId, Tran t,String flag,HttpSession session){

        String createBy=((User)session.getAttribute("user")).getName();
        
        if ("a".equals(flag)){
            //如果进入了if语句 说明需要创建交易
            t.setId(UUIDUtil.getUUID());
            String createTime=DateTimeUtil.getSysTime();

            t.setCreateBy(createBy);
            t.setCreateTime(createTime);
            
            
        }

        boolean falg1=clueService.convert(clueId,t,flag,createBy);

        if (falg1){

            return "redirect:/workbench/clue/toClueIndex.do";
            
        }else{

            return "redirect:/fail.jsp";

        }

    }
    
}
