package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.utils.DateTimeUtil;
import com.bjpowernode.crm.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.dao.CustomerDao;
import com.bjpowernode.crm.workbench.dao.TranDao;
import com.bjpowernode.crm.workbench.dao.TranHistoryDao;
import com.bjpowernode.crm.workbench.domain.Customer;
import com.bjpowernode.crm.workbench.domain.Tran;
import com.bjpowernode.crm.workbench.domain.TranHistory;
import com.bjpowernode.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Author:孙康
 * 2019/12/4
 */
@Service
public class TranServiceImpl implements TranService {

    @Autowired
    private TranDao tranDao;

    @Autowired
    private TranHistoryDao tranHistoryDao;

    @Autowired
    private CustomerDao customerDao;

    @Override
    public void saveTran(Tran t, String customerName) {
        Customer cus =customerDao.getCusByName(customerName);
        if (cus==null){
//            如果没有这个客户，则根据客户的名称，新建客户
            cus=new Customer();
            cus.setId(UUIDUtil.getUUID());
            cus.setCreateTime(DateTimeUtil.getSysTime());
            cus.setCreateBy(t.getCreateBy());
            cus.setName(customerName);
            cus.setOwner(t.getOwner());
            cus.setNextContactTime(t.getNextContactTime());

//            添加客户
            customerDao.saveCustomer(cus);
        }

//        为t对象，封装客户的id信息
        t.setCustomerId(cus.getId());
//        添加交易
        tranDao.saveTran(t);

//        添加交易历史
        TranHistory th=new TranHistory();
        th.setId(UUIDUtil.getUUID());
        th.setCreateTime(DateTimeUtil.getSysTime());
        th.setCreateBy(t.getCreateBy());
        th.setExpectedDate(t.getExpectedDate());
        th.setStage(t.getStage());
        th.setMoney(t.getMoney());
        th.setTranId(t.getId());

        tranHistoryDao.saveTranHistory(th);
        
    }

    @Override
    public Tran getByIdForOwner(String id) {
        Tran t=tranDao.getByIdForOwner(id);
        
        return t;
    }

    @Override
    public List<TranHistory> getHistoryListByTranId(String tranId) {
        List<TranHistory> thList=tranHistoryDao.getHistoryListByTranId(tranId);
        
        return thList;
    }


    @Override
    public void updateTranStage(Tran t) {
//        更新阶段
        tranDao.updateTranStage(t);

//        添加交易历史
        TranHistory th=new TranHistory();
        th.setId(UUIDUtil.getUUID());
        th.setCreateBy(t.getEditBy());
        th.setCreateTime(DateTimeUtil.getSysTime());
        th.setExpectedDate(t.getExpectedDate());
        th.setStage(t.getStage());
        th.setMoney(t.getMoney());
        th.setTranId(t.getId());

        tranHistoryDao.saveTranHistory(th);
        
    }
//取统计图表的数据
    @Override
    public Map<String, Object> getChartData() {
//        取得dataList,
           List<Map<String,Object>> dataList=tranDao.getChartData();
//        取得max
           int max=tranDao.getStageCountMax();
//        取得stageNameList
        List<String> stageNameList=tranDao.getStageNameList();

//        创建一个map对象，将以上dataList和map保存起来
            Map<String,Object> map=new HashMap<>();
            map.put("dataList", dataList);
            map.put("max",max);
            map.put("stageNameList", stageNameList);
//
//        返回map
        
        return map;
    }
}
