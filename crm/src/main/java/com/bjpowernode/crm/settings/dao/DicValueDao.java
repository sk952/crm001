package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.DicType;
import com.bjpowernode.crm.settings.domain.DicValue;

import java.util.List;

/**
 * Author:孙康
 * 2019/11/18
 */
public interface DicValueDao {
    void deleteByCodes(String[] codes);

    void saveValue(DicValue dv);

    DicValue getValueByCode(String value);

    void updateValue(DicValue dt);

    int checkCode2(String code);

    List<DicValue> getDicValueListByCode(String code);

//    void updateValue(DicType dt);
}
