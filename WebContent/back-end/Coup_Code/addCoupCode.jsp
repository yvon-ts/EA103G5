<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.coup_code.model.*"%>

<%
	CoupCodeVO coupVO = (CoupCodeVO) request.getAttribute("coupVO");
%>
<html>
<head>
<meta charset="UTF-8">
<title>addCoupCode</title>
</head>
<body>

	<h3>addCoupCode</h3>
	<br>
	<h4>
		<a
			href="<%=request.getContextPath()%>/back-end/Coup_Code/select_page.jsp">回首頁</a>
	</h4>


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
				<td>給予會員編號:</td>
				<td><input type="TEXT" name="memno" size="45"></td>
			</tr>
			<tr>
				<td>折扣代碼:</td>
				<td><input type="TEXT" name="coupcode" size="45"></td>
			</tr>
			<tr>
				<td>折扣金額:</td>
				<td><input type="TEXT" name="discamt" size="45"></td>
			</tr>
			<tr>
				<td>使用期限:</td>
				<td><input name="coupexp" id="f_date1" type="text"></td>
			</tr>

		</table>
		<br> <input type="hidden" name="action" value="insert"> <input
			type="submit" value="送出新增">
	</FORM>
<!-- 	<script type="text/javascript"> -->

<!-- </script> -->
</body>

<!-- <link rel="stylesheet" type="text/css" -->
<%-- 	href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" /> --%>
<%-- <script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script> --%>
<%-- <script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script> --%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.css" />
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.js"></script>
<script src="<%=request.getContextPath()%>/datetimepicker/jquery.datetimepicker.full.js"></script>

<style>
  .xdsoft_datetimepicker .xdsoft_datepicker {
           width:  300px;   /* width:  300px; */
  }
  .xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
           height: 151px;   /* height:  151px; */
  }
</style>

<script>
		//----------------------------------------------------------格式化日期-----------------------------------------------------------

        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker: false,       //timepicker:true,
	       format:'Y-m-d ',         //format:'Y-m-d H:i:s',
		   value: new Date() // value:   new Timestamp(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
</script>
</html>