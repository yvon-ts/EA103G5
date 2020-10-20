<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.promo_list.model.*"%>
<%
  PromoListVO promoVO = (PromoListVO) request.getAttribute("promoVO");
%>


<html>
<head>
<meta charset="UTF-8">
<title>listOnePromoList.jsp</title>

</head>
<body>
<table id="table-1">
	<tr><td>
		 <h3>listOnePromoList.jsp</h3>
		 <h4><a href="<%=request.getContextPath()%>/back-end/Promo_List/select_page.jsp">回首頁</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>優惠活動編號</th>
		<th>優惠活動名稱</th>
		<th>優惠開始日期</th>
		<th>優惠結束日期</th>
		<th>優惠簡介</th>
	</tr>
	<tr>
		<td><%=promoVO.getPromono()%></td>
		<td><%=promoVO.getPromoname()%></td>
		<td><%=promoVO.getStartdate()%></td>
		<td><%=promoVO.getEnddate()%></td>
		<td><%=promoVO.getPromoinfo()%></td>
	</tr>
</table>
</body>
</html>