<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>

<html>
<head>
<meta charset="UTF-8">
<title>結帳購物車</title>
</head>
<body>
	<%
		Vector<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");

		session.setAttribute("memno", "MEM0003");
		String memno = (session.getAttribute("memno")).toString();

		pageContext.setAttribute("memno", "memno");
		memno = (session.getAttribute("memno")).toString();
	%>
	<form name="checkoutForm"
		action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do"
		method="POST">
		<input type="hidden" name="action" value="ADD"> 
		<input type="hidden" name="memno" value="<%=memno%>"> 
		<input type="hidden" name="courseno" value="COUR0002">
		<input type="hidden" name="courseprice" value="600">
		<input type="hidden" name="promono" value="PRO0001">
		<input type="hidden" name="orderamt" value="600"> 
		<input type="hidden" name="payby" value="信用卡">
<!-- 		<input type="hidden" name="coupcode" value="XXXX-ZXCV"> -->
		<input type="submit" value="付款結帳">
		
	</form>

</body>
</html>