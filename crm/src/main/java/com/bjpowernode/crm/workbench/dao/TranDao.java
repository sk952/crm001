package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    void saveTran(Tran t);

    Tran getByIdForOwner(String id);

    void updateTranStage(Tran t);

    List<Map<String, Object>> getChartData();

    int getStageCountMax();

    List<String> getStageNameList();
}
