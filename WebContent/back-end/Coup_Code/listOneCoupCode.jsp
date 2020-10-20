<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.coup_code.model.*"%>
<%-- 此頁暫練習採用 Script 的寫法取值 --%>

<%
	CoupCodeVO coupVO = (CoupCodeVO) request.getAttribute("coupVO");
%>
<html>
<head>
<title>折價券資料 - listOneCoupCode.jsp</title>
</head>
<body bgcolor='white'>

	<table id="table-1">
		<tr>
			<td>
				<h3>折價券資料 - listOneCoupCode.jsp</h3>
				<h4>
					<a
						href="<%=request.getContextPath()%>/back-end/Coup_Code/select_page.jsp">回首頁</a>
				</h4>
			</td>
		</tr>
	</table>

	<table>
		<tr>
			<th>折扣碼編號</th>
			<th>會員編號</th>
			<th>折扣代碼</th>
			<th>折扣金額</th>
			<th>使用狀態</th>
			<th>發送時間</th>
			<th>使用期限</th>
		</tr>
		<tr>
			<td><%=coupVO.getCoupno()%></td>
			<td><%=coupVO.getMemno()%></td>
			<td><%=coupVO.getCoupcode()%></td>
			<td><%=coupVO.getDiscamt()%></td>
			<td><%=coupVO.getDiscstatus()%></td>
			<td><%=coupVO.getCouptime()%></td>
			<td><%=coupVO.getCoupexp()%></td>
		</tr>
	</table>

</body>
</html>