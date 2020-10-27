<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.report_detail.model.*"%>
<%@ page import="com.employee.model.*"%>
<%@ page import="com.members.model.*"%>
<%-- 此頁練習採用 EL 的寫法取值 --%>

<%
    ReportDetailService reportdetailSvc = new ReportDetailService();
    List<ReportDetailVO> list = reportdetailSvc.getAll();
    request.setAttribute("list",list);
%>

<%-- <jsp:useBean id="empSvc" scope="page" class="com.employee.model.*" /> --%>
<%-- <jsp:useBean id="memSvc" scope="page" class="com.members.model.*" /> --%>

<html>
<head>
<title>所有員工資料 - listAllReport.jsp</title>

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
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
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

<table>
	<tr>
		<th>文章檢舉編號</th>
		<th>檢舉者會員編號</th>
		<th>文章編號</th>
		<th>處理狀態</th>
		<th>處理者員工編號</th>
		<th>處理時間</th>
		
		
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="reportdetailVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr>
			<td>${reportdetailVO.reportno}</td>
			<td>${reportdetailVO.memno}</td>
			<td>${reportdetailVO.postno}</td>
			<td>${reportdetailVO.poststatus}</td>
			<td>${reportdetailVO.empno}</td>
<%-- 			<td><c:forEach var="empVO" items="${empSvc.all}"> --%>
<%--                     <c:if test="${empVO.empno==empVO.empno}"> --%>
<%-- 	                    ${empVO.empno}【${empVO.empname} - ${emptVO.empemail}】 --%>
<%--                     </c:if> --%>
<%--                 </c:forEach> --%>
<!-- 			</td> -->
			<td><fmt:formatDate value="${reportdetailVO.reportlmod}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
			
			
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="下架">
			     <input type="hidden" name="reportno" value="${reportdetailVO.reportno}">
			     <input type="hidden" name="action"	value="update"></FORM>
			</td>
			<td>
			  <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do" style="margin-bottom: 0px;">
			     <input type="submit" value="上架">
			     <input type="hidden" name="reportno" value="${reportdetailVO.reportno}">
			     <input type="hidden" name="action"	value="getOne_For_Update_removeReportBack"></FORM>
			</td>

			
		</tr>
	</c:forEach>
</table>
<%@ include file="page2.file" %>

</body>
</html>