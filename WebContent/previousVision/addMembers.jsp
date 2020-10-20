<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>

<%
  MembersVO membersVO = (MembersVO) request.getAttribute("membersVO");
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>會員註冊</title>

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
	background-color: white;
	margin-top: 1px;
	margin-bottom: 1px;
  }
  table, th, td {
    border: 0px solid #CCCCFF;
  }
  th, td {
    padding: 1px;
  }
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>註冊成為會員</h3></td><td>
		 <h4><a href="select_page.jsp"><img src="images/tomcat.png" width="100" height="100" border="0">回首頁</a></h4>
	</td></tr>
</table>

<h3>新增會員資料:</h3>

<%-- 錯誤表列 --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">請修正以下錯誤:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="MembersServlet" name="form1" enctype="multipart/form-data">
<input type="text" id="memacc" name="memacc" onblur="sendRequest()">
<label for="memacc">請輸入帳號</label>
<br>
<input type="password" id="mempwd" name="mempwd">
<label for="mempwd">請輸入密碼</label>
<br>
<input type="password" id="Rmempwd" name="Rmempwd">
<label for="Rmempwd">請再次輸入密碼</label>
<br>
<input type="text" id="memname" name="memname">
<label for="memname">請輸入全名</label>
<br>
<input type="text" id="nkname" name="nkname">
<label for="nkname">請輸入暱稱</label>
<br>
<input type="text" id="memail" name="memail">
<label for="memail">請輸入電子信箱</label>
<br>
<input type="text" id="mphone" name="mphone">
<label for="mphone">請輸入電話</label>
<br>
<input name="membday" id="f_date1" type="text">
<label for="membday">請選擇生日</label>
<br>
<input type="file" id="picture" name="picture">
<br>
<label for="picture">點選此處上傳頭像</label>
<br>
<input type="hidden" name="action" value="insert">
<input type="submit" value="送出新增">
<div id="msg"></div>
</form>
</body>



<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->

<% 
  java.sql.Date membday = null;
  try {
	  membday = membersVO.getMembday();
   } catch (Exception e) {
	    membday = new java.sql.Date(System.currentTimeMillis());
   }
%>
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

<script type="text/javascript">
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:false,       //timepicker:true,
	       step: 1,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d',         //format:'Y-m-d H:i:s',
		   value: '<%=membday%>', // value:   new Date(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        
   
        // ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

        //      1.以下為某一天之前的日期無法選擇
             var somedate1 = new Date('1920-01-01');
             $('#f_date1').datetimepicker({
                 beforeShowDay: function(date) {
               	  if (  date.getYear() <  somedate1.getYear() || 
        		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
                     ) {
                          return [false, ""]
                     }
                     return [true, ""];
             }});

        
             //2.以下為某一天之後的日期無法選擇
             var somedate2 = new Date(new Date());
             $('#f_date1').datetimepicker({
                 beforeShowDay: function(date) {
               	  if (  date.getYear() >  somedate2.getYear() || 
        		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
                     ) {
                          return [false, ""]
                     }
                     return [true, ""];
             }});


        //      3.以下為兩個日期之外的日期無法選擇 (也可按需要換成其他日期)
        //      var somedate1 = new Date('2017-06-15');
        //      var somedate2 = new Date('2017-06-25');
        //      $('#f_date1').datetimepicker({
        //          beforeShowDay: function(date) {
        //        	  if (  date.getYear() <  somedate1.getYear() || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() <  somedate1.getMonth()) || 
        //		           (date.getYear() == somedate1.getYear() && date.getMonth() == somedate1.getMonth() && date.getDate() < somedate1.getDate())
        //		             ||
        //		            date.getYear() >  somedate2.getYear() || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() >  somedate2.getMonth()) || 
        //		           (date.getYear() == somedate2.getYear() && date.getMonth() == somedate2.getMonth() && date.getDate() > somedate2.getDate())
        //              ) {
        //                   return [false, ""]
        //              }
        //              return [true, ""];
        //      }});


var request;
  function createXMLHttpRequest() {
    if (window.ActiveXObject) {
      request = new ActiveXObject("Microsoft.XMLHTTP");
    } else if (window.XMLHttpRequest) {
      request = new XMLHttpRequest();
    } else {
      window.alert("建議使用GOOGLE CHROME瀏覽器");
    }
  }

function processResult() {
    if ((request.readyState == 4) && (request.status == 200)) {
      var str = request.responseText;
      if(str=="true"){
        var msg = document.getElementById("msg").innerHTML ="<span style='color:#00cc00'>此帳號可以使用</span>" ;
      }else{
        var msg = document.getElementById("msg").innerHTML ="<span style='color:#cc0000'>此帳號已被註冊</span>" ;
      }
      
    }
  }
function sendRequest() {
    createXMLHttpRequest();
    request.onreadystatechange = processResult;
    var memacc = document.getElementById("memacc").value;
    
    // request.open("GET", "AccountCheckServlet?username="+username, true); 
    request.open("POST", "MemaccCheckServlet", true);
    request.setRequestHeader("Content-Type",
        "application/x-www-form-urlencoded");
    request.send("memacc=" + memacc);
  }






















        
</script>
</html>