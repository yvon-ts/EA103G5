<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="BIG5"%>
<%@ page import="com.anwser_list.model.*,java.util.*,com.tests.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    

<jsp:useBean id="testTypeSvc" scope="page"
	class="com.test_type.model.TestTypeService" />

<jsp:useBean id="ase" scope="page"
	class="com.anwser_list.model.AnwserListService" />	

<jsp:useBean id="tse" scope="session"
	class="com.tests.model.TestsService" />	

<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%= request.getContextPath()%>/front-end/css/style2.css">
<script defer src="https://use.fontawesome.com/releases/v5.0.0/js/all.js"></script>

</head>
<body>
	<div class="heads">
		<h3>得分:<%=tse.getOneByNO(tse.getTestno()).getScore()%>分<a href="<%= request.getContextPath()%>/front-end/test/SelectedTest.jsp">回首頁</a></h3>
	</div>
	
	<div class="container">
	<c:forEach var="question" items="${list}" varStatus="counter">
		<!--         找出是哪一種類別 -->
		<c:set var="type" value="${testTypeSvc.getOnebyNO(question.typeno)}" />
	    <c:set var="studentAnsArray" value="${ase.getOneByQBNO(question.qbankno,tse.testno).studentans.split('')}" /> 
		<c:set var="testAnsArray" value="${ase.getOneByQBNO(question.qbankno,tse.testno).testans.split('')}" /> 

		
			
		<div class="box1">
			<!-- 	印出題目 -->
			<div class="question">
				
				<span>${counter.count}</span>.${ question.qustmt}<span  class="testtype"><h6>(難度:${testTypeSvc.getOnebyNO(question.typeno).testdgee})(題型:${(type.testtype eq 'checkbox' )? '多選題':(type.testtype eq 'radio' )? '單選題':'填空題' })</h6></span>
				<c:if test="${ase.getOneByQBNO(question.qbankno,tse.testno).testans eq ase.getOneByQBNO(question.qbankno,tse.testno).studentans}">
					<i class="fas fa-check" style="color:green"></i>
				</c:if>
					<c:if test="${ase.getOneByQBNO(question.qbankno,tse.testno).testans ne ase.getOneByQBNO(question.qbankno,tse.testno).studentans}">
					<i class="fas fa-times" style="color:red"></i> 
				</c:if>
			</div>
			
			<!-- 	印出單選/多選題 -->
			<c:if test="${not empty question.op1}">
					<ul class="multiple">
					<label>
						<li class="option"><input type="${type.testtype}"
						class="class${counter.count}" name="${question.qbankno}" value="0" ${(studentAnsArray[0] eq '1' )? 'checked':'' } disabled/> <span>A. </span><span>${question.op1}</span>
						
						<c:if test="${testAnsArray[0] eq '1'}">
							<i class="fas fa-check" style="color:green"></i> 
						</c:if>
						
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="1" ${(studentAnsArray[1] eq '1' )? 'checked':'' } disabled/> <span>B. </span><span>${question.op2}</span>
						<c:if test="${testAnsArray[1] eq '1'}">
							<i class="fas fa-check" style="color:green"></i> 
						</c:if>
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="2" ${(studentAnsArray[2] eq '1' )? 'checked':'' } disabled/> <span>C. </span><span>${question.op3}</span>
						<c:if test="${testAnsArray[2] eq '1'}">
							<i class="fas fa-check" style="color:green"></i> 
						</c:if>
					</li>
					</label>
					<label>
						<li class="option"><input type="${type.testtype}"
							class="class${counter.count}" name="${question.qbankno}" value="3" ${(studentAnsArray[3] eq '1' )? 'checked':'' } disabled/> <span>D. </span><span>${question.op4}</span>
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
				id="class${counter.count}" class="class${counter.count}" style="width:200%" value="${ase.getOneByQBNO(question.qbankno,tse.testno).studentans}" disabled > 
				</li>
				<li class="fill">
				
					<c:if test="${ase.getOneByQBNO(question.qbankno,tse.testno).testans ne ase.getOneByQBNO(question.qbankno,tse.testno).studentans}">
					<div style="color:red;margin-left:165px">${ase.getOneByQBNO(question.qbankno,tse.testno).testans}</div>
				</c:if>
				</li>
				</ul>
			</div>
		</c:if>
	</c:forEach>
	</div>
</body>
</html>