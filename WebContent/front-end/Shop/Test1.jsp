<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<body>
	購物車頁面
	<%
		Vector<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");

		session.setAttribute("memno", "MEM0003");
		String memno = (session.getAttribute("memno")).toString();

		pageContext.setAttribute("memno", "memno");
		memno = (session.getAttribute("memno")).toString();
	%>
	
	<%=buylist %>
	<form name="checkoutForm" action="<%=request.getContextPath()%>/Order_Master/Order_Master.do" method="POST"> 
		<input type="hidden" name="action" value="insert"> 
		<input type="hidden" name="memno" value="<%=memno%>"> 
		<input type="hidden" name="courseno" value="COUR0002">
		<input type="hidden" name="courseprice" value="600">
		<input type="hidden" name="promono" value="PROM0001">
		<input type="hidden" name="orderamt" value="600"> 
		<input type="hidden" name="payby" value="信用卡">
		<input type="hidden" name="coupcode" value="AXXX-ZXCV">
		<input type="submit" value="付款結帳">
	</form>

</body>
</html>