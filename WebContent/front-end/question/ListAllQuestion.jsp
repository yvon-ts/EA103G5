<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*,com.test_type.model.*"%>
<%@ page import="com.question_bank.model.*,com.course.model.*"%>
<% 
		QuestionBankService questionbankSvc = new QuestionBankService();
		List<QuestionBankVO> questionBankVoList = questionbankSvc.getAll(request.getParameter("courseno"));
	
		pageContext.setAttribute("questionBankVoList", questionBankVoList);
		
		
			
// 			String coursename = "";
			
// 			if(request.getParameter("update") == null){
// 			String str=request.getParameter("coursename");
// 			byte[] bytes=str.getBytes("ISO-8859-1");
// 				 coursename=new String(bytes,"utf-8");
// 			}else{
// 				coursename =request.getParameter("coursename");
// 			}
%>
<jsp:useBean id="ttSvc" scope="page" class="com.test_type.model.TestTypeService" />


<!DOCTYPE html>
<html>
<head>
<title>題庫管理 - ${courseVOForTest.coursename}</title>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!--     <title>Bootstrap CRUD Data Table for Database with Modal Form</title> -->
	
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<!--     <link rel="stylesheet" href="http://www.bootcss.com/p/bootstrap-switch/static/stylesheets/bootstrapSwitch.css"> -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front-end/question/css/listAll.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <style>
    
    </style>

</head>
<body>

	<jsp:useBean id="testTypeSvc" scope="page" class="com.test_type.model.TestTypeService" />
	<jsp:useBean id="CourseSvc" scope="page" class="com.course.model.CourseService" />
	
	<jsp:include page="/index/front-index/header.jsp" />

<%-- <c:if test="${not empty errorMsgs}"> --%>
<!-- 	<ul> -->
<%-- 	    <c:forEach var="message" items="${errorMsgs}"> --%>
<%-- 			<li style="color:red">${message}</li> --%>
<%-- 		</c:forEach> --%>
<!-- 	</ul> -->
<%-- </c:if> --%>
	<div class="container-fluid" style="margin-top: 90px;">

		<div class="row">
			<div class="col" style="text-align:center;color:white;">
				<h1 id="pageTitle" >題庫管理 -${courseVOForTest.coursename} </h1>
			</div>
		</div>
	 <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-6">
                            <h2 style="color:white">考題管理</h2>
                        </div>
                        <div class="col-sm-6">
                            <a
								href='<%=request.getContextPath()%>/front-end/course/editCourse.jsp?courseno=${courseVOForTest.courseno}'
								class="btn btn-info"><i class="fa fa-undo" aria-hidden="true"></i>
								<span>回到課程編輯</span></a>
							<a
								href='<%=request.getContextPath()%>/front-end/question/inputQuestion.jsp?'
								class="btn btn-info"><i class="material-icons">&#xE147;</i>
								<span>新增考題</span></a>
<!-- 							<button type="button" class="btn btn-primary" data-toggle="modal" data-target=".bd-example-modal-lg">新增考題</button> -->
                        </div>
                    </div>
                </div>
                


<!-- <div class="modal fade bd-example-modal-lg" style="width:750px; margin:auto" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true"> -->
<!--   <div class="modal-dialog modal-lg"> -->
<!--     <div class="modal-content"> -->
<%--        <form id="myform" class="flexform-column" action="<%= request.getContextPath()%>/question/questionBank.do" method="post"> --%>
<!--       <div class="modal-body"> -->
<!--         <div class="form-group"> -->
<%--        		<input class="form-control" type="text" name="courseno" value="<%=coursename %>" readonly="readonly"> --%>
<!--     		<select class="form-control" id="exampleFormControlSelect1"  name="testtype" required>	 -->
<!--         				<option value="-1" >請選擇題型</option> -->
<!--         				<option value="text"  >填空題</option> -->
<!--         				<option value="radio" >選擇題</option> -->
<!--         				<option value="checkbox">多選題</option> -->
<!--     		</select> -->
			
<!--     		<select class="form-control" id="exampleFormControlSelect2"  name="testscope" required>	 -->
<!--                 	<option value="1">單元一</option> -->
<!--                     <option value="2">單元二</option> -->
<!--                     <option value="3">單元三</option> -->
<!--     		</select> -->
<!--     		<div id="parentDiv"></div> -->
<!--     		<input type="hidden" name="action" value="inputQuestion"> -->
<!--     		<button type="button" class="btn btn-primary">提交考題</button> -->
<!--   		</div> -->
<!--       </div> -->
<!--       </form> -->
<!--     </div> -->
<!--   </div> -->
<!-- </div> -->
			

                <form action="<%= request.getContextPath()%>/question/questionBank.do" method="post" id = "myForm">
                	
				<div class="container">

				<div class="row">
  					<div class="col-2">
  					<div class="form-group">
    					<select class="form-control" name="testtypeno">
    							<option value="" selected>請選擇題型</option>
    						<c:forEach var="testTypevo" items="${ttSvc.all}">
                				<option value="${testTypevo.testtypeno}">${testTypevo.testdgee}-${(testTypevo.testtype eq 'checkbox' )? '多選題':(testTypevo.testtype eq 'radio' )? '單選題':'填空題' }</option>	
                			</c:forEach>
    					</select>
  					</div>
  					</div>
  					<div class="col-2">
  					
  					<div class="form-group">
    					<select class="form-control" name="testscope">
    							<option value="" selected>請選擇單元</option>
    							<option value="1">單元一</option>
                				<option value="2">單元二</option>
                				<option value="3">單元三</option>
                				<option value="4">單元四</option>
    					</select>
  					</div>
  					</div>
  					<div class="col-2">
  					<input class="form-control" type="text" name="qustmt">
                	</div>
                	<div class="col-2">
                	<input type="hidden" name="action" value="listEmps_ByCompositeQuery">
<%--                 	<input type="hidden" name="courseno" value="<%=request.getParameter("courseno") %>"> --%>
<%--                 	<input type="hidden" name="coursename" value="<%=coursename %>"> --%>
                	<input type="submit" value="送出查詢">
                	
                	</div>
                	</div>
                </div>
                </form>
              
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>題目編號</th>
                            <th>課程名稱</th>
                            <th>課程難易度</th>
                            <th>單元範圍</th>
                            <th>題目敘述</th>
                            <th>編輯</th>
                            <th>狀態</th>	
                        </tr>
                    </thead>
                    <tbody>
                    	
                    <%@ include file="page/page1.file" %>
                    	<c:forEach var="QuestionBankvo" items="${questionBankVoList}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>" varStatus="counter">
                        	
                        	
                        	<c:set var="type" value="${testTypeSvc.getOnebyNO(QuestionBankvo.typeno)}" /> 
                        <tr>
                            
                            <td>${QuestionBankvo.qbankno }</td>
                            <td>${CourseSvc.getOneCourse(QuestionBankvo.courseno).coursename }</td>
                            <c:if test="${ttSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '簡單'}">
                            	<td><span class="badge badge-primary">簡單 ${(type.testtype eq 'checkbox' )? '多選題':(type.testtype eq 'radio' )? '單選題':'填空題' }</span></td>
                            </c:if>
                            <c:if test="${ttSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '中等'}">
                            	<td><span class="badge badge-success">中等 ${(type.testtype eq 'checkbox' )? '多選題':(type.testtype eq 'radio' )? '單選題':'填空題' }</span></td>
                            </c:if>
                            <c:if test="${ttSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '困難'}">
                            	<td><span class="badge badge-warning">困難 ${(type.testtype eq 'checkbox' )? '多選題':(type.testtype eq 'radio' )? '單選題':'填空題' }</span></td>
                            </c:if>
                            
                            
                            <td>${QuestionBankvo.testscope }</td>
                            <td style="width:30%"  class="set" >${QuestionBankvo.qustmt}</td>
                            <td>
                            
                            	<FORM METHOD="post" ACTION="<%=request.getContextPath()%>/question/questionBank.do" style="margin-bottom: 0px;">
			     					<input style="font-family: FontAwesome" value="&#xf044;" type="submit">
	
			     					<input type="hidden" name="qbankno"     value="${QuestionBankvo.qbankno}">
<%-- 			     					<input type="hidden" name="courseno"    value="<%=request.getParameter("courseno") %>"> --%>
<%-- 			     					<input type="hidden" name="coursename"  value="<%=coursename %>"> --%>
			     					<input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--送出本網頁的路徑給Controller-->
			     					<input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--送出當前是第幾頁給Controller-->
			     					<input type="hidden" name="action"	value="getOne_For_Update">
			     				</FORM>
			     			</td>	
			     			<td>
			     					<input type="checkbox" id="customSwitches${counter.count}"  value="${QuestionBankvo.qbankno}" ${QuestionBankvo.qustatus eq '1'? "checked":"" } /><label for="customSwitches${counter.count}"></label>
                            </td>
                        </tr>
                        </c:forEach>
                    </tbody>
                </table>
               
                <%@ include file="page/page2.file" %>
            </div>
        </div>
    </div>
    
    
    <!-- include 前台頁面的 footer -->
	<jsp:include page="/index/front-index/footer.jsp" />
	<!-- include 前台頁面的 footer -->
	
 </div>   
    
    
	<script type="text/javascript">
			
			$(document).ready(function(){
				
				
				
				for(let i = 1 ; i <= `${questionBankVoList.size()}`;i++){
					
					$('#customSwitches' +i).click(function(){
						$.ajax({
							type : "post",
							url  : "editStatus.jsp",
							data : {
								qbankno : $(this).val(),
								status  : $(this).prop("checked")? 0 : 1
							},
						success : function(data){
							console.log(123);
						}
						});
					});
				}	
				$('.set').find('img').css("width","150px");
				$('.set').find('img').css("height","150px");
				
			});
	</script>
</body>
</html>