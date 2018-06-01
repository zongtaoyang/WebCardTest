package service;

import dto.ProjectCaseDto;
import dto.ProjectStatistic;
import dto.ProjectUserDto;
import entity.Case;
import entity.Project;
import entity.User;

import java.util.ArrayList;
import java.util.Map;

public interface ProjectService extends BaseService<Project> {

    //------------------------------------------------------
    public Long getProjectTotal(Map<String, Object> map);

    public ArrayList<ProjectStatistic> findByNameWithPage(Map<String, Object> map);

    //------------------------------------------------------
    public ArrayList<ProjectUserDto> findProjectUser(Map<String, Object> map);

    Long getProjectUserTotal(Map<String, Object> map);

    public int addUserToProject(int projectId, int userId);

    public int deleteUserFromProject(Map<String, Object> map);

    //------------------------------------------------------
    public ArrayList<ProjectCaseDto> findProjectCase(Map<String, Object> map);

    Long getProjectCaseTotal(Map<String, Object> map);

    public int addCaseToProject(int projectId, int userId);

    public int deleteCaseFromProject(Map<String, Object> map);
}
