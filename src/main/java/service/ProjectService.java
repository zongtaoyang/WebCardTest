package service;

import dto.ProjectStatistic;
import entity.Case;
import entity.Project;
import entity.User;

import java.util.ArrayList;
import java.util.Map;

public interface ProjectService extends BaseService<Project> {

    public ArrayList<ProjectStatistic> findByNameWithPage(Map<String, Object> map);

    public ArrayList<User> findProjectUser(Map<String, Object> map);

    public ArrayList<Case> findProjectCase(Map<String, Object> map);

    public int addUserToProject(int projectId, int userId);

    public Long getProjectTotal(Map<String,Object> map);

    Long getProjectUserTotal(Map<String, Object> map);

    Long getProjectCaseTotal(Map<String, Object> map);
}
