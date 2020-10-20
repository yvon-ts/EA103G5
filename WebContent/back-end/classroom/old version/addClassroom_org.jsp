<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.classroom.model.*"%>

<%
	ClassroomVO classroomVO = (ClassroomVO) request.getAttribute("classroomVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>教室資料新增 - addClassroom.jsp</title>

<style>
table {
	width: 450px;
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
}

table, th, td {
	border: 0px solid #CCCCFF;
}

th, td {
	padding: 1px;
}
</style>

</head>

<body bgcolor='white'>
	<h3>教室資料新增 - addClassroom.jsp</h3>
	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post" ACTION="classroom.do" name="form1">
		<table>
			<tr>
				<td>教室名稱:</td>
				<td><input type="TEXT" name="roomname" size="45"
					value="<%=(classroomVO == null) ? "A001" : classroomVO.getRoomname()%>" /></td>
			</tr>
			<tr>
				<td>空間列數:</td>
				<td><input type="NUMBER" name="roomrow" size="45"
					value="<%=(classroomVO == null) ? 3 : classroomVO.getRoomrow()%>" /></td>
			</tr>
			<tr>
				<td>空間欄數:</td>
				<td><input type="NUMBER" name="roomcolumn" size="45"
					value="<%=(classroomVO == null) ? 5 : classroomVO.getRoomcolumn()%>" /></td>
			</tr>
			<tr>
				<td>預設座位狀態:</td>
				<td><input type="TEXT" name="defaultseat" size="45"
					value="<%=(classroomVO == null) ? "101010101010110" : classroomVO.getDefaultseat()%>" /></td>
			</tr>
			<tr>
				<td>是否註銷:</td>
				<td>
					<input type="RADIO" name="roomdelete" size="45" value=false checked>可使用
					<input type="RADIO" name="roomdelete" size="45" value=true>已註銷
				</td>
			</tr>

		</table>
		<br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出新增">
	</FORM>
</body>
</html>