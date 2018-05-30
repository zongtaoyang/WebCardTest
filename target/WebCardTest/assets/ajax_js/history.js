$(document).ready(function(){
	refush();
	write_person();
})

function find(){
	$.ajax({
	type: "GET",
	url: "/WebCardTest/history/find",
	data:$("#find").serialize(),
	dataType: "json",
	async: false,
	success:function(resultData) {
		setCookie("history_total", resultData.total);
		var new_html = '';
		$.each(resultData.data, function(i, item){
//			var t = document.createElement("tr");
			new_html += '<tr><td>'+item.id+'</td><td>'+item.username+'</td><td>'+new Date(item.ctime).toLocaleString()+'</td><td></tr>';
		})
		$('#history tbody').html(new_html);
		jump_page(1, 'history');
	},
	error:function(XMLHttpRequest, textStatus, errorThrown) {
		 alert(XMLHttpRequest.status);
		 alert(XMLHttpRequest.readyState);
		 alert(textStatus);
	}});
	return false; // 必须返回false，否则表单会自己再做一次提交操作，并且页面跳转
}

function write_person(){
	$.ajax({
		type: "GET",
		url: "/WebCardTest/user/list",
		dataType: "json",
		async: false,
		success: function(resultData){
			$.each(resultData.data, function(i, item){
				var option = document.createElement("option");
				option.setAttribute("value", item.id);
				option.innerHTML = item.username;
				$('#person').append(option);
			})
		},
		error: function(XMLHttpRequest, textStatus, errorThrown) {
			 alert(XMLHttpRequest.status);
			 alert(XMLHttpRequest.readyState);
			 alert(textStatus);
		}

		})
}

function refush(){
	find();
};
