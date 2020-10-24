<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.coup_code.model.*, com.members.model.*"%>


<%
	MembersVO membersVO = (MembersVO) session.getAttribute("membersVO");
	String memno = membersVO.getMemno().toString();

	CoupCodeService coupSvc = new CoupCodeService();
	List<CoupCodeVO> list = coupSvc.getMemberCoup(memno);
	pageContext.setAttribute("list", list);
%>

<html>
<head>
<title>listAllByMemno.jsp</title>

</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>listAllByMemno.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp">回上頁</a>
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
			<th>折扣券號碼</th>
			<th>折扣券金額</th>
			<th>領取時間</th>
			<th>使用期限</th>
		</tr>
		<%@ include file="page1.file"%>

		<c:forEach var="coupVO" items="${list}" begin="<%=pageIndex%>"
			end="<%=pageIndex+rowsPerPage-1%>">

			<tr>
				<td>${coupVO.coupcode}</td>
				<td>${coupVO.discamt}</td>
				<td>${coupVO.couptime}</td>
				<td>${coupVO.coupexp}</td>
			</tr>
		</c:forEach>
	</table>
	<%@ include file="page2.file"%>

</body>
</html>