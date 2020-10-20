<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.coup_code.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
	CoupCodeService coupSvc = new CoupCodeService();
	List<CoupCodeVO> list = coupSvc.getAll();
	pageContext.setAttribute("list", list);
%>


<html>
<head>
<title>所有折價券資料 - listAllCoupCode.jsp</title>
</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>所有折價券資料 - listAllCoupCode.jsp</h3>
				<h4>
					<a href="select_page.jsp">回首頁</a>
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
			<th>折扣碼編號</th>
			<th>會員編號</th>
			<th>折扣代碼</th>
			<th>折扣金額</th>
			<th>使用狀態</th>
			<th>發送時間</th>
			<th>使用期限</th>
			<th>修改</th>
		</tr>
		<%@ include file="page1.file"%>
		<c:forEach var="coupVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${coupVO.coupno}</td>
				<td>${coupVO.memno}</td>
				<td>${coupVO.coupcode}</td>
				<td>${coupVO.discamt}</td>
				<td>${coupVO.discstatus}</td>
				<td>${coupVO.couptime}</td>
				<td>${coupVO.coupexp}</td>
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