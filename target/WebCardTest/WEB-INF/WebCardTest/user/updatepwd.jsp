<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/WebCardTest/tag.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <LINK rel="stylesheet" type="text/css" href="${baseurl}js/easyui/styles/default.css">
    <%@ include file="/WEB-INF/WebCardTest/common_js.jsp" %>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp" %>
    <style type="text/css">
        select {
            width: 93%;
            height: 25px;
        }

        .imput_text {
            width: 95%
        }
    </style>
    <title>添加用户</title>
    <script type="text/javascript">
        function sysusersave() {
            var oldpwd = $('#oldpwd').val();
            var newpwd = $('#newpwd').val();
            var newpwd1 = $('#newpwd1').val();
            if (oldpwd == '') {
                $.messager.alert('提示信息', '原密码不能为空！', 'warn');
                return;
            }
            if (newpwd == '') {
                $.messager.alert('提示信息', '新密码不能为空！', 'warn');
                return;
            }
            if (newpwd1 != newpwd) {
                $.messager.alert('提示信息', '新密码两次密码输入不一致！', 'warn');
                return;
            }
            jquerySubByFId('userform', sysusersave_callback, null, "json");

        }

        //ajax调用的回调函数，ajax请求完成调用此函数，传入的参数是action返回的结果
        function sysusersave_callback(data) {
            if (data.success) {
                $.messager.alert('提示信息', data.msg, 'success');
            } else {
                $.messager.alert('提示信息', data.msg, 'error');
            }
        }
    </script>
</head>
<body>
<form id="userform" action="${baseurl}WebCardTest/user/updatepwd" method="post">
    <TABLE border=0 cellSpacing=0 cellPadding=0 width="500" height="160">
        <TBODY>
        <TR>
            <TD>
                <TABLE class="toptable grid" border=1 cellSpacing=1 cellPadding=4
                       align=center>
                    <TBODY>
                    <TR>
                        <TD height=30 width="15%" align=right>原始密码：</TD>
                        <TD class=category width="35%">
                            <div style="width:100%">
                                <input class="imput_text" type="password" id="oldpwd" name="oldpwd"/>
                            </div>
                        </TD>
                    </TR>
                    <TR>
                        <TD height=30 width="15%" align=right>新密码：</TD>
                        <TD class=category width="35%">
                            <div style="width:100%">
                                <input class="imput_text" type="password" id="newpwd" name="newpwd"/>
                            </div>
                        </TD>
                    </TR>
                    <TR>
                        <TD height=30 width="15%" align=right>密码确认：</TD>
                        <TD class=category width="35%">
                            <div style="width:100%">
                                <input class="imput_text" type="password" id="newpwd1" name="newpwd1"/>
                            </div>
                        </TD>
                    </TR>
                    <tr>
                        <td colspan=2 align=center class=category>
                            <a id="submitbtn" class="easyui-linkbutton" iconCls="icon-ok" href="#"
                               onclick="sysusersave()">确认</a>
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