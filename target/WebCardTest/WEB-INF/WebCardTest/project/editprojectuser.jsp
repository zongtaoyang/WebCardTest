<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/WebCardTest/tag.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <%@ include file="/WEB-INF/WebCardTest/common_js.jsp" %>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp" %>
    <title>用户管理</title>
    <style type="text/css">
        .btnr {
            text-align: center;
            vertical-align: middle;
        }
    </style>
    <script type="text/javascript">
        var projectId = '${project.id}';
        //datagrid列定义
        var columns_v = [[
            {
                field: 'ck',
                checkbox: true
            }, {
                field: 'login_name',//对应json中的key
                title: '登录名',
                width: "30%"
            }, {
                field: 'user_name',//对应json中的key
                title: '真实姓名',
                width: "30%"
            }, {
                field: 'create_time',//对应json中的key
                title: '加入时间',
                width: "39%",
                formatter: function (date) {
                    return new Date(date).toLocaleString();
                }
            }]];

        //加载datagrid
        $(function () {
            doSearch();
        });

        function doSearch() {
            $('#projectuserlist').datagrid({
                title: '项目组员信息列表',//数据列表标题
                nowrap: true,//单元格中的数据不换行，如果为true表示不换行，不换行情况下数据加载性能高，如果为false就是换行，换行数据加载性能不高
                striped: true,//条纹显示效果
                url: '${baseurl}WebCardTest/user/find',//加载数据的连接，引连接请求过来是json数据
                idField: 'id',//此字段很重要，数据结果集的唯一约束(重要)，如果写错影响 获取当前选中行的方法执行
                loadMsg: '加载中...',
                columns: columns_v,
                width: "99%",
                height: "auto",
                pagination: true,//是否显示分页
                rownumbers: true//是否显示行号

            });
        }

        function addprojectuser() {
            var records = $("#projectuserlist").datagrid("getSelections");
            if (records.length == 0) {
                $.messager.alert('提示信息', '请选择人员！', 'warning');
                return;
            }
            var ids = '';
            for (var i = 0; i < records.length; i++) {
                if (ids.length > 0) {
                    ids += ',';
                }
                ids += records[i].id;
            }
            $.ajax({
                type: 'post',
                url: '${baseurl}WebCardTest/project/addUserToProject',
                data: {"project_id": projectId, "user_ids": ids},
                dataType: 'json',
                success: function (res) {
                    if (res.success) {
                        $.messager.alert('提示信息', res.msg, 'success');
                        parent.closemodalwindow();
                    } else {
                        $.messager.alert('提示信息', res.msg, 'error');
                    }
                }
            })
        }

    </script>

</head>
<body>
<div>
    <table id="projectuserlist"></table>

    <%-- 定义 datagird 工具栏 --%>
    <div id="easyui_toolbar" region="north" border="false"
         style="border-bottom: 1px solid #ddd; vertical-align: middle;
         height: 48px; padding: 2px 5px; background: #fafafa;">
        <div style="height:50%; margin-top:12px;">
            <div style="float: left;vertical-align: middle;">
                <a id="submitbtn"  class="easyui-linkbutton"   iconCls="icon-ok" href="#" onclick="addprojectuser()">提交</a>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <a id="closebtn"  class="easyui-linkbutton" iconCls="icon-cancel" href="#" onclick="parent.closemodalwindow()">关闭</a>
            </div>

            <%-- 项目查询表 --%>
            <div id="search" style="float: right;vertical-align: middle;">
                <input id="ss" class="easyui-searchbox"
                       searcher="doSearch" prompt="请输入真实姓名"
                       style="width: 230px; vertical-align: middle;">
            </div>
        </div>

    </div>
</div>
</body>
</html>