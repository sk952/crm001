package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.exception.AjaxRequestException;
import com.bjpowernode.crm.exception.TraditionRequestException;
import com.bjpowernode.crm.settings.domain.DicType;
import com.bjpowernode.crm.settings.domain.DicValue;

import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/11/18
 */
public interface DicService {
    List<DicType> getDicTypeList();

    void checkCode(String code) throws AjaxRequestException;

    boolean checkCode1(String code);

    void saveType(DicType dt) throws TraditionRequestException;

    DicType getTypeByCode(String code);

    void updateType(DicType dt);

    void deleteType(String[] codes);

    List<DicType> getValueList();

    void saveValue(DicValue dv);

    void deletevalue(String[] codes);

    DicValue getValueByCode(String value);

    void updateValue(DicValue dt);

    boolean checkCode2(String code);

    Map<String, List<DicValue>> getDicValueList();

//    void updateValue(DicValue dt);
}
