package com.bjpowernode.crm.settings.domain;

/**
 * Author:孙康
 * 2019/11/18
 */
public class DicValue {
    private String id;//主键
    private String value;//字典值
    private String text;//字典文本
    private String orderNo;//排序号
    private String typeCode;//类型编码

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getOrderNo() {
        return orderNo;
    }

    public void setOrderNo(String orderNo) {
        this.orderNo = orderNo;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }
}
