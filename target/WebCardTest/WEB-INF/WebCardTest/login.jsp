<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>智能卡测试系统登录</title>
    <!-- Mobile specific metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Force IE9 to render in normal mode -->
    <!--[if IE]>
    <meta http-equiv="x-ua-compatible" content="IE=9"/><![endif]-->
    <meta name="author" content="SuggeElson"/>
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="application-name" content="sprFlat admin template"/>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp" %>
    <!-- Windows8 touch icon ( http://www.buildmypinnedsite.com/ )-->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="assets/ajax_js/login.js"></script>
    <meta name="msapplication-TileColor" content="#3399cc"/>
</head>
<body class="login-page">
<!-- Start #login -->
<div id="login" class="animated bounceIn">
    <!-- Start .login-wrapper -->
    <div class="login-wrapper">
        <ul id="myTab" class="nav nav-tabs nav-justified bn">
            <li>
                <a href="#log-in" data-toggle="tab">管理员登录</a>
            </li>
        </ul>
        <div id="myTabContent" class="tab-content bn">
            <div class="tab-pane fade active in" id="log-in">
                <form class="form-horizontal mt10" id="login-form" role="form" onsubmit="return login();">
                    <div class="form-group">
                        <div class="col-lg-12">
                            <input type="text" name="login_name" id="login_name" class="form-control left-icon" value=""
                                   placeholder="请输入用户名">
                            <i class="ec-user s16 left-input-icon"></i>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-12">
                            <input type="password" name="password" id="password" class="form-control left-icon" value=""
                                   placeholder="">
                            <i class="ec-locked s16 left-input-icon"></i>
                            <span class="help-block"><a href="#"><small>忘记密码?那也没办法</small></a></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-8">
                            <!-- col-lg-12 start here -->
                            <button class="btn btn-success pull-right" type="submit">登录</button>
                        </div>
                        <!-- col-lg-12 end here -->
                        <div class="col-lg-6 col-md-6 col-sm-6 col-xs-8">
                            <!-- col-lg-12 start here -->
                            <button class="btn btn-success pull-left" onclick="reset_form(); return false;">重置</button>
                        </div>
                        <!-- col-lg-12 end here -->
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!-- End #.login-wrapper -->
</div>
<!-- End #login -->
<!-- Javascripts -->
<!-- Load pace first -->
<script src="assets/plugins/core/pace/pace.min.js"></script>
<!-- Important javascript libs(put in all pages) -->
<!-- Bootstrap plugins -->
<script src="assets/js/bootstrap/bootstrap.js"></script>
<!-- Form plugins -->
<script src="assets/plugins/forms/icheck/jquery.icheck.js"></script>
<script src="assets/plugins/forms/validation/jquery.validate.js"></script>
<script src="assets/plugins/forms/validation/additional-methods.min.js"></script>
<!-- Init plugins olny for this page -->
<script src="assets/js/pages/login.js"></script>
</body>
</html>