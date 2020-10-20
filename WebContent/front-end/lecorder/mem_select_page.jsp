<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post"	action="<%=request.getContextPath()%>/front-end/lecorder/listByMemno.jsp">
		會員編號：<input type="text" name="memno">
		<input type="submit" value="查看已訂位講座">
	</form>
</body>
</html>