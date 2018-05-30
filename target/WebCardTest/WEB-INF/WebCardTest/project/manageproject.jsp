<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/WebCardTest/tag.jsp" %>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>智能卡测试系统</title>

    <%@ include file="/WEB-INF/WebCardTest/common_js.jsp" %>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp" %>

    <script type="text/javascript">

        var flag = 0;
        var drigTitle = '项目信息表（用例）'
        <%-- 定义 datagird 列 --%>
        var columns_v = [[{field: 'ck', checkbox: true},
            {field: "name", title: "项目名称", width: '30%'},
            {field: "description", title: "项目描述", width: '43%'},
            {field: "test_progress", title: "测试进度", width: '5%'},
            {
                field: "create_time", title: "创建时间", width: '20%', formatter: function (date) {
                    return new Date(date).toLocaleString();
                }
            }]];

        <%-- 初始化-展示 datagird 工具栏 --%>
        $(function () {
            doSearch('');
        });


        //“添加”按钮响应函数
        function doAdd() {
            createmodalwindow("添加项目", 500, 250, '${baseurl}WebCardTest/project/toaddproject');
        }

        //“修改”按钮响应函数
        function doEdit() {
            var records = $("#projectTreeGrid").treegrid("getSelections");
            if (records.length != 1) {
                $.messager.alert('提示信息', '请选择一条记录！', 'warning');
            } else {
                if (records[0].parent != null) {
                    $.messager.alert('提示信息', '请选择项目！', 'warning');
                    return;
                }
                var id = records[0].id;
                createmodalwindow("修改项目", 500, 250, '${baseurl}WebCardTest/project/toeditproject?id=' + id);
            }
        }

        function doChangeShow() {
            if(flag==1){
                flag = 0;
                drigTitle = '项目信息表（用例）';
            }else{
                flag = 1;
                drigTitle = '项目信息表（测试员）';
            }
            doSearch("")
        }

        //“删除”按钮响应函数
        function doDelete() {
            var records = $("#projectTreeGrid").treegrid("getSelections");
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
                            url: '${baseurl}WebCardTest/project/remove?id=' + ids,
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

        //“编辑组员”按钮响应函数
        function doEditUser(index,row) {
            $('#projectTreeGrid').datagrid('selectRow', index);// 关键在这里
            // var row = $('#projectTreeGrid').datagrid('getSelected');
            if (row) {
                var id = row.id;
                <%--createmodalwindow("查看项目组员：" + row.name, 600, 450, '${baseurl}WebCardTest/project/toeditprojectuser?id=' + id);--%>

                $('#ddv-'+index).datagrid({
                    url:'${baseurl}WebCardTest/project/findProjectUserByProjectId',
                    type: 'post',
                    queryParams: {
                        project_id: id
                    },
                    pagination: true,//分页
                    fitColumns:true,
                    singleSelect:true,
                    rownumbers:true,
                    loadMsg:'加载中...',
                    width:"80%",
                    height:'auto',
                    columns:[[
                        {field: 'ck',checkbox: true  }, {
                            field: 'login_name',//对应json中的key
                            title: '登录名',
                            width: "35%"
                        }, {
                            field: 'user_name',//对应json中的key
                            title: '真实姓名',
                            width: "35%"
                        }, {
                            field: 'ctime',//对应json中的key
                            title: '加入时间',
                            width: "29%",
                            formatter: function (date) {
                                return new Date(date).toLocaleString();
                            }
                        }
                    ]],
                    onResize:function(){
                        $('#projectTreeGrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#projectTreeGrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    }
                });
                $('#projectTreeGrid').datagrid('fixDetailRowHeight',index);
            } else {
                $.messager.alert('提示信息', '请选择一条记录！', 'warning');
                return;
            }



        }

        //“编辑用例”按钮响应函数
        function doEditCase(index,row) {
            $('#projectTreeGrid').datagrid('selectRow', index);// 关键在这里
            // var row = $('#projectTreeGrid').datagrid('getSelected');
            if (row) {
                var id = row.id;
                <%--createmodalwindow("查看项目用例：" + row.name, 600, 450, '${baseurl}WebCardTest/project/toeditprojectcase?id=' + id);--%>
                $('#ddv-'+index).datagrid({
                    url:'${baseurl}WebCardTest/project/findProjectCaseByProjectId',
                    type: 'post',
                    queryParams: {
                        project_id: id
                    },
                    pagination: true,//分页
                    fitColumns:true,
                    singleSelect:true,
                    rownumbers:true,
                    loadMsg:'加载中...',
                    width:"80%",
                    height:'auto',
                    columns:[[
                        {field: 'ck',checkbox: true  }, {
                            field: 'name',//对应json中的key
                            title: '用例名称',
                            width: "35%"
                        }, {
                            field: 'description',//对应json中的key
                            title: '用例描述',
                            width: "35%"
                        }, {
                            field: 'ctime',//对应json中的key
                            title: '加入时间',
                            width: "29%",
                            formatter: function (date) {
                                return new Date(date).toLocaleString();
                            }
                        }
                    ]],
                    onResize:function(){
                        $('#projectTreeGrid').datagrid('fixDetailRowHeight',index);
                    },
                    onLoadSuccess:function(){
                        setTimeout(function(){
                            $('#projectTreeGrid').datagrid('fixDetailRowHeight',index);
                        },0);
                    }
                });
                $('#projectTreeGrid').datagrid('fixDetailRowHeight',index);
            } else {
                $.messager.alert('提示信息', '请选择一条记录！', 'warning');
                return;
            }

        }

        //“查询”按钮响应函数
        function doSearch(name) { //用户输入项目名,点击搜素,触发此函数
            console.log("doSearch-> name=" + name);
            $('#projectTreeGrid').datagrid('clearSelections');
            $("#projectTreeGrid").datagrid({
                title: drigTitle,
                url: "${baseurl}WebCardTest/project/list?name=" + name,
                type: 'get',
                onLoadError: function () {
                    $.messager.alert('提示信息', '加载数据失败，请重试！！！', '');
                },
                // style: "width:'85%';height:250px",
                striped: true,
                rownumbers: true,
                singleSelect: true,
                nowrap: true,//不换行
                loadMsg: '加载中...',
                pagination: true,//分页
                columns: columns_v,
                toolbar: "#easyui_toolbar",

                iconCls: 'icon-save',
                // height: "100%",
                animate: true,//动画
                collapsible: true,//可折叠的
                idField: 'id',
                treeField: 'name',
                view: detailview,
                detailFormatter:function(index,row){
                    return '<div style="padding:15px;"><table id="ddv-' + index + '"></table></div>';
                },
                onExpandRow: function(index,row){

                    if(flag == 0){
                        doEditCase(index,row);
                    }else{
                        doEditUser(index,row);
                    }
                }
            });
            // $('#search').appendTo('#projectTreeGrid.datagrid-toolbar');
        }


    </script>
</head>

<script type="text/javascript">
</script>
<body>
<div>
    <%-- 项目信息列表 --%>
    <table id="projectTreeGrid" class="easyui-datagrid" style="width: 99%;"></table>

    <%-- 定义 datagird 工具栏 --%>
    <div id="easyui_toolbar" region="north" border="false"
         style="border-bottom: 1px solid #ddd; vertical-align: middle;
         height: 48px; padding: 2px 5px; background: #fafafa;">
        <div style="height:50%; margin-top:12px;">
            <div style="float: left;vertical-align: middle;">
                <a class="easyui-linkbutton" plain="true" iconCls="icon-add" onclick="doAdd()">添加</a>
                <a class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="doEdit()">修改</a>
                <a class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="doDelete()">删除 </a>
                <a class="easyui-linkbutton" plain="true" iconCls="icon-remove" onclick="doChangeShow()">显示项目与测试员</a>
            </div>

            <%-- 项目查询表 --%>
            <div id="search" style="float: right;vertical-align: middle;">
                <input id="ss" class="easyui-searchbox"
                       searcher="doSearch" prompt="请输入项目名"
                       style="width: 230px; vertical-align: middle;">
            </div>
        </div>

    </div>


</div>


</body>
</html>