<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>EA103G5 Classroom: Home</title>
</head>

<body>
	<h1>Classroom: Home</h1>
	<p>This is the Home Page for EA103G5 Classroom: Home</p>
	<h3>資料查詢：</h3>

	<%-- 錯誤處理 --%>
	<c:if test="${not empty errorMsgs }">
		<h3>請修正以下錯誤：</h3>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li>${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<ul>
		<li><a href="<%=request.getContextPath()%>/back-end/classroom/listAllClassroom.jsp"> List </a> all Classrooms.</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do">
				<span> 請輸入教室編號 (如 ROOM0001)：</span> <input type="text" name="roomno">
				<input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<jsp:useBean id="classroomSvc" scope="page"
			class="com.classroom.model.ClassroomService" />

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do">
				<span> 請選擇教室編號：</span> <select name="roomno">
					<c:forEach var="classroomVO" items="${classroomSvc.all}">
						<option value="${classroomVO.roomno}">
							${classroomVO.roomno}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>

		<li>
			<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do">
				<span> 請選擇教室名稱：</span> <select name="roomno">
					<c:forEach var="classroomVO" items="${classroomSvc.all}">
						<option value="${classroomVO.roomno}">
							${classroomVO.roomname}
					</c:forEach>
				</select> <input type="hidden" name="action" value="getOne_For_Display">
				<input type="submit" value="送出">
			</FORM>
		</li>
	</ul>
	
	<h3>教室管理</h3>
	<ul>
		<li> <a href="<%=request.getContextPath()%>/back-end/classroom/addClassroom.jsp"> Add </a> a new Classroom.</li>
	</ul>
	
<%--  	<jsp:include page="/back-end/classroom/listAllClassroom.jsp"/> --%>

</body>
</html>