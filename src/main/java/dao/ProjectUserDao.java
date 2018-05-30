package dao;

import entity.ProjectUser;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Map;

@Repository
public interface ProjectUserDao extends BaseDao<ProjectUser>{
    long getTotalByProjectId(int project_id);
    long getTotalByUserId(int user_id);
    public ArrayList<ProjectUser> findByProjectId(int project_id);
    public ArrayList<ProjectUser> findByProjectIdWithPage(Map<String, Object> map);
    public ArrayList<ProjectUser> findByUserId(int id);
}
