var page_size = 5; //每页数
function setCookie(name,value)
{
	var Days = 30;
	var exp = new Date();
	exp.setTime(exp.getTime() + Days*24*60*60*1000);
	document.cookie = name + "="+ escape (value) + ";expires=" + exp.toGMTString();
}

function getCookie(name)
{
	var arr,reg=new RegExp("(^| )"+name+"=([^;]*)(;|$)");
	if(arr=document.cookie.match(reg))
	return unescape(arr[2]);
	else
	return null;
}

function jump_page(page, key){
	var dataDom = $("#"+key+" tbody");
	var i = 0;
	var person_total = getCookie(key+"_total");
	while(i < person_total){
		if(i < (page-1) * page_size || i >= page * page_size){
			$("#"+key+" tbody tr").eq(i).attr("style", "display: none;");
		}
		else{
			$("#"+key+" tbody tr").eq(i).attr("style", "display: table-row;");
		}
		i++;
	}
	write_page_info(page, key);
}

function write_page_info(now, key){
	var max_page = parseInt(getCookie(key+"_total")/page_size) + 1;
	var t = document.getElementById("page_info");
	t.innerHTML = '<li class="paginate_button" aria-controls="dataTables-example" tabindex="0" id="dataTables-example_previous">'
		+'<a href="javascript:void(0);" onclick=jump_page(1,"'+key+'")>首页</a></li>';
	if(now > 1){
		t.innerHTML += '<li class="paginate_button" aria-controls="dataTables-example" tabindex="0">'
		    +'<a href="javascript:void(0);" onclick=jump_page('+(now-1)+',"'+key+'")>'+(now-1)+'</a>'
		    +'</li>'
	}
	t.innerHTML += '<li class="paginate_button " aria-controls="dataTables-example" tabindex="0">'
		    +'<a href="javascript:void(0);" onclick=jump_page('+now+',"'+key+'")>'+now+'</a>'
		    +'</li>';
	if(now < max_page){
		t.innerHTML += '<li class="paginate_button " aria-controls="dataTables-example" tabindex="0">'
		    +'<a href="javascript:void(0);" onclick=jump_page('+(now+1)+',"'+key+'")>'+(now+1)+'</a>'
		    +'</li>';
	}
	t.innerHTML += '<li class="paginate_button " aria-controls="dataTables-example" tabindex="0">'
		    +'<a href="javascript:void(0);" onclick=jump_page('+max_page+',"'+key+'")>末页</a>'
		    +'</li>'
}