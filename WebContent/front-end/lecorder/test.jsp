<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String lodrno = request.getParameter("lodrno");
	String seatno = request.getParameter("seatno");
	String lodrseat = request.getParameter("currseat");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%=lodrseat%>
座位：<%=seatno %>
訂單：<%=lodrno %>
</body>
</html>