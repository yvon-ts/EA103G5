<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.promo_list.model.*"%>

<%
	PromoListVO promoVO = (PromoListVO) request.getAttribute("promoVO");
%>

<html>
<head>
<meta charset="UTF-8">
<title>addPromoList</title>
</head>
<body>

	<h3>addPromoList</h3>
	<br>
	<h4>
		<a
			href="<%=request.getContextPath()%>/back-end/Promo_List/select_page.jsp">回首頁</a>
	</h4>


	<h3>資料新增:</h3>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<FORM METHOD="post"
		ACTION="<%=request.getContextPath()%>/Promo_List/Promo_List.do"
		name="form1">
		<table>
			<tr>
				<td>優惠活動名稱:</td>
				<td><input type="TEXT" name="promoname" size="45"
					value="<%=(promoVO == null) ? "限時優惠" : promoVO.getPromoname()%>" /></td>
			</tr>
			<tr>
				<td>優惠開始日期:</td>
				<td><input name="startdate" id="f_date1" type="text"></td>
			</tr>
			<tr>
				<td>優惠結束日期:</td>
				<td><input name="enddate" id="f_date2" type="text"></td>
			</tr>
			<tr>
				<td>優惠簡介:</td>
				<td><input type="TEXT" name="promoinfo" size="45"
					value="<%=(promoVO == null) ? "八折優惠!" : promoVO.getPromoinfo()%>" /></td>
			</tr>


		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
</body>
</html>