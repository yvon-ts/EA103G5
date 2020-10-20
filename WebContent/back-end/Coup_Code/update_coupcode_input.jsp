<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coup_code.model.*"%>

<%
	CoupCodeVO coupVO = (CoupCodeVO) request.getAttribute("coupVO");
%>
<html>
<head>
<meta charset="BIG5">
<title>update_coupcode_input.jsp</title>
</head>
<body>
	<table id="table-1">
		<tr>
			<td>
				<h3>update_coupcode_input.jsp</h3>
			</td>
			<td>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Coup_Code/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

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
		ACTION="<%=request.getContextPath()%>/Coup_Code/Coup_CodeServlet.do"
		name="form1">
		<table>
			<tr>
				<td>折價券編號編號:<font color=red><b>*</b></font></td>
				<td><%=coupVO.getCoupno()%></td>
		</table>
		<b>選擇折價券狀態:</b> <select size="1" name="discstatus">
			<option value="0" <c:if test="<%=coupVO.getDiscstatus().equals(0) %>">selected</c:if>>未使用</option>
			<option value="1" <c:if test="<%=coupVO.getDiscstatus().equals(1) %>">selected</c:if>>已使用</option>
		</select> <br> <input type="hidden" name="action" value="update">
		<input type="hidden" name="coupno" value="<%=coupVO.getCoupno()%>">
		<input type="submit" value="送出修改">
	</FORM>
</body>
</html>