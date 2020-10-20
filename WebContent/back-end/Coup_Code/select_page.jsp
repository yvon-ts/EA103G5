<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>Coup_Code: Home</title>

</head>
<body bgcolor='white'>

<table id="table-1">
   <tr><td><h3>Coup_Code: Home</h3></td></tr>
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
  <li><a href='listAllCoupCode.jsp'>List</a> all Coups.  <br><br></li>
  
  
  <li>
    <FORM METHOD="post" ACTION="<%=request.getContextPath()%>/Coup_Code/Coup_CodeServlet.do" >
        <b>輸入折扣碼編號 (如COUP0001):</b>
        <input type="text" name="coupno">
        <input type="hidden" name="action" value="getOne_For_Display">
        <input type="submit" value="送出">
    </FORM>
  </li>

  <jsp:useBean id="coupSvc" scope="page" class="com.coup_code.model.CoupCodeService" />
   

<h3>折價券管理</h3>

<ul>
  <li><a href='addCoupCode.jsp'>Add</a> a new Coup code.</li>
</ul>

</body>
</html>