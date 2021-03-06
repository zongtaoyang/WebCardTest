package interceptor;
import javax.servlet.http.HttpServletRequest;  
import javax.servlet.http.HttpServletResponse;  
  
import org.slf4j.Logger;  
import org.slf4j.LoggerFactory;  
import org.springframework.web.servlet.ModelAndView;  
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;  
  
import util.RequestUtil;
  
  
/** 
 * @author tfj 
 * 2014-8-1 
 */  
public class IdentityInterceptor extends HandlerInterceptorAdapter{  
    private final Logger log = LoggerFactory.getLogger(IdentityInterceptor.class);
    
//  未登录可访问 
      
    private String login_url="/login"; 
    
    /**  
     * 在业务处理器处理请求之前被调用  
     * 如果返回false  
     *     从当前的拦截器往回执行所有拦截器的afterCompletion(),再退出拦截器链 
     * 如果返回true  
     *    执行下一个拦截器,直到所有的拦截器都执行完毕  
     *    再执行被拦截的Controller  
     *    然后进入拦截器链,  
     *    从最后一个拦截器往回执行所有的postHandle()  
     *    接着再从最后一个拦截器往回执行所有的afterCompletion()  
     */    
    @Override    
    public boolean preHandle(HttpServletRequest request,    
            HttpServletResponse response, Object handler) throws Exception {    
        if ("GET".equalsIgnoreCase(request.getMethod())) {  
            RequestUtil.saveRequest();  
        }  
        log.info("==============执行顺序: 1、preHandle================");    
        String requestUri = request.getRequestURI();  
        String contextPath = request.getContextPath();  
        String url = requestUri.substring(contextPath.length());  
        if(url.contains("assets"))  //静态资源  
        {  
            return true;  
        } 
        if(url.contains(login_url))
        {  
            return true;  
        }  
        log.info("requestUri:"+requestUri);    
        log.info("contextPath:"+contextPath);    
        log.info("url:"+url);    
          
        String username =  (String)request.getSession().getAttribute("username");
        String user_role =  (String)request.getSession().getAttribute("user_role");
        if(username == null || !user_role.equals("admin")){  
            log.info("Interceptor：跳转到login页面！");
            response.sendRedirect(request.getContextPath() + "/login");
            return false;
        }  
        return true;     
    }    
    
    /** 
     * 在业务处理器处理请求执行完成后,生成视图之前执行的动作    
     * 可在modelAndView中加入数据，比如当前时间 
     */  
//    @Override    
//    public void postHandle(HttpServletRequest request,    
//            HttpServletResponse response, Object handler,    
//            ModelAndView modelAndView) throws Exception {     
//        log.info("==============执行顺序: 2、postHandle================");    
//        if(modelAndView != null){  //加入当前时间    
//            modelAndView.addObject("var", "测试postHandle");    
//        }    
//    }    
    
    /**  
     * 在DispatcherServlet完全处理完请求后被调用,可用于清理资源等   
     *   
     * 当有拦截器抛出异常时,会从当前拦截器往回执行所有的拦截器的afterCompletion()  
     */    
//    @Override    
//    public void afterCompletion(HttpServletRequest request,    
//            HttpServletResponse response, Object handler, Exception ex)    
//            throws Exception {    
//        log.info("==============执行顺序: 3、afterCompletion================");    
//    }    
  
}  
