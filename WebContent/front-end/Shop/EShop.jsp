<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商店 - Eshop.jsp</title>
</head>
<body>
	<font size="+3">網路商店</font>
	<hr>
	<p>
	<table border="1" width="740">
		<tr bgcolor="#999999">
			<th width="200">課程名稱</th>
			<th width="100">售價</th>
			<th width="120"></th>
		</tr>
<tr>
		<form name="shoppingForm" action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do" method="POST">
			<tr>
				<td width="200"><div align="center">不一樣的養生法</div></td>
				<td width="100"><div align="center">600</div></td>
				<td width="120"><div align="center">
				<input type="submit" name="Submit" value="放入購物車">
					</div></td>
					<input type="hidden" name="courseno" value="COUR0001"> 
					<input type="hidden" name="courseprice" value="600"> 
					<input type="hidden" name="action" value="ADD">
			</tr>
		</form>
		</tr>
		<tr>
		<form name="shoppingForm" action="<%=request.getContextPath()%>/Shop/Shopping_Cart.do" method="POST">
			 <tr>	
				<td width="200"><div align="center">拉拉拉</div></td>
				<td width="100"><div align="center">500</div></td>
				<td width="120"><div align="center">
				<input type="submit" name="Submit" value="放入購物車">
					</div></td>
				<input type="hidden" name="courseno" value="COUR0002" /> 
				<input type="hidden" name="courseprice" value="500" /> 
				<input type="hidden" name="action" value="ADD" />
			</tr>
		</form>
</tr>
	</table>
	<p>
		<jsp:include page="Shopping_Cart.jsp"  flush="true"/>
</body>
</html>