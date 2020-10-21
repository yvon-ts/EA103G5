<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.* , com.course.model.*" %>
<html>
<head>
<meta charset="UTF-8" content="text/html; charset=UTF-8">
<title>購物車</title>
</head>
<body>

<%Vector<CourseVO> buylist = (Vector<CourseVO>) session.getAttribute("shoppingcart");%>
<%if (buylist != null && (buylist.size() > 0)) {%>

<font size="+3">目前您購物車的內容如下：</font>

<table border="1" width="740">
	<tr bgcolor="#999999">
		<th width="200">課程名稱</th><th width="100">售價</th>
	</tr>
	
	<%
	 for (int index = 0; index < buylist.size(); index++) {
		 CourseVO order = buylist.get(index);
	%>
	<tr>
		<td width="200"><div align="center"><b><%=order.getCourseno()%></b></div></td>
		<td width="100"><div align="center"><b><%=order.getCourseprice()%></b></div></td>
		<td width="100"><div align="center">
          <form name="deleteForm" action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do" method="POST">
              <input type="hidden" name="action" value="DELETE">
              <input type="hidden" name="del" value="<%= index %>">
              <input type="submit" value="刪除">
           </form>
           </div>
        </td>
	</tr>
	<%}%>
</table>
<p>
          <form name="checkoutForm" action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do" method="POST">
              <input type="hidden" name="action" value="CHECKOUT"> 
              <input type="submit" value="付款結帳">
          </form>

<%}%>
</body>
</html>