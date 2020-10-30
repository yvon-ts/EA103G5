<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.question_bank.model.*" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<% 
	QuestionBankVO QuestionBankvo = (QuestionBankVO) request.getAttribute("QuestionBankvo");

if(QuestionBankvo !=null && QuestionBankvo.getQuans()!= null && QuestionBankvo.getOp1()!=null  ){
    StringBuilder testAns = new StringBuilder();
    
    
    for(int i = 0 ; i < QuestionBankvo.getQuans().length();i++){
      if(QuestionBankvo.getQuans().charAt(i) =='1'){
        testAns.append((char)(65+i));
      }
    }
    pageContext.setAttribute("testAns",testAns.toString());
    pageContext.setAttribute("opAns",QuestionBankvo.getQuans().split(""));
  }

	String str=request.getParameter("coursename");
	byte[] bytes=str.getBytes("ISO-8859-1");
	String coursename=new String(bytes,"utf-8");

%>
<jsp:useBean id="testTypeSvc" scope="page" class="com.test_type.model.TestTypeService" />
<jsp:useBean id="CourseSvc" scope="page" class="com.course.model.CourseService" />


<!DOCTYPE html>
<html>

<head>
    <title>題庫管理 - <%=coursename %>}</title>
    <!-- include libraries(jQuery, bootstrap) -->
<!--     <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet"> -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!--     <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
    <!-- include summernote css/js -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/front-end/question/css/style.css">
    
</head>

<body>


<c:if test="${not empty errorMsgs}">
	<ul class="error" style="display:none;">
	    <c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<jsp:include page="/index/front-index/header.jsp" />


<div class="container-fluid" style="margin-top: 90px;">

		<div class="row">
			<div class="col" style="text-align:center;color:white;">
				<h1 id="pageTitle" >新增考題</h1>
			</div>
		</div>
   
        <div class="container">
        <form id="myform" class="flexform-column" action="<%= request.getContextPath()%>/question/questionBank.do" method="post">
        <div class="user"> 
            	<!--     第一次填寫 -->
    	<c:if test="${empty errorMsgs}"> 
        	<select id="idatype" name="testtype" class="select-text choose" required>
        		<option value="-1" >請選擇題型</option>
        		<option value="text"  >填空題</option>
        		<option value="radio" >選擇題</option>
        		<option value="checkbox">多選題</option>
    		</select>
    	</c:if>
<!--     	錯誤處理填寫 -->
    	<c:if test="${not empty errorMsgs}">
        	<select id="idatype" name="testtype" class="select-text choose" required>
        		<option value="text" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testtype eq 'text'? 'selected':'disabled'} >填空題</option>
        		<option value="radio" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testtype eq 'radio'? 'selected':'disabled'}>選擇題</option>
        		<option value="checkbox" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testtype eq 'checkbox'? 'selected':'disabled'}>多選題</option>
    		</select>
    	</c:if>
               <select id="idatype" name="courseno" class="select-text" required>
                		<c:forEach var="CourseVo" items="${CourseSvc.getAllForEmployee()}">
                			 <option value="${CourseVo.courseno }" ${QuestionBankvo.courseno eq CourseVo.courseno ? 'selected' :''} >${CourseVo.coursename }</option>
                		</c:forEach>
                </select>
                
                <select id="idatype" name="testscope" class="select-text" required>
                    <option value="1" ${QuestionBankvo.testscope eq '1' ? 'selected' :''}>單元一</option>
                    <option value="2" ${QuestionBankvo.testscope eq '2' ? 'selected' :''}>單元二</option>
                    <option value="3" ${QuestionBankvo.testscope eq '3' ? 'selected' :''}>單元三</option>
                </select>
                <div id="parentDiv"></div>
                <input type="hidden" name="action" value="inputQuestion">
                <input type="hidden" name="update" value="update">
                <input type="hidden" name="coursename" value="<%=coursename%>">
                <input type="hidden" name="courseno" value="<%= request.getParameter("courseno")%>">
                <input type='submit' id="turnin" value='放置題庫' style="display:block ">
        		</div>
        </form>
        </div>
    </div>    
    <script type="text/javascript">
       
        		
                $(document).ready(function() {
                	
                	
                	if($(".error").find('li').length > 0){
                		
                		var str = "" ; 
                		for(let i = 0 ; i < $(".error").find('li').length ; i++ ){
							str += $(".error").find('li')[i].innerText + "<br>";
						}
                		
                		sweetAlert(
                				  '輸入錯誤',
                				  str,
                				  'error'
                				);
                	}
                	
                	
                	
                	$('#turnin').prop("disabled",true);
                	
                   

                    $(".choose").change(function() {

                        if ($(this).val() == 'text') {
                            $('#parentDiv').html(`
                    <select id="idatype" name="typeno" class="select-text" required>
                        <option value="1" >簡單</option>
                        <option value="2" >中等</option>
                        <option value="3" >困難</option>
                    </select><h5>題目:</h5><textarea class="summernote" id="saveToLocal" name="qustmt">${QuestionBankvo.qustmt}</textarea>
                		    <h5>答案:</h5><textarea name="quans" style="width = 480px;" >${QuestionBankvo.quans}</textarea>`);
                            
                            $('#turnin').prop("disabled",false);
                            $('.summernote').summernote({
                                width: 480,
                                height: 300,
                                toolbar: [
                                    // [groupName, [list of button]]
                                    ['style', ['bold', 'italic', 'underline']],
                                    ['fontsize', ['fontsize']],
                                    ['color', ['color']],
                                    ['para', ['ul', 'ol', 'paragraph']],
                                    ['height', ['height']],
                                    ['Insert',['picture','table']]
                                  ]
                            });
                            
                            
                            $('.btn').css("padding","5px");
                            $('.btn').css("color","black");
                            
                        } else if ($(this).val() == 'radio') {

                            $('#parentDiv').html(`<select id="idatype" name="typeno" class="select-text" required>
                        <option value="4" >簡單</option>
                        <option value="5" >中等</option>
                        <option value="6" >困難</option>
                    </select><h5>題目:</h5><textarea class="summernote" name="qustmt">${QuestionBankvo.qustmt}</textarea>
                    <ul class="option">
                    <li><label><input type="radio" name="single" value="A" ${opAns[0] eq '1'? 'checked':''}> A. <input type="text" name="op1" value="${QuestionBankvo.op1}" placeholder="請輸入選項" style="width:209px"></label></li>
                    <li><label><input type="radio" name="single" value="B" ${opAns[1] eq '1'? 'checked':''}> B. <input type="text" name="op2" value="${QuestionBankvo.op2}" placeholder="請輸入選項" style="width:209px"></label></li>
                    <li><label><input type="radio" name="single" value="C" ${opAns[2] eq '1'? 'checked':''}> C. <input type="text" name="op3" value="${QuestionBankvo.op3}" placeholder="請輸入選項" style="width:209px"></label></li>
                    <li><label><input type="radio" name="single" value="D" ${opAns[3] eq '1'? 'checked':''}> D. <input type="text" name="op4" value="${QuestionBankvo.op4}" placeholder="請輸入選項" style="width:209px"></label></li>
                </ul>
            <h5>答案:</h5><input type="text" name="quans" id="writeanswer" value="${testAns}" readonly="readonly">`);

                            $('.summernote').summernote({
                                width: 480,
                                height: 300,
                                toolbar: [
                                    // [groupName, [list of button]]
                                    ['style', ['bold', 'italic', 'underline']],
                                    ['fontsize', ['fontsize']],
                                    ['color', ['color']],
                                    ['para', ['ul', 'ol', 'paragraph']],
                                    ['height', ['height']],
                                    ['Insert',['picture','table']]
                                  ]
                            });
                            
                            
                            $('.btn').css("padding","5px");
                            $('.btn').css("color","black");
                            
                            $('li').css("listStyle", "none");
                            $('li').click(function() {
                                var check = $(this).find('input[type=radio]');
                                check.prop('checked', true);
                                $('#writeanswer').text("");
                                $('#writeanswer').val(check.val());
                                
                                $('#turnin').prop("disabled",false);
                            });
                        } else if ($(this).val() == 'checkbox') {

                            $('#parentDiv').html(`<select id="idatype" name="typeno" class="select-text" required>
                        <option value="7" >簡單</option>
                        <option value="8" >中等</option>
                        <option value="9" >困難</option>
                    </select><h5>題目:</h5><textarea class="summernote" name="qustmt">${QuestionBankvo.qustmt}</textarea>
                    <ul class="option">
                    <li><label><input type="checkbox" name="multiple" value="A" ${opAns[0] eq '1'? 'checked':''}> A. <input type="text" name="op1" value="${QuestionBankvo.op1}" placeholder="請輸入選項" style="width:209px"></label></li>
                    <li><label><input type="checkbox" name="multiple" value="B" ${opAns[1] eq '1'? 'checked':''}> B. <input type="text" name="op2" value="${QuestionBankvo.op2}" placeholder="請輸入選項" style="width:209px"></label></li>
                    <li><label><input type="checkbox" name="multiple" value="C" ${opAns[2] eq '1'? 'checked':''}> C. <input type="text" name="op3" value="${QuestionBankvo.op3}" placeholder="請輸入選項" style="width:209px"></label></li>
                    <li><label><input type="checkbox" name="multiple" value="D" ${opAns[3] eq '1'? 'checked':''}> D. <input type="text" name="op4" value="${QuestionBankvo.op4}" placeholder="請輸入選項" style="width:209px"></label></li>
                </ul>
            <h5>答案:</h5><input type="text" name="quans" id="writeanswer" value="${testAns}" readonly="readonly"> `);
                            
                            $('.summernote').summernote({
                                width: 480,
                                height: 300,
                                toolbar: [
                                    // [groupName, [list of button]]
                                    ['style', ['bold', 'italic', 'underline']],
                                    ['fontsize', ['fontsize']],
                                    ['color', ['color']],
                                    ['para', ['ul', 'ol', 'paragraph']],
                                    ['height', ['height']],
                                    ['Insert',['picture','table']]
                                  ]
                            });
                            
                            
                            $('.btn').css("padding","5px");
                            $('.btn').css("color","black");
                            
                            $('li').css("listStyle", "none");
                            $('li').click(function() {
                                var check = $(this).find('input[type=checkbox]');
                                var outputAnswer = "";
                                if (check.prop('checked')) {
                                    check.prop('checked', false);
                                } else {
                                    check.prop('checked', true);
                                }

                                $('#writeanswer').text("");

                                for (let i = 0; i < $('.option li input[type=checkbox]').length; i++) {
                                    if ($('.option li input[type=checkbox]')[i].checked)
                                        outputAnswer += $('.option li input[type=checkbox]')[i].value;
                                }
                                $('#writeanswer').val(outputAnswer);
								
                                $('#turnin').prop("disabled",false);
                            });
                        }
                    });
                   
                    
                  
                    
                    
                    $("#idatype").trigger('change');
                    
                });
            </script>
            
            
            
            <!-- include 前台頁面的 footer -->
			<jsp:include page="/index/front-index/footer.jsp" />
			<!-- include 前台頁面的 footer -->
            <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
        </body>

        </html>        	
            
