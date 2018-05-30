<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<div id="header">
    <div class="container-fluid">
        <div class="navbar">
            <div class="navbar-header">
                <a class="navbar-brand" href="person">
                    <i class="im-windows8 text-logo-element animated bounceIn"></i><span
                        class="text-logo">案例</span><span class="text-slogan">系统</span>
                </a>
            </div>
            <nav class="top-nav" role="navigation">
                <ul class="nav navbar-nav pull-right">
                    <li class="dropdown">
                        <a href="#" data-toggle="dropdown">
                            <%=request.getSession().getAttribute("user_name")%>
                        </a>
                        <ul class="dropdown-menu right" role="menu">
                            <li><a href="#"><i class="st-settings"></i> 个人设置</a>
                            </li>
                            <li><a href="/WebCardTest/logout"><i class="im-exit"></i> 退出</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
        <!-- Start #header-area -->
        <!-- End #header-area -->
    </div>
    <!-- Start .header-inner -->
</div>