<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/WebCardTest/tag.jsp" %>
<html>
<head>
    <link href="/data/favicon.ico" rel="icon" type="image/x-icon"/>
    <title>IC智能卡自动测试系统</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">

    <%@ include file="/WEB-INF/WebCardTest/common_js.jsp" %>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp" %>

    <script type="text/javascript">
        var menu_file = 'data/menu.json';
        var tabOnSelect = function (title) {
            //根据标题获取tab对象
            var currTab = $('#tabs').tabs('getTab', title);
            var iframe = $(currTab.panel('options').content);//获取标签的内容

            var src = iframe.attr('src');//获取iframe的src
            //当重新选中tab时将ifram的内容重新加载一遍，目的是获取当前页面的最新内容
            if (src)
                $('#tabs').tabs('update', {
                    tab: currTab,
                    options: {
                        content: createFrame(src)//ifram内容
                    }
                });
        };
        var _menus;
        $(function () {//预加载方法
            //通过ajax请求菜单
            $.ajax({
                url: '${baseurl}' + menu_file,
                type: 'POST',
                dataType: 'json',
                success: function (data) {
                    _menus = data;
                    initMenu(_menus);//解析json数据，将菜单生成
                },
                error: function (msg) {
                    alert('菜单加载异常!');
                }
            });

            //tabClose();
            //tabCloseEven();
            //加载欢迎页面
            $('#tabs').tabs('add', {
                title: '欢迎使用',
                content: createFrame('${baseurl}welcome.action')
            }).tabs({
                //当重新选中tab时将ifram的内容重新加载一遍
                onSelect: tabOnSelect
            });

            //修改密码
            $('#modifypwd').click(menuclick);

        });

        //退出系统方法
        function logout() {
            _confirm('您确定要退出本系统吗?', null,
                function () {
                    location.href = '${baseurl}logout.action';
                }
            )
        }


        //帮助
        function showhelp() {
            window.open('${baseurl}help/help.html', '帮助文档');
        }


    </script>


    <META name="GENERATOR" content="MSHTML 9.00.8112.16540">
</HEAD>

<body style="overflow-y: hidden;" class="easyui-layout" scroll="no">

<%-- 主界面头，在界面最上边 --%>
<div style="background:  rgb(117,185,230);height:60px; color: rgb(255, 255, 255); line-height: 30px; overflow: hidden; font-family: Verdana, 微软雅黑, 黑体;"
     border="false" split="true" region="north">
      <span style="background:rgb(117,185,230); padding-right: 20px; font-size:14px;float: right;" class="head">
     欢迎当前用户：【
            <a href="#"><%=request.getSession().getAttribute("username")%></a>】
    <a style="font-size:14px;" id="loginOut"
       href=javascript:logout()
    >退出系统</a>
  </span>
    <span style="padding-left: 10px; font-size: 24px;">
        <img align="absmiddle" src="common/images/blocks.gif" width="20" height="20">
   IC智能卡自动测试系统</span> <span style="padding-left: 15px;" id="News"></span>
</div>

<%-- 主界面脚，系统版本信息，在界面最下边 --%>
<div style="background: rgb(210, 224, 242); height: 50px;" split="false" region="south">
    <div class="footer">
        系统版本号：1.0 &nbsp;&nbsp;&nbsp; 发布日期：2017-07-01
    </div>
</div>

<%-- 主界面导航栏，在界面最左边 --%>
<div style="width: 180px;" id="west" title="导航菜单" split="true" region="west" hide="true">
    <div id="nav" class="easyui-accordion" border="false" fit="true">
        <!--  导航内容 -->
    </div>
</div>

<%-- 主界面TAB框,在主界面最中间 --%>
<div style="background: rgb(238, 238, 238); overflow-y: hidden;" id="mainPanle" region="center">
    <div id="tabs" class="easyui-tabs" border="false" fit="true"></div>
</div>

</body>

</html>
