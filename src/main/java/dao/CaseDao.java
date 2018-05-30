package dao;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import entity.Case;

@Repository
public interface CaseDao extends BaseDao<Case>{
	
}
