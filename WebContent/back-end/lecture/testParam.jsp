<%@ page language="java" contentType="text/html; charset=BIG5"
    pageEncoding="BIG5"%>
    <%@ page import="com.lecture.model.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="<%=request.getContextPath()%>/lecture/lecture.do">
	<input type="hidden" name="action" value="insert"><br>
	<input type="submit">
</form>
</body>
</html>