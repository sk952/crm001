/*
package com.bjpowernode.crm.test;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

*/
/**
 * 动力节点
 * 2019/11/25
 *//*

public class ExcelTest {

    public static void main(String[] args) {

        Student s1 = new Student("A0001","wyf",23);
        Student s2 = new Student("A0002","lh",24);
        Student s3 = new Student("A0003","cxk",25);

        List<Student> sList = new ArrayList<>();

        sList.add(s1);
        sList.add(s2);
        sList.add(s3);

        //创建一个excel文件
        HSSFWorkbook workbook = new HSSFWorkbook();

        //通过文件，创建一页
        HSSFSheet sheet = workbook.createSheet();

        //通过页，创建一行
        */
/*

            行的创建要通过下标来指定是哪一行
            下标是通过从0开始的计数
            如下案例所示createRow(0)，表示创建的是第一行

         *//*

        HSSFRow row = sheet.createRow(0);

        //通过行，来创建行中的单元格
        */
/*

            单元格也是要共工作下标来指定是哪一格
            下标是通过从0开始的计数
            如下案例所示createCell(0)，表示是在当前行中创建的第一个单元格

         *//*

        HSSFCell cell = row.createCell(0);
        cell.setCellValue("id");

        //创建第一行下的第二个单元格
        cell = row.createCell(1);
        cell.setCellValue("name");

        //创建第一行下的第三个单元格
        cell = row.createCell(2);
        cell.setCellValue("age");


        //遍历sList取值填充excel
        for(int i=0;i<sList.size();i++){

            //取得每一个学生对象
            Student s = sList.get(i);

            //从第二行（下标为1）开始进行操作
            //注意：此处使用的是i+1，不能是++i
            row = sheet.createRow(i+1);

            cell = row.createCell(0);
            cell.setCellValue(s.getId());

            cell = row.createCell(1);
            cell.setCellValue(s.getName());

            cell = row.createCell(2);
            cell.setCellValue(s.getAge());

        }

        try {
            OutputStream out = new FileOutputStream(new File("D:\\study\\student.xls"));
            workbook.write(out);
            out.close();
            workbook.close();
        } catch (Exception e) {
            e.printStackTrace();
        }


    }

}




















































*/
