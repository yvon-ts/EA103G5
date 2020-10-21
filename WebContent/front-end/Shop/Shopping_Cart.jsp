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
	<script>
		$("#deleteForm").on("click", function(e) {
			e.preventDefault();
			return false;
		});
	</script>

	<%
		Vector<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");

		session.setAttribute("memno", "MEM0003");
		String memno = (session.getAttribute("memno")).toString();

		pageContext.setAttribute("memno", "memno");
		memno = (session.getAttribute("memno")).toString();
	%>

	<font size="+3">目前您購物車的內容如下：</font>
	<p>
	<table border="1" width="740">
		<tr bgcolor="#999999">
			<th width="200">課程名稱</th>
		</tr>

		<%
			int orderamt = 0;
			for (int index = 0; index < buylist.size(); index++) {
				CourseVO order = buylist.get(index);
				orderamt += order.getCourseprice();
		%>
		<c:if test="${empty shoppingcart}">
			<h3>此購物車為空</h3>
		</c:if>
		<tr>
			<td width="200"><div align="center">
					<b><%=order.getCourseno()%></b>
				</div></td>
			<td width="200"><div align="center">
					<b><%=order.getCourseprice()%></b>

				</div></td>

			<td width="100"><div align="center">
					<form id="deleteForm"
						action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do"
						method="POST">
						<input type="hidden" name="action" value="DELETE"> <input
							type="hidden" name="del" value="<%=index%>"> <input
							type="submit" value="刪除">
					</form>
				</div></td>

		</tr>
		<%
			}
		%>
		<tr>
			<td width="200">總金額</td>
			<td width="200"><div align="center">
					<b><%=orderamt%></b>
				</div></td>
		</tr>
	</table>
	<p>
	<form name="checkoutForm"
		action="<%=request.getContextPath()%>/Order_Master/Order_Master.do"
		method="POST">
		<input type="hidden" name="action" value="insert"> <input
			type="hidden" name="memno" value="<%=memno%>"> <input
			type="hidden" name="orderamt" value="<%=orderamt%>">
			<input
			type="hidden" name="payby" value="信用卡">
			<input
			type="hidden" name="coupno" value="11"> <input
			type="submit" value="付款結帳">
	</form>
</body>
</html>