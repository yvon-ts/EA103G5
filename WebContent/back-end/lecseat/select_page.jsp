<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>select_page.jsp</title>
</head>
<body>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

	<form method="post" action="<%=request.getContextPath()%>/lecseat/lecseat.do">
		<input type="text" name="querySeat">
		<input type="submit" value="查詢全部">
		<input type="hidden" name="action" value="getOne">
	</form>
	<form method="post" action="<%=request.getContextPath()%>/back-end/lecseat/listAllLecseat.jsp">
		<input type="submit" value="查詢全部">
	</form>
</body>
</html>