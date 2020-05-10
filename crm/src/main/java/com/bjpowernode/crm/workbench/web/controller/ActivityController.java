package com.bjpowernode.crm.workbench.web.controller;

import com.bjpowernode.crm.exception.AjaxRequestException;
import com.bjpowernode.crm.settings.domain.User;
import com.bjpowernode.crm.settings.service.UserService;
import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.HandleFlag;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.vo.PaginationVo;
import com.bjpowernode.crm.workbench.domain.Activity;
import com.bjpowernode.crm.workbench.domain.ActivityRemark;
import com.bjpowernode.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/21
 */
@Controller
@RequestMapping("/workbench/activity")
public class ActivityController {
    @Autowired
    private ActivityService activityService;

    @Autowired
    private UserService userService;

    @RequestMapping("/toActivityIndex.do")
    public String  toActivityIndex(){
        return "/workbench/activity/index";
    }



    @RequestMapping("/getUserList.do")
    @ResponseBody
    public List<User> getUserList(){
        List<User> uList=userService.getUserList();
        return uList;
            
    }

//添加
    @RequestMapping("/saveActivity.do")
    @ResponseBody
    public Map<String,Object> saveActivity(Activity a, HttpSession session) throws AjaxRequestException {
//        从表单中传递的六项参数已被封装到a中，将没有封装的信息补全
        a.setId(UUIDUtil.getUUID());
        //创建时间:当前系统时间
        String createTime= DateTimeUtil.getSysTime();
        //创建人
        String createBy=((User)session.getAttribute("user")).getName();
        a.setCreateBy(createBy);
        a.setCreateTime(createTime);
        try {
            activityService.saveActivity(a);
        } catch (Exception e) {
            e.printStackTrace();
            throw new AjaxRequestException();   
        }

        return HandleFlag.successTrue();

        
    }

    //查询刷新
    @RequestMapping("/pageList.do")
    @ResponseBody
    public Map<String,Object> pageList(String pageNoStr,String pageSizeStr,String name,String owner,String startData,String endDate){
        int pageNo=Integer.valueOf(pageNoStr);
        int pageSize=Integer.valueOf(pageSizeStr);
        //计算略过的记录数
        int skipCount=(pageNo-1)*pageSize;
        //所有的参数都具备了，现在可以都打包了
        Map<String,Object> paramMap=new HashMap<>();
        paramMap.put("name",name);
        paramMap.put("owner",owner);
        paramMap.put("startDate",startData);
        paramMap.put("endDate",endDate);
        paramMap.put("skipCount",skipCount);
        paramMap.put("pageSize",pageSize);

        Map<String,Object> map=activityService.pageList(paramMap);
        return map;
    }

//第二种
    @RequestMapping("/pageList1.do")
    @ResponseBody
    public Map<String,Object> pageList1(@RequestParam Map<String,Object> map){

        String pageNoStr=(String)map.get("pageNoStr");
        String pageSizeStr=(String)map.get("pageSizeStr");
        int pageNo=Integer.valueOf(pageNoStr);
        int pageSize=Integer.valueOf(pageSizeStr);
//        计算略过的记录数
        int skipCount=(pageNo-1)*pageSize;

        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

//        需要业务层为我们返回 dataList total
        Map<String,Object> map1=activityService.pageList(map);
        return map1;

    }


    //第三种   ，用到vo多，才会为他单独建立实体类 
    @RequestMapping("/pageList2.do")
    @ResponseBody
    public PaginationVo<Activity> pageList2(@RequestParam Map<String,Object> map){

        String pageNoStr=(String)map.get("pageNoStr");
        String pageSizeStr=(String)map.get("pageSizeStr");
        int pageNo=Integer.valueOf(pageNoStr);
        int pageSize=Integer.valueOf(pageSizeStr);
//        计算略过的记录数
        int skipCount=(pageNo-1)*pageSize;

        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

//        需要业务层为我们返回 dataList total
        PaginationVo<Activity> vo =activityService.pageList2(map);
        return vo;

    }


//    删除
    @RequestMapping("/deleteActivity.do")
    @ResponseBody
    public Map<String,Object> deleteActivity(String[] ids){
        activityService.deleteActivity(ids);
        return HandleFlag.successTrue();
        
    }


    //为修改按钮，打开修改市场活动的模态窗口,取得模态窗口中需要的值
    @RequestMapping("/getUserListAndActivity.do")
    @ResponseBody
    public Map<String,Object> getUserListAndActivity(String id ){
        Map<String,Object> map=activityService.getUserListAndActivity(id);
        return map;

    }

//    修改
    @RequestMapping("/updateActivity.do")
    @ResponseBody
    public Map<String,Object> updateActivity(Activity a, HttpSession session) throws AjaxRequestException {
        //创建时间:当前系统时间
        String editTime= DateTimeUtil.getSysTime();
        //创建人
        String editBy=((User)session.getAttribute("user")).getName();
        a.setEditTime(editTime);
        a.setEditBy(editBy);

        try {
            activityService.updateActivity(a);
        } catch (Exception e) {
            e.printStackTrace();
            throw new AjaxRequestException();
        }

        return HandleFlag.successTrue();


    }


//    导出按钮的查询操作
   /* @RequestMapping("/exportActivityAll.do")
    public void exportActivityAll(HttpServletResponse response){
        //通过业务层查询市场活动的所有记录
        List<Activity> aList=activityService.getActivityList();
        //创建一个excel 文件
        HSSFWorkbook workbook=new HSSFWorkbook();
//        通过文件创建一页
        HSSFSheet sheet=workbook.createSheet();
//        通过页创建一行
        HSSFRow row=sheet.createRow(0);
        //创建第一行下的第1个单元格
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("id");

        //创建第一行下的第2个单元格
        cell = row.createCell(1);
        cell.setCellValue("owner");

        //创建第一行下的第3个单元格
        cell = row.createCell(2);
        cell.setCellValue("name");

        //创建第一行下的第4个单元格
        cell = row.createCell(3);
        cell.setCellValue("startDate");

        //创建第一行下的第5个单元格
        cell = row.createCell(4);
        cell.setCellValue("endDate");

        //创建第一行下的第6个单元格
        cell = row.createCell(5);
        cell.setCellValue("cost");

        //创建第一行下的第7个单元格
        cell = row.createCell(6);
        cell.setCellValue("description");

        //创建第一行下的第8个单元格
        cell = row.createCell(7);
        cell.setCellValue("createTime");

        //创建第一行下的第9个单元格
        cell = row.createCell(8);
        cell.setCellValue("createBy");

        //创建第一行下的第10个单元格
        cell = row.createCell(9);
        cell.setCellValue("editTime");

        //创建第一行下的第11个单元格
        cell = row.createCell(10);
        cell.setCellValue("editBy");
//        遍历sList取值填充excel
        for (int i=0;i<aList.size();i++){
//            取出每一个市场活动，将数据填充到每一个单元格
            Activity a=aList.get(i);
            row = sheet.createRow(i+1);
            //创建第一行下的第1个单元格
            cell = row.createCell(0);
            cell.setCellValue(a.getId());

            //创建第一行下的第2个单元格
            cell = row.createCell(1);
            cell.setCellValue(a.getOwner());

            //创建第一行下的第3个单元格
            cell = row.createCell(2);
            cell.setCellValue(a.getName());

            //创建第一行下的第4个单元格
            cell = row.createCell(3);
            cell.setCellValue(a.getStartDate());

            //创建第一行下的第5个单元格
            cell = row.createCell(4);
            cell.setCellValue(a.getEndDate());

            //创建第一行下的第6个单元格
            cell = row.createCell(5);
            cell.setCellValue(a.getCost());

            //创建第一行下的第7个单元格
            cell = row.createCell(6);
            cell.setCellValue(a.getDescription());

            //创建第一行下的第8个单元格
            cell = row.createCell(7);
            cell.setCellValue(a.getCreateTime());

            //创建第一行下的第9个单元格
            cell = row.createCell(8);
            cell.setCellValue(a.getCreateBy());

            //创建第一行下的第10个单元格
            cell = row.createCell(9);
            cell.setCellValue(a.getEditTime());

            //创建第一行下的第11个单元格
            cell = row.createCell(10);
            cell.setCellValue(a.getEditBy());


        }
        //为客户浏览器提供下载框
        response.setContentType("octets/stream");
        response.setHeader("Content-Disposition","attachment;filename=Activity-"+DateTimeUtil.getSysTime()+".xls");

        *//*

            通过response得到的响应流，如果我们自己没有关闭掉
            tomcat服务器会自动帮我们关闭掉

         *//*

        OutputStream out= null;
        try {
            out = response.getOutputStream();
            workbook.write(out);
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }



//   选择导出
    @RequestMapping("/exportActivityXz.do")
    public void exportActivityXz(String[] ids,HttpServletResponse response){
        //通过业务层查询市场活动的所有记录
        List<Activity> aList=activityService.getActivityListByIds(ids);
        //创建一个excel 文件
        HSSFWorkbook workbook=new HSSFWorkbook();
    //        通过文件创建一页
        HSSFSheet sheet=workbook.createSheet();
    //        通过页创建一行
        HSSFRow row=sheet.createRow(0);
        //创建第一行下的第1个单元格
        HSSFCell cell = row.createCell(0);
        cell.setCellValue("id");

        //创建第一行下的第2个单元格
        cell = row.createCell(1);
        cell.setCellValue("owner");

        //创建第一行下的第3个单元格
        cell = row.createCell(2);
        cell.setCellValue("name");

        //创建第一行下的第4个单元格
        cell = row.createCell(3);
        cell.setCellValue("startDate");

        //创建第一行下的第5个单元格
        cell = row.createCell(4);
        cell.setCellValue("endDate");

        //创建第一行下的第6个单元格
        cell = row.createCell(5);
        cell.setCellValue("cost");

        //创建第一行下的第7个单元格
        cell = row.createCell(6);
        cell.setCellValue("description");

        //创建第一行下的第8个单元格
        cell = row.createCell(7);
        cell.setCellValue("createTime");

        //创建第一行下的第9个单元格
        cell = row.createCell(8);
        cell.setCellValue("createBy");

        //创建第一行下的第10个单元格
        cell = row.createCell(9);
        cell.setCellValue("editTime");

        //创建第一行下的第11个单元格
        cell = row.createCell(10);
        cell.setCellValue("editBy");
    //        遍历sList取值填充excel
        for (int i=0;i<aList.size();i++){
    //            取出每一个市场活动，将数据填充到每一个单元格
            Activity a=aList.get(i);
            row = sheet.createRow(i+1);
            //创建第一行下的第1个单元格
            cell = row.createCell(0);
            cell.setCellValue(a.getId());

            //创建第一行下的第2个单元格
            cell = row.createCell(1);
            cell.setCellValue(a.getOwner());

            //创建第一行下的第3个单元格
            cell = row.createCell(2);
            cell.setCellValue(a.getName());

            //创建第一行下的第4个单元格
            cell = row.createCell(3);
            cell.setCellValue(a.getStartDate());

            //创建第一行下的第5个单元格
            cell = row.createCell(4);
            cell.setCellValue(a.getEndDate());

            //创建第一行下的第6个单元格
            cell = row.createCell(5);
            cell.setCellValue(a.getCost());

            //创建第一行下的第7个单元格
            cell = row.createCell(6);
            cell.setCellValue(a.getDescription());

            //创建第一行下的第8个单元格
            cell = row.createCell(7);
            cell.setCellValue(a.getCreateTime());

            //创建第一行下的第9个单元格
            cell = row.createCell(8);
            cell.setCellValue(a.getCreateBy());

            //创建第一行下的第10个单元格
            cell = row.createCell(9);
            cell.setCellValue(a.getEditTime());

            //创建第一行下的第11个单元格
            cell = row.createCell(10);
            cell.setCellValue(a.getEditBy());

        }
        //为客户浏览器提供下载框
        response.setContentType("octets/stream");
        response.setHeader("Content-Disposition","attachment;filename=Activity-"+DateTimeUtil.getSysTime()+".xls");

        OutputStream out= null;
        try {
            out = response.getOutputStream();
            workbook.write(out);
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }



//    上传
    @RequestMapping("/importActivity.do")
    @ResponseBody
    public Map<String,Object> importActivity(@RequestParam("myFile")MultipartFile file, HttpServletRequest request) throws AjaxRequestException {

//        取得文件的名称
        String fileName=DateTimeUtil.getSysTimeForUpload();
//        取得文件上传的路径

//        通过全局作用域对象realpath方法来取得虚拟路径下的真实路径
        String path=request.getServletContext().getRealPath("/tmpDic");
        System.out.println("-------------------"+path);

        try {
            file.transferTo(new File(path+"/"+fileName));

            InputStream input=new FileInputStream(path+"/"+fileName);

            HSSFWorkbook workbook=new HSSFWorkbook(input);
        //取得第一页中的信息
            HSSFSheet sheet=workbook.getSheetAt(0);
            List<Activity> aList=new ArrayList<>();

            HSSFRow row=null;

            for (int i=1;i<sheet.getLastRowNum()+1;i++){
                row=sheet.getRow(i);
                Activity a=new Activity();
                a.setId(UUIDUtil.getUUID());
                HSSFCell cell=null;
                for (int j=1;j<row.getLastCellNum();j++){
                    cell=row.getCell(j);
                    if(j==1){

                        a.setOwner(cell.getStringCellValue());

                    }else if(j==2){

                        a.setName(cell.getStringCellValue());

                    }else if(j==3){

                        a.setStartDate(cell.getStringCellValue());

                    }else if(j==4){

                        a.setEndDate(cell.getStringCellValue());

                    }else if(j==5){

                        a.setCost(cell.getStringCellValue());

                    }else if(j==6){

                        a.setDescription(cell.getStringCellValue());

                    }else if(j==7){

                        a.setCreateTime(cell.getStringCellValue());

                    }else if(j==8){

                        a.setCreateBy(cell.getStringCellValue());

                    }else if(j==9){

                        a.setEditTime(cell.getStringCellValue());

                    }else if(j==10){

                        a.setEditBy(cell.getStringCellValue());

                    }
                }
                aList.add(a);
            }
//            添加
            activityService.saveActivityList(aList);
            workbook.close();

        } catch (Exception e) {

            e.printStackTrace();
            throw new AjaxRequestException();

        }
        return HandleFlag.successTrue();


    }
*/







    @RequestMapping("/toActivityDetail.do")
    public ModelAndView toActivityDetail(String id){
        Activity a=activityService.getActivityListByIdForOwner(id);

        ModelAndView mav=new ModelAndView();
        mav.addObject("a", a);
        mav.setViewName("/workbench/activity/detail");

        return mav;
        
    }



    @RequestMapping("/getRemarkListByAid.do")
    @ResponseBody
    public List<ActivityRemark> getRemarkListByAid(String activityId){
        List<ActivityRemark> aList=activityService.getRemarkListByAid(activityId);
        return aList;
    }
//    删除
    @RequestMapping("/deleteRemarkById.do")
    @ResponseBody
    public Map<String,Object> deleteRemarkById(String id){
        activityService.deleteRemarkById(id);
        return HandleFlag.successTrue();
        
    }


    @RequestMapping("/saveRemark.do")
    @ResponseBody
    public Map<String,Object> savaRemark(ActivityRemark ar,HttpSession session){
        ar.setId(UUIDUtil.getUUID());
        String createTime=DateTimeUtil.getSysTime();
        String createBy=((User)session.getAttribute("user")).getName();
        ar.setCreateBy(createBy);
        ar.setCreateTime(createTime);
        ar.setEditFlag("0");
        activityService.saveRemark(ar);
        //    要他 {"success":true,"ar":{备注}}

/*      1
        Map<String,Object> map=new HashMap<>();
        map.put("success", true);
        map.put("ar", ar);
        return map;
        */

//      2
        return HandleFlag.successObj("ar",ar);
        
    }



    @RequestMapping("/updateRemark.do")
    @ResponseBody
    public Map<String,Object> updateRemark(ActivityRemark ar,HttpSession session){
        String editTime=DateTimeUtil.getSysTime();
        String editBy=((User)session.getAttribute("user")).getName();

        ar.setEditFlag("1");
        ar.setEditBy(editBy);
        ar.setEditTime(editTime);

        activityService.updateRemark(ar);
        return HandleFlag.successObj("ar", ar);
        
    }

    

}
