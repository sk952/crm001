package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.exception.AjaxRequestException;
import com.bjpowernode.crm.exception.TraditionRequestException;
import com.bjpowernode.crm.settings.dao.DicTypeDao;
import com.bjpowernode.crm.settings.dao.DicValueDao;
import com.bjpowernode.crm.settings.domain.DicType;
import com.bjpowernode.crm.settings.domain.DicValue;
import com.bjpowernode.crm.settings.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/18
 */
@Service
public class DicServiceImpl implements DicService {
    @Autowired
    private DicTypeDao dicTypeDao;
    @Autowired
    private DicValueDao dicValueDao;

    @Override
    public List<DicType> getDicTypeList() {
        List<DicType> dtList=dicTypeDao.getDicTypeList();

        return dtList;
    }

    @Override
    public void checkCode(String code) throws AjaxRequestException {
        int count=dicTypeDao.checkCode(code);
        //count=1有重复 等于0没重复
        if (count==1){
            throw new AjaxRequestException();
        }



    }


   /* @Override
    public List<DicType> getDicTypeList() {
        List<DicType> dtList=dicTypeDao.getDicTypeList();

        return dtList;
    }*/


   @Override
   public boolean checkCode1(String code) {
       int count=dicTypeDao.checkCode(code);
       boolean flag=true;

       if (count==1){
           flag=false;

       }
       return flag;
   }

    @Override
    public boolean checkCode2(String code) {
        int count=dicValueDao.checkCode2(code);
        boolean flag=true;

        if (count==1){
            flag=false;

        }
        return flag;

    }

    @Override
    public void saveType(DicType dt) throws TraditionRequestException {
        dicTypeDao.saveType(dt);
    }
//保存。更新。字典值的

    @Override
    public void updateValue(DicValue dt) {
        dicValueDao.updateValue(dt);

    }

    //字典值修改
    @Override
    public DicValue getValueByCode(String value) {
        DicValue dt=dicValueDao.getValueByCode(value);
        return dt;
    }

    @Override
    public void deletevalue(String[] codes) {
/*        //删除字典值
        dicValueDao.deleteByCodes(codes);*/
        //删除
        dicTypeDao.deletevalue(codes);


    }

    //添加
    @Override
    public void saveValue(DicValue dv) {
       dicValueDao.saveValue(dv);

    }

    @Override
    public DicType getTypeByCode(String code) {
       DicType dt=dicTypeDao.getTypeByCode(code);
        return dt;
    }

    //查询
    @Override
    public List<DicType> getValueList() {
        List<DicType> dvList=dicTypeDao.getValueList();
        return dvList;
    }

    //删除
    @Override
    public void deleteType(String[] codes) {
       //在删除一之前先删除，一关联所有的多
        //删除字典值
        dicValueDao.deleteByCodes(codes);
        //删除字典类型
        dicTypeDao.deleteType(codes);

    }

    //更新
    @Override
    public void updateType(DicType dt) {
       dicTypeDao.updateType(dt);

    }



//

    @Override
    public Map<String, List<DicValue>> getDicValueList() {

       Map<String,List<DicValue>> map=new HashMap<>();

       //查询字典类型编码，取出所有字典类型编码
        List<DicType> dtList=dicTypeDao.getDicTypeList();

        //通过每一个字典类型编码，取得对应的dvList,将各组键值对保存到map
        for (DicType dt:dtList){
            String code=dt.getCode();
            List<DicValue> dvList=dicValueDao.getDicValueListByCode(code);
            map.put(code+"List", dvList);
        }
        //返回map
        return map;
    }

}
