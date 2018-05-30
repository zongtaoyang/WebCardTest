package dao;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import entity.Role;

@Repository
public interface RoleDao extends BaseDao<Role>{
	public Role login(@Param("login_name") String login_name, @Param("password") String password);
}
