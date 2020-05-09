package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Customer;

import java.util.List;

public interface CustomerDao {

    Customer getCusByName(String company);

    void saveCustomer(Customer cus);

    List<String> getCustomerNamesByName(String name);
}
