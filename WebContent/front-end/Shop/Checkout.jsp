<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.course.model.*, com.coup_code.model.*, com.members.model.*"%>

<%
	List<CourseVO> buylist = (List<CourseVO>) session.getAttribute("shoppingList");

	MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
%>

<html>
<head>
<meta charset="UTF-8">
<title>Checkout.jsp</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/rateit.css" />
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<style>
	.title{
            height: 1px;
            margin: 0 auto 30px;
            position: relative;
            background-color: #0099CC;
	}
	.checkoutArea,{
		text-align : center;
	}
	.js-load-more{
		padding:0 15px;
		width:120px;
		height:30px;
		background-color:#D31733;
		color:#fff;
		line-height:30px;
		border-radius:5px;
		margin:20px auto;
		border:0 none;
		font-size:16px;
		display:none;/*預設不顯示，ajax呼叫成功後才決定顯示與否*/
	}
	.rateit .rateit-preset {
	color: #FFCC36;
	background:
		url(https://cdnjs.cloudflare.com/ajax/libs/jquery.rateit/1.1.3/star.gif)
		left -32px !important;
}
</style>
</head>
<body>


	<table border="1" width="740">
		<tr bgcolor="#999999">
			<th width="200">課程名稱</th>
			<th width="100">售價</th>
		</tr>


		<%
			int total = 0;
			for (int i = 0; i < buylist.size(); i++) {
				CourseVO order = buylist.get(i);
				String coursename = order.getCoursename();
				int sellprice = order.getCourseprice();
				total += sellprice;
		%>

		<tr>
			<td width="200"><div><%=coursename%></div></td>
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
		<input type="hidden" name="action" value="insert"><input
			type="hidden" name="memno" value="<%=membersVO.getMemno()%>">
		<input type="hidden" name="orderamt" value="<%=total%>">
		要使用折扣券嗎<select name="coupno">
			<option value="empty">不使用折扣券
				<c:forEach var="coupVO"
					items="${coupSvc.getMemberCoup(membersVO.memno)}">
					<option value="${coupVO.coupno}">${coupVO.coupcode}
				</c:forEach>
		</select> <input type="submit" value="送出">
	</form>
	<a href="<%=request.getContextPath()%>/front-end/Shop/EShop.jsp">返回EShop</a>
</body>
</html>