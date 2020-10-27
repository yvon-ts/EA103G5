<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<%@ page import="com.teacher.model.*"%>

<%-- <jsp:useBean id="teacherSvc" scope="page" class="com.teacher.model.TeacherService" />
 --%>
<%@ include file="/index/front-index/header.jsp" %>




<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Xducation-註冊老師</title>

    <!-- Font Icon -->
    <%-- <link rel="styl<!-- <!--  --> -->esheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
 --%>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
    <script src="https://cdn.ckeditor.com/ckeditor5/23.0.0/classic/ckeditor.js"></script>
 
     <%-- 
 <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/style.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/bootstrap.min.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/nivo-lightbox.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/animate.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/main.css"> --%>
<%--     <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/responsive.css"> --%>
</head>
<style type="text/css">
@import url("https://fonts.googleapis.com/css?family=Nunito:400,900");



body .progress_inner #step-5:checked + div + div + div + div > .ppic5, body .progress_inner #step-4:checked + input + div + div + div + div > .ppic4, body .progress_inner #step-2:checked + input + input + input + div + div + div + div > .ppic2, body .progress_inner #step-3:checked + input + input + div + div + div + div > .ppic3, body .progress_inner #step-1:checked + input + input + input + input + div + div + div + div > .ppic1 {
  top: 50%;
  left: 0px;
  opacity: 1;
}



* {
  box-sizing: border-box;
}

body .progress_inner__step:before, body .progress_inner, body .progress_inner__status .box_base, body .progress_inner__status .box_item, body .progress_inner__status .box_ribbon, body .progress_inner__status .box_bow, body .progress_inner__status .box_bow__left, body .progress_inner__status .box_bow__right, body .progress_inner__status .box_tag, body .progress_inner__status .box_string {
  position: absolute;
  left: 0;
  right: 0;
  top: 50%;
  -webkit-transform: translateY(-50%);
          transform: translateY(-50%);
  margin: auto;
}

body .progress_inner__bar, body .progress_inner__bar--set {
  height: 6px;
  left: 10%;
  background: repeating-linear-gradient(45deg, #1ea4ec, #1ea4ec 4px, #1f8bc5 4px, #1f8bc5 10px);
  -webkit-transition: width 800ms cubic-bezier(0.915, 0.015, 0.3, 1.005);
  transition: width 800ms cubic-bezier(0.915, 0.015, 0.3, 1.005);
  border-radius: 6px;
  width: 0;
  position: relative;
  z-index: -1;
}

body .progress_inner__step:before {
  width: 30px;
  height: 30px;
  color: #70afd0;
  background: white;
  line-height: 30px;
  border: 3px solid #a6cde2;
  font-size: 12px;
  top: 3px;
  border-radius: 100%;
  -webkit-transition: all 0.4s;
  transition: all 0.4s;
  cursor: pointer;
  pointer-events: none;
}

body .progress_inner__step {
  width: 20%;
  font-size: 14px;
  padding: 0 10px;
  -webkit-transition: all 0.4s;
  transition: all 0.4s;
  float: left;
  text-align: center;
  position: relative;
}
body .progress_inner__step label {
  padding-top: 50px;
  top: -20px;
  display: block;
  position: relative;
  cursor: pointer;
}
body .progress_inner__step:hover {
  color: white;
}
body .progress_inner__step:hover:before {
  color: white;
  background: #1ea4ec;
}

body {
  font-family: "Nunito", sans-serif;
  background: #a6cde2;
  color: #2e6c8e;
  text-align: center;
  font-weight: 900;
}
body .progress_inner {
  height: 200px;
  width: 700px;
}
body .progress_inner #step-5:checked + div {
  width: 80%;
}
body .progress_inner #step-5:checked + div + div + div > .tab:nth-of-type(5) {
  opacity: 1;
  top: 0;
}
body .progress_inner #step-5:checked + div + div + div + div {
  right: 10%;
}
body .progress_inner #step-4:checked + input + div {
  width: 60%;
}
body .progress_inner #step-4:checked + input + div + div + div > .tab:nth-of-type(4) {
  opacity: 1;
  top: 0;
}
body .progress_inner #step-4:checked + input + div + div + div + div {
  right: 30%;
}
body .progress_inner #step-3:checked + input + input + div {
  width: 40%;
}
body .progress_inner #step-3:checked + input + input + div + div + div > .tab:nth-of-type(3) {
  opacity: 1;
  top: 0;
}
body .progress_inner #step-3:checked + input + input + div + div + div + div {
  right: 50%;
}
body .progress_inner #step-2:checked + input + input + input + div {
  width: 20%;
}
body .progress_inner #step-2:checked + input + input + input + div + div + div > .tab:nth-of-type(2) {
  opacity: 1;
  top: 0;
}
body .progress_inner #step-2:checked + input + input + input + div + div + div + div {
  right: 70%;
}
body .progress_inner #step-1:checked + input + input + input + input + div {
  width: 0%;
}
body .progress_inner #step-1:checked + input + input + input + input + div + div + div > .tab:nth-of-type(1) {
  opacity: 1;
  top: 0;
}
body .progress_inner #step-1:checked + input + input + input + input + div + div + div + div {
  right: 90%;
}
body .progress_inner__step:nth-of-type(1):before {
  content: "1";
}
body .progress_inner__step:nth-of-type(2):before {
  content: "2";
}
body .progress_inner__step:nth-of-type(3):before {
  content: "3";
}
body .progress_inner__step:nth-of-type(4):before {
  content: "4";
}
body .progress_inner__step:nth-of-type(5):before {
  content: "5";
}
body .progress_inner__bar--set {
  width: 80%;
  top: -6px;
  background: #70afd0;
  position: relative;
  z-index: -2;
}
body .progress_inner__tabs .tab {
  opacity: 0;
  position: absolute;
  top: 40px;
  text-align: center;
  margin-top: 80px;
  box-shadow: 0px 2px 1px #80b7d5;
  padding: 30px;
  background: white;
  border-radius: 10px;
  -webkit-transition: all 0.2s;
  transition: all 0.2s;
}
body .progress_inner__tabs .tab h1 {
  margin: 0;
}
body .progress_inner__tabs .tab p {
  font-weight: 400;
  opacity: 0.8;
}
body .progress_inner__status {
  width: 40px;
  height: 40px;
  top: -80px;
  -webkit-transition: right 800ms cubic-bezier(0.915, 0.015, 0.3, 1.005);
  transition: right 800ms cubic-bezier(0.915, 0.015, 0.3, 1.005);
  -webkit-transform: translateX(50%);
          transform: translateX(50%);
  position: absolute;
}
body .progress_inner__status div {
  opacity: 0;
  -webkit-transition: all 600ms cubic-bezier(0.915, 0.015, 0.3, 1.005);
  transition: all 600ms cubic-bezier(0.915, 0.015, 0.3, 1.005);
  -webkit-transition-delay: 300ms;
          transition-delay: 300ms;
}
body .progress_inner__status div {
  position: absolute;
}


body .progress_inner input[type="radio"] {
  display: none;
}
img.ppic{

    width: 45px;
    height: 45px;
}

 img.pic{
        width: 36px;
        height: 36px;
    }   
    img.dpic{
        width: 200px;
        height: 200px;
    }     

figure.license{
   width:200px;
   height:200px;
   margin:auto;
   }  
   label#cert{
    width:250px;
    
    }
   
div.signup-content{
padding:0px;
height:800px;
}
   
    section#copyright{
 height:200px;
 margin-top:850px;
 }
 nav.navbar{
 background-color:white;
 }
 input#apply{
width:150px;
height:50px;
margin-top:100px;


}
div#applyouter{
}
h1#applytext{
width:630px;
text-align:center;

}
input.form-submit {
  display: inline-block;
  background: #6dabe4;
  color: #fff;
  border-bottom: none;
  width: auto;
 border:1px;
  border-radius: 5px;
  -moz-border-radius: 5px;
  -webkit-border-radius: 5px;
  -o-border-radius: 5px;
  -ms-border-radius: 5px;
  margin-top: 25px;
  cursor: pointer; 
 
  
  }
  div#editor{
  width:100px;
  height:100px;
  position:absolute;
  z-index:20;
  
  
  
  }
  input#bankacc{
    width: 400px;
    display: block;
    border: none;
    border-bottom: 1px solid #999;
    padding:0px 70px;
    font-family: Poppins;
    box-sizing: border-box;
    margin:20px auto;
    text-align:center;

  

  }
  h1{
  padding-bottom:15px;}
  
  
 div.form-submit:hover {
    background: #4292dc; }
    
    
    img.bankPic{
    width:150px;
    height:50px;
    margin:7px;
    
    }
   

   
 
body{
background: url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");
}

    
</style>
<body>
<!--     <nav class="navbar navbar-expand-md bg-inverse fixed-top scrolling-navbar"> -->
<!--             <div class="container"> -->
<!--                 左上角LOGO Start -->
<%--                 <a href="<%=request.getContextPath()%>/front-end/members/indexV1.jsp" class="navbar-brand"><img src="nav_css_ForTeacherRegister/img/logo.svg" alt=""> --%>
<!--                     <div id="logo">Xducation</div> -->
<!--                 </a> -->
<!--                 左上角LOGO End -->
<!--                 <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarCollapse" aria-controls="navbarCollapse" aria-expanded="false" aria-label="Toggle navigation"> -->
<!--                     <i class="lni-menu"></i> -->
<!--                 </button> -->
<!--                 <div class="collapse navbar-collapse" id="navbarCollapse"> -->
<!--                     <ul class="navbar-nav mr-auto w-100 justify-content-end clearfix"> -->
<!--                         <li class="nav-item"> -->
<!--                             <a class="nav-link" href="#"> -->
<!--                                 進入搜尋&nbsp;<i class="lni-search"></i> -->
<!--                             </a> -->
<!--                         </li> -->
<!--                         <li class="nav-item"> -->
<!--                             <a class="nav-link" href="#"> -->
<!--                                 精選課程&nbsp;<i class="lni-leaf"></i> -->
<!--                             </a> -->
<!--                         </li> -->
<!--                         <li class="nav-item"> -->
<!--                             <a class="nav-link" href="#"> -->
<!--                                 名人講座&nbsp;<i class="lni-bulb"></i> -->
<!--                             </a> -->
<!--                         </li> -->
                       
<!--                        <li class="nav-item"> -->
<%--                             <a class="nav-link" href="<%=request.getContextPath()%>/front-end/members/signIn.jsp" style="color: #0099CC"> --%>
<!--                                 我要登入&nbsp;<i class="lni-home"></i> -->
<!--                             </a> -->
<!--                         </li> -->
<!--                         已登入 End -->
<!--                     </ul> -->
<!--                 </div> -->
<!--             </div> -->
<!--         </nav> -->

     <div class="main">
  

        <!-- Sign up form -->
        <section class="signup">
        
        <form method="POST" action="<%=request.getContextPath()%>/teacher/teacher.do" enctype='multipart/form-data' >
        
            
  <div class='progress_inner'>
     <div class='progress_inner__step'>
      <label for='step-1'>準備成為一名老師</label>
    </div>
    <div class='progress_inner__step'>
      <label for='step-2'>跟大家介紹自己吧</label>
    </div>
    <div class='progress_inner__step'>
      <label for='step-3'>有兩張證照是必須</label>
    </div>
    <div class='progress_inner__step'>
      <label for='step-4'>薪水匯到哪呢?</label>
    </div>
    <div class='progress_inner__step'>
      <label for='step-5'>請耐心等候審核</label>
    
    </div>
    <input checked='checked' id='step-1' name='step' type='radio'>
    <input id='step-2' name='step' type='radio'>
    <input id='step-3' name='step' type='radio'>
    <input id='step-4' name='step' type='radio'>
    <input id='step-5' name='step' type='radio'>
    <div class='progress_inner__bar'></div>
    <div class='progress_inner__bar--set'></div>
    <div class='progress_inner__tabs'>
      <div style="width: 100%;height: 500px;" class='tab tab-0' >
        <h1>申請須知</h1>
        <table>
        
        <tr>
        <td>
       <ul style="color:#0099CC; font-family:'Gochi Hand';">
       
       <li>1.老師在 Xducation 上架的課程皆為專屬授權，授權範圍包括募資影片、課程影片及課程講義</li>
       <li>2.授權期間為 2 年。若未經 Xducation 同意單方面提前下架課程，將依違約條款處理</li>
       <li>3.授權期間內，未經 Xducation 事前書面同意，老師不可以將課程上架到其它付費或免費平台、翻譯重製，或作其他利用</li>
       <li>4.專屬授權不影響老師就相同主題以平面媒體或電子書之形式出版、或開設線下實體教學課程的權利</li>
       <li>5.約定「第三方服務」及第三方服務的「系統串接設定費用」，由 Xducation 與老師雙方共同負擔。</li>
       <li>6.「第三方服務」提供者包含多管道行銷平台（Shopback、LINE 購物、蝦皮商城等），以及金流服務平台。</li>
       <li>7.課程開課日需提供「完整」課程影片給購課學員，而非分批提供，才算是「開課」。且在 Xducation 提供課程製作服務時，老師亦需提供必要的協助，確保課程於預定開課日上架開課。</li>
       <li>8.新增即便合約終止後，消費者可繼續使用「已購買」之課程。</li>
       
       </ul>
       </td>
        
        </tr>
        
        
        
        
        </table>
        
        
        
      </div>

      <div style="width: 100%;height: 500px;" class='tab tab-1' >
        <h1>老師簡介</h1>
        

                     <table>
                        <tr>
                        <th><ul style="color:#0099CC; font-family:'Gochi Hand';"><li>1.擅長領域</li><li>2.教學經驗</li><li>3.最高學歷</li></ul></th>

                       
                         <th>
                         <div id="editor"><textarea style="margin:0px 50px;width: 480px;height: 150px;  position:absolute;z-index: 10;" name="tchrintro" placeholder="資料的詳細度將會影響審核成功的機率，祝好運">djfjdskfjspfks</textarea></div>
        
                        <%--  <textarea style="margin:0px 50px;width: 480px;height: 150px;  position:absolute;z-index: 10;" name="tchrintro" placeholder="資料的詳細度將會影響審核成功的機率，祝好運">${requestScope.teacherVO.tchrintro}</textarea> 
 --%>

                         </th>
                        <!--  <th><div style="width: 250px;"></div></th> -->
                        </tr>
                        <tr><th></th></tr>




                     </table>   
           
        
                         
      </div>





      <div style="width: 100%;height: 500px;"  class='tab tab-2'>
        <h1>專業證照</h1>
        <table>
            <tr><td><div style="height: 50px;"></div></td><th><div class="form-group" id="form-group" style="position:absolute;z-index: 20">
                                <label id="cert" style="color:#0099CC; font-family:'Gochi Hand';">點選上傳證照1<img class="pic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/pictures.svg"><input  onchange="readURL(this)" targetID="license1" style="display:none;" type="file" name="tchrcert1" style="display:none;" id="tchrcert"/></label>
                               </div></th>


 <td><div style="width:400px"></div></td>
 <td><div style="height: 50px;"></div></td>
 
 
 

                               <td><img id="license1" class="dpic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/certification.jpg" ></td>



                           </tr>
            

 


   <tr><td><div style="height: 200px;"></div></td>    <th><div class="form-group" id="form-group" style="position:absolute;z-index: 20">
                                <label id="cert" style="color:#0099CC; font-family:'Gochi Hand';">點選上傳證照2  <img class="pic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/pictures.svg"><input  onchange="readURL(this)" targetID="license2" style="display:none;" type="file" name="tchrcert2" style="display:none;" id="tchrcert"/></label>
                               </div></th>





 <td><div style="width:400px"></div></td>
 <td><div style="height: 50px;"></div></td>

                               <td><img id="license2" class="dpic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/certification.jpg" ></td>






                           </tr>


        </table>
      </div>








      <div style="width: 100%;height: 500px; position:absolute;z-index: 9;" class='tab tab-3' >
        <h1>銀行帳號</h1>
        <input style="width: 400px;height:30px " type="text" name="bankacc" id="bankacc" placeholder="只能輸入數字，限制20字" value="${teacherVO.bankacc}"/>
        <table>
        <tr><th style="color:#0099CC; font-family:'Gochi Hand';">我們只接受以下銀行	</th></tr>
            <tr>
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/CUbank.png'></td>
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/citi_bank.png'></td>
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/CTBC_Bank.png'></td>
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/hsbcBank.png'></td>


            </tr>


            <tr>
                
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/fubonBank.png'></td>
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/huananBank.png'></td>
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/taiwanBank.png'></td>
                <td><img class="bankPic" id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/firstBank.png'></td>
            </tr>
            



        </table>
      </div>












      <div style="width: 100%;height: 500px;" id="applyouter" class='tab tab-4'>
         <h1 id="applytext">確認申請</h1>
         <table>
         <tr>
         <th style="padding-top:50px;font-size:20px;color:#0099CC; font-family:'Gochi Hand'">
         提醒:確認選擇後，該帳號不得再次更改「開課身份」，未來若有任何需要調整、協助的地方，歡迎聯繫你的 Xducation 專屬專案企劃夥伴，或透過右下角客服告訴我們 。
         
         </th>
         
         
         </tr>
         <tr>
         <td style="padding-right:160px;padding-bottom:150px;">
         <input type="hidden" name="action" value="insert">
           <input type='hidden' name='memno' value='${membersVO.memno}'>
           <input id="apply" style="position:absolute;z-index: 12;" type="submit" name="signup" class="form-submit" value="提交"/>
        
         
         </td>         
         
         </tr>
         
         
         
         
         </table>
         
         
         
         
        
         
         
         
        
           
      </div>
    </div>
    <div class='progress_inner__status'>
      <div class='ppic1'><img class="ppic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/student.svg" alt=""></div>
      <div class='ppic2'><img class="ppic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/reunion.svg" alt=""></div>
      <div class='ppic3'><img class="ppic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/certification.svg" alt=""></div>
      <div class='ppic4'><img class="ppic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/bank-account.svg" alt=""></div>
      <div class='ppic5'><img class="ppic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/teacher.svg" alt=""></div>
     
    </div>
  </div>
             </form>
            
            
            
            
            
        </section>
        <c:if test="${not empty errorMsgs}">
		<c:forEach var="message" items="${errorMsgs}">
			<input type="hidden" id="message" value="${message}">
		</c:forEach>
	
</c:if>
        
        
        
        
        
    </div>
<section>
<footer id="footer" >
        <section id="copyright" class="">
            <div >
                <div >
                    <div >
                        <div class="copyright-content">Xducation<p><a href="#">關於我們</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">其他服務</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="#">網站地圖</a></p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </footer>

</section>	



        


        


    <!-- JS -->
    <script type="text/javascript">
    ClassicEditor
    .create( document.querySelector( '#editor' ) )
    .catch( error => {
        console.error( error );
    } );
    
    
    
    
    
    
    
    var message = document.getElementById('message').value;
    if(message.length !== 0){
    	 swal('注意', message, 'warning');
    }
  
   
    
    
    
        function readURL(input){

        	  if(input.files && input.files[0]){

        	    var imageTagID = input.getAttribute("targetID");

        	    var reader = new FileReader();

        	    reader.onload = function (e) {

        	       var img = document.getElementById(imageTagID);

        	       img.setAttribute("src", e.target.result)

        	    }

        	    reader.readAsDataURL(input.files[0]);

        	  }

        	}
    </script>
    
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>