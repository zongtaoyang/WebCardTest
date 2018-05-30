/**
 * 
 */
var i=0;
var j=0;
var progress_topic = new Array("success","primary", "warning", "danger")
var xhrOnProgress=function(fun) {
	  xhrOnProgress.onprogress = fun; //绑定监听
	  //使用闭包实现监听绑
	  return function() {
	    //通过$.ajaxSettings.xhr();获得XMLHttpRequest对象
	    var xhr = $.ajaxSettings.xhr();
	    //判断监听函数是否为函数
	    if (typeof xhrOnProgress.onprogress !== 'function')
	      return xhr;
	    //如果有监听函数并且xhr对象支持绑定时就把监听函数绑定上去
	    if (xhrOnProgress.onprogress && xhr.upload) {
	      xhr.upload.onprogress = xhrOnProgress.onprogress;
	    }
	    return xhr;
	  }
}
function guid() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
        var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
        return v.toString(16);
    });
}
function cancel(id){
	if($('#ttt'+id).attr('aria-valuenow') != "100"){
		alert('上传未完成');
		return;
	}
	document.getElementById(id).remove();
}
$(function(){
$("#fileMutiply").change(function upload_file(){
	var group_id = $("#group_upload").val();
	if(!group_id){
		alert('请选择分组');
		return;
	}
	var file = this.files[0];
	var id = guid();
	var panel = '<div class="panel-body"><div class="progress progress-striped active"><div id="ttt'+id+'" class="progress-bar progress-bar-'+progress_topic[j%4]+'" role="progressbar" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100" style="width: 0%"></div></div></div>';
	++ j;
	var remove = '<a href="#" class="btn btn-info btn-lg" onclick=cancel("'+id+'")>x</a>';
	$('#filelist').append(
			'<div class="row" id="'+id+'">'
			+'<div class="col-md-2">'+file.name+'</div>'
			+'<div class="col-md-6">'+panel+'</div>'
			+'<div class="col-md-1"><span id="ywc'+id+'">已完成0%</span></div>'
			+'<div class="col-md-1">'+remove+'</div></div>');
	var formData = new FormData();
	formData.append('files', file);
	formData.append('group_id', group_id);
	formData.append('case_name', $("#case_name").val());
	$.ajax({
      url:'/WebCardTest/case/upload',
      type:'post',
      cache: false,
      data: formData,//文件以formData形式传入
      processData : false,//必须false才会自动加上正确的Content-Type 
      contentType : false,
      xhr:xhrOnProgress(function(evt){
		    var loaded = evt.loaded;   //已经上传大小情况 
		    var tot = evt.total;   //附件总大小 
		    var per = Math.floor(100*loaded/tot);	    
		    $('#ttt'+id).attr('style', 'width: '+per+'%');
		    $('#ttt'+id).attr('aria-valuenow', per);
	    	$('#ywc'+id).html('已完成'+per+'%')
	  }),
      success:function(data){
         refush()
      },
      error:function(xhr){
    	  alert("上传出错");
      }               
    });
})
})