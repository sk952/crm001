package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.ContactsActivityRelation;

import java.util.List;

public interface ContactsActivityRelationDao {

    void saveRelationList(List<ContactsActivityRelation> contactsActivityRelationList);
}
