package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.Tran;

/**
 * Author:孙康
 * 2019/11/28
 */
public interface ClueService {
    void saveClue(Clue c);

    Clue getClueByIdForOwner(String id);

    void deleteRelationById(String id);

    void saveRelation(String clueId, String[] activityIds);

    boolean convert(String clueId, Tran t, String flag, String createBy);
}
