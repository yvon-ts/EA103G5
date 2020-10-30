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
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/front-end/css/style2.css">
<script defer src="https://use.fontawesome.com/releases/v5.0.0/js/all.js"></script>
<style>
	a{
		margin:30px;
	}

</style>
</head>
<body>

	<jsp:include page="/index/front-index/header.jsp" />
	
		
	
	<div class="container-fluid" style="margin-top: 90px;">
	
	<div style="text-align: center; color:#0099cc;" ><h2>得分:<%=TestSvc.getOneByNO(testsVo.getTestno()).getScore()%>分</h2></div>
	
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
					<i class="fas fa-check" style="color:green"></i>
				</c:if>
					<c:if test="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).testans ne anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans}">
					<i class="fas fa-times" style="color:red"></i> 
				</c:if>
				<h6>(難度:${TypeSvc.getOnebyNO(question.typeno).testdgee})(題型:${(type.testtype eq 'checkbox' )? '多選題':(type.testtype eq 'radio' )? '單選題':'填空題' })</h6></span>
				
			</div>
			
			<!-- 	印出單選/多選題 -->
			<c:if test="${not empty question.op1}">
					<ul class="multiple">
					<label>
						<li class="option"><input type="${type.testtype}"
						class="class${counter.count}" name="${question.qbankno}" value="0" ${(studentAnsArray[0] eq '1' )? 'checked':'' } disabled/> <span>A</span><span>${question.op1}</span>
						
						<c:if test="${testAnsArray[0] eq '1'}">
							<i class="fas fa-check" style="color:green"></i> 
						</c:if>
						
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="1" ${(studentAnsArray[1] eq '1' )? 'checked':'' } disabled/> <span>B</span><span>${question.op2}</span>
						<c:if test="${testAnsArray[1] eq '1'}">
							<i class="fas fa-check" style="color:green"></i> 
						</c:if>
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="2" ${(studentAnsArray[2] eq '1' )? 'checked':'' } disabled/> <span>C</span><span>${question.op3}</span>
						<c:if test="${testAnsArray[2] eq '1'}">
							<i class="fas fa-check" style="color:green"></i> 
						</c:if>
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="3" ${(studentAnsArray[3] eq '1' )? 'checked':'' } disabled/> <span>D</span><span>${question.op4}</span>
						<c:if test="${testAnsArray[3] eq '1'}">
							<i class="fas fa-check" style="color:green"></i> 
						</c:if>
					</li>
					</label>
				</ul>
		</div>
		</c:if>
		<!-- 	印出填空題 -->
		<c:if test="${empty question.op1}">
				
			<ul style="margin-top:10px">
				<li class="fill">
				<input type="${type.testtype}" name="${question.qbankno}" placeholder="請填寫答案"
				id="class${counter.count}" class="class${counter.count}" style="width:200%" value="${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans}" disabled > 
				</li>
				<li class="fill">
				
					<c:if test="${anwserSvc.getOneByQBNO(question.qbankno,tse.testno).testans ne anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).studentans}">
					<div style="color:red;margin-left:165px">${anwserSvc.getOneByQBNO(question.qbankno,testsVo.testno).testans}</div>
				</c:if>
				</li>
				</ul>
			</div>
		</c:if>
	</c:forEach>
	</div>
			<div style="text-align: center; margin:20px;"><a href="<%=request.getContextPath()%>/course/course.do?action=showCourseMainPage&courseno=<%= request.getParameter("courseno") %>" class="btn btn-border">回到課程總覽</a><a href="<%=request.getContextPath()%>/front-end/test/ListAllTestRecord.jsp" class="btn btn-border">考試紀錄</a></div>
	<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
	
	
	<script>
	$(document).ready(function(){
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