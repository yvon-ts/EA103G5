<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.course.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");
%>

<html>
<head>
<title>課程資料 - listOneCourse.jsp</title>

<style>
table#table-1 {
	frontground-color: #CCCCFF;
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
	frontground-color: white;
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

	<h1>課程資料 - ListOneCourse.jsp</h1>
	<p>
		<a href="<%=request.getContextPath()%>/front-end/course/select_page.jsp">回首頁</a>
	</p>

	<table>
		<tr>
			<th>課程編號</th>
			<th>類別編號</th>
			<th>老師編號</th>
			<th>課程名稱</th>
			<th>課程資訊</th>
			<th>課程單價</th>
			<th>課程總時數</th>
			<th>商品狀態</th>
			<th>累積總評分</th>
			<th>評分次數</th>
		</tr>
		<tr>
			<td>${courseVO.courseno}</td>
			<td>${courseVO.cstypeno}</td>
			<td>${courseVO.tchrno}</td>
			<td>${courseVO.coursename}</td>
			<td>${courseVO.courseinfo}</td>
			<td>${courseVO.courseprice}</td>
			<td>${courseVO.ttltime}</td>
			<td>${courseVO.csstatus}</td>
			<td>${courseVO.csscore}</td>
			<td>${courseVO.csscoretimes}</td>
		</tr>
	</table>
	
</body>
</html>