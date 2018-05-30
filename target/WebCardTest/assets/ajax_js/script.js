$(document).ready(function () {
    refush();
    write_group();
})

function showcase(id) {
    window.open("/WebCardTest/case/showcase?id=" + id);
}

function write_group() {
    $.ajax({
        type: "GET",
        url: "/WebCardTest/group/list",
        dataType: "json",
        async: false,
        success: function (resultData) {
            $.each(resultData.data, function (i, item) {
                var group_choose_option = document.createElement("option");
                var group_upload_option = document.createElement("option");
                group_choose_option.setAttribute("value", item.id);
                group_choose_option.innerHTML = item.name;
                group_upload_option.setAttribute("value", item.id);
                group_upload_option.innerHTML = item.name;
                $('#group_choose').append(group_choose_option);
                $('#group_upload').append(group_upload_option);
            })
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }

    })
}
function find() {
    $.ajax({
        type: "GET",
        url: "/WebCardTest/case/find",
        data: $("#find").serialize(),
        dataType: "json",
        async: false,
        success: function (resultData) {
            setCookie("case_total", resultData.total);
            var new_html = '';
            $.each(resultData.data, function (i, item) {
                var edithtml = '<div class="btn-group dropdown"><a class="btn dropdown-toggle" data-toggle="dropdown" id="dropdownMenu2" aria-expanded="false"><button class="btn">编辑</button></a><div class="dropdown-menu pull-right" role="menu" aria-labelledby="dropdownMenu2"><div class="option-dropdown"><p class="col-lg-12">编辑</p><form id="case_edit' + item.id + '" class="form-horizontal" onsubmit="return edit(' + item.id + ');"><div class="form-group"><div class="col-lg-12"><input type="text" name="name" class="form-control" placeholder="新案例名"></div></div><div class="form-group"><div class="col-lg-12"><textarea name="case_id" class="form-control wysiwyg" placeholder="新案例编号，4位"></textarea></div></div><div class="form-group wysiwyg"><div class="col-lg-12"><textarea name="group_name" class="form-control" placeholder="新分组名"></textarea></div></div><div class="form-group"><div class="col-lg-12"><button class="btn btn-success btn-xs pull-right">编辑</button></div></div></form></div></div></div>';
                new_html += '<tr><td>' + item.id + '</td><td>' + item.name + '</td><td>' + item.case_id + '</td><td>' + new Date(item.ctime).toLocaleString() + '</td><td>' + item.group_name + '</td><td><a><button class="btn" onclick="showcase(' + item.id + ')">查看脚本</button></a>' + edithtml + '<a><button class="btn" onclick="remove(' + item.id + ')">删除</button></a></td></tr>';
            })
            $('#case tbody').html(new_html);
            jump_page(1, 'case');
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert(XMLHttpRequest.status);
            alert(XMLHttpRequest.readyState);
            alert(textStatus);
        }
    });
    return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
}

function remove(id) {
    $.ajax({
        type: "GET",
        url: "/WebCardTest/case/remove",
        data: {"id": id},
        dataType: "json",
        async: false,
        success: function (resultData) {
            if (resultData.info == "success") {
                alert("删除成功");
            }
            else if (resultData.info == "id_error") {
                alert("没有这个用户");
            }
            else {
                alert("系统错误");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("删除失败");
        }
    });
    refush();
}

function edit(id) {
    var datas = $("#case_edit" + id).serialize();
    var group_selection = document.getElementById("group_choose");
    var group_name = $("#case_edit" + id).children()[2].children[0].children[0].value;
    var group_id = null;
    for (var i = 1; i < group_selection.length; i++) {
        if (group_name == group_selection.children[i].text) {
            group_id = group_selection.children[i].value;
            break;
        }
    }
    if (group_id == null) {
        alert("无此分组");
        return false;
    }
    datas += '&group_id=' + group_id + '&id=' + id;
    $.ajax({
        type: "GET",
        url: "/WebCardTest/case/edit",
        data: datas,
        dataType: "json",
        async: false,
        success: function (resultData) {
            if (resultData.info == "success") {
                alert("修改成功");
            }
            else if (resultData.info == "id_error") {
                alert("没有这个用户");
            }
            else {
                alert("系统错误");
            }
        },
        error: function (XMLHttpRequest, textStatus, errorThrown) {
            alert("添加/修改失败");
        }
    });
    refush();
    return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
}

function refush() {
    find();
};
