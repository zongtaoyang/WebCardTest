package service;

import java.util.ArrayList;
import java.util.Map;

public interface BaseService<T> {
    public int insert(T t);

    public int update(T t);

    public int delete(int id);

    /**
     * 获取总记录数
     * @param map
     * @return
     */
    public Long getTotal(Map<String, Object> map);

    public ArrayList<T> find(Map map);

    public ArrayList<T> isExist(Map map);

    public T findByIntId(int id);

    public T findByStringId(String t_id);

    public ArrayList<T> all();
}
