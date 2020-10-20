<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.tracking_list.model.*"%>

<%

		  TrackingListVO trackinglistVO2 = new TrackingListVO();//假資料
		  trackinglistVO2.setMemno("MEM0005");//假資料
		  trackinglistVO2.setCourseno("COUR0005");//假資料

		
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>新增追蹤 - addTracking.jsp</title>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 450px;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
  textarea{
  resize:none;
  }
</style>

</head>
<body bgcolor='white'>


<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/tracking_list/tracking_list.do" name="form1">
<table>


	
	<tr>
		<td>會員編號:</td>
		<td><%=trackinglistVO2.getMemno()%></td>
	</tr>
	<tr>
		<td>課程編號:</td>
		<td><%=trackinglistVO2.getCourseno()%></td>
	</tr>


</table>
<br>
<input type="hidden" name="memno" value="<%=trackinglistVO2.getMemno()%>"/>
<input type="hidden" name="courseno" value="<%=trackinglistVO2.getCourseno()%>"/>

<input type="hidden" name="action"	value="insert">
<input type="submit" value="追蹤課程"></FORM>


</body>




</html>