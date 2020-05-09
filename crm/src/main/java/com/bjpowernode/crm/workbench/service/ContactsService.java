package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Contacts;

import java.util.List;

/**
 * Author:孙康
 * 2019/12/4
 */
public interface ContactsService {
    List<Contacts> gteContactsListByFullname(String fullname);
}
