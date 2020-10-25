<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*, com.coup_code.model.*, com.members.model.*"%>

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
		List<CourseVO> buylist = (List<CourseVO>) session.getAttribute("shoppingList");

		MembersVO Membersvo = (MembersVO) session.getAttribute("Membersvo");
		Membersvo = new MembersVO();
		Membersvo.setMemno("MEM0002");

		session.setAttribute("Membersvo", Membersvo);//此處須修改
		String memno = "MEM0002";

		// 		session.setAttribute("memNo", "MEM0003");
		// 		String memNo = (session.getAttribute("memNo")).toString();
	%>

	<table border="1" width="740">
		<tr bgcolor="#999999">
			<th width="200">課程名稱</th>
			<th width="100">售價</th>
		</tr>


		<%
			int total = 0;
			for (int i = 0; i < buylist.size(); i++) {
				CourseVO order = buylist.get(i);
				String courseno = order.getCourseno();
				int sellprice = order.getCourseprice();
				total += sellprice;
		%>

		<tr>
			<td width="200"><div><%=courseno%></div></td>
			<td width="100"><div><%=sellprice%></div></td>
		</tr>
		<%
			}
		%>
		<tr>

			<td width="120"><div align="center">
					<font>總金額：</font>
				</div></td>
			<td width="100"><font><%=total%></font></td>
		</tr>
	</table>
	<jsp:useBean id="coupSvc" scope="page"
		class="com.coup_code.model.CoupCodeService" />
	<form method="post"
		action="<%=request.getContextPath()%>/Order_Master/Order_Master.do"
		id="myForm">
		<input type="hidden" name="action" value="insert"> <input
			type="hidden" name="coupcode" value="XXXX-ZXCV"> <input
			type="hidden" name="memno" value="MEM0002"> <input
			type="hidden" name="orderamt" value="${totalPrice}"> <select>
			<c:forEach var="coupVO" items="${coupSvc.getMemberCoup(Membersvo.memno)}">
				<option value="empty">不使用折扣券
				<option value="${coupVO.coupcode}">${coupVO.coupcode}
			</c:forEach>
		</select>
	</form>
	<a href="<%=request.getContextPath()%>/front-end/Shop/EShop.jsp">返回EShop</a>
</body>
</html>