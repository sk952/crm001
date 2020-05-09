package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/12/4
 */
public interface TranService {
    void saveTran(Tran t, String customerName);

    Tran getByIdForOwner(String id);

    List<TranHistory> getHistoryListByTranId(String tranId);

    void updateTranStage(Tran t);

    Map<String, Object> getChartData();
}
