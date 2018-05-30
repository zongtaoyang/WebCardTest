package service;

import java.util.ArrayList;

import entity.User;

public interface UserService extends BaseService<User>{
	User login(String loginName, String password);
}
