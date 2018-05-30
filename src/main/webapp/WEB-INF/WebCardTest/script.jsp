<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>智能卡测试系统</title>
    <!-- Mobile specific metas -->
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <!-- Force IE9 to render in normal mode -->
    <!--[if IE]>
    <meta http-equiv="x-ua-compatible" content="IE=9"/><![endif]-->
    <meta name="author" content="SuggeElson"/>
    <meta name="description" content=""
    />
    <meta name="keywords" content=""
    />
    <meta name="application-name" content="sprFlat admin template"/>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp" %>
    <!-- Windows8 touch icon ( http://www.buildmypinnedsite.com/ )-->
    <meta name="msapplication-TileColor" content="#3399cc"/>
    <!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="assets/ajax_js/base.js"></script>
    <script type="text/javascript" src="assets/js/jquery-ui-1.10.4.custom.min.js"></script>
    <script type="text/javascript" src="assets/js/jquery-ui-timepicker-addon.js"></script>
    <script type="text/javascript" src="assets/js/jquery-ui-timepicker-zh-CN.js"></script>
    <script type="text/javascript">
        $(function () {
            $(".ui_timepicker").datetimepicker({
                //showOn: "button",
                //buttonImage: "./css/images/icon_calendar.gif",
                //buttonImageOnly: true,
                showSecond: true,
                timeFormat: 'hh:mm:ss',
                stepHour: 1,
                stepMinute: 1,
                stepSecond: 1
            })
        })
    </script>
    <script type="text/javascript" src="assets/ajax_js/script.js"></script>
    <!--FileUpload  Js -->
    <script type="text/javascript" src="assets/ajax_js/fileupload.js"></script>
</head>
<body>
<!-- Start #header -->
<%@ include file="/WEB-INF/WebCardTest/common_head.jsp" %>
<!-- End #header -->
<!-- Start #sidebar -->
<%@ include file="/WEB-INF/WebCardTest/common_left.jsp" %>
<!-- End #sidebar -->
<!-- Start #content -->
<div id="content">
    <!-- Start .content-wrapper -->
    <div class="content-wrapper">
        <div class="row">
            <!-- Start .row -->
            <!-- Start .page-header -->
            <div class="col-lg-12 heading">
                <h1 class="page-header"><i class="en-upload"></i> 案例管理</h1>
                <!-- Start .bredcrumb -->
                <ul id="crumb" class="breadcrumb">
                </ul>
                <!-- End .breadcrumb -->
                <!-- Start .option-buttons -->
                <div class="option-buttons">
                    <div class="btn-toolbar" role="toolbar">
                        <div class="btn-group">
                            <a id="clear-localstorage" class="btn tip" title="Reset panels position" onclick="refush()">
                                <i class="ec-refresh color-red s24"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- End .option-buttons -->
            </div>
            <!-- End .page-header -->
        </div>
        <!-- End .row -->
        <!-- Page start here ( usual with .row ) -->
        <div class="outlet">
            <!-- Start .outlet -->

            <div class="col-md-5">
                <select class="form-control" name="id" id="group_upload">
                    <option value="">请指定分组</option>
                </select>
            </div>
            <div class="col-md-3">
                <input id="case_name" class="form-control" type="text" value="" placeholder="在这里输入案例名">
            </div>
            <div class="row">
                <div class="col-md-12">
                    <blockquote>
                        <p style="font-size:16px">
                            在这里进行案例的添加，指定一个分组，输入一个案例名，然后添加文件即可开始上传
                        </p>
                    </blockquote>
                    <br/>
                    <div id='filelist'>
                    </div>
                    <div class="row fileupload-buttonbar">
                        <div class="col-lg-7">
                                   	<span class="btn btn-success fileinput-button">
                                        <i class="input-file"></i>
                                        <input type="file" id="fileMutiply" name="files"/>
                                        <span>选择文件添加案例</span>
                                       </span>
                            <span class="fileupload-process">
                       </span>
                        </div>
                        <!-- The global progress information -->
                        <div class="col-lg-5 fileupload-progress fade">
                            <!-- The global progress bar -->
                            <div class="progress progress-striped active" role="progressbar" aria-valuemin="0"
                                 aria-valuemax="100">
                                <div class="progress-bar progress-bar-success" style="width:0%;">
                                </div>
                            </div>
                            <!-- The extended global progress information -->
                            <div class="progress-extended">
                                &nbsp;
                            </div>
                        </div>
                    </div>
                    <!-- The table listing the files available for upload/download -->
                    <table role="presentation" class="table table-striped clearfix">
                        <tbody class="files">
                        </tbody>
                    </table>
                    <div class="col-lg-12">
                        <!-- col-lg-12 start here -->
                        <div class="panel panel-default plain toggle panelClose panelRefresh">
                            <!-- Start .panel -->
                            <div class="panel-heading white-bg">
                                <h4 class="panel-title">案例列表</h4>
                            </div>
                            <ul id="crumb" class="breadcrumb">
                                <form class="form-search" id="find" onsubmit="return find();">
                                    <div class="col-md-6">
                                        <select class="form-control" name="id" id="group_choose">
                                            <option value="">请选择分组</option>
                                        </select>
                                    </div>
                                    <input type="text" name="begin_time" class="ui_timepicker" value=""
                                           placeholder="时间范围左值">
                                    <input type="text" name="end_time" class="ui_timepicker" value=""
                                           placeholder="时间范围右值">
                                    <button class="btn btn-primary start">查找</button>
                                </form>
                            </ul>
                            <div class="panel-body">
                                <table class="table" id="case">
                                    <thead>
                                    <tr>
                                        <th class="per10">序号</th>
                                        <th class="per10">案例名</th>
                                        <th class="per10">案例编号</th>
                                        <th class="per20">加入时间</th>
                                        <th class="per15">分组</th>
                                        <th class="per25">操作</th>
                                    </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <div class="page">
                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate"
                                     align="center">
                                    <ul class="pagination" id="page_info">
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <!-- End .panel -->
                    </div>
                    <!-- col-lg-12 end here -->
                </div>
            </div>
            <!-- Page End here -->
        </div>
        <!-- End .outlet -->
        <!-- The blueimp Gallery widget -->
        <div id="blueimp-gallery" class="blueimp-gallery blueimp-gallery-controls" data-filter=":even">
            <div class="slides">
            </div>
            <h3 class="title"></h3>
            <a class="prev">
                ‹
            </a>
            <a class="next">
                ›
            </a>
            <a class="close white">
            </a>
            <a class="play-pause">
            </a>
            <ol class="indicator">
            </ol>
        </div>
        <script id="template-upload" type="text/x-tmpl">
                { %
                    for (var i = 0, file; file = o.files[i]; i++)
                    { %
                    } < tr class = "template-upload fade" > < td > < span class = "preview" > < /span>
            </td > < td class = "vam" > < p class = "name" >
                    { %= file.name %
                    } < /p>
                {% if (file.error) { %}
                    <div><span class="label label-danger">Error</span >
                    { %= file.error %
                    } < /div>
                {% } %}
            </td > < td class = "vam" > < p class = "size" >
                    { %= o.formatFileSize(file.size) %
                    } < /p>
                {% if (!o.files.error) { %}
                    <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0">
                    <div class="progress-bar progress-bar-success" style="width:0%;"></div > < /div>
                {% } %}
            </td > < td class = "vam" >
                    { %
                        if (!o.files.error && !i && !o.options.autoUpload)
                        { %
                        } < button class = "btn blue start btn-sm" > < i class = "en-upload" > < /i>
                        <span>Start</span > < /button>
                {% } %}
                {% if (!i) { %}
                    <button class="btn red cancel btn-sm">
                        <i class="fa-ban-circle"></i > < span > Cancel < /span>
                    </button >
                        { %
                        } %
                    } < /td>
        </tr >
                    { %
                    } %
                }




        </script>
        <!-- The template to display files available for download -->
        <script id="template-download" type="text/x-tmpl">
                { %
                    for (var i = 0, file; file = o.files[i]; i++)
                    { %
                    } < tr class = "template-download fade" > < td > < span class = "preview" >
                    { %
                        if (file.thumbnailUrl)
                        { %
                        } < a href = "{%=file.url%}"
                        title = "{%=file.name%}"
                        download = "{%=file.name%}"
                        data - gallery > < img src = "{%=file.thumbnailUrl%}" > < /a>
                    {% } %}
                </span > < /td>
            <td class="vam">
                <p class="name">
                    {% if (file.url) { %}
                        <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a >
                        { %
                        }
                        else
                        { %
                        } < span >
                        { %= file.name %
                        } < /span>
                    {% } %}
                </p >
                        { %
                            if (file.error)
                            { %
                            } < div > < span class = "label label-danger" > Error < /span> {%=file.error%}</div >
                            { %
                            } %
                        } < /td>
            <td class="vam">
                <span class="size">{%=o.formatFileSize(file.size)%}</span > < /td>
            <td class="vam">
                {% if (file.deleteUrl) { %}
                    <button class="btn red delete btn-sm" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                        <i class="en-trash"></i > < span > Delete < /span>
                    </button > < input type = "checkbox"
                        name = "delete"
                        value = "1"
                        class = "toggle" >
                        { %
                        }
                        else
                        { %
                        } < button class = "btn yellow cancel btn-sm" > < i class = "fa-ban-circle" > < /i>
                        <span>Cancel</span > < /button>
                {% } %}
            </td > < /tr>
    {% } %}




        </script>
    </div>
    <!-- End .content-wrapper -->
    <div class="clearfix"></div>
</div>
<!-- End #content -->
<![endif]-->
<!-- Bootstrap Js -->
<script src="assets/js/bootstrap.min.js"></script>

<!-- Metis Menu Js -->
<script src="assets/js/jquery.metisMenu.js"></script>
<!-- Morris Chart Js -->
<!-- <script src="assets/js/morris/raphael-2.1.0.min.js"></script> -->
<!-- <script src="assets/js/morris/morris.js"></script> -->


<script src="assets/js/easypiechart.js"></script>
<script src="assets/js/easypiechart-data.js"></script>

<script src="assets/js/Lightweight-Chart/jquery.chart.js"></script>

<!-- Custom Js -->
<!-- <script src="assets/js/custom-scripts.js"></script> -->
<script type="text/javascript" src="assets/js/chartjs.js"></script>
</body>
</html>