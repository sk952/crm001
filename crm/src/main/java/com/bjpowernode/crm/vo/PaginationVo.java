package com.bjpowernode.crm.vo;

import com.bjpowernode.crm.workbench.domain.Activity;
//import org.apache.poi.ss.formula.functions.T;

import java.util.List;

/**
 * Author:孙康
 * 2019/11/23
 */

import java.util.List;

public class PaginationVo<T> {
    private List<T> dataList;
    private int total;


    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }
}
