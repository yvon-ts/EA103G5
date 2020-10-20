<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.classroom.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	ClassroomVO classroomVO = (ClassroomVO) request.getAttribute("classroomVO");
%>

<html>
<head>
<title>教室資料 - listOneClassroom.jsp</title>

<style>
table#table-1 {
	background-color: #CCCCFF;
	border: 2px solid black;
	text-align: center;
}

table#table-1 h4 {
	color: red;
	display: block;
	margin-bottom: 1px;
}

h4 {
	color: blue;
	display: inline;
}
</style>

<style>
table {
	width: 600px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
}

table, th, td {
	border: 1px solid #CCCCFF;
}

th, td {
	padding: 5px;
	text-align: center;
}
</style>

</head>
<body bgcolor='white'>

	<h1>教室資料 - ListOneClassroom.jsp</h1>
	<p>
		<a href="<%=request.getContextPath()%>/back-end/classroom/select_page.jsp">回首頁</a>
	</p>

	<table>
		<tr>
			<th>教室編號</th>
			<th>教室名稱</th>
			<th>空間列數</th>
			<th>空間行數</th>
			<th>空間總數</th>
			<th>預設座位狀態</th>
			<th>是否註銷</th>
			<th>最後修改時間</th>
		</tr>
		<tr>
			<td>${classroomVO.roomno}</td>
			<td>${classroomVO.roomname}</td>
			<td>${classroomVO.roomrow}</td>
			<td>${classroomVO.roomcolumn}</td>
			<td>${classroomVO.roomrow * classroomVO.roomcolumn}</td>
			<td>${classroomVO.defaultseat}</td>
			<td>${classroomVO.roomdelete}</td>
			<td><fmt:formatDate value="${classroomVO.roomlastmod}"
					pattern="yyyy-MM-dd HH:mm:ss" /></td>
		</tr>
	</table>
	
</body>
</html>