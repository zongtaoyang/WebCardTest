$(document).ready(function(){
	refush();
	jump_page(1, "person");
})
function remove(id){
	$.ajax({
	type: "GET",
	url: "/WebCardTest/user/remove",
	data:{"id":id},
	dataType: "json",
	async: false,
	success:function(resultData) {
		if(resultData.info == "success"){
			alert("删除成功");
		}
		else if(resultData.info == "id_error"){
			alert("没有这个用户");
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
	url: "/WebCardTest/user/edit",
	data:$("#person_edit").serialize(),
	dataType: "json",
	async: false,
	success:function(resultData) {
		if(resultData.info == "success"){
			alert("添加/修改成功");
		}
		else if(resultData.info == "id_error"){
			alert("没有这个用户");
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
	url: "/WebCardTest/user/list",
	dataType: "json",
	async: false,
	success: function(resultData){
		setCookie("person_total", resultData.total);
		var new_html = ''
		$.each(resultData.data, function(i, item){
			new_html += '<tr><td>'+item.id+'</td><td>'+item.username+'</td><td>'+new Date(item.ctime).toLocaleString()+'</td><td>'+new Date(item.last_login_time).toLocaleString()+'</td><td>'+item.phone+'</td><td><a><button class="btn" onclick="remove('+item.id+')">删除</button></a></td></tr>';
		})
		$('#person tbody').html(new_html);
	},
	error: function(XMLHttpRequest, textStatus, errorThrown) {
		 alert(XMLHttpRequest.status);
		 alert(XMLHttpRequest.readyState);
		 alert(textStatus);
	}

	})
};
