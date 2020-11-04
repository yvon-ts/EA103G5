<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.classroom.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	ClassroomVO classroomVO = (ClassroomVO) request.getAttribute("classroomVO");
%>

<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>教室資料 - listOneClassroom.jsp</title>

	<!-- Bootstrap 的 CSS -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/classroom/css/classroom.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/classroom/css/classroom.css">
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>

</head>

<body>
	<main class="app-content" style="background-color: #f3f3f3">
		<div id="table-area" class="container-fluid">
			<div class="table-responsive">
				<form method="post" action="<%=request.getContextPath()%>/back-end/classroom/listAllClassroom.jsp">
					<button class="bttn" type="submit">回首頁</button>
				</form>
				<p>
					<div class="table-wrapper">
						<div class="row">
							<div class="col-md-4">

								<h2>基本資料：</h2>
								<br>
								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">編號</span>
									</div>
									<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										name="roomno" value="${classroomVO.roomno}" readonly>
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">名稱</span>
									</div>
									<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										name="roomname" value="${classroomVO.roomname}" readonly>
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">深度</span>
									</div>
									<input type="number" class="form-control roomSpace" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										min="1" max="10" id="roomrow" name="roomrow" value="${classroomVO.roomrow}" readonly>
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">寬度</span>
									</div>
									<input type="number" class="form-control roomSpace" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										min="1" max="10" id="roomcolumn" name="roomcolumn" value="${classroomVO.roomcolumn}" readonly>
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">狀態</span>
									</div>
									<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										name="roomdelete" value="${classroomVO.roomdelete ? '暫停使用' : '開放中'}" readonly>
								</div>

								<h2>座位數：<span id="seatCount"></span> / <span id="blockCount"></span></h2>

								<!-- 預設座位狀態：(hidden) -->
								<input type="hidden" id="defaultseat" name="defaultseat" value="${classroomVO.defaultseat}" readonly>
							</div>

							<div class="col-md-8">
								<h2 class="text-center">座位配置預覽圖</h2>
								<br>
								<div id="classroom">
									<div id="stage">
										Stage
									</div>
									<br>
									<div id="seatmapping">
									</div>
								</div>
							</div>
						</div>
					</div>
			</div>
		</div>
	</main>

	<script src="<%=request.getContextPath()%>/back-end/classroom/javascript/classroom.js"></script>
	<script>
		let statusStr = $("#defaultseat").val();
		setDefaultseatValue(statusStr);
		showSeatMapping();
	</script>
</body>

</html>