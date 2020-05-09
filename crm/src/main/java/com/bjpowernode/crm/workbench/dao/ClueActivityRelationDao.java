package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

public interface ClueActivityRelationDao {


    void deleteRelationById(String id);

    void saveRalationList(List<ClueActivityRelation> clueActivityRelationList);

    void saveRalation(ClueActivityRelation car);

    List<ClueActivityRelation> getRelationListByClueId(String clueId);

    void deleteRelationByClueId(String clueId);
}
