<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>


<%@ include file="/index/front-index/header.jsp" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Xducation - 老師檔案</title>

    <!-- Font Icon -->
    <link rel="stylesheet" href="fonts/material-icon/css/material-design-iconic-font.min.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
	
	<link rel="stylesheet" href="<%=request.getContextPath()%>/library/bootstrap/4.5.3/css/bootstrap.min.css">
	<script src="<%=request.getContextPath()%>/library/bootstrap/4.5.3/js/bootstrap.min.js"></script>
	
	<script	src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
	<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
	
    <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/style.css">
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/bootstrap.min.css"> --%>
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/nivo-lightbox.css"> --%>
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/animate.css"> --%>
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/main.css"> --%>
	<%-- <link rel="stylesheet" href="<%=request.getContextPath()%>/front-end/teacher/nav_css_ForTeacherRegister/css/responsive.css"> --%>
</head>

<style type="text/css">
body {
  font-family: 'Open Sans', sans-serif;
  font-weight: 300;
}
.tabs {
  max-width: 900px;
  margin: 0 auto;
  padding: 0 20px;
}
#tab-button {
  display: table;
  table-layout: fixed;
  width: 100%;
  margin: 0;
  padding: 0;
  list-style: none;
}
#tab-button li {
  display: table-cell;
  width: 20%;
}
#tab-button li a {
  display: block;
  padding: .5em;
  background: #eee;
  border: 1px solid #ddd;
  text-align: center;
  color: #000;
  text-decoration: none;
  font-family: 'Gochi Hand';
  font-size:25px;
}
#tab-button li:not(:first-child) a {
  border-left: none;
}
#tab-button li a:hover,
#tab-button .is-active a {
  border-bottom-color: transparent;
  background: #fff;
}
.tab-contents {
  padding: .5em 2em 1em;
  border: 1px solid #ddd;
}



.tab-button-outer {
  display: none;
}
.tab-contents {
  margin-top: 20px;
}
@media screen and (min-width: 640px) {
  .tab-button-outer {
    position: relative;
    z-index: 2;
    display: block;
  }
  .tab-select-outer {
    display: none;
  }
  .tab-contents {
    position: relative;
    top: -1px;
    margin-top: 0;
  }
}

.signup{
margin-bottom: 50px;;
}

div#fti{
width:300px;
height:100px;
margin:0px;
padding:5px 75px;

}


img.fti{
        width: 36px;
        height: 36px;
        margin:0px 7px;
    }
   
    #pic{
        width: 53px;
        height: 53px;

    }
    img.pic{
        width: 36px;
        height: 36px;
    }
    h2.form-title{
        width: 400px;
    }
    div.signup-form{
       width: 400px;
       margin-right:5px; 
    }
    h5.h5{
        color: black;
    }
   
    
    input#name{
    width:230px;}
    label#cert{
    width:250px;
    
    }
    figure.license{
   width:100px;
   height:100px;
   margin:0px;
    }
    img.pimg{
   width:150px;
   height:150px;
   cursor:pointer;
    }
    img#mprofile{
    width:300px;
   height:300px;
  border-radius: 50%;
   
    }
    h3#mname{
    width:300px;
    text-align:center;
    }
  div.signup-image{
   width:300px;
   height:400px;
   margin-top:1px;
   margin-bottom:50px;
   
   
  }
  div.signup-form{
   height:400px;
   margin:30px 0px;
  }
  div.signup-content{
  padding:0px;
  }
  div#mpic{
  margin-top:20px;
  }
  section#copyright{
  margin-top:0px;
 
  }
  img#bankpic{
  width:110px;
  height:20px;
  }
  div.main{
  padding:150px 0 0 0 ;
  	background: url("<%=request.getContextPath()%>/front-end/members/assets/img/bgPic.png");}
    
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
            <div class="container">
                
 <div class="tabs">
  <div class="tab-button-outer">
    <ul id="tab-button">
      <li><a href="#tab01">Profile</a></li>
      <li><a href="#tab02">About me</a></li>
      <li><a href="#tab03">Course</a></li>
      <li><a href="#tab04">Test</a></li>
      <li><a href="#tab05">?</a></li>
    </ul>
  </div>
  <div class="tab-select-outer">
    表示選択：
    <select id="tab-select">
      <option value="#tab01">Tab 1</option>
      <option value="#tab02">Tab 2</option>
      <option value="#tab03">Tab 3</option>
      <option value="#tab04">Tab 4</option>
      <option value="#tab05">Tab 5</option>
    </select>
  </div>

  <div id="tab01" class="tab-contents">
   <h2  class="form-title">${loginMembersVO.memname}<img class="pic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/teacher.svg"></h2>
                        
    <div class="signup-content">
                
                       
                    <div class="signup-form">
                    
                            <div class="form-group">
                                <h5 class="h5">銀行帳號<img class="pic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/bank-account.svg"></h5>
                                <table>
                                <th><p>${loginTeacherVO.bankacc}</p></th>
                                <th> <div id="bankdisplay"></div></th>
                                </table>
                                
                                <input type="hidden" id="bankvalue"  value="${loginTeacherVO.bankacc}">
                            </div>
                            <div class="form-group">
                                <h5 class="h5">你的專業證照<img class="pic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/certification.svg"></h5>
                                <p>點選可放大檢視</p>
                                <table id="license">
                                <th><img  class="pimg" src="<%=request.getContextPath()%>/front-end/teacher/TchrcertDisplayServlet1?TCHRNO=${loginTeacherVO.tchrno}" ></th>
                                <th><img  class="pimg" src="<%=request.getContextPath()%>/front-end/teacher/TchrcertDisplayServlet2?TCHRNO=${loginTeacherVO.tchrno}" ></th>
                                <div id="outerdiv" style="position:fixed;top:0;left:0;background:rgba(0,0,0,0.7);z-index:2;width:100%;height:100%;display:none;">
    <div id="innerdiv" style="position:absolute;">
        <img id="bigimg" style="border:5px solid #fff;" src="" />
    </div>
</div>
                                </table>
                            </div>
                             <div class="form-group" id="form-group">
                              
                               </div>
                               <div class="form-group" id="form-group">
                               </div>
                            <div class="form-group">
                               <p></p>
                               
                            </div>
                          
                            <div class="form-group">
                           
                            
                            </div>
                          
                       
                    </div>
                    
                   
                    
                    <div class="signup-image">
                    <div id="mpic"><img id='mprofile' src="<%=request.getContextPath()%>/front-end/members/MprofileDisplayServlet?MEMNO=${loginMembersVO.memno}" alt="sing up image">
                   </div>
                   <div id="fti"><img class="fti" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/facebook.svg"><img class="fti" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/twitter.svg"><img class="fti" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/instagram.svg">
             </div>
                  
               
                   
                     
                               
                    </div>
                   

                </div>
  </div>
  <div id="tab02" class="tab-contents">
    <h2 >關於我<img class="pic" src="<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/reunion.svg"></h2>
       <p>${loginTeacherVO.tchrintro}</p>                      
    
  </div>
  <div id="tab03" class="tab-contents">
    	<h2>我所開設的課程</h2>    
    	
	<%@ include file="/front-end/course/listTeacherCourseInclude.file"%>
	<a href="<%=request.getContextPath()%>/front-end/course/addCourse.jsp">
    		<button type="button" class="btn btn-block btn-lg btn-info h4">
    			新增課程
    		</button>
    	</a>
	<%-- <jsp:include page="/front-end/course/listTeacherCourseInclude.jsp" /> --%>
  </div>
  
</div>
            </div>
           
 
           
        </section>
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


    </div>

    <!-- JS -->
    <script type="text/javascript">
    var bankvalue = document.getElementById('bankvalue').value;
   switch(bankvalue.substring(0,3)) {
   
   case "013":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/CUbank.png'>";
       break;
   case "021":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/citi_bank.png'>";
       break;
   case "822":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/CTBC_Bank.png'>";
       break;
   case "081":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/hsbcBank.png'>";
       break;
   case "012":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/fubonBank.png'>";
       break;
   case "008":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/huananBank.png'>";
       break;
   case "004":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/taiwanBank.png'>";
       break;
   case "007":
	   document.getElementById('bankdisplay').innerHTML="<img id='bankpic' src='<%=request.getContextPath()%>/front-end/teacher/teacherRegister_css/images/firstBank.png'>";
       break;
   
   
   
   }
    
    
    
   
    
    
    
    
    
    
    
    $(function() {
    	  var $tabButtonItem = $('#tab-button li'),
    	      $tabSelect = $('#tab-select'),
    	      $tabContents = $('.tab-contents'),
    	      activeClass = 'is-active';

    	  $tabButtonItem.first().addClass(activeClass);
    	  $tabContents.not(':first').hide();

    	  $tabButtonItem.find('a').on('click', function(e) {
    	    var target = $(this).attr('href');

    	    $tabButtonItem.removeClass(activeClass);
    	    $(this).parent().addClass(activeClass);
    	    $tabSelect.val(target);
    	    $tabContents.hide();
    	    $(target).show();
    	    e.preventDefault();
    	  });

    	  $tabSelect.on('change', function() {
    	    var target = $(this).val(),
    	        targetSelectNum = $(this).prop('selectedIndex');

    	    $tabButtonItem.removeClass(activeClass);
    	    $tabButtonItem.eq(targetSelectNum).addClass(activeClass);
    	    $tabContents.hide();
    	    $(target).show();
    	  });
    	});
  
   
    
    
    
    $(function(){  
        $(".pimg").click(function(){  
            var _this = $(this);//將當前的pimg元素作為_this傳入函式  
            imgShow("#outerdiv", "#innerdiv", "#bigimg", _this);  
        });  
    });  

    function imgShow(outerdiv, innerdiv, bigimg, _this){  
        var src = _this.attr("src");//獲取當前點選的pimg元素中的src屬性  
        $(bigimg).attr("src", src);//設定#bigimg元素的src屬性  
      
            /*獲取當前點選圖片的真實大小，並顯示彈出層及大圖*/  
        $("<img/>").attr("src", src).load(function(){  
            var windowW = $(window).width();//獲取當前視窗寬度  
            var windowH = $(window).height();//獲取當前視窗高度  
            var realWidth = this.width;//獲取圖片真實寬度  
            var realHeight = this.height;//獲取圖片真實高度  
            var imgWidth, imgHeight;  
            var scale = 0.8;//縮放尺寸，當圖片真實寬度和高度大於視窗寬度和高度時進行縮放  
              
            if(realHeight>windowH*scale) {//判斷圖片高度  
                imgHeight = windowH*scale;//如大於視窗高度，圖片高度進行縮放  
                imgWidth = imgHeight/realHeight*realWidth;//等比例縮放寬度  
                if(imgWidth>windowW*scale) {//如寬度扔大於視窗寬度  
                    imgWidth = windowW*scale;//再對寬度進行縮放  
                }  
            } else if(realWidth>windowW*scale) {//如圖片高度合適，判斷圖片寬度  
                imgWidth = windowW*scale;//如大於視窗寬度，圖片寬度進行縮放  
                            imgHeight = imgWidth/realWidth*realHeight;//等比例縮放高度  
            } else {//如果圖片真實高度和寬度都符合要求，高寬不變  
                imgWidth = realWidth;  
                imgHeight = realHeight;  
            }  
                    $(bigimg).css("width",imgWidth);//以最終的寬度對圖片縮放  
              
            var w = (windowW-imgWidth)/2;//計算圖片與視窗左邊距  
            var h = (windowH-imgHeight)/2;//計算圖片與視窗上邊距  
            $(innerdiv).css({"top":h, "left":w});//設定#innerdiv的top和left屬性  
            $(outerdiv).fadeIn("fast");//淡入顯示#outerdiv及.pimg  
        });  
          
        $(outerdiv).click(function(){//再次點選淡出消失彈出層  
            $(this).fadeOut("fast");  
        });  
    }  
        
        
        
        
        
        
        
        
        
        
    </script>
    
</body><!-- This templates was made by Colorlib (https://colorlib.com) -->
</html>