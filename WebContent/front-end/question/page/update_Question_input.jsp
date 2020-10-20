<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.question_bank.model.*"%>
<% 
  QuestionBankVO QuestionBankvo = (QuestionBankVO) request.getAttribute("QuestionBankvo");
  

	
  if(QuestionBankvo.getOp1()!=null){
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
<!DOCTYPE html>
<html>

<head>
    <title>Insert title here</title>
      <!-- include libraries(jQuery, bootstrap) -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <!-- include summernote css/js -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
    <style type="text/css">
        button {
            display: block;
        }
        h3 {
            display: inline-block;
            vertical-align: top;
        }

        .option li {
            list-style: none;
            margin-top: 10px;
        }

        .option {
            margin-left: 20px;
        }
        textarea {
            width: 400px;
        }
    </style>
</head>

<body>
    <c:if test="${not empty errorMsgs}">
        <font style="color:red">請修正以下錯誤:</font>
        <ul>
            <c:forEach var="message" items="${errorMsgs}">
                <li style="color:red">${message}</li>
            </c:forEach>
        </ul>
    </c:if>
    <form action="<%= request.getContextPath()%>/question/question.do" method="post">
        <select id="choose" name="testtype">
            <option value="-1">請選擇題型</option>
            <option value="text" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testtype eq 'text' ? 'selected' :''}>填空題</option>
            <option value="radio" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testtype eq 'radio' ? 'selected' :''}>選擇題</option>
            <option value="checkbox" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testtype eq 'checkbox' ? 'selected' :''}>多選題</option>
        </select>
        <div id="parentDiv"></div>
    </form>
    <script type="text/javascript">
        $(document).ready(function() {
			$('#choose').hide();
            $("#choose").change(function() {
                if ($(this).val() === "text") {


                    var str = `
                    <div>題目編號: ${QuestionBankvo.qbankno}</div>
                    <div>
                        <h4>課程名稱:</h4>
                        <select id="teacherCourse" name="courseno">
                            <option value="COUR0001" ${QuestionBankvo.courseno eq "COUR0001" ? 'selected':''}>courseName1</option>
                            <option value="COUR0002" ${QuestionBankvo.courseno eq "COUR0002" ? 'selected':''}>courseName2</option>
                            <option value="COUR0003" ${QuestionBankvo.courseno eq "COUR0003" ? 'selected':''}>courseName3</option>
                            <option value="COUR0004" ${QuestionBankvo.courseno eq "COUR0004" ? 'selected':''}>courseName4</option>
                        </select>
                    </div>
                    <div>
                        <h4>題目難易度:</h4>
                        <select  name="typeno">
                            <option value="1" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '簡單'? 'selected':''}>簡單</option>
                            <option value="2" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '中等'? 'selected':''} >中等</option>
                            <option value="3" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '困難'? 'selected':''}>困難</option>
                        </select>
                    </div>
    <div>
        <h4>測驗單元:</h4>
        <select id="courseUnit" name="testscope">
            <option value="1" ${QuestionBankvo.testscope eq '1'? 'selected':''}>單元一</option>
            <option value="2" ${QuestionBankvo.testscope eq '2'? 'selected':''}>單元二</option>
            <option value="3" ${QuestionBankvo.testscope eq '3'? 'selected':''}>單元三</option>
        </select>
    </div>
    <div><h4 >題目:</h4><textarea class="summernote" name="qustmt">${QuestionBankvo.qustmt}</textarea>
    <div><h4 >正解:</h4><textarea name="quans" >${QuestionBankvo.quans}</textarea></div>
    <input type="hidden" name="action" value="updateQuestion" >
    <input type='submit' value='放置題庫' style="display:block">
    <input type="hidden" name="qbankno" value="${QuestionBankvo.qbankno}">`;

                    $('#parentDiv').html(str);
                    $('.summernote').summernote({
                        width: 600,
                        height: 300,
                    });



                } else if ($(this).val() === "radio") {
                    var str = `
                      <div>題目編號: ${QuestionBankvo.qbankno}</div>
                    <div>
                      <h4>課程名稱:</h4>
                        <select id="teacherCourse" name="courseno">
                            <option value="COUR0001" ${QuestionBankvo.courseno eq "COUR0001" ? 'selected':''}>courseName1</option>
                            <option value="COUR0002" ${QuestionBankvo.courseno eq "COUR0002" ? 'selected':''}>courseName2</option>
                            <option value="COUR0003" ${QuestionBankvo.courseno eq "COUR0003" ? 'selected':''}>courseName3</option>
                            <option value="COUR0004" ${QuestionBankvo.courseno eq "COUR0004" ? 'selected':''}>courseName4</option>
                        </select>
                    </div>
                    <div>
                        <h4>難易度:</h4>
                        <select  name="typeno">
                            <option value="4" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '簡單'? 'selected':''}>簡單</option>
                            <option value="5" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '中等'? 'selected':''} >中等</option>
                            <option value="6" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '困難'? 'selected':''}>困難</option>
                        </select>
                    </div>
                    <div>
                        <h4>測驗單元:</h4>
                        <select id="courseUnit" name="testscope">
                            <option value="1" ${QuestionBankvo.testscope eq '1'? 'selected':''}>單元一</option>
                            <option value="2" ${QuestionBankvo.testscope eq '2'? 'selected':''}>單元二</option>
                            <option value="3" ${QuestionBankvo.testscope eq '3'? 'selected':''}>單元三</option>
                        </select>
                    </div>
    <div><h4 >題目:</h4><textarea class="summernote" name="qustmt">${QuestionBankvo.qustmt}</textarea>
    <ul class="option">
        <li><label><input type="radio" name="single" value="A" ${opAns[0] eq '1'? 'checked':''}> A. <input type="text" name="op1" value="${QuestionBankvo.op1}" placeholder="請輸入選項" ></label></li>
        <li><label><input type="radio" name="single" value="B" ${opAns[1] eq '1'? 'checked':''}> B. <input type="text" name="op2" value="${QuestionBankvo.op2}" placeholder="請輸入選項" ></label></li>
        <li><label><input type="radio" name="single" value="C" ${opAns[2] eq '1'? 'checked':''}> C. <input type="text" name="op3" value="${QuestionBankvo.op3}" placeholder="請輸入選項" ></label></li>
        <li><label><input type="radio" name="single" value="D" ${opAns[3] eq '1'? 'checked':''}> D. <input type="text" name="op4" value="${QuestionBankvo.op4}" placeholder="請輸入選項" ></label></li>
    </ul>
    <div><h4 >正解:</h4><input type="text" name="quans" id="writeanswer" value="${testAns}"  /></div>
    <div>
    <input type="hidden" name="action" value="updateQuestion" >
    <input type='submit' value='放置題庫' style="display:block">
    <input type="hidden" name="qbankno" value="${QuestionBankvo.qbankno}">
    `;


                    $('#parentDiv').html(str);
                    
                    $('.summernote').summernote({
                        width: 600,
                        height: 300,
                    });

                    $('li').click(function() {
                        var check = $(this).find('input[type=radio]');
                        check.prop('checked', true);
                        $('#writeanswer').text("");
                        $('#writeanswer').val(check.val());
                    });
                } else if ($(this).val() === "checkbox") {
                    var str = `<div>題目編號: ${QuestionBankvo.qbankno}</div>
                    <div>
                      <h4>課程名稱:</h4>
                        <select id="teacherCourse" name="courseno">
                            <option value="COUR0001" ${QuestionBankvo.courseno eq "COUR0001" ? 'selected':''}>courseName1</option>
                            <option value="COUR0002" ${QuestionBankvo.courseno eq "COUR0002" ? 'selected':''}>courseName2</option>
                            <option value="COUR0003" ${QuestionBankvo.courseno eq "COUR0003" ? 'selected':''}>courseName3</option>
                            <option value="COUR0004" ${QuestionBankvo.courseno eq "COUR0004" ? 'selected':''}>courseName4</option>
                        </select>
                    </div>
                    <div>
                        <h4>難易度:</h4>
                        <select  name="typeno">
                            <option value="7" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '簡單'? 'selected':''}>簡單</option>
                            <option value="8" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '中等'? 'selected':''} >中等</option>
                            <option value="9" ${testTypeSvc.getOnebyNO(QuestionBankvo.typeno).testdgee eq '困難'? 'selected':''}>困難</option>
                        </select>
                    </div>
                    <div>
                        <h4>測驗單元:</h4>
                        <select id="courseUnit" name="testscope">
                            <option value="1" ${QuestionBankvo.testscope eq '1'? 'selected':''}>單元一</option>
                            <option value="2" ${QuestionBankvo.testscope eq '2'? 'selected':''}>單元二</option>
                            <option value="3" ${QuestionBankvo.testscope eq '3'? 'selected':''}>單元三</option>
                        </select>
                    </div>
    <div><h4>題目:</h4><textarea class="summernote" name="qustmt">${QuestionBankvo.qustmt}</textarea>
    <ul class="option">
        <li><label><input type="checkbox" name="multiple" value="A"  ${opAns[0] eq '1'? 'checked':''}> A. <input type="text" name="op1" value="${QuestionBankvo.op1}" placeholder="請輸入選項" ></label></li>
        <li><label><input type="checkbox" name="multiple" value="B"  ${opAns[1] eq '1'? 'checked':''}> B. <input type="text" name="op2" value="${QuestionBankvo.op2}" placeholder="請輸入選項" ></label></li>
        <li><label><input type="checkbox" name="multiple" value="C"  ${opAns[2] eq '1'? 'checked':''}> C. <input type="text" name="op3" value="${QuestionBankvo.op3}" placeholder="請輸入選項" ></label></li>
        <li><label><input type="checkbox" name="multiple" value="D"  ${opAns[3] eq '1'? 'checked':''}> D. <input type="text" name="op4" value="${QuestionBankvo.op4}" placeholder="請輸入選項" ></label></li>
    </ul>
    <div><h4>正解</h4><input type="text" name="quans" value="${testAns}"  id="writeanswer"/></div>
    <input type="hidden" name="action" value="updateQuestion" >
    <input type='submit' value='放置題庫' style="display:block">
    <input type="hidden" name="qbankno" value="${QuestionBankvo.qbankno}">
    `;


                    $('#parentDiv').html(str);
                    
                    $('.summernote').summernote({
                        width: 600,
                        height: 300,
                    });

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

                    });
                }
            });
            $("#choose").trigger('change');
        });
    </script>
</body>

</html>