package dao;

import entity.ProjectCase;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.Map;

@Repository
public interface ProjectCaseDao extends BaseDao<ProjectCase>{
    long getTotalByProjectId(int project_id);
    long getTotalByUserId(int user_id);
    public ArrayList<ProjectCase> findByProjectId(int id);
    public ArrayList<ProjectCase> findByProjectIdWithPage(Map<String, Object> map);
    public ArrayList<ProjectCase> findByCaseId(int id);
}
