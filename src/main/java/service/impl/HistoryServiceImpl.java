package service.impl;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.HistoryDao;
import entity.History;
import service.HistoryService;

@Service
public class HistoryServiceImpl extends BaseServiceImpl<History> implements HistoryService {
	
    private HistoryDao historyDao;
    
    @Resource
    public void setHistoryDao(HistoryDao historyDao){
    	this.historyDao = historyDao;
    	super.setBaseDao(historyDao);
    }
}
