package service.impl;

import dao.*;
import dto.ProjectCaseDto;
import dto.ProjectStatistic;
import dto.ProjectUserDto;
import entity.*;
import org.springframework.stereotype.Service;
import service.ProjectService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

@Service
public class ProjectServiceImpl extends BaseServiceImpl<Project> implements ProjectService {

    private ProjectDao projectDao;
    private ExecuteDao executeDao;//用于查询执行记录，并计算project的进度
    private ProjectCaseDao projectCaseDao;//用于查询某project的case列表
    private ProjectUserDao projectUserDao;//用于车讯某project的user列表
    private UserDao userDao;//用于查询某个user id对应的name
    private CaseDao caseDao;//用于查询某个case id对应的name

    @Resource
    public void setProjectDao(ProjectDao projectDao) {
        this.projectDao = projectDao;
    }

    @Resource
    public void setExecuteDao(ExecuteDao executeDao) {
        this.executeDao = executeDao;
    }

    @Resource
    public void setProjectCaseDao(ProjectCaseDao projectCaseDao) {
        this.projectCaseDao = projectCaseDao;
    }

    @Resource
    public void setProjectUserDao(ProjectUserDao projectUserDao) {
        this.projectUserDao = projectUserDao;
    }

    @Resource
    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Resource
    public void setCaseDao(CaseDao caseDao) {
        this.caseDao = caseDao;
    }


    //==============================================================================
    //               project
    //==============================================================================

    /**
     * 查询Project信息
     *
     * @param map
     * @return
     */
    @Override
    public ArrayList<ProjectStatistic> findByNameWithPage(Map<String, Object> map) {
        ArrayList<ProjectStatistic> statisticsArray = new ArrayList<ProjectStatistic>();
        ArrayList<Project> arraylist = projectDao.find(map);
        System.out.println("Project arraylist->" + arraylist);
        for (int i = 0; i < arraylist.size(); i++) {
            Project project = arraylist.get(i);

            ArrayList<User> prjectUserList = new ArrayList<User>();
            ArrayList<Case> prjectCaseList = new ArrayList<Case>();

            //根据project id 获取user列表
            ArrayList<ProjectUser> projectUserArrayList = projectUserDao.findByProjectId(project.getId());
            for (int j = 0; j < projectUserArrayList.size(); j++) {
                if (null != userDao.findByIntId(projectUserArrayList.get(j).getUser_id())) {
                    prjectUserList.add(userDao.findByIntId(projectUserArrayList.get(j).getUser_id()));
                }
            }

            //根据project id 获取case列表
            ArrayList<ProjectCase> projectCaseArrayList = projectCaseDao.findByProjectId(project.getId());
            for (int k = 0; k < projectCaseArrayList.size(); k++) {
                if (null != caseDao.findByIntId(projectCaseArrayList.get(k).getCase_id())) {
                    prjectCaseList.add(caseDao.findByIntId(projectCaseArrayList.get(k).getCase_id()));
                }
            }

            ProjectStatistic projectStatistic = new ProjectStatistic();
            projectStatistic.setId(project.getId());
            projectStatistic.setName(project.getName());
            projectStatistic.setDescription(project.getDescription());
            projectStatistic.setCase_list(prjectCaseList);
            projectStatistic.setUser_list(prjectUserList);
            projectStatistic.setCreate_time(project.getCreate_time());
            projectStatistic.setUpdate_time(project.getUpdate_time());
            projectStatistic.setTest_progress(0);//TODO
            statisticsArray.add(projectStatistic);
        }

        return statisticsArray;
    }


    @Override
    public Long getProjectTotal(Map<String, Object> map) {
        return projectDao.getTotal(map);
    }


    //==============================================================================
    //               project_user
    //==============================================================================
    @Override
    public ArrayList<ProjectUserDto> findProjectUser(Map<String, Object> map) {

        ArrayList<ProjectUserDto> projectUsersDto = new ArrayList<ProjectUserDto>();

        if (map.get("project_id") != null && map.get("project_id") != "") {

            ArrayList<ProjectUser> projectUsers = projectUserDao.findByProjectIdWithPage(map);

            for (int i = 0; i < projectUsers.size(); i++) {
                ProjectUser projectUser = projectUsers.get(i);
                ProjectUserDto projectUserDto = new ProjectUserDto();
                projectUserDto.setProject_id(projectUser.getProject_id());
                projectUserDto.setUser_id(projectUser.getUser_id());
                projectUserDto.setCreate_time(projectUser.getCreate_time());
                User user = userDao.findByIntId(projectUsers.get(i).getUser_id());
                projectUserDto.setLogin_name(user.getLogin_name());
                projectUserDto.setUser_name(user.getUser_name());
                projectUsersDto.add(projectUserDto);
            }
        }

        return projectUsersDto;
    }

    @Override
    public Long getProjectUserTotal(Map<String, Object> map) {
        if (map.isEmpty()) {
            return Long.valueOf(-1);
        }
        if (map.get("project_id") != null && map.get("project_id") != "") {
            int project_id = Integer.valueOf(map.get("project_id").toString());
            return projectUserDao.getTotalByProjectId(project_id);
        }
        if (map.get("user_id") != null && map.get("user_id") != "") {
            int user_id = Integer.valueOf(map.get("user_id").toString());
            return projectUserDao.getTotalByUserId(user_id);
        }
        return Long.valueOf(-1);
    }

    @Override
    public int addUserToProject(int projectId, int userId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("project_id", projectId);
        map.put("user_id", userId);
        int ret = 0;
        if (projectUserDao.isExist(map).size() == 0) {
            ProjectUser projectUser = new ProjectUser(projectId, userId);
            ret = projectUserDao.insert(projectUser);
        }
        return ret;
    }

    @Override
    public int deleteUserFromProject(Map<String, Object> map) {
        if (map.get("project_id") != null && map.get("project_id").toString().length() > 0
                && map.get("user_id") != null && map.get("user_id").toString().length() > 0) {
            return projectUserDao.deleteProjectUser(map);
        } else {
            return 0;
        }

    }


    //==============================================================================
    //               project_case
    //==============================================================================
    @Override
    public ArrayList<ProjectCaseDto> findProjectCase(Map<String, Object> map) {

        ArrayList<ProjectCaseDto> cases = new ArrayList<ProjectCaseDto>();

        if (map.get("project_id") != null && map.get("project_id") != "") {
            ArrayList<ProjectCase> projectCases = projectCaseDao.findByProjectIdWithPage(map);
            for (int i = 0; i < projectCases.size(); i++) {
                ProjectCaseDto projectCaseDto = new ProjectCaseDto();
                ProjectCase projectCase = projectCases.get(i);
                projectCaseDto.setProject_id(projectCase.getProject_id());
                projectCaseDto.setCase_id(projectCase.getCase_id());
                projectCaseDto.setCreate_time(projectCase.getCreate_time());
                Case acase = caseDao.findByIntId(projectCases.get(i).getCase_id());
                projectCaseDto.setName(acase.getName());
                projectCaseDto.setDescription(acase.getDescription());
                cases.add(projectCaseDto);
            }
        }

        return cases;
    }

    @Override
    public Long getProjectCaseTotal(Map<String, Object> map) {
        if (map.isEmpty()) {
            return Long.valueOf(-1);
        }
        if (map.get("project_id") != null && map.get("project_id") != "") {
            int project_id = Integer.valueOf(map.get("project_id").toString());
            return projectCaseDao.getTotalByProjectId(project_id);
        }
        if (map.get("case_id") != null && map.get("case_id") != "") {
            int user_id = Integer.valueOf(map.get("case_id").toString());
            return projectCaseDao.getTotalByUserId(user_id);
        }
        return Long.valueOf(-1);
    }


    @Override
    public int addCaseToProject(int projectId, int caseId) {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("project_id", projectId);
        map.put("case_id", caseId);
        int ret = 0;
        if (projectCaseDao.isExist(map).size() == 0) {
            ProjectCase projectCase = new ProjectCase(projectId, caseId);
            ret = projectCaseDao.insert(projectCase);
        }
        return ret;
    }

    @Override
    public int deleteCaseFromProject(Map<String, Object> map) {
        if (map.get("project_id") != null && map.get("project_id").toString().length() > 0
                && map.get("case_id") != null && map.get("case_id").toString().length() > 0) {
            return projectUserDao.deleteProjectUser(map);
        } else {
            return 0;
        }

    }


}
