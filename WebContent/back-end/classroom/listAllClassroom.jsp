<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.classroom.model.*"%>

<%
	ClassroomService classroomSvc = new ClassroomService();
	List<ClassroomVO> list = classroomSvc.getAll();
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>

<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>所有教室列表 - listAllClassroom.jsp</title>
<style>
table, th, td {
	border: 1px solid black;
}
</style>
</head>

<body>
	<h1>所有教室列表 - listAllClassroom.jsp</h1>
	<p>
		<a href="<%=request.getContextPath()%>/back-end/classroom/select_page.jsp">回首頁</a>
	</p>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>教室編號</th>
			<th>教室名稱</th>
			<th>教室深度</th>
			<th>教室寬度</th>
			<th>教室空間數</th>
			<th>預設座位狀態</th>
			<th>教室是否註銷</th>
			<th>最後修改時間</th>
			<th>修改</th>
			<th>註銷</th>
		</tr>
		<c:forEach var="classroomVO" items="${list}">
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
				<td>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do" style="margin-bottom: 0px;">
			     	<input type="submit" value="修改">
			     	<input type="hidden" name="roomno"  value="${classroomVO.roomno}">
			     	<input type="hidden" name="action"	value="getOne_For_Update"></FORM>
				</td>
				<td>
					<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/classroom/classroom.do" style="margin-bottom: 0px;">
			     	<input type="submit" value="註銷">
			     	<input type="hidden" name="roomno"  value="${classroomVO.roomno}">
			     	<input type="hidden" name="action"	value="delete"></FORM>
				</td>
			</tr>
		</c:forEach>
	</table>

</body>

</html>