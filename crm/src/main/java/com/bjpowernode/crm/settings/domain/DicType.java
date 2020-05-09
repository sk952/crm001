package com.bjpowernode.crm.settings.domain;

/**
 * Author:孙康
 * 2019/11/18
 */
public class DicType {
    private String code;//字典类型编码
    private String name;//类型名称
    private String description;//类型描述

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
