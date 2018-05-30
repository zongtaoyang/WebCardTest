package service.impl;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.BaseDao;
import service.BaseService;

@Service
public class BaseServiceImpl<T> implements BaseService<T> {

    // 注入Service依赖
    @Autowired
    private BaseDao<T> baseDao;

    @Override
    public ArrayList<T> all() {
        // TODO Auto-generated method stub
        return baseDao.all();
    }

    @Override
    public int update(T t) {
        return baseDao.update(t);
    }

    @Override
    public int insert(T t) {
        // TODO Auto-generated method stub
        return baseDao.insert(t);
    }

    @Override
    public int delete(int id) {
        // TODO Auto-generated method stub
        return baseDao.delete(id);
    }

    @Override
    public Long getTotal(Map<String, Object> map) {
        return baseDao.getTotal(map);
    }

    @Override
    public ArrayList<T> find(Map map) {
        // TODO Auto-generated method stub
        return baseDao.find(map);
    }

    @Override
    public ArrayList<T> isExist(Map map) {
        // TODO Auto-generated method stub
        return baseDao.isExist(map);
    }

    @Override
    public T findByIntId(int id) {
        // TODO Auto-generated method stub
        return baseDao.findByIntId(id);
    }

    @Override
    public T findByStringId(String t_id) {
        // TODO Auto-generated method stub
        return baseDao.findByStringId(t_id);
    }

    public BaseDao<T> getBaseDao() {
        return baseDao;
    }

    public void setBaseDao(BaseDao<T> baseDao) {
        this.baseDao = baseDao;
    }
}
