package dao;
import java.util.ArrayList;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

public interface BaseDao<T> {
	public int insert(T t);
	public int update(T t);
	public int delete(int id);
	public ArrayList<T> find(Map map);
	public ArrayList<T> isExist(Map map);
	public T findByIntId(int id);
	public T findByStringId(String t_id);
	public ArrayList<T> all();
	public Long getTotal(Map<String, Object> map);
//	public ArrayList<T> list(Map<String, Object> map);
}
