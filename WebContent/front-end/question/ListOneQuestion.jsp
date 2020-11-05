<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.question_bank.model.*"%>
<%
	QuestionBankVO QuestionBankvo = (QuestionBankVO)request.getAttribute("QuestionBankvo");
	
	
	
	if(QuestionBankvo!=null && QuestionBankvo.getOp1()!=null){
    StringBuilder testAns = new StringBuilder();
    
    
    for(int i = 0 ; i < QuestionBankvo.getQuans().length();i++){
      if(QuestionBankvo.getQuans().charAt(i) =='1'){
        testAns.append((char)(65+i));
      }
    }
    pageContext.setAttribute("testAns",testAns.toString());
  }
	
	
%>
<jsp:useBean id="CourseSvc" scope="page" class="com.course.model.CourseService" />

<jsp:useBean id="ttSvc" scope="page" class="com.test_type.model.TestTypeService" />
<!DOCTYPE html>
<html>
<head>
<meta charset="BIG5">
<title>題庫管理 - <%=request.getParameter("coursename") %></title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="http://www.bootcss.com/p/bootstrap-switch/static/stylesheets/bootstrapSwitch.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front-end/question/css/listAll.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
<jsp:include page="/index/front-index/header.jsp" />
   
   <div class="container-fluid" style="margin-top: 90px;">
	<div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2>考題資料</h2>
                        </div>
                        <div class="col-sm-6">
                            <a href='<%= request.getContextPath()%>/front-end/question/ListAllQuestion.jsp?whichPage=<%=request.getParameter("whichPage") %>&coursename=<%=request.getParameter("coursename") %>&courseno=<%=request.getParameter("courseno") %>' class="btn btn-info" ><span>
							回到考題管理</span></a>
                        </div>
                    </div>
                </div>
                <table class="table table-striped table-hover">
                   
                        <tr>
                            <td>題目編號</td><td>${QuestionBankvo.qbankno }</td>
                        </tr>
                        <tr>
                            <td>課程名稱</td><td>${CourseSvc.getOneCourse(QuestionBankvo.courseno).coursename }</td>
                        </tr>
                        <tr>    
                            <td>課程難易度</td><td>${ttSvc.getOnebyNO(QuestionBankvo.typeno).testdgee}</td>
                        </tr>
                        <tr>                            
                        	<td>單元範圍</td><td>${QuestionBankvo.testscope }</td>
                        </tr>
                        <tr>
                            <td>題目敘述</td>	<td>${QuestionBankvo.qustmt}</td>
                        </tr>
                       <c:if test="${not empty QuestionBankvo.op1}">
                        <tr>    
                            <td>選項A</td><td>${QuestionBankvo.op1}</td>
                        </tr>
                        <tr>    
                            <td>選項B</td><td>${QuestionBankvo.op2}</td>
                        </tr>
                        <tr>    
                            <td>選項C</td><td>${QuestionBankvo.op3}</td>
                        </tr>
                        <tr>    
                            <td>選項D</td><td>${QuestionBankvo.op4}</td>
                        </tr>
                        <tr>   
                            <td>答案</td><td>${testAns}</td>
                        </tr>
                        </c:if>
                        <c:if test="${empty QuestionBankvo.op1}">
                        <tr>   
                            <td>答案</td><td>${QuestionBankvo.quans}</td>
                        </tr>
                        </c:if>
                   
                 
                 </table>
              </div>
        </div>
    </div>     
    </div>
     <!-- include 前台頁面的 footer -->
			<jsp:include page="/index/front-index/footer.jsp" />
			<!-- include 前台頁面的 footer -->
</body>
</html>