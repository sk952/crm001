package com.bjpowernode.crm.settings.dao;

import com.bjpowernode.crm.settings.domain.DicType;

import java.util.List;

/**
 * Author:孙康
 * 2019/11/18
 */
public interface DicTypeDao {
    List<DicType> getDicTypeList();

    int checkCode(String code);

    void saveType(DicType dt);

    DicType getTypeByCode(String code);

    void updateType(DicType dt);

    void deleteType(String[] codes);

    List<DicType> getValueList();

    void deletevalue(String[] codes);

}
