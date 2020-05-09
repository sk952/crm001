package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Contacts;

import java.util.List;

public interface ContactsDao {

    void saveContacts(Contacts con);


    List<Contacts> gteContactsListByFullname(String fullname);
}
