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
        select {
            width: 100%;
            height: 25px;
        }
    </style>
    <script type="text/javascript">
        //datagrid列定义
        var columns_v = [[{field: 'ck', checkbox: true}
            , {field: 'login_name', title: '登录名', align: 'center', width: '25%'}
            , {field: 'user_name', title: '姓名', align: 'center', width: '29%'}
            , {field: 'phone', title: '电话', align: 'center', width: '15%'}
            , {field: 'role', title: '权限', align: 'center', width: '10%'}
            , {
                field: 'last_login_time', title: '上次登录时间', align: 'center', width: '20%', formatter: function (date) {
                    return new Date(date).toLocaleString();
                }
            }]];


        //加载datagrid
        $(function () {
            doSearch('', '');
        });

        //“查询”按钮响应函数
        function doSearch(user_name, login_name) { //用户输入人员登录名和姓名,点击搜素,触发此函数
            console.log("doSearch-> user_name=" + user_name + "-> login_name=" + login_name);
            // $('#pmuserlist').datagrid('clearSelections');
            $("#userTreeGrid").datagrid({
                title: "人员信息列表",
                url: "${baseurl}WebCardTest/user/find",
                type: 'post',
                queryParams: {
                    user_name: user_name,
                    login_name: login_name
                },
                onLoadError: function () {
                    $.messager.alert('提示信息', '加载数据失败，请重试！！！', '');
                },
                // style: "width:'85%';height:250px",
                striped: true,
                rownumbers: true,
                singleSelect: true,
                nowrap: true,
                loadMsg: '加载中...',
                pagination: true,
                columns: columns_v,
                toolbar: "#easyui_toolbar",

                iconCls: 'icon-save',
                width:'80%',
                // height: "100%",
                animate: true,
                collapsible: true,
                idField: 'id',
                treeField: 'name'
            });
            // $('#search').appendTo('#projectTreeGrid.datagrid-toolbar');
        }

        //查询方法
        function queryuser() {
            $('#userTreeGrid').datagrid('clearSelections');
            //datagrid的方法load方法要求传入json数据，最终将 json转成key/value数据传入action
            //将form表单数据提取出来，组成一个json
            var formdata = $("#userqueryForm").serializeJson();
            $('#userTreeGrid').datagrid('load', formdata);
        }

        //“添加”按钮响应函数
        function doAdd() {
            createmodalwindow("添加人员", 500, 250, '${baseurl}WebCardTest/user/toadduser');
        }

        //“修改”按钮响应函数
        function doEdit() {
            var records = $("#userTreeGrid").treegrid("getSelections");
            if (records.length != 1) {
                $.messager.alert('提示信息', '请选择一条记录！', 'warning');
            } else {
                if (records[0].parent != null) {
                    $.messager.alert('提示信息', '请选择人员！', 'warning');
                    return;
                }
                var id = records[0].id;
                createmodalwindow("修改人员信息", 500, 250, '${baseurl}WebCardTest/user/toedituser?id=' + id);
            }
        }

        //“删除”按钮响应函数
        function doDelete() {
            var records = $("#userTreeGrid").treegrid("getSelections");
            if (records.length == 0) {
                $.messager.alert('提示信息', '请选择要删除的记录！', 'warning');
                return;
            } else {
                $.messager.confirm("确认", "确认要删除所有选中的记录吗？", function (r) {
                    if (r) {
                        var ids = '';
                        for (var i = 0; i < records.length; i++) {
                            if (ids.length > 0) {
                                ids += ',';
                            }
                            ids += records[i].id;
                        }
                        $.ajax({
                            type: 'get',
                            url: '${baseurl}WebCardTest/user/remove?id=' + ids,
                            dataType: 'json',
                            success: function (res) {
                                if (res.success) {
                                    $.messager.alert('提示信息', res.msg, 'success');
                                    doSearch('');
                                } else {
                                    $.messager.alert('提示信息', res.msg, 'error');
                                }
                            }
                        })
                    }
                });
            }
        }
    </script>

</head>
<body>
<!-- 查询列表 -->
<table id="userTreeGrid"></table>

<%-- 定义 datagird 工具栏 --%>
<div id="easyui_toolbar" region="north" border="false"
     style="border-bottom: 1px solid #ddd; vertical-align: middle;
         height: 48px; padding: 2px 5px; background: #fafafa;">
    <div style="height:50%; margin-top:12px;">
        <div style="float: left;vertical-align: middle;">
            <a class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="doAdd()">添加</a>
            <a class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="doEdit()">修改</a>
            <a class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="doDelete()">删除 </a>
            <a class="text">|</a>
            <a class="easyui-linkbutton" plain="true" iconCls="icon-reload" onclick="doSearch('','')">刷新</a>
        </div>

        <%-- 人员信息查询表 --%>
        <div id="search" style="float: right;vertical-align: middle;">
            <!-- html的静态布局 -->
            <form id="userqueryForm">
                <!-- 查询条件 -->
                <table class="table_search">
                    <tbody>
                    <tr>
                        <a width="100" style="padding-right:10px;">登录名：<input type="text" name="login_name"/></a>
                        <a width="100" style="padding-right:10px;">姓名：<input type="text" name="user_name"/></a>
                        <a width="100" style="padding-right:10px;">
                            <a id="btn" href="#" onclick="queryuser()"
                               class="easyui-linkbutton" iconCls='icon-search'>查询</a>
                        </a>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>


    </div>

</div>


</body>
</html>