<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%-- <jsp:include page="/back_index/back-endHomePage.jsp"></jsp:include> --%>
<%@ page import="com.report_detail.model.*"%>

<%
    ReportDetailService reportdetailSvc = new ReportDetailService();
    List<ReportDetailVO> list = reportdetailSvc.getPending();
    request.setAttribute("list",list);
%>



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

<table id="table-1">
   <tr><td><h3>IBM ReportDetail: Home</h3><h4>( MVC )</h4></td></tr>
</table>


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
      <th scope="col">First</th>
      <th scope="col">Last</th>
      <th scope="col">Handle</th>
    </tr>
  </thead>
  <tbody>
  <c:forEach var="reportdetailVO" items="${list}">
    <tr>
      <th scope="row">1</th>
      <td>Mark</td>
      <td>Otto</td>
      <td>@mdo</td>
    </tr>
    </c:forEach>
  </tbody>
</table>
<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/report_detail/listAllReport.jsp">List All Report</a>.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do">
        <b>輸入檢舉編號 (如REPO0001):</b>
        <input type="text" name="reportno">
        <input type="hidden" name="action" value="getOne_For_Display_Front">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="reportdetailSvc1" scope="page" class="com.report_detail.model.ReportDetailService" />
   
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do">
       <b>選擇欲查詢被檢舉編號:</b>
       <select size="1" name="reportno">
         <c:forEach var="reportdetailVO" items="${reportdetailSvc.all}" > 
          <option value="${reportdetailVO.reportno}">${reportdetailVO.reportno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="getOne_For_Display_Back">
       <input type="submit" value="送出">
    </FORM>
  </li>
  
<%--    <jsp:useBean id="reportdetailSvc" scope="page" class="com.report_detail.model.ReportDetailService" /> --%>
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do">
       <b>會員編號查詢檢舉:</b>
       <select size="1" name="memno">
         <c:forEach var="reportdetailVO" items="${reportdetailSvc.all}" > 
          <option value="${reportdetailVO.memno}">${reportdetailVO.memno}
         </c:forEach>   	
       </select>
       <input type="hidden" name="action" value="findByMemno">
       <input type="submit" value="送出">
     </FORM>
  </li>
<%--    <jsp:useBean id="reportdetailSvc" scope="page" class="com.report_detail.model.ReportDetailService" /> --%>
  <li>
     <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do">
       <b>員工編號查詢檢舉:</b>
       <select size="1" name="empno">
         <c:forEach var="reportdetailVO" items="${reportdetailSvc.all}" > 
          <option value="${reportdetailVO.empno}">${reportdetailVO.empno}
         </c:forEach>   
       </select>
       <input type="hidden" name="action" value="findByEmpno">
       <input type="submit" value="送出">
     </FORM>
  </li>
  
</ul>



<h3>前台-新增檢舉</h3>

<ul>
  <li><a href='<%= request.getContextPath()%>/front-end/report_detail/addReport.jsp'>Add</a> a new Reports.</li>
</ul>

<h3>前台-取消檢舉</h3>
<ul>
  <li><a href='<%= request.getContextPath()%>/front-end/report_detail/removeReport.jsp'>Remove</a> a new Reports.</li>
</ul>

<hr>
<div>
<div class="card" style="width: 18rem;display:inline-block;">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="card-link">Card link</a>
    <a href="#" class="card-link">Another link</a>
  </div>
</div>
<div class="card" style="width: 18rem;display:inline-block;marign-right:100px;">
  <div class="card-body">
    <h5 class="card-title">Card title</h5>
    <h6 class="card-subtitle mb-2 text-muted">Card subtitle</h6>
    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
    <a href="#" class="card-link">Card link</a>
    <a href="#" class="card-link">Another link</a>
  </div>
</div>
</div>


</div>
</div>
</div>

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