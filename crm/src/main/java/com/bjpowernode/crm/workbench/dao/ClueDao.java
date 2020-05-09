package com.bjpowernode.crm.workbench.dao;

import com.bjpowernode.crm.workbench.domain.Clue;
import com.bjpowernode.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

public interface ClueDao {


    void saveClue(Clue c);

    Clue getClueByIdForOwner(String id);

    Clue getById(String clueId);

    void deleteClueById(String clueId);
}
