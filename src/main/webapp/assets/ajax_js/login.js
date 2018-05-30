function login(){
	$.ajax({
	type: "POST",
	url: "/WebCardTest/user/login",
	data:$("#login-form").serialize(),
	dataType: "json",
	async: false,
	success:function(resultData) {
		if(resultData.info == "success"){
			window.location.href="main";
		}
		else{
			alert("账号/密码错误");
		}
	},
	error:function(XMLHttpRequest, textStatus, errorThrown) {
		alert("登录失败， 服务器错误");
	}});
	return false;
}

function reset_form(){
    document.getElementById("login_name").value="";
	document.getElementById("password").value="";
}
