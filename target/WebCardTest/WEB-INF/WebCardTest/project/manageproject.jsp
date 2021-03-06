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
            if (flag == 1) {
                flag = 0;
                drigTitle = '项目信息表（用例）';
            } else {
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
        function doEditUser(index, row) {
            $('#projectTreeGrid').datagrid('selectRow', index);// 关键在这里
            console.log("doEditUser->index=" + index + "|row=" + row);
            var rows = $('#projectTreeGrid').datagrid('getRows');
            var projectrow = rows[index];
            console.log("doEditUser->projectrow=" + row.id + "|" + projectrow.toString());

            if (row) {
                var project_id = row.id;
                $('#ddv-' + index).datagrid({
                    url: '${baseurl}WebCardTest/project/findProjectUser',
                    type: 'post',
                    queryParams: {
                        project_id: project_id,
                    },
                    pagination: true,//分页
                    fitColumns: true,
                    singleSelect: true,
                    rownumbers: true,
                    loadMsg: '加载中...',
                    width: "80%",
                    height: 'auto',
                    columns: [[
                        {field: 'ck', checkbox: true}, {
                            field: 'login_name',//对应json中的key
                            title: '登录名',
                            width: 200
                        }, {
                            field: 'user_name',//对应json中的key
                            title: '真实姓名',
                            width: 200
                        }, {
                            field: 'create_time',//对应json中的key
                            title: '加入时间',
                            width: 200,
                            formatter: function (date) {
                                return new Date(date).toLocaleString();
                            }
                        }, {
                            field: 'do',//对应json中的key
                            title: '操作',
                            width: 50,
                            formatter: function (value, row, index) {//通过此方法格式化显示内容,value表示从json中取出该单元格的值，row表示这一行的数据，是一个对象,index:行的序号+"')\"
                                return "<a href='javascript:;' style='font-size:14px;' onclick=\"doDeleteUser('" + row.project_id+"','"+ row.case_id +"')\">【删除】</a>";

                            }
                        }
                    ]],
                    onResize: function () {
                        $('#projectTreeGrid').datagrid('fixDetailRowHeight', index);
                    },
                    onLoadSuccess: function () {
                        setTimeout(function () {
                            $('#projectTreeGrid').datagrid('fixDetailRowHeight', index);
                        }, 0);
                    }
                });
                $('#projectTreeGrid').datagrid('fixDetailRowHeight', index);
            } else {
                $.messager.alert('提示信息', '请选择一条记录！', 'warning');
                return;
            }


        }

        function doDeleteUser(project_id, case_id) {
            console.log("doDeleteUser->project_id=" + project_id + "|case_id=" + case_id);
            $.ajax({
                type: 'post',
                url: '${baseurl}WebCardTest/project/deleteUserFromProject',
                data: {project_id: project_id, case_id: case_id},
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

        function doDeleteCase(project_id, case_id) {
            console.log("doDeleteCase->project_id=" + project_id + "|case_id=" + case_id);
            $.ajax({
                type: 'post',
                url: '${baseurl}WebCardTest/project/deleteUserFromProject',
                data: {project_id: project_id, case_id: case_id},
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

        //“编辑组员”按钮响应函数
        function toAddUser(index) {
            $('#projectTreeGrid').datagrid('selectRow', index);// 关键在这里
            var row = $('#projectTreeGrid').datagrid('getSelected');
            if (row) {
                var id = row.id;
                createmodalwindow("查看项目组员：" + row.name, 600, 450, '${baseurl}WebCardTest/project/toeditprojectuser?id=' + id);
            } else {
                $.messager.alert('提示信息', '请选择一条记录！', 'warning');
                return;
            }


        }

        //“编辑用例”按钮响应函数
        function doEditCase(index, row) {
            $('#projectTreeGrid').datagrid('selectRow', index);// 关键在这里
            console.log("doEditUser->index=" + index + "|row=" + row);
            var rows = $('#projectTreeGrid').datagrid('getRows');
            var projectrow = rows[index];
            console.log("doEditCase->projectrow=" + row.id + "|" + projectrow.toString());
            if (row) {
                var id = row.id;
                $('#ddv-' + index).datagrid({
                    url: '${baseurl}WebCardTest/project/findProjectCase',
                    type: 'post',
                    queryParams: {
                        project_id: id
                    },
                    pagination: true,//分页
                    fitColumns: true,
                    singleSelect: true,
                    rownumbers: true,
                    loadMsg: '加载中...',
                    width: "80%",
                    height: 'auto',
                    columns: [[
                        {field: 'ck', checkbox: true}, {
                            field: 'name',//对应json中的key
                            title: '用例名称',
                            width: "35%"
                        }, {
                            field: 'description',//对应json中的key
                            title: '用例描述',
                            width: "35%"
                        }, {
                            field: 'create_time',//对应json中的key
                            title: '加入时间',
                            width: "29%",
                            formatter: function (date) {
                                return new Date(date).toLocaleString();
                            }
                        }, {
                            field: 'do',//对应json中的key
                            title: '操作',
                            width: 50,
                            formatter: function (value, row, index) {//通过此方法格式化显示内容,value表示从json中取出该单元格的值，row表示这一行的数据，是一个对象,index:行的序号+"')\"
                                return "<a href='javascript:;' style='font-size:14px;' onclick=\"doDeleteCase('" + row.project_id+"','"+ row.case_id +"')\">【删除】</a>";

                            }
                        }
                    ]],
                    onResize: function () {
                        $('#projectTreeGrid').datagrid('fixDetailRowHeight', index);
                    },
                    onLoadSuccess: function () {
                        setTimeout(function () {
                            $('#projectTreeGrid').datagrid('fixDetailRowHeight', index);
                        }, 0);
                    }
                });
                $('#projectTreeGrid').datagrid('fixDetailRowHeight', index);
            } else {
                $.messager.alert('提示信息', '请选择一条记录！', 'warning');
                return;
            }

        }

        //“编辑用例”按钮响应函数
        function toAddCase(index) {
            $('#projectTreeGrid').datagrid('selectRow', index);// 关键在这里
            var row = $('#projectTreeGrid').datagrid('getSelected');
            if (row) {
                var id = row.id;
                createmodalwindow("查看项目用例：" + row.name, 600, 450, '${baseurl}WebCardTest/project/toeditprojectcase?id=' + id);
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
                detailFormatter: function (index, row) {
                    return '<div style="padding:15px;"><table id="ddv-' + index + '"></table></div>';
                },
                onExpandRow: function (index, row) {

                    if (flag == 0) {
                        doEditCase(index, row);
                    } else {
                        doEditUser(index, row);
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
                <a> | </a>
                <a class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="toAddCase()">添加用例</a>
                <a class="easyui-linkbutton" plain="true" iconCls="icon-edit" onclick="toAddUser()">添加人员</a>
                <a> | </a>
                <a class="easyui-linkbutton" plain="true" iconCls="icon-reload"
                   onclick="doChangeShow()">【测试员】or【用例】详情</a>
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