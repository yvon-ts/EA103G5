<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<%@ page import="com.video.model.*"%>

<%
	CourseVO courseVO = (CourseVO) request.getAttribute("courseVO");
%>

<!DOCTYPE html>
<html>

<head>
</head>

<body>
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
		<input type="hidden" name="courseno" value="${courseVO.courseno}">
		<input type="hidden" name="tchrno" value="${courseVO.tchrno}">
		<input type="hidden" name="ttltime" value="${courseVO.ttltime}">
		<input type="hidden" name="csstatus" value="${courseVO.csstatus}">
		<input type="hidden" name="csscore" value="${courseVO.csscore}">
		<input type="hidden" name="csscoretimes" value="${courseVO.csscoretimes}">
		
		<table>
			<jsp:useBean id="courseSvc" scope="page" class="com.course.model.CourseService"/>
			<tr>
				<td>課程名稱:</td>
				<td><input type="text" name="coursename" size="45"
					value="${courseVO.coursename }"/></td>
			</tr>
			<tr>
				<td>類別編號:<font color=red><b>*</b></font></td>
				<td><input type="text" name="cstypeno" size="45"
					value="${courseVO.cstypeno}" /></td>
			</tr>
			<tr>
				<td>課程單價:</td>
				<td><input type="number" name="courseprice" size="45"
					value="${courseVO.courseprice}" /></td>
			</tr>
			<tr>
				<td>課程資訊:</td>
<!-- 				<td><input type="text" name="courseinfo" size="45" -->
<%-- 					value="${courseVO.courseinfo}" /></td> --%>
				<td>
					<textarea name="courseinfo" rows="10" cols="50">${courseVO.courseinfo}</textarea>
				</td>
			</tr>
		</table>
		<br>
		<input type="hidden" name="action" value="update">
		<input type="submit" value="送出修改">
	</FORM>

</body>
</html>