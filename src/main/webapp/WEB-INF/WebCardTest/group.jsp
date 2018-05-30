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
    <meta name="description" content=""/>
    <meta name="keywords" content=""/>
    <meta name="application-name" content="sprFlat admin template"/>
    <%@ include file="/WEB-INF/WebCardTest/common_css.jsp"%>
    <!-- Windows8 touch icon ( http://www.buildmypinnedsite.com/ )-->
    <meta name="msapplication-TileColor" content="#3399cc"/>
    <!-- jQuery Js -->
    <script src="assets/js/jquery-1.10.2.js"></script>
    <script type="text/javascript" src="assets/ajax_js/base.js"></script>
    <script type="text/javascript" src="assets/ajax_js/group.js"></script>
</head>
<body>
<!-- Start #header -->
<%@ include file="/WEB-INF/WebCardTest/common_head.jsp"%>
<!-- End #header -->

<%@ include file="/WEB-INF/WebCardTest/common_left.jsp" %>

<!-- Start #content -->
<div id="content">
    <!-- Start .content-wrapper -->
    <div class="content-wrapper">
        <div class="row">
            <!-- Start .row -->
            <!-- Start .page-header -->
            <div class="col-lg-12 heading">
                <h1 class="page-header"><i class="im-table2"></i> 分组管理</h1>
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
                        <div class="btn-group dropdown">
                            <a class="btn dropdown-toggle" data-toggle="dropdown" id="dropdownMenu2"><i
                                    class="ec-pencil s24"></i></a>
                            <div class="dropdown-menu pull-right" role="menu" aria-labelledby="dropdownMenu2">
                                <div class="option-dropdown">
                                    <div class="row">
                                        <p class="col-lg-12">添加/编辑</p>
                                        <form id="group_edit" class="form-horizontal" onsubmit="return edit();">
                                            <div class="form-group">
                                                <div class="col-lg-12">
                                                    <input type="text" name="id" class="form-control"
                                                           placeholder="若编辑，输入序号">
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                            <div class="form-group">
                                                <div class="col-lg-12">
                                                    <textarea name="name" class="form-control wysiwyg"
                                                              placeholder="分组名称"></textarea>
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->

                                            <div class="form-group">
                                                <div class="col-lg-12">
                                                    <button class="btn btn-success btn-xs pull-right">添加/编辑</button>
                                                </div>
                                            </div>
                                            <!-- End .form-group  -->
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- End .option-buttons -->
            </div>
            <!-- End .page-header -->
        </div>
        <!-- End .row -->
        <div class="outlet">
            <!-- Start .outlet -->
            <!-- Page start here ( usual with .row ) -->
            <div class="row">
                <div class="col-lg-12">
                    <!-- col-lg-12 start here -->
                    <div class="panel panel-default plain toggle panelClose panelRefresh">
                        <!-- Start .panel -->
                        <div class="panel-heading white-bg">
                            <h4 class="panel-title">分组列表</h4>
                        </div>
                        <div class="panel-body">
                            <table class="table" id="group">
                                <thead>
                                <tr>
                                    <th class="per10">序号</th>
                                    <th class="per15">分组编号</th>
                                    <th class="per10">分组名称</th>
                                    <th class="per15">创建时间</th>
                                    <th class="per5">操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                </tbody>
                            </table>
                            <div class="page">
                                <div class="dataTables_paginate paging_simple_numbers" id="dataTables-example_paginate"
                                     align="center">
                                    <ul class="pagination" id="page_info">

                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- End .panel -->
                </div>
                <!-- col-lg-12 end here -->
            </div>
            <!-- End .row -->
            <!-- Page End here -->
        </div>
        <!-- End .outlet -->
    </div>
    <!-- End .content-wrapper -->
    <div class="clearfix"></div>
</div>
<!-- End #content -->
<!-- Javascripts -->
<!-- Bootstrap Js -->
<script src="assets/js/bootstrap.min.js"></script>

<!-- Metis Menu Js -->
<script src="assets/js/jquery.metisMenu.js"></script>
<!-- Morris Chart Js -->
<script src="assets/js/morris/raphael-2.1.0.min.js"></script>
<script src="assets/js/morris/morris.js"></script>


<script src="assets/js/easypiechart.js"></script>
<script src="assets/js/easypiechart-data.js"></script>

<script src="assets/js/Lightweight-Chart/jquery.chart.js"></script>

<!-- Custom Js -->
<script src="assets/js/custom-scripts.js"></script>


<!-- Chart Js -->
<script type="text/javascript" src="assets/js/chartjs.js"></script>

</body>
</html>