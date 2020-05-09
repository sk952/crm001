package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.HandleFlag;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.domain.Contacts;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/12/4
 */
@Controller
@RequestMapping("/workbench/transaction")
public class TranController {
    @Autowired
    private ContactsService contactsService;

    @Autowired
    private TranService tranService;
    @Autowired
    private UserService userService;
    @Autowired
    private CustomerService customerService;              



    @RequestMapping("/toTranIndex.do")
    public String toTranIndex(){
        return "/workbench/transaction/index";
    }

    @RequestMapping("/toTranSave.do")
    public ModelAndView toTranSave(){
        List<User> uList=userService.getUserList();

        ModelAndView mav=new ModelAndView();
        mav.addObject("uList", uList);
        mav.setViewName("/workbench/transaction/save");
        return mav;
    }

    @RequestMapping("/getContactsListByFullname.do")
    @ResponseBody
    public List<Contacts> getContactsListByFullname(String fullname){
        List<Contacts> cList=contactsService.gteContactsListByFullname(fullname);
//        处理对象中，邮箱和对象的空值
        for (Contacts c:cList){
            String email=c.getEmail();
            if (email==null){
                c.setEmail("-");
            }
            String mphone=c.getMphone();
            if (mphone==null){
                c.setMphone("-");
            }
        }
        return cList;
        
        
    }

    @RequestMapping("/getCustomerNamesByName.do")
    @ResponseBody
    public List<String> getCustomerNamesByName(String name){
        List<String> sList=customerService.getCustomerNamesByName(name);
        return sList;

    }

    @RequestMapping("/getPossibilityByStage.do")
    @ResponseBody
    public Map<String,String> getPossibilityByStage(String stage, HttpServletRequest request){
//        阶段：stage
//        阶段和可能性之间的关系 pMap
        ServletContext application=request.getServletContext();
        Map<String,String> pMap=(Map<String, String>)application.getAttribute("pMap");
//        取得可能性
        String possibility=pMap.get(stage);

        Map<String,String> map=new HashMap<>();
        map.put("possibility", possibility);

        return map;
    }

    @RequestMapping("/saveTran.do")
    public String saveTran(Tran t,String customerName,HttpSession session){
        String id= UUIDUtil.getUUID();
        String createTime= DateTimeUtil.getSysTime();
        String createBy=((User)session.getAttribute("user")).getName();

        t.setId(id);
        t.setCreateTime(createTime);
        t.setCreateBy(createBy);

        tranService.saveTran(t,customerName);
        return "redirect:/workbench/transaction/toTranIndex.do";
        
    }

    @RequestMapping("/toTranDetail.do")
    public ModelAndView toTranDetail(String id,HttpServletRequest request){
        Tran t=tranService.getByIdForOwner(id);
//处理可能性 阶段
        String stage=t.getStage();

//        阶段和可能性之间的对应关系pMap
        ServletContext application=request.getServletContext();
        Map<String,String> pMap=(Map<String,String>)application.getAttribute("pMap");

//        取得可能性
        String possibility=pMap.get(stage);
        t.setPossibility(possibility);
        

        ModelAndView mav=new ModelAndView();
        mav.addObject("t", t);
//        mav.addObject("possibility",possibility);
        mav.setViewName("/workbench/transaction/detail");
        return mav;
    }

//    获得历史列表
    @RequestMapping("/getHistoryListByTranId.do")
    @ResponseBody
    public List<TranHistory> getHistoryListByTranId(String tranId,HttpServletRequest request){
        List<TranHistory> thList=tranService.getHistoryListByTranId(tranId);
        ServletContext application=request.getServletContext();
        Map<String,String> pMap=(Map<String,String>)application.getAttribute("pMap");

//        遍历每一条历史
        for (TranHistory th:thList){
//            取得每一个阶段的历史
            String stage=th.getStage();
            String possibility=pMap.get(stage);

            th.setPossibility(possibility);
            
            
        }
        return thList;
        
    }

    @RequestMapping("/updateTranStage.do")
    @ResponseBody
    public Map<String,Object> updateTranStage(Tran t, HttpServletRequest request){
        String editTime= DateTimeUtil.getSysTime();
        String editBy=((User)request.getSession().getAttribute("user")).getName();

        t.setCreateBy(editBy);
        t.setCreateTime(editTime);

        tranService.updateTranStage(t);

        ServletContext application=request.getServletContext();
        Map<String,String> pMap=(Map<String,String>)application.getAttribute("pMap");

        t.setPossibility(pMap.get(t.getStage()));

        return HandleFlag.successObj("t", t);

        
        

        
        
        
    }

}
