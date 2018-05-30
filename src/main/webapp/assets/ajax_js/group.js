$(document).ready(function(){
	refush();
	jump_page(1, "group");
})
function remove(id){
	$.ajax({
	type: "GET",
	url: "/WebCardTest/group/remove",
	data:{"id":id},
	dataType: "json",
	async: false,
	success:function(resultData) {
		if(resultData.info == "success"){
			alert("删除成功");
		}
		else if(resultData.info == "id_error"){
			alert("没有这个分组");
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
	url: "/WebCardTest/group/edit",
	data:$("#group_edit").serialize(),
	dataType: "json",
	async: false,
	success:function(resultData) {
		if(resultData.info == "success"){
			alert("添加/修改成功");
		}
		else if(resultData.info == "id_error"){
			alert("没有这个分组");
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
	url: "/WebCardTest/group/list",
	dataType: "json",
	async: false,
	success: function(resultData){
		setCookie("group_total", resultData.total);
		var new_html = ''
		$.each(resultData.data, function(i, item){
			new_html += '<tr><td>'+item.id
                +'</td><td>'+item.group_id
				+'</td><td>'+item.name
				+'</td><td>'+new Date(item.ctime).toLocaleString()
				+'</td><td><a><button class="btn" onclick="remove('+item.id+')">删除</button></a></td></tr>';
		})
		$('#group tbody').html(new_html)
	},
	error: function(XMLHttpRequest, textStatus, errorThrown) {
		 alert(XMLHttpRequest.status);
		 alert(XMLHttpRequest.readyState);
		 alert(textStatus);
	}

	})
};
