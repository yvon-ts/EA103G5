<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.functionx.model.*"%>
<jsp:include page="/back-end/index/homepage.jsp" />
<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService" />
<jsp:useBean id="courseTypeSvc" scope="page" class="com.course_type.model.CourseTypeService" />
<jsp:useBean id="membersSvc" scope="page" class="com.members.model.MembersService" />
<jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />

<%
// 	System.out.println("==========");
	request.setCharacterEncoding("UTF-8");
	Map<String, String[]> map = new TreeMap<String, String[]>();
	
	String newSearchStatus = (String) request.getParameter("show");
// 	System.out.println("newSearchStatus 1 = " + newSearchStatus);
	String searchStatus = (String) session.getAttribute("searchStatus");
// 	System.out.println("searchStatus 1 = " + searchStatus);
	if (searchStatus == null) {
		searchStatus = "all";
	}
// 	System.out.println("searchStatus 2 = " + searchStatus);

	if (newSearchStatus != null) {
		searchStatus = newSearchStatus;
	}
// 	System.out.println("searchStatus 2 = " + searchStatus);
	session.setAttribute("searchStatus", searchStatus);
	
	if (!("all".equals(searchStatus))) {
		map.put("csstatus", new String[]{searchStatus});
	}
	List<CourseVO> list = courseSvc.getAll(map);
	pageContext.setAttribute("list", list);
%>

<jsp:useBean id="funSvc" scope="page" class="com.functionx.model.FunctionxService" />
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">

	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/font-awesome/5.15.1/css/all.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
	<script src="<%=request.getContextPath()%>/library/bootstrap/4.5.3/js/bootstrap.min.js"></script>
	<script src="<%=request.getContextPath()%>/library/jquery/jquery-3.5.1.js"></script>

	<style>
		body {
			color: #566787;
			background: #f5f5f5;
			font-family: 'Varela Round', sans-serif;
		}

		.table-responsive {
			margin: 30px 0;
		}

		.table-wrapper {
			min-width: auto;
			background: #fff;
			padding: 20px 25px;
			border-radius: 3px;
			box-shadow: 0 1px 1px rgba(0, 0, 0, .05);
		}

		.table-wrapper .btn {
			float: right;
			color: #333;
			background-color: #fff;
			border-radius: 3px;
			border: none;
			outline: none !important;
			margin-left: 10px;
		}

		.table-wrapper .btn:hover {
			color: #333;
			background: #f2f2f2;
		}

		.table-wrapper .btn.btn-primary {
			color: #fff;
			background: #03A9F4;
		}

		.table-wrapper .btn.btn-primary:hover {
			background: #03a3e7;
		}

		.table-title .btn {
			font-size: 13px;
			border: none;
		}

		.table-title .btn i {
			float: left;
			font-size: 21px;
			margin-right: 5px;
		}

		.table-title .btn span {
			float: left;
			margin-top: 2px;
		}

		.table-title {
			color: #fff;
			background: #4b5366;
			padding: 16px 25px;
			margin: -20px -25px 10px;
			border-radius: 3px 3px 0 0;
		}

		.table-title h2 {
			margin: 5px 0 0;
			font-size: 24px;
		}

		.show-entries select.form-control {
			width: 60px;
			margin: 0 5px;
		}

		.table-filter .filter-group {
			float: right;
			margin-left: 15px;
		}

		.table-filter input,
		.table-filter select {
			height: 34px;
			border-radius: 3px;
			border-color: #ddd;
			box-shadow: none;
		}

		.table-filter {
			padding: 5px 0 15px;
			border-bottom: 1px solid #e9e9e9;
			margin-bottom: 5px;
		}

		.table-filter .btn {
			height: 34px;
		}

		.table-filter label {
			font-weight: normal;
			margin-left: 10px;
		}

		.table-filter select,
		.table-filter input {
			display: inline-block;
			margin-left: 5px;
		}

		.table-filter input {
			width: 200px;
			display: inline-block;
		}

		.filter-group select.form-control {
			width: 110px;
		}

		.filter-icon {
			float: right;
			margin-top: 7px;
		}

		.filter-icon i {
			font-size: 18px;
			opacity: 0.7;
		}

		table.table tr th,
		table.table tr td {
			border-color: #e9e9e9;
			padding: 12px 15px;
			vertical-align: middle;
		}

		table.table tr th:first-child {
			width: 60px;
		}

		table.table tr th:last-child {
			width: 80px;
		}

		table.table-striped tbody tr:nth-of-type(odd) {
			background-color: #fcfcfc;
		}

		table.table-striped.table-hover tbody tr:hover {
			background: #f5f5f5;
		}

		table.table th i {
			font-size: 13px;
			margin: 0 5px;
			cursor: pointer;
		}

		table.table td a {
			font-weight: bold;
			color: #566787;
			display: inline-block;
			text-decoration: none;
		}

		table.table td a:hover {
			color: #2196F3;
		}

		table.table td a.view {
			width: 30px;
			height: 30px;
			color: #2196F3;
			border: 2px solid;
			border-radius: 30px;
			text-align: center;
		}

		input[type="submit"].view {
			width: 60px;
			height: 30px;
			color: #2196F3;
			border: 2px solid;
			border-radius: 30px;
			text-align: center;
		}

		input[type="submit"].view:hover {
			color: #000000;
		}

		table.table td a.view i {
			font-size: 22px;
			margin: 2px 0 0 1px;
		}

		table.table .avatar {
			border-radius: 50%;
			vertical-align: middle;
			margin-right: 10px;
		}

		.status {
			font-size: 30px;
			margin: 2px 2px 0 0;
			display: inline-block;
			vertical-align: middle;
			line-height: 10px;
		}

		.text-success {
			color: #10c469;
		}

		.text-info {
			color: #62c9e8;
		}

		.text-warning {
			color: #FFC107;
		}

		.text-danger {
			color: #ff5b5b;
		}

		.pagination {
			float: right;
			margin: 0 0 5px;
		}

		.pagination2 {
			float: left;
			margin: 0 0 5px;
		}

		.pagination2 form {
			border: none;
			font-size: 13px;
			min-width: 30px;
			min-height: 30px;
			color: #999;
			margin: 0 2px;
			line-height: 30px;
			border-radius: 2px !important;
			text-align: center;
			padding: 0 6px;
		}

		.pagination li a {
			border: none;
			font-size: 13px;
			min-width: 30px;
			min-height: 30px;
			color: #999;
			margin: 0 2px;
			line-height: 30px;
			border-radius: 2px !important;
			text-align: center;
			padding: 0 6px;
		}

		.pagination li a:hover {
			color: #666;
		}

		.pagination li.active a {
			background: #03A9F4;
		}

		.pagination li.active a:hover {
			background: #0397d6;
		}

		.pagination li.disabled i {
			color: #ccc;
		}

		.pagination li i {
			font-size: 16px;
			padding-top: 6px
		}

		.hint-text {
			float: left;
			margin-top: 10px;
			font-size: 13px;
		}
	</style>

	<script>
		$(document).ready(function () {
			$('[data-toggle="tooltip"]').tooltip();
		});
	</script>

	<title>調整課程權限</title>
</head>

<body>
	<main class="app-content">
		<div class="container-xl">
			<div class="table-responsive">
				<div class="table-wrapper">
					<div class="table-title">
						<div class="row">
							<div class="col-sm-4">
								<h2>
									<b>課程列表</b>
								</h2>
							</div>
							<div class="col-sm-6">
								<form method="post" action="<%=request.getContextPath()%>/back-end/course/editCourseStatus.jsp">
									<select class="custom-select" name="show">
										<option value="all" ${searchStatus=="all" ? 'selected' : '' }>所有
										<option value="審核中" ${searchStatus=="審核中" ? 'selected' : '' }>審核中
										<option value="上架" ${searchStatus=="上架" ? 'selected' : '' }>上架
										<option value="下架" ${searchStatus=="下架" ? 'selected' : '' }>下架
									</select>
							</div>
							<div class="col-sm-2">
								<input type="submit" value="查詢" class="view show">
								</form>
							</div>
						</div>
					</div>
					<table class="table table-striped table-hover" id="test">
						<thead>
							<tr>
								<th>編號</th>
								<th>名稱</th>
								<th>類別</th>
								<th>老師</th>
								<th>單價</th>
								<th>更新時間</th>
								<th>狀態</th>
								<th>修改</th>
							</tr>
						</thead>
						<tbody>

							<%@ include file="page1.file"%>
							<c:forEach var="courseVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
								<%-- 								<c:forEach var="courseVO" items="${courseSvc.allForEmployee}"> --%>
								<tr>
									<td>${courseVO.courseno}</td>
									<td>${courseVO.coursename}</td>
									<td>${courseTypeSvc.getOneCourseType(courseVO.cstypeno).cstypename}</td>
									<td>${membersSvc.getOneMembers(teacherSvc.getOneTeacher(courseVO.tchrno).memno).memname}</td>
									<td>${courseVO.courseprice}</td>
									<td>
										<fmt:formatDate value="${courseVO.courlmod}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td>
										<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/CourseServlet_Ajax">
											<select class="custom-select" name="csstatus">
												<option value="審核中" ${courseVO.csstatus=="審核中" ? 'selected' : '' }>審核中
												<option value="上架" ${courseVO.csstatus=="上架" ? 'selected' : '' }>上架
												<option value="下架" ${courseVO.csstatus=="下架" ? 'selected' : '' }>下架
											</select>
											<input type="hidden" name="courseno" value="${courseVO.courseno}">
											<input type="hidden" name="action" value="updateCourseStatus">
										</FORM>
									</td>
									<td>
										<input type="submit" value="修改" class="view updateButton">
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@ include file="page2.file"%>
				</div>
			</div>
		</div>
	</main>

	<script>
		// 上傳單一單元的影片
		$(".updateButton").click(function (e) {
			e.preventDefault();
			console.log($(this).parents("tr").find("form")[0]);
			var formData = new FormData($(this).parents("tr").find("form")[0]);

			for (let key of formData.keys()) {
				console.log(key + " : " + formData.get(key));
			}

			$.ajax({
				url: "<%=request.getContextPath()%>/CourseServlet_Ajax",
				type: "POST",
				data: formData,
				processData: false,
				contentType: false,
				success: function (data) {
					swal({
						title:'課程狀態調整',
						text: data,
						type: 'info'
					})
				},
				error: function (data) {
					swal('伺服器忙碌中', "請稍後再試", 'warning');
				}
			});
		});
	</script>
</body>

</html>