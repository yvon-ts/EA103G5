<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="BIG5"%>
<%@ page import="com.anwser_list.model.*,java.util.*,com.tests.model.*,com.course.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
// 	String courseno = 	(String)request.getSession().getAttribute("coursenoForTest");

// 	CourseService cSvc = new CourseService();
// 	CourseVO  coursevoForNow = cSvc.getOneCourse(courseno);
	
// 	pageContext.setAttribute("coursevoForNow", coursevoForNow);
	
	TestsVO testsVo = (TestsVO) request.getAttribute("testsVo");
%>

<jsp:useBean id="anwserSvc" class="com.anwser_list.model.AnwserListService" />	

<jsp:useBean id="TestSvc" class="com.tests.model.TestsService" />	

<jsp:useBean id="TypeSvc" class="com.test_type.model.TestTypeService" />

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/front-end/test/css/style2.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@100;300;400;500&display=swap" rel="stylesheet">
<style>
	.score{
		    font-weight: 700;
   			color: #09adbf;
	}
	.container-fluid{
		font-family: 'Noto Sans TC', sans-serif;
	}
</style>
</head>
<body>

	<jsp:include page="/index/front-index/header.jsp" />
	
		
	
	<div class="container-fluid" style="margin-top: 90px;">
	
	<div style="text-align: center; color:#0099cc;" ><h2 class="score">得分:<%=TestSvc.getOneByNO(testsVo.getTestno()).getScore()%>分</h2></div>
	
	<c:forEach var="question" items="${QuestionList}" varStatus="counter">
		<!--         找出是哪一種類別 -->
		<c:set var="type" value="${TypeSvc.getOnebyNO(question.typeno)}" />
	    <c:set var="studentAnsArray" value="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans.split('')}" /> 
		<c:set var="testAnsArray" value="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).testans.split('')}" /> 

		
			
		<div class="box1">
			<!-- 	印出題目 -->
			<div class="question">
				
				<span>${counter.count}</span>.${ question.qustmt}<span>
				<c:if test="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).testans eq anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans}">
					
					<i class="fa fa-check" aria-hidden="true" style="color:green"></i>
				</c:if>
					<c:if test="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).testans ne anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans}">
					
					<i class="fa fa-times" aria-hidden="true" style="color:red"></i>
				</c:if>
				<h6>
					<span id="testDegreeAndType${counter.count}" style="font-weight: 100;">${TypeSvc.getOnebyNO(question.typeno).testdgee}
					  ${(type.testtype eq 'checkbox' )? '多選題':(type.testtype eq 'radio' )? '單選題':'填空題' }</span>
				</h6>
				</span>
				
			</div>
			
			<!-- 	印出單選/多選題 -->
			<c:if test="${not empty question.op1}">
					<ul class="multiple">
					<label>
						<li class="option"><input type="${type.testtype}"
						class="class${counter.count}" name="${question.qbankno}" value="0" ${(studentAnsArray[0] eq '1' )? 'checked':'' } disabled/> <span>A</span><span>${question.op1}</span>
						
						<c:if test="${testAnsArray[0] eq '1'}">
							<i class="fa fa-check" aria-hidden="true" style="color:green"></i> 
						</c:if>
						
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="1" ${(studentAnsArray[1] eq '1' )? 'checked':'' } disabled/> <span>B</span><span>${question.op2}</span>
						<c:if test="${testAnsArray[1] eq '1'}">
							<i class="fa fa-check" aria-hidden="true" style="color:green"></i> 
						</c:if>
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="2" ${(studentAnsArray[2] eq '1' )? 'checked':'' } disabled/> <span>C</span><span>${question.op3}</span>
						<c:if test="${testAnsArray[2] eq '1'}">
							<i class="fa fa-check" aria-hidden="true" style="color:green"></i> 
						</c:if>
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="3" ${(studentAnsArray[3] eq '1' )? 'checked':'' } disabled/> <span>D</span><span>${question.op4}</span>
						<c:if test="${testAnsArray[3] eq '1'}">
							<i class="fa fa-check" aria-hidden="true" style="color:green"></i> 
						</c:if>
					</li>
					</label>
				</ul>
		</div>
		</c:if>
		<!-- 	印出填空題 -->
		<c:if test="${empty question.op1}">
				
			<ul style="margin-top:10px" class="multiple">
				<li class="fill">
				<input type="${type.testtype}" name="${question.qbankno}"
				id="class${counter.count}" class="class${counter.count}" style="width:200%" value="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans}" disabled > 
				</li>
				<li class="fill">
				<c:if test="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).testans ne anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans}">
					<div style="color:red;margin-left:200px;font-weight: 700;">${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).testans}</div>
				</c:if>
				</li>
				</ul>
			</div>
		</c:if>
	</c:forEach>
	</div>
			<div style="text-align: center; margin:20px;"><a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=<%= request.getParameter("courseno") %>" class="btn btn-border" style="margin:30px;">回到課程總覽</a><a href="<%=request.getContextPath()%>/front-end/test/ListAllTestRecord.jsp?courseno=<%= request.getParameter("courseno") %>" class="btn btn-border" style="margin:30px;">考試紀錄</a></div>
	<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
	
	
	<script>
	$(document).ready(function(){
		
		for(let i = 1 ; i <= $('ul.multiple').length ; i++){
			if($('#testDegreeAndType' + i ).text().indexOf('簡單') > -1){
				$('#testDegreeAndType' + i ).addClass('badge badge-success');
			}else if($('#testDegreeAndType' + i ).text().indexOf('中等') > -1){
				$('#testDegreeAndType' + i ).addClass('badge badge-warning');
			}else if($('#testDegreeAndType' + i ).text().indexOf('困難') > -1){
				$('#testDegreeAndType' + i ).addClass('badge badge-danger');
			}
		}
		
		
		
		$('label').css('display','block');
		$('ul').css('margin','20px 40px');
		$('label span:first-of-type').css('top','-8px');
		$('label span:first-of-type').css('left','-23px');
		$('.fill').css('margin','0px 10px');
		
		$('input:checked').parents('li.option').css('border','1px solid #14bdcc');
		$('input:checked').parents('li.option').css('background-color','rgba(20, 189, 204, .1)');
		
	});
	
	</script>
	
	<jsp:include page="/index/front-index/footer.jsp" />
	
</body>
</html>