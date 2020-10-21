<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*"%>

<html>
<head>
<meta charset="UTF-8">
<title>Checkout.jsp</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css"
	integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh"
	crossorigin="anonymous">
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
		integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
		integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
		integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
		crossorigin="anonymous"></script>

	<%
		Vector<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");
		String amount = (String) request.getAttribute("amount");
		
// 		session.setAttribute("memNo", "MEM0003");
// 		String memNo = (session.getAttribute("memNo")).toString();
	%>

	<table border="1" width="740">
		<tr bgcolor="#999999">
			<th width="200">課程名稱</th>
			<th width="100">售價</th>
		</tr>


		<%
			for (int i = 0; i < buylist.size(); i++) {
				CourseVO order = buylist.get(i);
				String courseno = order.getCourseno();
				int sellprice = order.getCourseprice();
		%>

		<tr>
			<td width="200"><div><%=courseno%></div></td>
			<td width="100"><div><%=sellprice%></div></td>
		</tr>
		<%
			}
		%>

		<tr>
			<td></td>
			<td></td>
			<td width="120"><div align="center">
					<font>總金額：</font>
				</div></td>
			<td width="100"><font><%=amount%></font></td>
		</tr>
	</table>

	<a href="<%=request.getContextPath()%>/front-end/Shop/EShop.jsp">返回EShop</a>
</body>
</html>