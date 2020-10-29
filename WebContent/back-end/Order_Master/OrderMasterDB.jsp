<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>

<title>Order_Master: Home</title>

</head>
<body bgcolor='white'>
<%@ include file="/back-end/index/homepage.jsp"%>

<main class="app-content">

<table id="table-1">
   <tr><td><h3>Order_Master: Home</h3></td></tr>
</table>


<h3>資料查詢:</h3>
	
<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<ul>
  <li><a href='ListAllOrder.jsp'>List</a> all Orders.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Order_Master/Order_Master.do" >
        <b>輸入訂單編號 (如ORD0001):</b>
        <input type="text" name="orderno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Order_Master/Order_Master.do" >
        <b>輸入會員編號 (如MEM0001):</b>
        <input type="text" name="memno">
        <input type="hidden" name="action" value="getMemno_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>
  
  <li>訂單查詢
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Order_Detail/Order_Detail.do" >
        <b>輸入會員編號 (如MEM0001):</b>
        <input type="text" name="memno">
        <b>輸入課程編號 (如COUR0001):</b>
        <input type="text" name="courseno">
        <input type="hidden" name="action" value="bought_Not">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="orcSvc" scope="page" class="com.order_master.model.OrderMasterService" />
   
</ul>
</main>
</body>
</html>