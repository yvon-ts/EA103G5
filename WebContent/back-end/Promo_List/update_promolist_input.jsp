<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.promo_list.model.*"%>

<%
	PromoListVO promoVO = (PromoListVO) request.getAttribute("promoVO");
	
%>

<html>
<head>
<meta charset="UTF-8">
<title>update_promolist_input.jsp</title>
</head>
<body>
	<table id="table-1">
		<tr>
			<td>
				<h3>update_promolist_input.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Promo_List/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<h3>資料修改:</h3>

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
				<td>優惠活動編號:<font color=red><b>*</b></font></td>
				<td><%=promoVO.getPromono()%></td>
			</tr>
			<tr>
				<td>優惠活動名稱:</td>
				<td><input type="TEXT" name="promoname" size="45"
					value="<%=promoVO.getPromoname()%>" /></td>
			</tr>
			<tr>
				<td>優惠開始日期:</td>
				<td><input name="startdate" id="f_date1" type="text"
					value="<%=promoVO.getStartdate()%>"></td>
			</tr>
			<tr>
				<td>優惠結束日期:</td>
				<td><input name="enddate" id="f_date2" type="text"
					value="<%=promoVO.getEnddate()%>"></td>
			</tr>
			<tr>
				<td>優惠資訊:</td>
				<td><input type="TEXT" name="promoinfo" size="45"
					value="<%=promoVO.getPromoinfo()%>" /></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="update"> <input
			type="hidden" name="promono" value="<%=promoVO.getPromono()%>">
		<input type="submit" value="送出修改">
	</FORM>
</body>
</html>