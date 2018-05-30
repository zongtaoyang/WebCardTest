<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>智能卡测试系统</title>

    <script type="text/javascript" src="${ctx}/common/jquery-easyui-1.5.5.1/jquery.min.js"></script>
    <script type="text/javascript" src="${ctx}/common/jquery-easyui-1.5.5.1/jquery.easyui.min.js"></script>
    <link rel="stylesheet" href="${ctx}/common/jquery-easyui-1.5.5.1/demo/demo.css" type="text/css">
    <link rel="stylesheet" href="${ctx}/common/jquery-easyui-1.5.5.1/themes/black/easyui.css" type="text/css">
    <link rel="stylesheet" href="${ctx}/common/jquery-easyui-1.5.5.1/themes/icon.css" type="text/css">

    <%--<script type="text/javascript">--%>
    <%--$(document).ready(function(){--%>
    <%--$("#dg").datagrid({--%>
    <%--title: "用户信息列表",--%>
    <%--url:"/WebCardTest/project/list",--%>
    <%--width: 700,--%>
    <%--height: 'auto',--%>
    <%--striped: true,--%>
    <%--rownumbers: true,--%>
    <%--singleSelect: true,--%>
    <%--nowrap: true,--%>
    <%--pagination: true--%>
    <%--})--%>
    <%--});--%>
    <%--</script>--%>
</head>
<body>
<div>
    <table id="dg" title="测试员列表" style="width:550px;height:250px"
           url="/WebCardTest/project/list" striped="true" nowrap="true" pagination="true"
           toolbar="#toolbar" idField="id" rownumbers="true" fitColumns="true" singleSelect="true">
        <thead>
        <tr>
            <th field="id" width="50" editor="text}">序号</th>
            <th field="name" width="50" editor="text}">项目名称</th>
            <th field="description" width="50" editor="text">项目描述</th>
            <th field="test_progress" width="50" editor="text}">测试进度</th>
            <th field="case_list" width="50" editor="text">用例列表</th>
            <th field="user_list" width="50" editor="text">测试员列表</th>
            <th field="create_time" width="50" editor="text">创建时间</th>
        </tr>
        </thead>
    </table>
    <div id="toolbar">
        <a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true"
           onclick="javascript:$('#dg').edatagrid('addRow')">增加</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true"
           onclick="javascript:$('#dg').edatagrid('destroyRow')">删除</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-save" plain="true"
           onclick="javascript:$('#dg').edatagrid('saveRow')">保存</a>
        <a href="#" class="easyui-linkbutton" iconCls="icon-undo" plain="true"
           onclick="javascript:$('#dg').edatagrid('cancelRow')">取消</a>
    </div>
</div>


</body>
</html>