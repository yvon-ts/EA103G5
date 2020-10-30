<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="BIG5"%>
<%@ page import="com.anwser_list.model.*,java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:useBean id="testTypeSvc" scope="page" class="com.test_type.model.TestTypeService" />
	
	
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/front-end/css/style2.css">

</head>
<body>	

	<jsp:include page="/index/front-index/header.jsp" />
	
	
	
<form method='post' action='<%= request.getContextPath()%>/question/questionTest.do' id='myForm'>

<!-- <div class="heads"> -->
<!-- 	<span id="Check_Txt">剩餘時間：<span id="Check_i">0分0秒</span></span><input type="submit" id = "turnin"  value="送出答案"> -->
<!-- </div> -->
<div class="container-fluid" style="margin-top: 90px;">
	<c:forEach var="question" items="${QuestionList}" varStatus="counter">
		<!--         找出是哪一種類別 -->
		<c:set var="type"
			value="${testTypeSvc.getOnebyNO(question.typeno)}" />
			
		<div class="box1">
			<!-- 	印出題目 -->
			<div class="question">
				<span>${counter.count}</span>.${question.qustmt}<span><h6>(難度:${testTypeSvc.getOnebyNO(question.typeno).testdgee})(題型:${(type.testtype eq 'checkbox' )? '多選題':(type.testtype eq 'radio' )? '單選題':'填空題' })</h6></span>
			</div>
			
			<!-- 	印出單選/多選題 -->
			<c:if test="${not empty question.op1}">
				<ul class="multiple">
					<label>
						<li class="option" style="vertical-align: middle;"><input type="${type.testtype}" class="class${counter.count}" name="${question.qbankno}" value="0"  /> <span>A </span><span>${question.op1}</span></li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}" class="class${counter.count}" name="${question.qbankno}" value="1"  /> <span>B </span><span>${question.op2}</span></li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}" class="class${counter.count}" name="${question.qbankno}" value="2" /> <span>C </span><span>${question.op3}</span></li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}" class="class${counter.count}" name="${question.qbankno}" value="3" /> <span>D </span><span>${question.op4}</span></li>
					</label>
				</ul>
				</div>
	
		</c:if>
		<!-- 	印出填空題 -->
		<c:if test="${empty question.op1}">
			<ul>	
				<input class="form-control form-control-lg" type="${type.testtype}" name="${question.qbankno}" placeholder="請填寫答案"
				id="class${counter.count}" />
			</ul>
			</div>
		</c:if>
		
	</c:forEach>
	<input type='hidden' name='testno' value='<%= (String)request.getAttribute("testno")%>'>
	<input type='hidden' name='courseno' value="<%= request.getParameter("courseno") %>">
	<input type='hidden' name='action' value='correct'>
	<div style="text-align: center;"><button type="button" class="btn btn-primary" id="turnin" >提交測驗</button> </div>
	
</form>
</div>



<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
	
<script type="text/javascript">

// 	var SetMinute = 1800; //計時器改用jQuery寫，

// 	function Check_Time() {
// 		SetMinute -= 1;
// 		var Check_i = document.getElementById("Check_i");

// 		var Cal_Minute = Math.floor(Math.floor(SetMinute % 3600) / 60);
// 		var Cal_Second = SetMinute % 60;

// 		Check_i.innerHTML =  + Cal_Minute + "分" + Cal_Second
// 				+ "秒";
// 		if (SetMinute === 0) {
// 			clearInterval(mm);
// 			document.getElementById("myForm").submit();
// 		}
// 	}
// 	var mm = window.setInterval("Check_Time()", 1000);
	
	$(document).ready(function() {
		
		
		//不動min.css 此頁修改
		$('label').css('display','block');
		$('ul').css('margin','20px 40px');
		
		var str = '/^[\u4e00-\u9fa5_a-zA-Z0-9_]+$/g';//正則表達式，中英文及數字才符合
		
		$('input[type=text]').keyup(function(){//正確作答則移除
			$(this).parents('ul').removeClass('notWritten');
		});
		
		
		
		$('input[type=radio]').click(function(){//正確作答則移除
			
			var ul = $(this).parents('ul');
			var liCount = ul.find('li.option').length;	
		
			for(let i = 0 ; i < liCount ; i++ ){
				ul.find('li.option')[i].style.border = '';
				
				ul.find('li.option')[i].style.backgroundColor = '';
			}
			
			
			if($(this).prop('checked')){
				$(this).parents('li.option').css('border','1px solid #14bdcc');
				$(this).parents('li.option').css('background-color','rgba(20, 189, 204, .1)');
			}
			
			$(this).parents('ul').removeClass('notWritten');
		});
		
		
		$('input[type=checkbox]').click(function(){
			if($(this).prop('checked')){
				$(this).parents('li.option').css('border','1px solid #14bdcc');
				$(this).parents('li.option').css('background-color','rgba(20, 189, 204, .1)');
			}else{
				$(this).parents('li.option').css('border','');
				$(this).parents('li.option').css('background-color','');
			}
			
			$(this).parents('ul').removeClass('notWritten');
			
		});
		
		
		$('#turnin').click(function(e) {//全部題目做完繳交判定
			e.preventDefault();
			
			//https://blog.csdn.net/evilcry2013/article/details/78673291
			//在JS中寫EL語法，須加上``符號;
			//判斷邏輯，在每個題目的選項或是填寫欄加上class 方便去查詢是否填寫
			
			
			
			for(let j = 1 ; j <= `${QuestionList.size()}` ; j++){
				
				var s ;
				
				if($('input[class=class'+ j +']').length > 0){
					 s = $('input[class=class'+ j +']');
				}else{
					 s = $('#class'+j);
				}
				
				var count = 0 ;
				if(s.length === 4){//單選/多選題
					for(let i = 0; i < s.length ;i++){
						if(s[i].checked){
							count++;
						}
					}
				}
				else if($('#class'+j).val().trim().length!=0 && $('#class'+j).val().trim().search(str)){//填空題
						count++;
				}
				if(count == 0){//沒有勾選或填寫的選項的ul加上標註
					s.parents('ul').addClass('notWritten');
				}
			}
			
			console.log($('.notWritten').length);
			
			if($('.notWritten').length <=0){//判斷是否沒有標註再交卷
				swal('你已完成測驗！', '', 'success').then(function(){
					$('#myForm').submit();
				});
				    	
			}else{
				swal('你尚未完成測驗！', '', 'warning');
			}
		});
		
	});
</script>

<jsp:include page="/index/front-index/footer.jsp" />
	
</body>


</html>