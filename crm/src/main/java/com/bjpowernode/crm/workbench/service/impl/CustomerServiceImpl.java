package com.bjpowernode.crm.workbench.service.impl;

import com.bjpowernode.crm.workbench.dao.CustomerDao;
import com.bjpowernode.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Author:孙康
 * 2019/12/4
 */
@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private CustomerDao customerDao;

    @Override
    public List<String> getCustomerNamesByName(String name) {
        List<String> sList=customerDao.getCustomerNamesByName(name);
        return sList;
    }
}
