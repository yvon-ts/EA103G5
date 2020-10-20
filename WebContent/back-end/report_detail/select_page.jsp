<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>ReportDetail: Home</title>

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
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>IBM ReportDetail: Home</h3><h4>( MVC )</h4></td></tr>
</table>



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

<ul>
  <li><a href="<%=request.getContextPath()%>/back-end/report_detail/listAllReport.jsp">List All Report</a>.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do">
        <b>輸入檢舉編號 (如REPO0001):</b>
        <input type="text" name="reportno">
        <input type="hidden" name="action" value="getOne_For_Display_Back">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="reportdetailSvc" scope="page" class="com.report_detail.model.ReportDetailService"/>
   
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
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do" name="form1">
<input type="hidden" name="action" value="getPending">
<input type="submit" value="未處理"></FORM>
<br>
<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/report_detail/report_detail.do" name="form1">
<input type="hidden" name="action" value="getSettled">
<input type="submit" value="已處理"></FORM>


<h3>前台-新增檢舉</h3>

<ul>
  <li><a href='<%= request.getContextPath()%>/front-end/report_detail/addReport.jsp'>Add</a> a new Reports.</li>
</ul>

<h3>前台-取消檢舉</h3>
<ul>
  <li><a href='<%= request.getContextPath()%>/front-end/report_detail/removeReport.jsp'>Remove</a> a new Reports.</li>
</ul>

</body>
</html>