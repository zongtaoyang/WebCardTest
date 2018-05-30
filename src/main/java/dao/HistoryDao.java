package dao;
import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import entity.History;

@Repository
public interface HistoryDao extends BaseDao<History>{
	
}
