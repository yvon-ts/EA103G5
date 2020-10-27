<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.sql.*"%> 
<%@ page import="java.util.*"%> 
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.lecture.model.*"%>
<%@ include file="/back-end/index/homepage.jsp" %>

<!DOCTYPE html>

<%
	LecVO lecVO = (LecVO) request.getAttribute("lecVO");
	String info = "請輸入講座資訊";
//========================Init lecstart========================//
	String param = request.getParameter("lecinit");
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
	SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss");
	java.util.Date paramDate = format.parse(param);
	java.util.Date paramDate2 = format2.parse(param);
	Timestamp lecinit = new java.sql.Timestamp(paramDate.getTime());
	
%>

<html>
<head>
<meta charset="UTF-8">
<title>Xducation - 陪你成長的學習好夥伴</title>
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/back-end/css/bootTable.css">
<style>
	#newimg{
		max-height: 200px;
		width: auto;
		position: absolute;
		margin-top: -250px;
		margin-left: 500px;
	}
	#form-area input{
		outline: none;
		border: 0;
		border-bottom: 1px solid #999;
		width: 200px;
	}
		#form-area select{
		outline: none;
		border-bottom: 1px solid #999;
	}
	.btm-line{
		margin-left: 4%;
		font-size: 1.1em;
		border-bottom:2px dashed #999;
		padding-bottom: 20px;
	}
	.blank{
		color:#ff6680;
		font-weight: 600;
	}
</style>
</head>
<body>
<main class="app-content" style="background-color: #f3f3f3">
	<div id="table-area" class="container-xl">
		<div class="table-responsive">
			<form method="post"	action="<%=request.getContextPath()%>/back-end/lecture/listAllLec.jsp">
				<button class="bttn" type="submit">放棄新增</button>
			</form><p>
			<div class="table-wrapper">
               		<div class="row">
						<c:if test="${not empty errorMsgs}">
							<ul>
								<c:forEach var="err" items="${errorMsgs}">
									<li style="color: red">${err}</li>
								</c:forEach>
							</ul>
						</c:if>
		
					<form method="post"	action="<%=request.getContextPath()%>/lecture/lecture.do" enctype="multipart/form-data">
				<div class="table-title">
					<div class="row">
						<div id="form-area" class="col-sm-7 btm-line">
				
							<h2 style="font-weight: 700;">&nbsp;【新增講座資料】</h2>
							
							<input type="hidden" name="signstart" id="f_date3">
							<input type="hidden" name="signend" id="f_date4">
							<input id="roomnoForm" type="hidden" name="roomno" value="${lecVO.roomno}"><br>
							<span id="theme">&emsp;講座名稱</span>&emsp;<input id="lecname" type="text" name="lecname" value="${lecVO.lecname}"><br>
							<span id="name">&emsp;講師姓名</span>
							<jsp:useBean id="spkrSvc" scope="page" class="com.speaker.model.SpkrService" />
							<select id="spkrno" name="spkrno">
								<option>------請選擇講師------</option>
								<c:forEach var="spkrVO" items="${spkrSvc.list}">
									<option value="${spkrVO.spkrno}" ${(lecVO.spkrno==spkrVO.spkrno)? 'selected':'' } >${spkrVO.spkrno}${spkrVO.spkrname}</option>
								</c:forEach>
							</select><br>
							<%-- 要擋註銷的教室 --%>
							<span id="price">&emsp;講座票價</span>&emsp;<input id="lecprice" name="lecprice" type="text" value="${lecVO.lecprice}"><br>
							<span id="start">&emsp;開始時間</span>&emsp;<input name="lecstart" id="f_date1" type="text"><br>
							<span id="end">&emsp;結束時間</span>&emsp;<input name="lecend" id="f_date2" type="text"><br>
							<span id="pic">&emsp;講座圖片</span>&emsp;<input name="lecpic" id="upimg" type="file" style="border: 0;"><br>
						</div>
					</div>
				<div id="preivew" >
					<img id="newimg" src="">
				</div>
			</div>
			<div class="col-sm-6">
				<%@ include file="/back-end/lecture/roomsetting/layout.jsp"%>
			</div>
			<div class="col-sm-7 btm-line">
			</div>
			<div class="col-sm-8" style="margin-left: 4%; margin-top: 20px">
				講座資訊
				<input id="action" type="hidden" name="action" value="insertText"><br>
				<%@ include file="/back-end/lecture/ckLec.file"%>
			</div>
			</form>
          </div>
		</div>
	</div>
</div>
</main>
	<script type="text/javascript">
		//圖片預覽
		var upimg = document.getElementById("upimg");
		upimg.addEventListener("change", function(){
			readURL(this);
		});
		
		function readURL(input){
			if (input.files && input.files[0]){
				var reader = new FileReader();
				reader.onload = function(e){
					var newimg = document.getElementById("newimg");
					newimg.setAttribute("src", e.target.result);
				}
				reader.readAsDataURL(input.files[0]);
			}
		}
	</script>
</body>
<!-- =========================================以下為 datetimepicker 之相關設定========================================== -->
<% 
	java.sql.Timestamp lecstart = null;
	java.sql.Timestamp lecend = null;
	java.sql.Timestamp signstart = null;
	java.sql.Timestamp signend = null;
	try {
	    lecstart = lecVO.getLecstart();
	    lecend = lecVO.getLecend();
	    signstart = lecVO.getSignstart();
	    signend = lecVO.getSignend();
	} catch (Exception e) {
	    lecstart = lecinit;
	    lecend = lecinit;
	    signstart = new java.sql.Timestamp(System.currentTimeMillis());
	    signend = new java.sql.Timestamp(System.currentTimeMillis());
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

<script>
//----------------------------------------------------------格式化日期-----------------------------------------------------------
        $.datetimepicker.setLocale('zh');
        $('#f_date1').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:00:00',         //format:'Y-m-d H:i:s',
		   value: '<%=lecstart%>', // value:   new Timestamp(),
           //disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
           //startDate:	            '2017/07/10',  // 起始日
           //minDate:               '-1970-01-01', // 去除今日(不含)之前
           //maxDate:               '+1970-01-01'  // 去除今日(不含)之後
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date2').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:00:00',         //format:'Y-m-d H:i:s',
		   value: '<%=lecend%>', // value:   new Timestamp(),
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date3').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:00:00',         //format:'Y-m-d H:i:s',
		   value: '<%=lecend%>', // value:   new Timestamp(),
        });
        
        $.datetimepicker.setLocale('zh');
        $('#f_date4').datetimepicker({
	       theme: '',              //theme: 'dark',
	       timepicker:true,       //timepicker:true,
	       step: 60,                //step: 60 (這是timepicker的預設間隔60分鐘)
	       format:'Y-m-d H:00:00',         //format:'Y-m-d H:i:s',
		   value: '<%=lecend%>', // value:   new Timestamp(),
        });
        
// ----------------------------------------------------------排定無法選擇的日期(待修改)-----------------------------------------------------------
//      1.以下為某一天之前的日期無法選擇
//      //講座開始日期(無法選擇昨天以前)
        var lecdate1 = new Date("<%=paramDate2%>");
//      $('#f_date1').datetimepicker({
//      	beforeShowDay: function(date) {
//          	if (  date.getYear() <  lecdate1.getYear() || 
//         			(date.getYear() == lecdate1.getYear() && date.getMonth() <  lecdate1.getMonth()) || 
//         		    (date.getYear() == lecdate1.getYear() && date.getMonth() == lecdate1.getMonth() && date.getDate() < lecdate1.getDate())
//                  ) {
//                  return [false, ""]
//                  }
//                  return [true, ""];
//       }});
//
        //講座結束日期(無法選擇昨天以前)
        $('#f_date2').datetimepicker({
            beforeShowDay: function(date) {
          	  if (  date.getYear() <  lecdate1.getYear() || 
  		           (date.getYear() == lecdate1.getYear() && date.getMonth() <  lecdate1.getMonth()) || 
  		           (date.getYear() == lecdate1.getYear() && date.getMonth() == lecdate1.getMonth() && date.getDate() < lecdate1.getDate())
                ) {
                     return [false, ""]
                }
                return [true, ""];
        }}); 
/* =========================================以下為表單錯誤處理========================================== */        
   $("#btn").mouseover(function(){
	
	//講座名稱
   	if ($("#lecname").val() === "")
	   $("#theme").addClass("blank");
   	else
	   $("#theme").removeClass("blank");
	
 	//講師姓名
    if ($("#spkrno").prop("selectedIndex") === 0)
   	   $("#name").addClass("blank");
    else
   	   $("#name").removeClass("blank");
 	
 	//講座票價
   if ($("#lecprice").val() === "")
   	  $("#price").addClass("blank");
   else
   	  $("#price").removeClass("blank");
   
   //教室名稱
   if ($("#roomSelect").prop("selectedIndex") === 0)
   	   $("#room").addClass("blank");
   else
       $("#room").removeClass("blank");
   
   //講座圖片
   var fileInput = $("#upimg").get(0).files[0];
   if (fileInput)
       $("#action").val("insert");
           
	var arr = document.getElementsByClassName("blank");
	console.log(arr);
	let blankItem = "";
    if (arr.length > 0) {
        for (let i = 0; i < arr.length; i++) {
        	blankItem += arr[i].textContent + " ";
        }
        var inputAlert = document.createElement("span");
 		inputAlert.textContent = "紅字部分尚未填寫：" + blankItem;
 		inputAlert.setAttribute("style", "color:#ff6680;font-weight:600;");
 		$("#alert").html(inputAlert);
 	} else {
 	    $("#alert").html("");
 	}
});
</script>

</html>

