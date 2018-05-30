package service.impl;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.GroupDao;
import entity.CGroup;
import service.GroupService;

@Service
public class GroupServiceImpl extends BaseServiceImpl<CGroup> implements GroupService {
	
    private GroupDao groupDao;
    
    @Resource
    public void setGroupDao(GroupDao groupDao){
    	this.groupDao = groupDao;
    	super.setBaseDao(groupDao);
    }
}
