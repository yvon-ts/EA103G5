<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.promo_list.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	PromoListService promoSvc = new PromoListService();
	List<PromoListVO> list = promoSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>listAllPromoList.jsp</title>
</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>listAllPromoList.jsp</h3>
				<h4>
					<a href="<%=request.getContextPath()%>/back-end/Promo_List/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<%-- 錯誤表列 --%>
	<c:if test="${not empty errorMsgs}">
		<font style="color: red">請修正以下錯誤:</font>
		<ul>
			<c:forEach var="message" items="${errorMsgs}">
				<li style="color: red">${message}</li>
			</c:forEach>
		</ul>
	</c:if>

	<table>
		<tr>
			<th>優惠活動編號</th>
			<th>優惠活動名稱</th>
			<th>優惠開始日期</th>
			<th>優惠結束日期</th>
			<th>優惠簡介</th>
			<th>修改</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="promoVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">
			<tr>
				<td>${promoVO.promono}</td>
				<td>${promoVO.promoname}</td>
				<td>${promoVO.startdate}</td>
				<td>${promoVO.enddate}</td>
				<td>${promoVO.promoinfo}</td>
				<td>
					<FORM METHOD="post"
						ACTION="<%=request.getContextPath()%>/Coup_Code/Coup_CodeServlet.do"
						style="margin-bottom: 0px;">
						<input type="submit" value="修改"> <input type="hidden"
							name="coupno" value="${coupVO.coupno}"> <input
							type="hidden" name="action" value="getOne_For_Update">
					</FORM>
				</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>