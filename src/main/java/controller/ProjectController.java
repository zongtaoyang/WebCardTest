package controller;

import dto.ProjectStatistic;
import entity.Case;
import entity.PageBean;
import entity.Project;
import entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import process.ReturnObj;
import service.ProjectService;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("WebCardTest/project")
public class ProjectController {
    private final String TAG = "ProjectController->";

    @Autowired
    private ProjectService projectService;

    /**
     * 跳转到项目管理页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/manageproject")
    public ModelAndView manageproject() throws Exception {
        System.out.println(TAG + "manageproject->...");
        ModelAndView mv = new ModelAndView("WebCardTest/project/manageproject");
        System.out.println(TAG + "manageproject->mv=" + mv);
        return mv;
    }

    /**
     * 跳转到新增项目页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/toaddproject")
    public ModelAndView toaddproject() throws Exception {
        ModelAndView view = new ModelAndView("WebCardTest/project/addproject");
        return view;
    }

    /**
     * 跳转到修改项目页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/toeditprojectuser")
    public ModelAndView toeditprojectuser(int id) throws Exception {
        ModelAndView view = new ModelAndView("WebCardTest/project/editprojectuser");
        try {
            Project project = projectService.findByIntId(id);
            view.addObject("project", project);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return view;
    }

    /**
     * 跳转到修改项目页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/toeditprojectcase")
    public ModelAndView toeditprojectcase(int id) throws Exception {
        ModelAndView view = new ModelAndView("WebCardTest/project/editprojectcase");
        try {
            Project project = projectService.findByIntId(id);
            view.addObject("project", project);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return view;
    }

    /**
     * 跳转到修改项目人员页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/toeditproject")
    public ModelAndView toeditproject(int id) throws Exception {
        ModelAndView view = new ModelAndView("WebCardTest/project/editproject");
        try {
            Project project = projectService.findByIntId(id);
            view.addObject("project", project);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return view;
    }


    @RequestMapping(value = "/find", method = RequestMethod.GET)
    @ResponseBody
    private List<Project> find(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("project_id", request.getParameter("project_id"));
        map.put("begin_time", request.getParameter("begin_time"));
        map.put("end_time", request.getParameter("end_time"));
        List<ProjectStatistic> result = new ArrayList<ProjectStatistic>();
        List<Project> list = projectService.find(map);
        String page_size = request.getParameter("page_size");
        String page_num = request.getParameter("page_num");
        if (page_size != null && page_size != "") {
            if (page_num != null && page_num != "") {
                int page_size_int = Integer.valueOf(page_size);
                int page_num_int = Integer.valueOf(page_num);
                result = result.subList(page_size_int * page_num_int, page_size_int * (page_num_int + 1));
            }
        }
        //map.put相当于request.setAttribute方法
        return list;
    }

    @RequestMapping(value = "/list")
    @ResponseBody
    private Map<String, Object> list(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        String name = request.getParameter("name");
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        System.out.println(TAG + "list->name=" + name + "|page=" + page + "|rows=" + rows);

        PageBean pageBean = new PageBean(page, rows);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);
        map.put("page", pageBean.getStart());
        map.put("rows", pageBean.getRows());
        List<ProjectStatistic> array = projectService.findByNameWithPage(map);
        Long total = projectService.getProjectTotal(map);
//        JSONObject result=new JSONObject();
//        JSONArray jsonArray=JSONArray.fromObject(userList);
        result.put("rows", array);
        result.put("total", total);
//        ResponseUtil.write(res, result);

        System.out.println(TAG + "list array= " + array);
        return result;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    private ReturnObj edit(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        System.out.println(TAG + "edit->...");
        ReturnObj result = new ReturnObj(ReturnObj.SUCCESS, ReturnObj.SAVE_SUCCESS_MSG, null);
        try {
            request.setCharacterEncoding("UTF-8");
        } catch (UnsupportedEncodingException e) {

        }
        Project project = new Project();
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        System.out.println(TAG + "edit request->id=" + id + "|name=" + name + "|description=" + description);
        project.setName(name);
        project.setDescription(description);
        if (id == "" || id == null) {
            System.out.println(TAG + "edit->insert...");
            result.setMsg(ReturnObj.SAVE_SUCCESS_MSG);

            if (projectService.insert(project) == 0) {
                result.setSuccess(ReturnObj.FAIL);
                result.setMsg(ReturnObj.SAVE_FAIL_MSG);
            }
        } else {
            int id_int = Integer.parseInt(id);
            if (id_int >= 0) {
                System.out.println(TAG + "edit->update->id=" + id);
                project.setId(id_int);
                if (projectService.update(project) == 0) {
                    result.setMsg(ReturnObj.UPDATE_FAIL_MSG);
                    result.setSuccess(ReturnObj.FAIL);
                } else {
                    result.setMsg(ReturnObj.UPDATE_SUCCESS_MSG);
                    project.setId(Integer.valueOf(id));
                }
            } else {
                result.setMsg(ReturnObj.UPDATE_FAIL_MSG);
                result.setSuccess(ReturnObj.FAIL);
            }
        }
        return result;
    }

    @RequestMapping(value = "/remove", method = RequestMethod.GET)
    @ResponseBody
    private ReturnObj remove(int id) throws IllegalArgumentException, IllegalAccessException {
        System.out.println(TAG + "remove-> id= " + id);
        ReturnObj result = new ReturnObj();
        if (projectService.delete(id) == 0) {
            result.setSuccess(ReturnObj.FAIL);
            result.setMsg(ReturnObj.DELETE_FAIL_MSG);
        } else {
            result.setSuccess(ReturnObj.SUCCESS);
            result.setMsg(ReturnObj.DELETE_SUCCESS_MSG);
        }
        return result;
    }

    @RequestMapping(value = "/findProjectUser", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> findProjectUserByProjectId(HttpServletRequest request) throws IllegalArgumentException {
        System.out.println(TAG + "findProjectUser->");

        Map<String, Object> result = new HashMap<String, Object>();
        String project_id = request.getParameter("project_id");
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        System.out.println(TAG + "list->project_id=" + project_id + "|page=" + page + "|rows=" + rows);

        PageBean pageBean = new PageBean(page, rows);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("project_id", project_id);
        map.put("page", pageBean.getStart());
        map.put("rows", pageBean.getRows());
        ArrayList<User> array = projectService.findProjectUser(map);
        Long total = projectService.getProjectUserTotal(map);
//        JSONObject result=new JSONObject();
//        JSONArray jsonArray=JSONArray.fromObject(userList);
        result.put("rows", array);
        result.put("total", total);
//        ResponseUtil.write(res, result);

        System.out.println(TAG + "list array= " + array);
        return result;
    }


    @RequestMapping(value = "/findProjectCase", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> findProjectCaseByProjectId(HttpServletRequest request) throws IllegalArgumentException {
        System.out.println(TAG + "findProjectCase->");

        Map<String, Object> result = new HashMap<String, Object>();
        String project_id = request.getParameter("project_id");
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        System.out.println(TAG + "list->project_id=" + project_id + "|page=" + page + "|rows=" + rows);

        PageBean pageBean = new PageBean(page, rows);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("project_id", project_id);
        map.put("page", pageBean.getStart());
        map.put("rows", pageBean.getRows());
        ArrayList<Case> array = projectService.findProjectCase(map);
        Long total = projectService.getProjectCaseTotal(map);
//        JSONObject result=new JSONObject();
//        JSONArray jsonArray=JSONArray.fromObject(userList);
        result.put("rows", array);
        result.put("total", total);
//        ResponseUtil.write(res, result);

        System.out.println(TAG + "list array= " + array);
        return result;
    }

    @RequestMapping(value = "/addUserToProject", method = RequestMethod.POST)
    @ResponseBody
    private ReturnObj addUserToProject(HttpServletRequest request) throws IllegalArgumentException {


        //获取当前处理的project id
        int project_id = Integer.parseInt(request.getParameter("project_id"));

        //获取要添加的user id 列表，转换成数组
        String user_id_str = request.getParameter("user_ids");

        System.out.println(TAG + "addUserToProject->project_id=" + project_id + "|user_id_str=" + user_id_str);

        String[] useridList = user_id_str.split(",");

        ReturnObj result = new ReturnObj(ReturnObj.SUCCESS, ReturnObj.ADD_SUCCESS_MSG, null);

        for (int i = 0; i < useridList.length; i++) {
            int user_id = Integer.parseInt(useridList[i]);

            if (projectService.addUserToProject(project_id, user_id) == 0) {
                result.setSuccess(ReturnObj.FAIL);
                result.setMsg(ReturnObj.ADD_FAIL_MSG);
                break;
            }
        }


        return result;
    }

}
