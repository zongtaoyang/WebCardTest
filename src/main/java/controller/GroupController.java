package controller;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import entity.CGroup;
import entity.User;
import service.GroupService;
import util.Tool;

@Controller
@RequestMapping("/WebCardTest/group")
public class GroupController {
    @Autowired
    private GroupService groupService;

    @RequestMapping(value = "/find", method = RequestMethod.GET)
    @ResponseBody
    private List<CGroup> find(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("group_id", request.getParameter("group_id"));
        map.put("begin_time", request.getParameter("begin_time"));
        map.put("end_time", request.getParameter("end_time"));
        List<CGroup> result = groupService.find(map);
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
        return result;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> list(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        List<CGroup> array = groupService.all();
        result.put("data", array);
        result.put("stat_code", 0);
        result.put("info", "success");
        result.put("total", array.size());
        return result;
    }

    @RequestMapping(value = "/edit", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> edit(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        CGroup group = new CGroup();
        String id = request.getParameter("id");
        group.setName(request.getParameter("name"));
        result.put("info", "success");
        result.put("stat_code", 0);
        if (id == "" || id == null) {
            if (group.getGroup_id() == null) {
                group.setGroup_id(new Tool().getUUID(3));
            }
            if (groupService.insert(group) == 0) {
                result.put("info", "id_error");
                result.put("stat_code", 1);
            }
        } else {
            group.setId(Integer.valueOf(id));
            if (groupService.update(group) == 0) {
                result.put("info", "id_error");
                result.put("stat_code", 1);
            }
        }
        result.put("data", null);
        result.put("total", 1);
        return result;
    }

    @RequestMapping(value = "/remove", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> remove(int id) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("info", "success");
        result.put("stat_code", 0);
        if (groupService.delete(id) == 0) {
            result.put("info", "id_error");
            result.put("stat_code", 1);
        }
        result.put("data", null);
        result.put("total", 1);
        return result;
    }
}
