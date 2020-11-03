<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.classroom.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<%
	ClassroomVO classroomVO = (ClassroomVO) request.getAttribute("classroomVO");
%>

<html>

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>addClassroom</title>

	<!-- Bootstrap 的 CSS -->
	<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
	<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
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
					<button class="bttn" type="submit">放棄新增</button>
				</form>
				<p></p>
				<div class="table-wrapper">
					<div class="row">
						<div class="col-md-4">

							<!-- 錯誤表列 -->
							<c:if test="${not empty errorMsgs}">
								<font style="color: red">請修正以下錯誤:</font>
								<ul>
									<c:forEach var="message" items="${errorMsgs}">
										<li style="color: red">${message}</li>
									</c:forEach>
								</ul>
							</c:if>

							<h2>基本資料：</h2>
							<br>
							<form METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do" name="form1">

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">名稱</span>
									</div>
									<input type="text" class="form-control" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										name="roomname" placeholder="請輸入教室名稱" value="<%=(classroomVO == null) ? "Z001" : classroomVO.getRoomname()%>">
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">深度</span>
									</div>
									<input type="number" class="form-control roomSpace" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										min="1" max="10" id="roomrow" name="roomrow" value="<%=(classroomVO == null) ? 3 : classroomVO.getRoomrow()%>">
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<span class="input-group-text" id="inputGroup-sizing-default">寬度</span>
									</div>
									<input type="number" class="form-control roomSpace" aria-label="Sizing example input" aria-describedby="inputGroup-sizing-default"
										min="1" max="10" id="roomcolumn" name="roomcolumn" value="<%=(classroomVO == null) ? 5 : classroomVO.getRoomcolumn()%>">
								</div>

								<div class="input-group mb-3">
									<div class="input-group-prepend">
										<label class="input-group-text">狀態</label>
									</div>
									<select class="custom-select" name="roomdelete">
										<option value=false ${(!classroomVO.roomdelete) ? 'selected' : '' }>可用</option>
										<option value=true ${(classroomVO.roomdelete) ? 'selected' : '' }>註銷</option>
									</select>
								</div>

								<h2>座位數：<span id="seatCount"></span> / <span id="blockCount"></span> </h2>

								<br>
								<input type="hidden" name="action" value="insert">
								<button type="submit" class="bttn" type="submit">新增教室</button>

								<!-- 預設座位狀態：(hidden) -->
								<input type="hidden" id="defaultseat" name="defaultseat" value="<%=(classroomVO == null) ? "111110000011111" : classroomVO.getDefaultseat()%>" readonly>
							</form>
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


		<script src="<%=request.getContextPath()%>/back-end/classroom/javascript/classroom.js"></script>
		<script>
			//         // 使用者輸入欲設定空間的 row
			//         let roomRow = $("#roomrow").val();
			//         // 使用者輸入欲設定空間的 Column
			//         let roomColumn = $("#roomcolumn").val();
			// 取得 defaultseat 的字串值
			let statusStr = $("#defaultseat").val();

			// [初始] 印出教室 layout
			setDefaultseatValue(statusStr);
			showSeatMapping();
			addBlockClickEvent();

			// ==============================================================

			// 當教室深度、寬度改變
			$(".roomSpace").change(seatChange);
		</script>
	</main>
</body>

</html>