<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/WebCardTest/tag.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

    <%@ include file="/WEB-INF/WebCardTest/common_js.jsp" %>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp" %>

    <style type="text/css">
        select {
            width: 93%;
            height: 25px;
        }

        .imput_text {
            width: 90%
        }
    </style>
    <title>添加用户</title>
    <script type="text/javascript">
        function projectsave() {
            //准备使用jquery 提供的ajax Form提交方式
            //将form的id传入，方法自动将form中的数据组成成key/value数据，通过ajax提交，提交方法类型为form中定义的method，
            //使用ajax form提交时，不用指定url，url就是form中定义的action
            //此种方式和原始的post方式差不多，只不过使用了ajax方式

            //第一个参数：form的id
            //第二个参数：projectsave_callback是回调函数，projectsave_callback当成一个方法的指针
            //第三个参数：传入的参数， 可以为空
            //第四个参数：dataType预期服务器返回的数据类型,这里action返回json
            //根据form的id找到该form的action地址
            jquerySubByFId('projectform', projectsave_callback, null, "json");

        }

        //ajax调用的回调函数，ajax请求完成调用此函数，传入的参数是action返回的结果
        function projectsave_callback(data) {
            if (data.success) {
                $.messager.alert('提示信息', data.msg, 'success');
                parent.closemodalwindow();
                parent.doSearch('');
            } else {
                $.messager.alert('提示信息', data.msg, 'error');
            }
            //message_alert(data);
        }
    </script>
</head>
<body>


<form id="projectform" action="${baseurl}WebCardTest/project/edit" method="post">
    <TABLE border=0 cellSpacing=0 cellPadding=0 width="100%" bgColor=#c4d8ed>

        <TBODY>
        <TR>
            <TD>
                <TABLE class="toptable grid" border=1 cellSpacing=1 cellPadding=4
                       align=center>
                    <TBODY>
                    <TR>
                        <TD height=30 width="15%" align=right>项目名称：</TD>
                        <TD class=category width="35%">
                            <div style="width:100%">
                                <input class="imput_text" type="text" name="name" value="${project.name}"/>
                                <input type="hidden" value="${project.id}" name="id">
                            </div>
                        </TD>
                    </TR>
                    <TR height="100">
                        <TD width="15%" align=right>项目描述：</TD>
                        <TD class=category width="35%">
                            <div style="width:100%">
                                <textarea rows="6" cols="20" name="description"
                                          class="imput_text">${project.description}</textarea>
                            </div>
                        </TD>
                    </TR>
                    <tr>
                        <td colspan=2 align=center class=category>
                            <a id="submitbtn" class="easyui-linkbutton" iconCls="icon-ok" href="#"
                               onclick="projectsave()">提交</a>
                            &nbsp;&nbsp;&nbsp;&nbsp;
                            <a id="closebtn" class="easyui-linkbutton" iconCls="icon-cancel" href="#"
                               onclick="parent.closemodalwindow()">关闭</a>
                        </td>
                    </tr>
                    </TBODY>
                </TABLE>
            </TD>
        </TR>
        </TBODY>
    </TABLE>
</form>
</body>
</html>