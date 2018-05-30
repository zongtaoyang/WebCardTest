package controller;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class WebController {


    //首页
    @RequestMapping("/main")
    public ModelAndView main()throws Exception{
        ModelAndView view = new ModelAndView("WebCardTest/main");
        return view;
    }

    //欢迎页面
    @RequestMapping("/welcome")
    public String welcome(){
        return "WebCardTest/welcome";
    }


    @RequestMapping(value = "/login", method = RequestMethod.GET)
    private ModelAndView login() {
        ModelAndView mv = new ModelAndView("WebCardTest/login");
        return mv;
    }

}
