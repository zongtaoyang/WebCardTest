package dao;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import entity.CGroup;

@Repository
public interface GroupDao extends BaseDao<CGroup>{
	public CGroup login(@Param("login_name") String login_name, @Param("password") String password);
}
