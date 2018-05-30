package controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import entity.PageBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import process.ReturnObj;
import util.Tool;

import entity.User;
import service.UserService;

@Controller
@RequestMapping("WebCardTest/user")
public class UserController {
    private final String TAG = "UserController->";

    @Autowired
    private UserService userService;

    /**
     * 跳转到《人员信息管理》页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/manageuser")
    public ModelAndView manageuser() throws Exception {
        System.out.println(TAG + "manageuser->...");
        ModelAndView mv = new ModelAndView("WebCardTest/user/manageuser");
        System.out.println(TAG + "manageuser->mv=" + mv);
        return mv;
    }

    /**
     * 跳转到《添加人员》页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/toadduser")
    public ModelAndView toadduser() throws Exception {
        System.out.println(TAG + "toadduser->...");
        ModelAndView mv = new ModelAndView("WebCardTest/user/adduser");
        System.out.println(TAG + "toadduser->mv=" + mv);
        return mv;
    }

    /**
     * 跳转到编辑人员信息页面
     *
     * @return
     * @throws Exception
     */
    @RequestMapping("/toedituser")
    public ModelAndView toedituser(int id) {
        System.out.println(TAG + "toedituser->...");
        ModelAndView mv = new ModelAndView("WebCardTest/user/edituser");
        System.out.println(TAG + "toedituser->mv=" + mv);
        try {
            User user = userService.findByIntId(id);
            mv.addObject("user", user);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mv;
    }

    @RequestMapping(value = "/login", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> login(String login_name, String password, HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        String p = new Tool().encodeMD5(password);
        User user = userService.login(login_name, p);
        System.out.println();
        System.out.println("user/login: user=" + user.getLogin_name() + "|password=" + password);
        //map.put相当于request.setAttribute方法
        if (user != null && user.getRole().equals("admin")) {
            request.getSession().setAttribute("username", user.getUser_name());
            request.getSession().setAttribute("user_id", user.getId());
            request.getSession().setAttribute("user_role", user.getRole());
            result.put("data", null);
            result.put("stat_code", 0);
            result.put("info", "success");
            result.put("total", 1);
        } else {
            result.put("data", null);
            result.put("stat_code", 1);
            result.put("info", "error");
            result.put("total", 1);
        }
        return result;
    }

    @RequestMapping(value = "/find", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> find(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        String user_name = request.getParameter("user_name");
        String login_name = request.getParameter("login_name");
        int page = Integer.parseInt(request.getParameter("page"));
        int rows = Integer.parseInt(request.getParameter("rows"));
        System.out.println(TAG + "list->user_name=" + user_name+ "|login_name=" + login_name + "|page=" + page + "|rows=" + rows);
        PageBean pageBean = new PageBean(page, rows);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user_name", user_name);
        map.put("login_name", login_name);
        map.put("page", pageBean.getStart());
        map.put("rows", pageBean.getRows());
        List<User> array = userService.find(map);
        Long total = userService.getTotal(map);
        result.put("rows", array);
        result.put("total", total);

        return result;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.POST)
    @ResponseBody
    private ReturnObj edit(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        ReturnObj result = new ReturnObj(ReturnObj.SUCCESS, ReturnObj.SAVE_SUCCESS_MSG, null);
        User user = new User();
        String id = request.getParameter("id");
        user.setLogin_name(request.getParameter("login_name"));
        user.setUser_name(request.getParameter("user_name"));
        user.setPassword(request.getParameter("password"));
        user.setPhone(request.getParameter("phone"));
        System.out.println(TAG + "edit->login_name="+user.getLogin_name()+"|user_name="+user.getUser_name()
                +"|password="+user.getPassword()+"|phone="+user.getPhone());
        result.setMsg(ReturnObj.SAVE_SUCCESS_MSG);
        if (id == "" || id == null) {
            System.out.println(TAG + "edit->insert...");

            if (userService.insert(user) == 0) {
                result.setSuccess(ReturnObj.FAIL);
                result.setMsg(ReturnObj.SAVE_FAIL_MSG);
            }else {
                result.setMsg(ReturnObj.SAVE_SUCCESS_MSG);
            }
        } else {
            System.out.println(TAG + "edit->update->id=" + id);
            user.setId(Integer.valueOf(id));
            if (userService.update(user) == 0) {
                result.setMsg(ReturnObj.UPDATE_FAIL_MSG);
                result.setSuccess(ReturnObj.FAIL);
            }else {
                result.setMsg(ReturnObj.UPDATE_SUCCESS_MSG);
            }
        }

        return result;
    }

    @RequestMapping(value = "/remove", method = RequestMethod.GET)
    @ResponseBody
    private ReturnObj remove(int id) throws IllegalArgumentException, IllegalAccessException {
        System.out.println(TAG + "remove-> id= " + id);
        ReturnObj result = new ReturnObj();
        if (userService.delete(id) == 0) {
            result.setSuccess(ReturnObj.FAIL);
            result.setMsg(ReturnObj.DELETE_FAIL_MSG);
        } else {
            result.setSuccess(ReturnObj.SUCCESS);
            result.setMsg(ReturnObj.DELETE_SUCCESS_MSG);
        }
        return result;
    }
}
