package com.bjpowernode.crm.settings.web.controller;


import com.bjpowernode.crm.exception.LoginException;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.utils.HandleFlag;
import com.bjpowernode.crm.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/15
 */
@Controller
@RequestMapping("/settings/user")
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/login.do")
    @ResponseBody
    public Map<String,Object> login(String loginAct, String loginPwd, String flag, HttpServletRequest request, HttpServletResponse response) throws LoginException {
        String ip=request.getLocalAddr();
        loginPwd=MD5Util.getMD5(loginPwd);
        User user=userService.login(loginAct,loginPwd , ip);
        request.getSession().setAttribute("user", user);

        //能运行到这里说明登录成功了
        //通过flag是否为a判断是否打勾
        //用cookie实现十天免登陆
        if ("a".equals(flag)){
            Cookie cookie1=new Cookie("loginAct", loginAct);
            Cookie cookie2=new Cookie("loginPwd", loginPwd);

            cookie1.setMaxAge(60*60*24*10);
            cookie2.setMaxAge(60*60*24*10);

            cookie1.setPath("/");
            cookie2.setPath("/");

            response.addCookie(cookie1);
            response.addCookie(cookie2);


            
        }
        


     /*   Map<String,Object> map=new HashMap<>();
        map.put("success", true);*/
                                                                            
        return HandleFlag.successTrue();
    }
    @RequestMapping("/toLogin.do")
    public String toLogin(HttpServletRequest request){
        //判断是否执行十天免登陆
        Cookie[] cookies=request.getCookies();
        String loginAct=null;
        String loginPwd=null;
        if (cookies!=null && cookies.length>0){
            for (Cookie cookie:cookies){
                String name=cookie.getName();
                if ("loginAct".equals(name)){
                    loginAct=cookie.getValue();
                    continue;
                }
                if ("loginPwd".equals(name)){
                    loginPwd=cookie.getValue();
                }
                
            }
        }
        if (loginAct!=null && loginPwd!=null){
            //做过十天免登录了
            String ip=request.getRemoteAddr();
            try {
                User user=userService.login(loginAct, loginPwd, ip);
                request.getSession().setAttribute("user",user);
                return "redirect:/workbench/toIndex.do";

            } catch (LoginException e) {
                e.printStackTrace();
                return "/login";
            }

        }else {
            return "/login";
            
        }


    }
    @RequestMapping("/logout.do")
    public String logout(HttpSession session,HttpServletResponse response){
        session.invalidate();
        Cookie cookie1=new Cookie("loginAct",null );
        Cookie cookie2=new Cookie("loginPwd",null );
        cookie1.setPath("/");
        cookie2.setPath("/");
        cookie1.setMaxAge(0);
        cookie2.setMaxAge(0);
        response.addCookie(cookie1);
        response.addCookie(cookie2);
        return "/login";


            
        
    }
}
