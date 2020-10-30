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
<div id="table-area" class="container-xl">
		<div class="table-responsive">
			<form method="post"	action="<%=request.getContextPath()%>/back-end/classroom/listAllClassroom.jsp">
				<button class="bttn" type="submit">放棄新增</button>
			</form><p>
			<div class="table-wrapper">
               		<div class="row">
<!-- 	<div class="container"> -->
<!-- 		<div class="row"> -->
<!-- 			<h1>教室資料新增 - addClassroom</h1> -->
<!-- 		</div> -->
<!-- 		<div class="row"> -->
<%-- 			<p><a href="<%=request.getContextPath()%>/back-end/classroom/select_page.jsp">回首頁</a></p> --%>
<!-- 		</div> -->

<!-- 		<div class="row"> -->
<!-- 			<div class="col-md-4"> -->
				
<%-- 				錯誤表列 --%>
<%-- 				<c:if test="${not empty errorMsgs}"> --%>
<!-- 					<font style="color: red">請修正以下錯誤:</font> -->
<!-- 					<ul> -->
<%-- 						<c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 							<li style="color: red">${message}</li> --%>
<%-- 						</c:forEach> --%>
<!-- 					</ul> -->
<%-- 				</c:if> --%>

				<h3>資料新增：</h3>
				<form METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do" name="form1">
				<div class="table-title">
					<div class="row">
					<div id="form-area" class="col-sm-7 btm-line">
					<p>教室名稱：<input type="text" name="roomname" placeholder="請輸入教室名稱"
						value="<%=(classroomVO == null) ? "Z001" : classroomVO.getRoomname()%>"></p>
					<p>教室深度：<input type="number" id="roomrow" class="roomSpace" name="roomrow" min="1" max="10"
						value="<%=(classroomVO == null) ? 3 : classroomVO.getRoomrow()%>"></p>
					<p>教室寬度：<input type="number" id="roomcolumn" class="roomSpace" name="roomcolumn" min="1" max="10"
						value="<%=(classroomVO == null) ? 5 : classroomVO.getRoomcolumn()%>"></p>
					<p>座位數：<span id="seatCount"></span> / <span id="blockCount"></span> </p>
					<p>狀態：<input type="RADIO" name="roomdelete" size="45" value=false checked>可用
							<input type="RADIO" name="roomdelete" size="45" value=true>註銷</p>
					<input type="hidden" name="action" value="insert">
					<input type="submit" value="送出新增">
					<button><a href="<%=request.getContextPath()%>/back-end/classroom/listAllClassroom.jsp">取消</a></button>
					<br>
					<p>預設座位狀態：(hidden)<input type="text" id="defaultseat" name="defaultseat" value="<%=(classroomVO == null) ? "111110000011111" : classroomVO.getDefaultseat()%>" readonly></p>
					
				
			</div>
			</div>
			</div>
</form>
			<div class="col-md-8">
				<h3>教室 Layout 預覽圖：</h3>
				<div id="classroom">
					<div id="stage">
						Stage
					</div>
					<br>
					<div id="seatmapping"></div>
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