$(document).ready(function(){
	refush();
	jump_page(1, "project");
})
function remove(id){
	$.ajax({
	type: "GET",
	url: "/WebCardTest/project/remove",
	data:{"id":id},
	dataType: "json",
	async: false,
	success:function(resultData) {
		if(resultData.info == "success"){
			alert("删除成功");
		}
		else if(resultData.info == "id_error"){
			alert("没有这个项目");
		}
		else{
			alert("系统错误");
		}
	},
	error:function(XMLHttpRequest, textStatus, errorThrown) {
		alert("删除失败");
	}});
	refush();
}

function edit(){
	$.ajax({
	type: "GET",
	url: "/WebCardTest/project/edit",
	data:$("#project_edit").serialize(),
	dataType: "json",
	async: false,
	success:function(resultData) {
		if(resultData.info == "success"){
			alert("添加/修改成功");
		}
		else if(resultData.info == "id_error"){
			alert("没有这个项目");
		}
		else{
			alert("系统错误");
		}
	},
	error:function(XMLHttpRequest, textStatus, errorThrown) {
		alert("添加/修改失败");
	}});
	refush();
	return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
}

function refush(){
	$.ajax({
	type: "GET",
	url: "/WebCardTest/project/list",
	dataType: "json",
	async: false,
	success: function(resultData){
		setCookie("project_total", resultData.total);
		var new_html = ''
		$.each(resultData.data, function(i, item){
			new_html += '<tr><td>'+item.project_id
				+'</td><td>'+item.project_name
                +'</td><td>'+item.project_use
                +'</td><td>'+item.test_progress
                +'</td><td>'+item.case_list
                +'</td><td>'+item.user_list
				+'</td><td>'+new Date(item.create_time).toLocaleString()
                +'</td><td>'+new Date(item.update_time).toLocaleString()
				+'</td><td><a><button class="btn" onclick="remove('+item.project_id+')">删除</button></a></td></tr>';
		})
		$('#project tbody').html(new_html)
	},
	error: function(XMLHttpRequest, textStatus, errorThrown) {
		 alert(XMLHttpRequest.status);
		 alert(XMLHttpRequest.readyState);
		 alert(textStatus);
	}

	})
};
