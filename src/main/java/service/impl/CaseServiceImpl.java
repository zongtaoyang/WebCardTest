package service.impl;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.CaseDao;
import entity.Case;
import service.CaseService;

@Service
public class CaseServiceImpl extends BaseServiceImpl<Case> implements CaseService {
	
    private CaseDao caseDao;
    
    @Resource
    public void setCaseDao(CaseDao caseDao){
    	this.caseDao = caseDao;
    	super.setBaseDao(caseDao);
    }
}
