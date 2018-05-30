package service.impl;

import dao.*;
import dto.ProjectStatistic;
import entity.*;
import org.springframework.stereotype.Service;
import service.ProjectService;

import javax.annotation.Resource;
import java.util.ArrayList;
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
    public ArrayList<User> findProjectUserByProjectId(Map<String, Object> map) {
        ArrayList<User> users = new ArrayList<User>();
        ArrayList<ProjectUser> projectUsers = projectUserDao.findByProjectIdWithPage(map);
        for(int i=0;i<projectUsers.size();i++){
            User user = userDao.findByIntId(projectUsers.get(i).getUser_id());
            user.setCtime(projectUsers.get(i).getCreate_time());
            users.add(user);
        }
        return users;
    }

    @Override
    public ArrayList<Case> findProjectCaseByProjectId(Map<String, Object> map){
        ArrayList<Case> cases = new ArrayList<Case>();
        ArrayList<ProjectCase> projectCases = projectCaseDao.findByProjectIdWithPage(map);
        for(int i=0;i<projectCases.size();i++){
            Case acase = caseDao.findByIntId(projectCases.get(i).getCase_id());
            acase.setCtime(projectCases.get(i).getCreate_time());
            cases.add(acase);
        }
        return cases;
    }

    @Override
    public int addUserToProject(int projectId, int userId) {
        ProjectUser projectUser =new ProjectUser(projectId, userId);
        return projectUserDao.insert(projectUser);
    }

    @Override
    public Long getProjectTotal(Map<String,Object> map) {
        return projectDao.getTotal(map);
    }

    @Override
    public Long getProjectUserTotal(Map<String,Object> map) {
        if(map.isEmpty()){
            return Long.valueOf(-1);
        }
        if(map.get("project_id")!=null&&map.get("project_id")!=""){
            int project_id = Integer.valueOf(map.get("project_id").toString());
            return projectUserDao.getTotalByProjectId(project_id);
        }
        if(map.get("user_id")!=null&&map.get("user_id")!=""){
            int user_id = Integer.valueOf(map.get("user_id").toString());
            return projectUserDao.getTotalByUserId(user_id);
        }
        return Long.valueOf(-1);
    }

    @Override
    public Long getProjectCaseTotal(Map<String,Object> map) {
        if(map.isEmpty()){
            return Long.valueOf(-1);
        }
        if(map.get("project_id")!=null&&map.get("project_id")!=""){
            int project_id = Integer.valueOf(map.get("project_id").toString());
            return projectCaseDao.getTotalByProjectId(project_id);
        }
        if(map.get("case_id")!=null&&map.get("case_id")!=""){
            int user_id = Integer.valueOf(map.get("case_id").toString());
            return projectCaseDao.getTotalByUserId(user_id);
        }
        return Long.valueOf(-1);
    }


}
