<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.course.model.*"%>

<%
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>課程資料新增 - addCourse.jsp</title>

<style>
table {
	width: 950px;
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
	<h3>課程資料新增 - addCourse.jsp</h3>
	
	<p>
		<a href="<%=request.getContextPath()%>/front-end/course/select_page.jsp">回首頁</a>
	</p>
	
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

	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/course/course.do" name="form1">
		<table>
			<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService"/>
			<tr>
				<td>類別編號:<font color=red><b>*</b></font></td>
				<td><input type="TEXT" name="cstypeno" size="45"
					value="<%=(courseVO == null) ? "TYPE0001" : courseVO.getCstypeno()%>" /></td>
			</tr>
			<tr>
				<td>老師編號:</td>
				<td><input type="TEXT" name="tchrno" size="45"
					value="<%=(courseVO == null) ? "TCHR0001" : courseVO.getTchrno()%>"/></td>
			</tr>
			<tr>
				<td>課程名稱:</td>
				<td><input type="TEXT" name="coursename" size="45"
					value="<%=(courseVO == null) ? "真空吸引" : courseVO.getCoursename()%>"/></td>
			</tr>
			<tr>
				<td>課程資訊:</td>
				<td><input type="TEXT" name="courseinfo" size="45"
					value="<%=(courseVO == null) ? "這是一堂騙錢的課" : courseVO.getCourseinfo()%>" /></td>
			</tr>
			<tr>
				<td>課程單價:</td>
				<td><input type="NUMBER" name="courseprice" size="45"
					value="<%=(courseVO == null) ? 787 : courseVO.getCourseprice()%>" /></td>
			</tr>
			<tr>
				<td>課程總時數:</td>
				<td><input type="NUMBER" name="ttltime" size="45"
					value="<%=(courseVO == null) ? 9999 : courseVO.getTtltime()%>" /></td>
			</tr>
			<tr>
				<td>商品狀態:</td>
				<td>
					<input type="RADIO" name="csstatus" size="45" value="審核中" checked>審核中
					<input type="RADIO" name="csstatus" size="45" value="上架">上架
					<input type="RADIO" name="csstatus" size="45" value="下架">下架
				</td>
			</tr>
			<tr>
				<td>累積總評分數:</td>
				<td><input type="NUMBER" name="csscore" size="45"
					value="<%=(courseVO == null) ? 333 : courseVO.getCsscore()%>" /></td>
			</tr>
			<tr>
				<td>評分次數:</td>
				<td><input type="NUMBER" name="csscoretimes" size="45"
					value="<%=(courseVO == null) ? 444 : courseVO.getCsscoretimes()%>" /></td>
			</tr>
		</table>
		<br>
		<input type="hidden" name="action" value="insert">
		<input type="submit" value="送出新增">
	</FORM>
</body>
</html>