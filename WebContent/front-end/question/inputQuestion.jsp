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
%>
<jsp:useBean id="testTypeSvc" scope="page" class="com.test_type.model.TestTypeService" />
<jsp:useBean id="CourseSvc" scope="page" class="com.course.model.CourseService" />


<!DOCTYPE html>
<html>

<head>
    <title></title>
    <!-- include libraries(jQuery, bootstrap) -->
<!--     <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet"> -->
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!--     <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
    <!-- include summernote css/js -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    
    
    <style type="text/css">
          .container {
	margin: 0 auto;
	padding: 0;
	width: 90%;
	overflow: hidden;
}

.flexform-column {
	margin: 40px auto;
	padding: 40px 40px 30px 40px;
	display: flex;
	flex-direction: column;
	align-items: center;
	width: 60%;
	/*background: #efefef;*/
	background: linear-gradient(to bottom, #e8e8e8 0, #f5f5f5 100%);
	border: 1px solid #dfdfdf;
	border-radius: 4px;
	font: normal 1.4rem Arial, sans-serif;
	box-shadow: 0 5px 15px rgba(0, 0, 0, 0.5);
	box-sizing: border-box;
}

.input-text {
	margin: 0 0 15px 0;
	padding: 6px 8px;
	font: 400 1.2rem Arial, sans-serif;
	color: #555;
	border: 1px solid #ddd;
	border-radius: 4px;
	width: 100%;
}

.input-text:focus {
	border: 1px solid #ddd;
	outline: none;
	background: #ffffe0;
	box-shadow: none;
}

.input-text::placeholder {
	color: rgba(85, 85, 85, 0.6);
}

.select-text {
	margin: 0 0 15px 0;
	padding: 6px 8px 6px 4px;
	font: 400 1.2rem Arial, Roboto, sans-serif;
	display: inline-block;
	border: 1px solid #ddd;
	border-radius: 4px;
	width: 100%;
}

.select-text:focus {
	border: 1px solid #ddd;
	outline: none;
	background: #ffffe0;
	box-shadow: none;
}

.input-textarea {
	margin: 0 0 20px 0;
	padding: 2px 10px 10px 10px;
	font: 400 1.2rem Arial, Roboto, sans-serif;
	line-height: 2rem;
	border: 1px solid #ddd;
	border-radius: 4px;
	width: 100%;
	height: 120px;
}

.input-textarea:focus {
	border: 1px solid #ddd;
	outline: none;
	background: #ffffe0;
	box-shadow: none;
}

.input-textarea::placeholder {
	color: rgba(85, 85, 85, 0.6);
}

.button-group-right {
	margin: 10px 0 20px 0;
	padding: 0;
	display: flex;
	flex-direction: row;
	justify-content: flex-end;
	width: 100%;
}

.button-group-left {
	margin: 15px 0;
	padding: 0;
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	width: 100%;
}

.mr-10 {
	margin-right: 10px;
}

select,
select option {
	color: #555;
}

select:invalid,
option[value=""] {
	color: rgba(85, 85, 85, 0.6);
}

.user{
	width:480px;
}

.note-handle .note-control-selection .note-control-se{display:none}



    </style>
    
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
            
