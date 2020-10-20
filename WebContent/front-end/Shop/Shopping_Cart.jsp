<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="test.Course"%>

<html>
<head>
<meta charset="UTF-8">
<title>結帳購物車</title>
</head>
<body>

	<%
		Vector<Course> buylist = (Vector<Course>) session.getAttribute("shoppingcart");
	%>

	<font size="+3">目前您購物車的內容如下：</font>
	<p>
	<table border="1" width="740">
		<tr bgcolor="#999999">
			<th width="200">課程名稱</th>
		</tr>

		<%
			for (int index = 0; index < buylist.size(); index++) {
				Course order = buylist.get(index);
		%>
		<c:if test="${empty shoppingcart}">
			<h3>此購物車為空</h3>
		</c:if>
		<tr>
			<td width="200"><div align="center">
					<b><%=order.getCourseno()%></b>
				</div></td>

			<td width="100"><div align="center">
					<form name="deleteForm"
						action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do"
						method="POST">
						<input type="hidden" name="action" value="DELETE"> <input
							type="hidden" name="del" value="<%=index%>"> <input
							type="submit" value="刪除">
				</div></td>
			</form>
		</tr>
		<%
			}
		%>
	</table>
	<p>
	<form name="checkoutForm"
		action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do"
		method="POST">
		<input type="hidden" name="action" value="CHECKOUT"> <input
			type="submit" value="付款結帳">
	</form>
	<%-- <%}%> --%>
</body>
</html>