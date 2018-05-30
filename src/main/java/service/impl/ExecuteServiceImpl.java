package service.impl;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.ExecuteDao;
import entity.Execute;
import service.ExecuteService;

@Service
public class ExecuteServiceImpl extends BaseServiceImpl<Execute> implements ExecuteService {
	
    private ExecuteDao executeDao;
    
    @Resource
    public void setExecuteDao(ExecuteDao executeDao){
    	this.executeDao = executeDao;
    	super.setBaseDao(executeDao);
    }
}
