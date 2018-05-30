package service.impl;

import java.util.ArrayList;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.UserDao;
import entity.User;
import service.UserService;

@Service
public class UserServiceImpl extends BaseServiceImpl<User> implements UserService {
	
    private UserDao userDao;
    
    @Resource
    public void setUserDao(UserDao userDao){
    	this.userDao = userDao;
    	super.setBaseDao(userDao);
    }
    
	public User login(String login_name, String password){
		return userDao.login(login_name, password);
	}
}
