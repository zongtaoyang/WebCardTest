package controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import util.Config;
import util.Tool;
import entity.Case;
import service.CaseService;
import entity.CGroup;
import service.GroupService;

@Controller
@RequestMapping("/WebCardTest/case")
public class CaseController {
    @Autowired
    private CaseService caseService;
    @Autowired
    private GroupService groupService;

    @RequestMapping(value = "/find", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> find(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("group_id", request.getParameter("group_id"));
        map.put("begin_time", request.getParameter("begin_time"));
        map.put("end_time", request.getParameter("end_time"));
        List<Case> array = caseService.find(map);
        result.put("data", array);
        result.put("stat_code", 0);
        result.put("info", "success");
        result.put("total", array.size());
        return result;
    }

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    @ResponseBody
    private Map<String, Object> list(HttpServletRequest request) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        List<Case> array = caseService.all();
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
        Case tcase = new Case();
        tcase.setId(Integer.valueOf(request.getParameter("id")));
        tcase.setGroup_name(request.getParameter("group_name"));
        tcase.setGroup_id(Integer.valueOf(request.getParameter("group_id")));
        tcase.setCase_id(tcase.getGroup_id() + request.getParameter("case_id"));
        tcase.setName(request.getParameter("name"));
        result.put("info", "success");
        result.put("stat_code", 0);
        if (caseService.update(tcase) == 0) {
            result.put("info", "id_error");
            result.put("stat_code", 1);
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
        if (caseService.delete(id) == 0) {
            result.put("info", "id_error");
            result.put("stat_code", 1);
        }
        result.put("data", null);
        result.put("total", 1);
        return result;
    }

    @RequestMapping(value = "/upload", method = RequestMethod.POST)
    @ResponseBody
    private Map<String, Object> upload(@RequestParam(value = "files", required = false) MultipartFile files
            , @RequestParam(value = "group_id", required = false) int group_id
            , @RequestParam(value = "case_name", required = false) String case_name) throws IllegalArgumentException, IllegalAccessException {
        Map<String, Object> result = new HashMap<String, Object>();
        result.put("info", "success");
        result.put("stat_code", 0);
        if (files.isEmpty()) {
            result.put("info", "no_file");
            result.put("stat_code", 1);
        } else {
            try {
                // 文件保存路径
                if (case_name == "" || case_name == null) case_name = "未命名案例";
                CGroup group = groupService.findByIntId(group_id);
                String filename = files.getOriginalFilename();
                String filepath = Config.FilePath + "/" + group.getGroup_id();
                File f = new File(filepath);
                if (!f.exists() && !f.isDirectory()) {
                    f.mkdir();
                }
                // 转存文件  
                files.transferTo(new File(filepath + "/" + filename));
                Case new_case = new Case();
                new_case.setName(case_name);
                new_case.setCase_id(group.getGroup_id() + new Tool().getUUID(4));
                new_case.setPath(filepath + "/" + filename);
                new_case.setGroup_id(group.getId());
                new_case.setGroup_name(group.getName());
                caseService.insert(new_case);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        result.put("data", null);
        result.put("total", 1);
        return result;
    }

    @RequestMapping(value = "/showcase", method = RequestMethod.GET)
    @ResponseBody
    private void showcase(HttpServletRequest request, HttpServletResponse response) throws IOException {
        // questionGroup - this comes OK.        
        Case tcase = caseService.findByIntId(Integer.valueOf(request.getParameter("id")));
        FileReader fr = new FileReader(tcase.getPath());
        BufferedReader bufferedreader = new BufferedReader(fr);
        String instring;
        response.setHeader("Content-Type", "text/html;charset=UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        PrintWriter p = response.getWriter();
        p.write("<!DOCTYPE html>");
        p.write("<html lang='en'>");
        p.write("<head>");
        p.write("<meta charset='utf-8'>");
        p.write("<title>查看案例内容</title>");
        p.write("<pre style=word-wrap: break-word; white-space: pre-wrap;>");
        while ((instring = bufferedreader.readLine()) != null) {
            p.write(instring + "\n");
        }
        p.write("</pre>");
        fr.close();
    }
}
