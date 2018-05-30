package dao;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import entity.User;

@Repository
public interface UserDao extends BaseDao<User>{
	public User login(@Param("login_name") String login_name, @Param("password") String password);
}
