package com.bjpowernode.crm.settings.web.controller;

import com.bjpowernode.crm.exception.AjaxRequestException;
import com.bjpowernode.crm.exception.TraditionRequestException;
import com.bjpowernode.crm.settings.domain.DicType;
import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import com.bjpowernode.crm.utils.HandleFlag;
import com.bjpowernode.crm.utils.UUIDUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/18
 */
@Controller
@RequestMapping("/settings/dictionary")
public class DicController {
    @Autowired
    private DicService dicService;


    @RequestMapping("/toIndex.do")
    public String toIndex(){
        return "/settings/dictionary/index";
        
    }
    @RequestMapping("/type/toTypeIndex.do")
    public ModelAndView toTypeIndex()throws TraditionRequestException {
        ModelAndView mav=new ModelAndView();

        //取得字典类型列表
        List<DicType> dtList =dicService.getDicTypeList();

        mav.addObject("dtList", dtList);
        //request.setAttribute("dtList",dtList);

        mav.setViewName("/settings/dictionary/type/index");
        //return "/settings/dictionary/type/index";

        return mav;



        //转发，把dtList保存到request域中,可以用request.setAttribute("dtList",dtList);
        //                             也可以用ModelAndView
        
    }

    @RequestMapping("/type/toTypeSave.do")
    public String toTypeSave(){
        return "/settings/dictionary/type/save";
    }


    @RequestMapping("/type/checkCode.do")
    @ResponseBody
    public Map<String,Object> checkCode(String code)throws AjaxRequestException {
        dicService.checkCode(code);
        return HandleFlag.successTrue();
    }

    @RequestMapping("/type/checkCode1.do")
    @ResponseBody
    public Map<String,Object> checkCode1(String code){
        boolean flag=dicService.checkCode1(code);
        Map<String,Object> map=new HashMap<>();
        map.put("success",flag);
        return map;
    }


    /*字典值查重*/
    @RequestMapping("/value/checkCode2.do")
    @ResponseBody
    public Map<String,Object> checkCode2(String code){
        boolean flag=dicService.checkCode2(code);
        Map<String,Object> map=new HashMap<>();
        map.put("success",flag);
        return map;
    }

    @RequestMapping("/type/saveType.do")
    public String saveType(DicType dt) throws TraditionRequestException {

        dicService.saveType(dt);

//        return "redirect:/WEB-INF/jsp/settings/dictionary/type/index.jsp"; 不行
        return "redirect:/settings/dictionary/type/toTypeIndex.do";
        
    }

    //修改
    @RequestMapping("/type/toTypeUpdate.do")
    public ModelAndView toTypeUpdate(String code){
        DicType dt=dicService.getTypeByCode(code);


        ModelAndView mav=new ModelAndView();
        mav.addObject("dt", dt);
        mav.setViewName("/settings/dictionary/type/edit");

        return mav;
        
    }


    //.字典值的....是接收并处理的传统请求的表单
    @RequestMapping("/value/updateValue.do")
    public String updateValue(DicValue dt){
        dicService.updateValue(dt);

        return "redirect:/settings/dictionary/value/toValueIndex.do";
    }


    //是接收并处理的传统请求的表单
    @RequestMapping("/type/updateType.do")
    public String updateType(DicType dt){
        dicService.updateType(dt);

        return "redirect:/settings/dictionary/type/toTypeIndex.do";
    }

    //删除
/*    @RequestMapping("/type/deleteType.do")
    public String deleteType(HttpServletRequest request){
        String[] codes=request.getParameterValues("codes");
    }*/
    @RequestMapping("/type/deleteType.do")
    public String deleteType(String[] codes){
        dicService.deleteType(codes);
        return "redirect:/settings/dictionary/type/toTypeIndex.do";

    }

//    字典值得 删除
    @RequestMapping("/value/deleteValue.do")
    public String deleteValue(String[] codes){
        dicService.deletevalue(codes);
        return "redirect:/settings/dictionary/value/toValueIndex.do";

}

//字典值的修改
@RequestMapping("/value/toValueUpdate.do")
    public ModelAndView toValueUpdate(String value) {

    DicValue dt=dicService.getValueByCode(value);


    ModelAndView mav = new ModelAndView();
    mav.addObject("dt", dt);
    mav.setViewName("/settings/dictionary/value/edit");

    return mav;

}

                                     
//    要取列表所以不能返回String类型，查询
    @RequestMapping("/value/toValueIndex.do")
    public ModelAndView toValueIndex(){
        List<DicType> dvList=dicService.getValueList();
        ModelAndView mav=new ModelAndView();
        mav.addObject("dvList", dvList);
        mav.setViewName("/settings/dictionary/value/index");
        return mav;
    }

    //字典添加1
    @RequestMapping("/value/toValueSave.do")
    public ModelAndView  toValueSave(){
        //取得字典类型列表
        List<DicType> dtList=dicService.getDicTypeList();
        ModelAndView mav=new ModelAndView();
        mav.addObject("dtList", dtList);
        mav.setViewName("/settings/dictionary/value/save");

        return mav;
    }

    //添加2
    @RequestMapping("/value/saveValue.do")
    public String saveValue(DicValue dv){
//        通过表单传递的参数,为我们的dv对象已经封装了typeCode,value,text,orderNo,还差一个uuid的id值
        //封装id
        dv.setId(UUIDUtil.getUUID());
        dicService.saveValue(dv);
        return "redirect:/settings/dictionary/value/toValueIndex.do";
        
    }

}
