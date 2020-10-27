<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<jsp:include page="/back-end/index/homepage.jsp"/>
<%@ page import="com.report_detail.model.*"%>
<%@ page import="com.employee.model.*"%>

<%
    ReportDetailService reportdetailSvc = new ReportDetailService();
    List<ReportDetailVO> list = reportdetailSvc.getAll();
    request.setAttribute("list",list);
%>

<%-- <%  --%>
<!-- // 	EmployeeVO EmployeeVO = (EmployeeVO) session.getAttribute("employeeVO"); -->
<!-- // 	System.out.println("目前登入的是:" + employeeVO.getempno()); -->
<%-- %> --%>

<html>
<head>
<title>ReportDetail: Home</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css">
	
<style>
  table#table-1 {
	width: 450px;
	background-color: #CCCCFF;
	margin-top: 5px;
	margin-bottom: 10px;
    border: 3px ridge Gray;
    height: 80px;
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
   .card {
    display:inline-block;
  }
</style>

</head>
<body bgcolor='white'>
<main class="app-content">




<div>
<div>
<div>
<h3>檢舉查詢:</h3>
	
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
<td>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do" name="form1">
<input type="hidden" name="action" value="getPending">
<input type="submit" value="未處理"></FORM>
</td>
<td>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do" name="form1">
<input type="hidden" name="action" value="getSettled">
<input id="test" type="submit" value="已處理"></FORM>
</td>
</tr>
</table>
 

<hr>
<table class="table table-striped">
  <thead>
    <tr>
      <th scope="col">#</th>
      <th scope="col">文章檢舉編號</th>
      <th scope="col">檢舉者會員編號</th>
      <th scope="col">文章編號</th>
      <th scope="col">處理狀態編號</th>
      <th scope="col">處理者員工編號</th>
      <th scope="col">處理時間</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="reportdetailVO" items="${list}">
    <th scope="row"></th>
      <td>${reportdetailVO.reportno}</td>
			<td>${reportdetailVO.memno}</td>
			<td>${reportdetailVO.postno}</td>
			<td>${reportdetailVO.poststatus}</td>
			<td>${reportdetailVO.empno}</td>
			<td><fmt:formatDate value="${reportdetailVO.reportlmod}" pattern="yyyy-MM-dd HH:mm"/></td>
			
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
  </tbody>
</table>







<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.bundle.min.js"></script>
		<script src="https://code.jquery.com/jquery-1.12.4.js" integrity="sha256-Qw82+bXyGq6MydymqBxNPYTaUXXq7c8v3CwiYwLLNXU=" crossorigin="anonymous"></script>
		
		<script type="text/javascript">
		$("#test").click(function({
			alert("OK")
		})
		</script>
	
</body>
</html>