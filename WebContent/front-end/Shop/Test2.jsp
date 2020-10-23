<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>
<body>
	訂單成立
	<%
		Vector<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");

		session.setAttribute("memno", "MEM0003");
		String memno = (session.getAttribute("memno")).toString();

		pageContext.setAttribute("memno", "memno");
		memno = (session.getAttribute("memno")).toString();
	%>
	

</body>
</html>