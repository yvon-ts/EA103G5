<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>



    
<!DOCTYPE html>
<html>

<head>
<title>Xducation-會員驗證</title>
<script src="https://cdn.jsdelivr.net/npm/animejs@3.0.1/lib/anime.min.js" type="text/javascript"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>

</head>
<style type="text/css" media="screen">
	 html, body { 
 	margin:0; 
 	padding:0;
	overflow: hidden;
}

.wrapper-2
{
	height: 100%;
	width:100%;
}
.container {
    position: absolute;
    left: 50%;
    transform: translate(-50%);
    width: 100%;
    height: 100%;
}

 svg {
 	  transform:  scale(0.75) translateY(-17%); 
 }


.girl-head
{
    transform-origin: 70% 88%;
    animation: head 5s infinite;
}

@keyframes head {
	0% { transform: rotate(0deg); }
	50% { transform: rotate(2deg) }
	100% { transform: rotate(0deg); }
}


@keyframes hand {
	0% { transform: rotate(0deg); }
	50% { transform: rotate(5deg) }
	100% { transform: rotate(0deg); }
}

#saturn
{
	transform-origin: 46% 29%;
	/*transform: rotate(25deg);*/
	animation: saturn 5s infinite;
}
#jupiter
{
    transform-origin: 42% 43%;
	/*transform: rotate(25deg);*/
	animation: planet 5s linear infinite;
}
#mars
{
    transform-origin: 52% 10%;
	/*transform: rotate(25deg);*/
	animation: planet 5s linear infinite;
}
#earth
{
    transform-origin: 56.5% 60%;;
	/*transform: rotate(25deg);*/
	animation: planet 5s linear infinite;
}
#venus
{
	transform-origin: 28% 14%;
	/*transform: rotate(25deg);*/
	animation: planet 5s linear infinite;
}
#mercury
{
	transform-origin: 55% 40%;
	/*transform: rotate(25deg);*/
	animation: planet 5s linear infinite;
}

.meteor
{
transform: translate(200px,-200px);
}

.meteor:nth-child(2)
{
	animation: meteor 2s linear infinite;
	animation-: 5s;
}
.meteor:nth-child(4)
{
	animation: meteor 3s linear infinite;
    animation-delay: 2s;
}
.meteor:nth-child(6)
{
	animation: meteor 3s linear infinite;
}

.stars:nth-child(1)
{
	animation: stars 2s ease-in-out  infinite;
}
.stars:nth-child(2)
{
	animation: stars 3s ease-in-out  infinite;	
}
.stars:nth-child(3)
{
	animation: stars 5s ease-in-out  infinite;
}
.stars:nth-child(4)
{
	opacity: 0.4;
	animation: stars 3s ease-in-out  infinite;
	animation-delay: 2s;
}
.stars:nth-child(5)
{
	opacity: 0.4;
	animation: stars 3s ease-in-out  infinite;
	animation-delay: 1s;
}
.stars:nth-child(6)
{
	animation: stars 3s ease-in-out  infinite;
}


/* PLanets animation*/ 
@keyframes saturn {
	0% { transform: rotate(40deg) }
	50% { transform: rotate(-15deg) }
	100% { transform: rotate(40deg) }
}

@keyframes planet {
	to { transform: rotate(360deg) }
}

@keyframes meteor {
	0% { transform: translate(200px,-200px); }
	100% { transform: translate(-300px,300px);}
}

@keyframes stars {
	0% { opacity: 0.4; }
	50% { opacity: 1; }
	100% { opacity:0.4; }
}

@-webkit-keyframes fade-in-out{
  0%{
    opacity: 1;
  }
  50%{
    opacity: 0;
  }
  100%{
    oapcity: 1;
  }
}

@-moz-keyframes fade-in-out{
  0%{
    opacity: 1;
  }
  50%{
    opacity: 0;
  }
  100%{
    oapcity: 1;
  }
}

@-o-keyframes fade-in-out{
  0%{
    opacity: 1;
  }
  50%{
    opacity: 0;
  }
  100%{
    oapcity: 1;
  }
}

@keyframes fade-in-out{
  0%{
    opacity: 1;
  }
  50%{
    opacity: 0;
  }
  100%{
    oapcity: 1;
  }
}








.logo{
width: 150px;
height: 150px;
position: absolute;
z-index: 1;
transform-origin: 46% 29%;
	/*transform: rotate(25deg);*/
	/* animation: saturn 5s infinite; */
	margin-top: 35px;
	margin-left: 530px;
	-webkit-animation: fade-in-out 2.5s infinite; 
  -moz-animation: fade-in-out 2.5s infinite; 
  -o-animation: fade-in-out 2.5s infinite; 
  animation: fade-in-out 2.5s infinite;
}
.woman{
	width:300px;
height: 300px;
position: absolute;
z-index: 2;
transform-origin: 70% 88%;
    animation: hand 2s infinite;
    animation-delay: 1s;
    margin-top: 550px;
	margin-left: 840px;


}

.wave2{
	width: 100%	;
height: 400px;
position: absolute;
z-index: 0;
 margin-top:550px;
 margin-left: 0;
 

}
.title{
	width: 600px;
height: 400px;
position: absolute;
z-index: 0;
 margin-top:350px;
 margin-left: 0;
 

}

.rocket{
	width: 70px;
height: 70px;
position: absolute;
z-index: 2;
 margin-top:225px;
 margin-left: 716.5px;
 -webkit-animation-name: spaceboots;
  -webkit-animation-duration: 0.8s;
  -webkit-transform-origin: 50% 50%;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-timing-function: linear;


}


/* @keyframes rocket {
	from {top: 100%; left: -25%;}
	to {top: 0%; left: 100%; transform: rotate(05deg);}
}
.rocket{
  background-image: url(https://i.imgur.com/UWv4YWj.png);
  background-size: contain;
  background-repeat: no-repeat;
  height: 40vh;
  width: 40vh;
  position: absolute;
  left: 5%;
  animation: rocket 5s linear infinite;
  z-index: 5
} */







.roket-container {
	width: 220px; height: 380px;
	position: absolute;
	left: 0; top: 0; right: 0; bottom: 0; 
	margin: auto;
	animation: vibration 0.2s infinite;
	z-index: 1; 
	margin-left: 701px;
	margin-top: 82px;

}
@keyframes vibration {
	0%   {transform: translate(0,0) rotate(319deg);}
	50%  {transform: translate(1px,-1px) rotate(319deg); }
	100% {transform: translate(0,0) rotate(319deg);}
}

/* .capsule { 
	width: 111px; height: 154px;
	position: absolute; 
	left: 46px; top: 5px;
	overflow: hidden;
}
.capsule .top {
	position: absolute;
	left: 0; width: 0; height: 0; padding: 0;
	border-bottom: 62px solid #f3f3f3;
	border-left: 56px solid transparent;
	border-right: 56px solid transparent;
}
.capsule .top:after {
	content:'';
	position: absolute; left: 25px; top: -14px;
	width: 0; height: 0;
	/* border-bottom: 84px solid #1d1d1d; */
	/* border-left: 0px solid transparent;
	border-right: 156px solid transparent;
	transform: skew(42deg); */
/* } */
.capsule .top .shadow {
	position: absolute;
	width: 0; height: 0;
	/* border-bottom: 90px solid #e0e0e0; */
	border-left: 20px solid transparent;
	border-right: 80px solid transparent;
	transform: skew(25deg);
}

/* .capsule .base {
	position: absolute; left: 0; top: 62px;
	z-index: 110;
	width: 112px; height: 99px;
	background: linear-gradient(to right, #f3f3f3 63%, #e0e0e0 63%);
} */
/* .wing-left {
	position: absolute; 
	left:15px; top: 77px;
	width: -6px; height: 80px; padding: 0;
	border-right: 38px solid #743388;
	border-bottom: 19px solid transparent;
	border-top: 21px solid transparent;
	transform: rotate(-2deg);
}
.wing-left:after {
	content:'';
	position: absolute; bottom: -50px;
	width: 0; height: 0;
	border-top: 20px solid transparent;
	border-right: 50px solid #1d1d1d;
	border-bottom: 50px solid transparent;
}
 */
/* .wing-right {
	position: absolute;
	top: 67px; right: 30px;
	height: 97px; width: 0; padding: 0;
	border-right: 40px solid #743388;
	border-bottom: 15px solid transparent;
	border-top: 0 solid transparent;
} 
/* */ /* .wing-right:after {
	content:'';
	position: absolute; 
	top: -25px; left: -50px;
	width: 101px; height: 0;
	border-top: 23px solid transparent;
	border-right: 68px solid #1d1d1d;
	border-bottom: 45px solid transparent;
} */ 
/* .tail { 
	position: absolute; 
	width: 101px; height: 0; z-index: 100;
	top: 153px; left: 51px;
	border-top: 23px solid #743388;
	border-right: 8px solid transparent;
	border-left: 9px solid transparent;
}
.window-big {
	width: 70px; height: 70px;
	background-color: #743388;
	border-radius: 50%;
	position: absolute;
	top: 57px; left: 66px;
	z-index: 120;
}
.window-small {
	width: 44px; height: 44px;
	background: #272425 url(); 
	background-size: 100%;
	position: absolute;
	left: 79px; top: 70px;
	z-index: 130;
	border-radius: 50%;
} */
.fire-1 { 
	position: absolute; 
	left: 64px; top: 169px; z-index: 90;
	width: 25px; height: 25px;
	background: linear-gradient(135deg, #ef8832 50%, #e82134 50%);
	transform: rotate(-40deg) skew(1deg, -11deg);
	animation: main_fire 0.1s ease-in infinite;
}
@keyframes main_fire {
	0%   {transform: translate(0, 5px) scale(1.1,1) rotate(-33deg) skew(0deg, -30deg);}
	100% {transform: translate(0, 0) scale(1.1,2) rotate(-33deg) skew(0deg, -30deg);}
}
.fire-2 {
	position: absolute; z-index: 90;
	left: 63px; top: 230px;
	width: 13px; height: 13px;
	background: linear-gradient(135deg, #ef8832 50%, #e82134 50%);
	transform: rotate(-33deg) skew(0deg, -30deg);
	animation: fire2 0.3s ease-in infinite;
}
@keyframes fire2 {
	0%   {transform: translate(0, -10px) scale(1) rotate(-33deg) skew(0deg, -30deg); opacity:1; }
	100% {transform: translate(0, 50px) scale(0.7) rotate(-33deg) skew(0deg, -30deg); opacity:0;}
}

.fire-3 {
	position: absolute; z-index: 90;
	left: 53px; top: 196px;
	width: 12px; height: 12px;
	background: linear-gradient(135deg, #ef8832 50%, #e82134 50%);
	transform: rotate(-33deg) skew(0deg, -30deg);
	animation: fire2 0.3s ease-in infinite 0.1s;
}

.fire-4 {
	position: absolute; z-index: 90;
	left: 126px; top: 200px;
	width: 12px; height: 12px;
	background: linear-gradient(135deg, #ef8832 50%, #e82134 50%);
	transform: rotate(-33deg) skew(0deg, -30deg);
	animation: fire2 0.3s ease-in infinite 0.2s;
}

.spark-1 {
	position: absolute;
	left: 40px; bottom: 77px;
	width: 8px; height: 8px;
	background-color: #e82134;
	animation: spark-fire 0.24s infinite;
}

.spark-2 {
	position: absolute;
	left: 132px; bottom: 68px;
	width: 6px; height: 6px;
	background-color: #e82134;
	animation: spark-fire 0.24s infinite;
}

.spark-3 {
	position: absolute;
	left: 109px; bottom: 80px;
	width: 6px; height: 6px;
	background-color: #e82134;
	animation: spark-fire 0.24s infinite 0.2s;
}

.spark-4 {
	position: absolute;
	left: 83px; bottom: 20px;
	width: 6px; height: 6px;
	background-color: #e82134;
	animation: spark-fire 0.24s infinite 0.14s;
}

@keyframes spark-fire {
	0%   {transform: translate(0, -10px); opacity:1;}
	100% {transform: translate(0, 50px); opacity:0;}
}

.star { 
	position: absolute; z-index: 50;
	width: 4px; height: 4px;
	border-radius: 50%;
	background: linear-gradient(135deg, #fc97e9 20%, #fafc9f 80%, #bdf4f9 100%) fixed;
	animation: space 0.4s infinite;
}
.star-1  {left: 50px; top: -10px; animation-delay: 0.5s; }
.star-2  {left: 60px; top: 10px; animation-delay: 0.34s; }
.star-3  {left: 70px; top: 100px; animation-delay: 0.1s; }
.star-4  {left: 30px; top: 230px; animation-delay: 0.23s; }
.star-5  {left: 70px; top: 160px; animation-delay: 0.14s; }
.star-6  {left: 80px; top: 190px; animation-delay: 0.23s; }
.star-7  {left: 40px; top: 200px; animation-delay: 0.53s; }
.star-8  {left: 120px; top: 210px; animation-delay: 0.3s; }
.star-9  {left: 150px; top: 30px; animation-delay: 0.2s; }
.star-10 {left: 150px; top: 70px; animation-delay: 0.27s; }
.star-11 {left: 120px; top: 90px; animation-delay: 0.23s; }
.star-12 {left: 10px; top: 10px; animation-delay: 0.1s; }
.star-13 {left: 70px; top: 200px; animation-delay: 0.22s; }
.star-14 {left: 90px; top: 300px; animation-delay: 0.1s; }
.star-15 {left: 160px; top: 80px; animation-delay: 0.3s; }
.star-16 {left: 200px; top: 30px; animation-delay: 0.26s; }
.star-17 {left: 40px; top: 40px; animation-delay: 0.34s; }
.star-18 {left: 10px; top: 80px; animation-delay: 0.2s; }
.star-19 {left: 78px; top: 40px; animation-delay: 0.45s; }
.star-20 {left: 96px; top: 50px; animation-delay: 0.73s; }


@keyframes space {
	0%   {transform: translate(0, -100px) scale(1,0); opacity:1;}
	100% {transform: translate(0, 100px) scale(1,1); opacity:0;}
}
@-webkit-keyframes spaceboots {
  0% {
    -webkit-transform: translate(2px, 1px) rotate(0deg);
  }
  10% {
    -webkit-transform: translate(-1px, -2px) rotate(-1deg);
  }
  20% {
    -webkit-transform: translate(-3px, 0px) rotate(1deg);
  }
  30% {
    -webkit-transform: translate(0px, 2px) rotate(0deg);
  }
  40% {
    -webkit-transform: translate(1px, -1px) rotate(1deg);
  }
  50% {
    -webkit-transform: translate(-1px, 2px) rotate(-1deg);
  }
  60% {
    -webkit-transform: translate(-3px, 1px) rotate(0deg);
  }
  70% {
    -webkit-transform: translate(2px, 1px) rotate(-1deg);
  }
  80% {
    -webkit-transform: translate(-1px, -1px) rotate(1deg);
  }
  90% {
    -webkit-transform: translate(2px, 2px) rotate(0deg);
  }
  100% {
    -webkit-transform: translate(1px, -2px) rotate(-1deg);
  }
}

.bg{
/* position: absolute;
  z-index: 3;
  
  width: 100%;
  height: 100%;
 
  border-radius: 30px;
  padding:10px 10px 0px 10px;
  background: rgba(57, 63, 84, 0.3);
  text-align: center;
   
  margin-left:0px;
  margin-top: 0px;  */


}



.code{
border-style: none;
background: transparent;
outline: none;
text-align: center;
width: 100%;
height: 50px;
}

.main{
position: absolute;
  z-index: 3;
  
  width: 450px;
  
 
  border-radius: 30px;
  padding:10px 10px 0px 10px;
  background: rgba(57, 63, 84, 0.8);
  text-align: center;
  height: 200px; 
  margin-left:950px;
  margin-top: 300px; 

  




}


.webflow-style-input {
  position: absolute;
  z-index: 11;
  display: -webkit-box;
  display: flex;
  -webkit-box-orient: horizontal;
  -webkit-box-direction: normal;
          flex-direction: row;
  width: 200px;
  max-width: 400px;
  margin-top:385px;
  margin-left:1080px; 
  border-radius: 5px;
  padding:10px 10px 0px 10px;
  background: rgba(57, 63, 84, 0.8);
  text-align: center;
  height: 40px; 
  border-radius: 20px ;


}
/* .webflow-style-input:after {
  border-radius: 5px;
  content: "";
  position: absolute;
  left: 0px;
  right: 0px;
  bottom: 0px;
  z-index: 999;
  height: 1px;
  border-bottom-left-radius: 2px;
  border-bottom-right-radius: 2px;
  background-position: 0% 0%;
  background: -webkit-gradient(linear, left top, right top, from(#B294FF), color-stop(#57E6E6), color-stop(#FEFFB8), color-stop(#57E6E6), color-stop(#B294FF), to(#57E6E6));
  background: linear-gradient(to right, #B294FF, #57E6E6, #FEFFB8, #57E6E6, #B294FF, #57E6E6);
  background-size: 500% auto;
  -webkit-animation: gradient 3s linear infinite;
          animation: gradient 3s linear infinite;
} */

.webflow-style-input input {
  
  color: #BFD2FF;
  font-size: 20px;
  line-height:10px;
  height: 20px; 
 
}
.webflow-style-input input::-webkit-input-placeholder {
  color: #7881A1;
}



input.submit{
cursor: pointer;
width: 100px;
height: 40px;
position: absolute;
z-index: 2;
background: rgba(57, 63, 84, 0.8);
color: #D0D0D0;

border-radius:20px;
border: 2px  rgba(57, 63, 84, 0.8);;
margin-left:1140px ;
margin-top: 450px;
 

}
div.submitouter{
width: 100%;
height: 200px;
/* background:red;  */
position: absolute;
z-index: 10;

}




















       
</style>



<body>
	
 <div class="wrapper-2">

  <div class="container">


<div class="roket-container">
  <div class="wing-left"></div>
  <div class="wing-right"></div>
  <div class="tail"></div>
	<div class="capsule">
		<div class="top">
			<div class="shadow"></div>
		</div>
		<div class="base"></div>
	</div>
	<div class="window-big"></div>
	<div class="window-small"></div>
  
  <div class="fire-1"></div>
  <div class="fire-2"></div>
  <div class="fire-3"></div>
  <div class="fire-4"></div>
  
  <div class="spark-1"></div>
  <div class="spark-2"></div>
  <div class="spark-3"></div>
  <div class="spark-4"></div>
  <div class="star star-1"></div>
  <div class="star star-2"></div>
  <div class="star star-3"></div>
  <div class="star star-4"></div>
  <div class="star star-5"></div>
  <div class="star star-6"></div>
  <div class="star star-7"></div>
  <div class="star star-8"></div>
  <div class="star star-9"></div>
  <div class="star star-10"></div>
  <div class="star star-11"></div>
  <div class="star star-12"></div>
  <div class="star star-13"></div>
  <div class="star star-14"></div>
  <div class="star star-15"></div>
  <div class="star star-16"></div>
  <div class="star star-17"></div>
  <div class="star star-18"></div>
  <div class="star star-19"></div>
  <div class="star star-20"></div>
</div>



<div class="main">
  <p style="color:#8E8E8E;font-family:'Gochi Hand'; ">完成驗證後我們將會為您開啟帳號<br>就可以開始您的線上學習之旅!
      <c:if test="${not empty errorMsgs}">
    
        <c:forEach var="message" items="${errorMsgs}">
            <input id="messages" type="hidden"  value="${message}">
        </c:forEach>
   
</c:if></p>

     
  </div>
<form method="POST" class="register-form" ACTION="<%=request.getContextPath()%>/members/members.do" id="register-form">
 <div class="webflow-style-input">

    <input class="code" maxlength="6" name="clientVerCode"  type="text" placeholder="輸入驗證碼">
    <input id="count" type="hidden"  value="${count}">
    <input id="inform" type="hidden"  value="${inform}">
  
  </div>
  <div class="submitouter">
   
   <input type="hidden" name="action" value="verify">
   <input  class="submit" type="submit" name="" value="提交">
  </div>
</form>


<div class="bg"></div>











  	<!-- <div class="rocket"></div> -->
  	<img class="rocket" src="<%=request.getContextPath()%>/front-end/members/assets/img/rocket.png" alt="">
  	
  	<img class="logo" src="<%=request.getContextPath()%>/front-end/members/assets/img/logo.svg" alt="">
  	<img class="woman"  src="<%=request.getContextPath()%>/front-end/members/assets/img/head/intro.png" alt="">
  	
  	<img class="wave2" src="<%=request.getContextPath()%>/front-end/members/assets/img/bigWave.png" alt="">
  	
    <img class="title" src="<%=request.getContextPath()%>/front-end/members/assets/img/title.png" alt="">

	<svg width="1366px" height="768px">
	<!-- <g id="Girl">
	<g>
		<path style="opacity: 1;" fill="#E8E8E8" d="M1043.21,748.195c8.565,6.429-10.495,14.336-36.66,14.588c-26.167-0.252-45.226-8.16-36.66-14.588
			c3.778-3.393,12.168-6.604,18.982-9.109c7.115-2.48,12.655-4.254,17.678-4.224c5.021-0.03,10.562,1.743,17.677,4.224
			C1031.041,741.591,1039.431,744.803,1043.21,748.195z"/>
	</g>
	<g>
		<g>
			<path fill="#FFA58C" d="M1017.721,717.142c0,0-0.378-0.289-1.066-0.811c-6.583-4.997-41.484-31.364-44.516-31.364
				c-3.35,0-13.739,6.367-10.39,13.07c3.351,6.705,24.132,27.15,42.565,36.869c18.435,9.72,15.417-13.406,15.417-13.406"/>
			<path fill="#FE4371" d="M987.893,657.149c0,0,38.08,5.323,55.302,35.525c21.785,38.208-13.881,53.111-31.842,38.208
				c-15.752-13.07-10.054-25.138-10.054-25.138s-27.169-11.01-25.472-23.46C976.689,675.96,984.54,677.258,987.893,657.149z"/>
			<path fill="#EA8D7C" d="M1008.674,718.148c0,0-27.451-18.847-28.153-15.765c-0.653,2.863,25.28,23.473,25.28,23.473
				L1008.674,718.148z"/>
			<path fill="#191919" d="M1029.787,733.74l-26.142-15.045l-11.396,7.248c0,0,6.45,5.053,5.866,9.241
				c-0.569,4.071-12.83,9.815-11.062,14.815h42.732C1031.924,741,1029.787,733.74,1029.787,733.74z"/>
			<path fill="#544A61" d="M1027.775,733.74l-26.141-15.045l-11.396,7.248c0,0,6.45,5.053,5.866,9.241
				c-0.569,4.071-12.83,9.815-11.062,14.815h42.731C1029.913,741,1027.775,733.74,1027.775,733.74z"/>
			<path fill="#DA2952" d="M1043.194,692.675c0,0,1.339,10.055-23.127,14.411c-10.987,1.959-18.769-1.341-18.769-1.341
				s-2.567,5.437,0.509,12.966c1.506,3.687,6.715,5.528,11.895,9.825c4.843,4.021,8.631,8.22,14.577,8.028
				C1044.376,736.05,1059.101,720.574,1043.194,692.675z"/>
		</g>
		<g class="girl-hand" >
			<path fill="#FFA58C" d="M957.644,692.591l-22.874,33.935c0,0-5.244,4.787,1.423,15.922c1.593,2.658,3.06,3.724,2.359,0.825
				c0,0-0.461-2.168-0.265-4.43c0.135-1.513-0.133-4.709,1.509-4.903c1.427-0.166,1.956,6.753,2.514,5.908
				c3.897-5.908,1.679-12.341,3.142-16.465c1.839-5.173,15.209-15.962,15.209-15.962L957.644,692.591z"/>
			<path fill="#161616" d="M919.214,717.184c-0.562-0.615-0.521-1.569,0.093-2.131l0.741-0.68c0.615-0.562,1.569-0.521,2.131,0.096
				l25.129,27.431c0.562,0.616,0.521,1.57-0.094,2.131l-0.741,0.68c-0.614,0.562-1.569,0.521-2.131-0.093"/>
			<path fill="#FFA58C" d="M939.796,733.698c2.011,1.563,1.956,6.994,2.514,6.149c3.897-5.908,1.679-12.341,3.142-16.465
				L939.796,733.698z"/>
		</g>
		<g class="girl-head">
			<path fill="#292131" d="M965.436,693.011c0,0,21.736-3.299,23.63-36.867c0.208-3.686-9.301-33.182-24.409-19.44
				c0,0-14.342-7.708-22.385,8.38c-8.045,16.088-4.658,13.702,0.02,37.364c3.016,15.255-0.993,25.646-0.993,25.646l10.392-15.082
				c0,0,1.051,17.283,1.514,22.955c0.409,5.012,4.785,11.958,4.858,17.093c0.06,4.132-1.674,19.275-1.674,19.275
				s6.374-12.521,6.861-14.751c2.048-9.37,1.518-27.815,1.518-27.815L965.436,693.011z"/>
			<path fill="#020002" d="M971.383,633.154c0,0,7.208,10.923,6.622,22.987c-1.013,20.863-17.85,21.869-19.859,44.492
				c-1.826,20.563,3.038,20.739,2.949,27.902c-0.052,4.132-4.707,23.798-4.707,23.798s6.374-12.521,6.861-14.751
				c2.048-9.37,1.518-27.815,1.518-27.815l0.669-16.757c0,0,21.736-3.299,23.63-36.867
				C989.239,653.04,982.527,631.638,971.383,633.154z"/>
		</g>
	</g>
</g> -->
<g id="Dream">

	<g>
		
		<path id="start-dream" fill="#2A2339" d="	M954.451,624.813c0,0-47.1-40.059-26.451-81.813c60-121.333-48.419-133.411-18.421-226.406C938.851,225.85,923.998,207.667,864,145C796.324,74.313,888.415,0,888.415,0h-700.67c0,0,110.832,16.95,111.365,165.102c0.225,62.564,70.529,118.74,119.429,131.838c69.219,18.541,130.041,47.962,151.067,114.149c20.49,64.497,90.323,97.511,158.482,92.996c46.579-3.085,103.872,3.252,128.993,56.997C872,593,954.451,624.813,954.451,624.813z"/>

	</g>

	<g id="Stars">
		<g class="stars">
			<g>
				<circle fill="#FFFFFF" stroke-miterlimit="10" cx="664.833" cy="95.499" r="3.003"/>
				<circle fill="#FFFFFF" stroke-miterlimit="10" cx="664.837" cy="221.506" r="4.599"/>
				<circle fill="#FFFFFF" stroke-miterlimit="10" cx="372.756" cy="102.132" r="3.003"/>
			</g>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="785.781" cy="55.146" r="3.004"/>
		</g>
		<g class="stars">
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="748.531" cy="227.972" r="4.599"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="741.327" cy="34.647" r="3.003"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="346.773" cy="142.208" r="2.628"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="628.86" cy="348.52" r="3.004"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="822.531" cy="459.972" r="4.599"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="867.531" cy="570.972" r="4.599"/>
		</g>
		<g class="stars">
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="492" cy="99" r="4.375"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="520" cy="171" r="7.656"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="721.555" cy="336.51" r="2.628"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="689.837" cy="417.506" r="4.599"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="750.555" cy="81.51" r="2.628"/>
		</g>
		<g class="stars">
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="392" cy="212" r="5"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="542" cy="33" r="7.656"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="630.3" cy="301.626" r="3.003"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="802.781" cy="365.146" r="3.004"/>
		</g>
		<g class="stars">
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="293" cy="71" r="5"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="520" cy="354" r="7.656"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="508.86" cy="266.52" r="3.004"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="867.531" cy="222.972" r="4.599"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="889.531" cy="293.972" r="4.599"/>
			<circle fill="#FFFFFF" stroke-miterlimit="10" cx="893.781" cy="502.146" r="3.004"/>
		</g>
	</g>
	<!-- <g id="Planets">
		<g id="mercury">
			<g>
				<path fill="#EDEDED" d="M754.171,331.667c-11.122,0-20.171-9.049-20.171-20.171c0-11.123,9.049-20.171,20.171-20.171
					c11.123,0,20.171,9.049,20.171,20.171C774.342,322.618,765.294,331.667,754.171,331.667z"/>
				<circle fill="#D0D0D8" cx="754.171" cy="311.496" r="18.558"/>
				<circle fill="#AAAAB2" cx="743.48" cy="304.402" r="1.916"/>
				<circle fill="#AAAAB2" cx="747.389" cy="320.715" r="1.286"/>
				<circle fill="#AAAAB2" cx="740.345" cy="315.808" r="0.899"/>
				<circle fill="#AAAAB2" cx="763.854" cy="302.587" r="2.118"/>
				<circle fill="#AAAAB2" cx="755.163" cy="301.158" r="1.496"/>
				<circle fill="#AAAAB2" cx="756.289" cy="314.084" r="0.403"/>
				<circle fill="#AAAAB2" cx="763.904" cy="314.74" r="1.16"/>
				<circle fill="#AAAAB2" cx="754.928" cy="326.137" r="2.37"/>
				<circle fill="#AAAAB2" cx="750.086" cy="307.68" r="0.353"/>
				<circle fill="#AAAAB2" cx="752.486" cy="297.288" r="0.45"/>
				<circle fill="#AAAAB2" cx="769.249" cy="312.756" r="1.261"/>
				<circle fill="#AAAAB2" cx="764.307" cy="324.624" r="0.454"/>
			</g>
		</g> -->
		<g id="venus">
			<g>
				<path fill="#FFF3C0" d="M380.519,128.667c-9.66,0-17.519-7.859-17.519-17.519s7.859-17.52,17.519-17.52
					c9.661,0,17.52,7.859,17.52,17.52S390.18,128.667,380.519,128.667z"/>
				<circle fill="#D8CA8B" cx="380.519" cy="111.148" r="16.118"/>
				<path fill="none" d="M396.631,111.35c0.001-0.067,0.005-0.134,0.005-0.202c0-1.768-0.289-3.467-0.814-5.059
					c-7.69,0.967-18.355,1.59-30.722,0.354c-0.448,1.469-0.692,3.026-0.698,4.64C372.91,114.079,386.974,117.409,396.631,111.35z"/>
				<path fill="none" d="M368.841,122.25c2.936,3.088,7.081,5.016,11.678,5.016c5.435,0,10.238-2.693,13.157-6.814
					C386.288,121.308,377.201,122.131,368.841,122.25z"/>
				<path fill="none" d="M395.147,104.38c-2.558-5.52-8.144-9.35-14.628-9.35c-5.913,0-11.079,3.186-13.883,7.933
					C374.404,104.689,385.259,106.197,395.147,104.38z"/>
				<path fill="#EADBA0" d="M394.813,118.594c-7.373,1.029-18.652,2.179-27.846,1.273c0.55,0.853,1.178,1.65,1.875,2.383
					c8.36-0.119,17.447-0.942,24.835-1.798C394.095,119.86,394.475,119.241,394.813,118.594z"/>
				<path fill="#EADBA0" d="M395.823,106.089c-0.194-0.585-0.419-1.156-0.676-1.709c-9.888,1.817-20.743,0.309-28.511-1.417
					c-0.642,1.085-1.16,2.251-1.535,3.48C377.468,107.68,388.133,107.057,395.823,106.089z"/>
				<path fill="#BCAF75" d="M394.813,118.594c1.134-2.171,1.788-4.632,1.819-7.245c-9.657,6.059-23.721,2.729-32.228-0.266
					c0,0.021-0.002,0.042-0.002,0.064c0,3.213,0.944,6.205,2.565,8.719C376.16,120.773,387.439,119.624,394.813,118.594z"/>
				<g>
					<ellipse fill="#A59862" cx="374.461" cy="104.447" rx="1.241" ry="0.686"/>
					<ellipse fill="#A59862" cx="379.643" cy="116.199" rx="1.518" ry="0.847"/>
					<ellipse fill="#A59862" cx="384.943" cy="117.976" rx="0.511" ry="0.472"/>
					<ellipse fill="#A59862" cx="391.41" cy="114.9" rx="0.584" ry="0.452"/>
				</g>
			</g>
		</g>
		<g id="earth">
			<g>
				<path fill="#B7EFF9" d="M771,480.667c-12.683,0-23-10.317-23-23s10.317-23,23-23s23,10.317,23,23S783.683,480.667,771,480.667z"
					/>
				<circle fill="#78D2EA" cx="771" cy="457.667" r="21.16"/>
				<g>
					<path fill="none" d="M781.35,463.148c-1.707-7.399-11.154-5.75-12.074-14.146c-0.648-5.911,3.007-9.417,8.281-11.455
						c-2.064-0.673-4.268-1.041-6.557-1.041c-7.762,0-14.542,4.181-18.225,10.411c3.615,3.118,6.063,9.728,1.475,23.673
						c3.708,4.799,9.431,7.959,15.902,8.215C782.154,475.421,782.383,467.624,781.35,463.148z"/>
					<path fill="#80E5C8" d="M769.275,449.003c0.92,8.396,10.367,6.746,12.074,14.146c1.033,4.476,0.805,12.272-11.197,15.657
						c0.281,0.012,0.563,0.021,0.848,0.021c11.687,0,21.16-9.475,21.16-21.16c0-9.396-6.128-17.358-14.604-20.119
						C772.282,439.586,768.627,443.092,769.275,449.003z"/>
					<path fill="#80E5C8" d="M752.775,446.918c-1.862,3.151-2.936,6.824-2.936,10.749c0,4.868,1.647,9.349,4.41,12.924
						C758.838,456.646,756.391,450.036,752.775,446.918z"/>
				</g>
				<g opacity="0.7">
					<path fill="none" d="M790.604,452.453c-0.272,0.301-0.471,0.661-0.471,1.055c0,0.281,0.103,0.547,0.26,0.785h1.359h0.137
						c-0.101-0.629-0.228-1.25-0.383-1.861c-0.07,0.004-0.137,0.021-0.208,0.021H790.604z"/>
					<path fill="none" d="M791.752,459h-4.6c-1.3,0-2.152-1.05-2.152-2.356v-0.06c0-1.306,0.853-2.584,2.152-2.584h0.479
						c0.149,0,0.244-0.584,0.244-0.865c0-0.394-0.185-0.135-0.445-1.135h-6.368c-2.509,0-4.063-1.581-4.063-4.089v-0.115
						c0-2.509,1.554-4.796,4.063-4.796h5.423c-3.863-4-9.37-6.619-15.485-6.619c-4.022,0-7.782,1.398-10.984,3.349
						c0.011-0.001,0.021,0.271,0.032,0.271h2.521c0.556,0,1.008,0.305,1.008,1c0,0.696-0.452,1-1.008,1h-2.521
						c-0.557,0-1.008-0.518-1.008-1.213c0-0.34,0.108-0.593,0.284-0.849c-5.715,3.789-9.484,10.316-9.484,17.687
						c0,2.54,0.448,4.749,1.269,7.006c0.827-0.862,1.985-1.631,3.274-1.631h10.234c2.509,0,4.383,2.527,4.383,5.036v0.114
						c0,2.509-1.874,4.85-4.383,4.85h-0.693c-0.273,0-0.471,0.741-0.471,1.135c0,0.281,0.103-0.135,0.26,0.865h1.359h0.7h3.899
						h0.701h4.6c1.3,0,2.027,0.518,2.027,1.824v0.06c0,0.381,0.111,0.778-0.061,1.083c8.307-2.523,14.668-9.967,15.183-18.967
						H791.752z M758.597,457h-3.627c-0.8,0-1.45-0.803-1.45-1.5c0-0.695,0.65-1.5,1.45-1.5h3.627c0.801,0,1.449,0.805,1.449,1.5
						C760.046,456.197,759.397,457,758.597,457z M766.249,457h-2.521c-0.558,0-1.009-0.803-1.009-1.5c0-0.695,0.451-1.5,1.009-1.5
						h2.521c0.556,0,1.007,0.805,1.007,1.5C767.256,456.197,766.805,457,766.249,457z M771.326,442h-3.627
						c-0.8,0-1.449-0.304-1.449-1c0-0.695,0.649-1,1.449-1h3.627c0.801,0,1.45,0.305,1.45,1
						C772.776,441.696,772.127,442,771.326,442z M783.729,473h-2.521c-0.557,0-1.008-0.804-1.008-1.5c0-0.695,0.451-1.5,1.008-1.5
						h2.521c0.555,0,1.007,0.805,1.007,1.5C784.736,472.196,784.284,473,783.729,473z"/>
					<path fill="none" d="M760.952,475c0.148-1,0.244-0.584,0.244-0.865c0-0.394-0.186-1.135-0.445-1.135h-4.646
						c0.88,1,1.838,1.746,2.859,2.454c0.408-0.331,0.931-0.454,1.508-0.454H760.952z"/>
					<path fill="#FFFFFF" d="M777,447.796v0.115c0,2.508,1.554,4.089,4.063,4.089h6.368c-0.212,0-0.473-0.224-0.733-0.369
						c0.273-0.152,0.584-0.134,0.92-0.134c0.563,0,1.062,0.305,1.409,0.693c0.348-0.389,0.847-0.608,1.408-0.608
						c0.333,0,0.64-0.019,0.909,0.131c-0.928-3.255-2.614-5.713-4.858-8.713h-5.423C778.554,443,777,445.287,777,447.796z"/>
					<path fill="#FFFFFF" d="M790.604,452.453h0.694c0.071,0,0.138-0.018,0.208-0.021c-0.049-0.191-0.104-0.379-0.158-0.569
						C791.089,452.008,790.823,452.211,790.604,452.453z"/>
					<path fill="#FFFFFF" d="M790.393,454c0.24,1,0.612,0.815,0.963,1.011c-0.273,0.153-0.584,0.321-0.921,0.321
						c-0.562,0-1.061-0.213-1.408-0.602c-0.348,0.389-0.847,0.656-1.409,0.656c-0.336,0-0.646-0.231-0.92-0.385
						c0.351-0.195,0.706-0.002,0.935-1.002h-0.479c-1.3,0-2.152,1.278-2.152,2.584v0.06c0,1.307,0.853,2.356,2.152,2.356h4.6h0.37
						c0.023-1,0.038-1.014,0.038-1.426c0-1.15-0.096-2.574-0.271-3.574h-0.137H790.393z"/>
					<path fill="#FFFFFF" d="M789.026,452.247c-0.348-0.389-0.847-0.637-1.409-0.637c-0.336,0-0.646,0.095-0.92,0.247
						c0.261,0.146,0.521,0.352,0.733,0.596c0.261,0.301,0.445,0.661,0.445,1.055c0,0.281-0.095,0.547-0.244,0.785
						c-0.229,0.365-0.584,0.669-0.935,0.864c0.273,0.153,0.584,0.248,0.92,0.248c0.563,0,1.062-0.249,1.409-0.638
						c0.348,0.389,0.847,0.638,1.408,0.638c0.337,0,0.647-0.095,0.921-0.248c-0.351-0.195-0.723-0.499-0.963-0.864
						c-0.157-0.238-0.26-0.504-0.26-0.785c0-0.394,0.198-0.754,0.471-1.055c0.22-0.242,0.485-0.445,0.744-0.591
						c-0.002-0.003-0.002-0.006-0.004-0.009c-0.27-0.149-0.576-0.243-0.909-0.243C789.873,451.61,789.374,451.858,789.026,452.247z"
						/>
					<path fill="#FFFFFF" d="M760.018,472.251c0.273-0.152,0.584-0.323,0.92-0.323c0.563,0,1.061,0.209,1.409,0.597
						c0.348-0.388,0.846-0.654,1.408-0.654c0.336,0,0.647,0.238,0.92,0.391c-0.261,0.146-0.53-0.261-0.751,0.739h0.693
						c2.509,0,4.383-2.341,4.383-4.85v-0.114c0-2.509-1.874-5.036-4.383-5.036h-10.234c-1.289,0-2.447,0.943-3.274,1.805
						c1.078,2.965,2.8,6.195,4.996,8.195h4.646C760.539,472,760.278,472.396,760.018,472.251z"/>
					<path fill="#FFFFFF" d="M777,476.824c0-1.307-0.728-1.824-2.027-1.824h-4.6h-0.701h-3.899h-0.7h-1.359
						c0.24,0,0.611,0.436,0.962,0.631c-0.272,0.153-0.584,0.131-0.92,0.131c-0.563,0-1.061-0.308-1.408-0.695
						c-0.349,0.388-0.847,0.608-1.409,0.608c-0.336,0-0.646,0.124-0.92-0.029c0.351-0.195,0.706-0.646,0.935-0.646h-0.48
						c-0.577,0-1.1-0.03-1.508,0.301c3.417,2.368,7.563,3.643,12.036,3.643c2.143,0,3.99-0.379,5.939-0.972
						c0.172-0.305,0.061-0.707,0.061-1.088V476.824z"/>
					<path fill="#FFFFFF" d="M764.675,472.098c-0.272-0.152-0.584-0.247-0.92-0.247c-0.563,0-1.061,0.248-1.408,0.636
						c-0.349-0.388-0.847-0.636-1.409-0.636c-0.336,0-0.646,0.095-0.92,0.247c0.261,0.146,0.521,0.352,0.733,0.596
						c0.26,0.301,0.445,0.661,0.445,1.055c0,0.281-0.096,0.546-0.244,0.785c-0.229,0.365-0.584,0.669-0.935,0.864
						c0.273,0.153,0.584,0.248,0.92,0.248c0.563,0,1.061-0.25,1.409-0.638c0.348,0.388,0.846,0.638,1.408,0.638
						c0.336,0,0.647-0.095,0.92-0.248c-0.351-0.195-0.722-0.499-0.962-0.864c-0.157-0.239-0.26-0.504-0.26-0.785
						c0-0.394,0.197-0.754,0.471-1.055C764.145,472.449,764.414,472.243,764.675,472.098z"/>
					<path fill="#FFFFFF" d="M766.249,454h-2.521c-0.558,0-1.009,0.805-1.009,1.5c0,0.697,0.451,1.5,1.009,1.5h2.521
						c0.556,0,1.007-0.803,1.007-1.5C767.256,454.805,766.805,454,766.249,454z"/>
					<path fill="#FFFFFF" d="M783.729,470h-2.521c-0.557,0-1.008,0.805-1.008,1.5c0,0.696,0.451,1.5,1.008,1.5h2.521
						c0.555,0,1.007-0.804,1.007-1.5C784.736,470.805,784.284,470,783.729,470z"/>
					<path fill="#FFFFFF" d="M758.597,454h-3.627c-0.8,0-1.45,0.805-1.45,1.5c0,0.697,0.65,1.5,1.45,1.5h3.627
						c0.801,0,1.449-0.803,1.449-1.5C760.046,454.805,759.397,454,758.597,454z"/>
					<path fill="#FFFFFF" d="M760.048,442h2.521c0.556,0,1.008-0.304,1.008-1c0-0.695-0.452-1-1.008-1h-2.521
						c-0.012,0-0.021-0.209-0.032-0.207c-0.234,0.141-0.464,0.184-0.691,0.335c-0.176,0.256-0.284,0.372-0.284,0.712
						C759.04,441.536,759.491,442,760.048,442z"/>
					<path fill="#FFFFFF" d="M771.326,440h-3.627c-0.8,0-1.449,0.305-1.449,1c0,0.696,0.649,1,1.449,1h3.627
						c0.801,0,1.45-0.304,1.45-1C772.776,440.305,772.127,440,771.326,440z"/>
				</g>
			</g>
		</g>
		<g id="mars">
			<g>
				<path fill="#FFB6B6" d="M712.668,100.796c-11.947,0-21.666-9.719-21.666-21.666s9.719-21.666,21.666-21.666
					c11.946,0,21.665,9.719,21.665,21.666S724.614,100.796,712.668,100.796z"/>
				<circle fill="#EA7D7D" cx="712.668" cy="79.13" r="20.061"/>
				<circle fill="#BF6262" cx="702.422" cy="72.526" r="2.594"/>
				<ellipse fill="#BF6262" cx="716.437" cy="94.474" rx="2.594" ry="0.869"/>
				<ellipse fill="#BF6262" cx="723.767" cy="78.076" rx="0.668" ry="0.549"/>
				<ellipse fill="#BF6262" cx="710.292" cy="84.375" rx="4.54" ry="2.541"/>
				<ellipse fill="#BF6262" cx="716.879" cy="64.582" rx="0.602" ry="0.535"/>
				<g>
					<path fill="none" d="M720.407,60.619c-1.378,1.549-4.358,2.625-7.824,2.625c-3.427,0-6.38-1.052-7.776-2.574
						c-7.172,3.059-12.199,10.171-12.199,18.46c0,11.079,8.981,20.061,20.061,20.061s20.061-8.981,20.061-20.061
						C732.729,70.795,727.645,63.648,720.407,60.619z"/>
					<path fill="#FFFFFF" d="M712.583,63.244c3.466,0,6.446-1.076,7.824-2.625c-2.382-0.997-4.996-1.549-7.739-1.549
						c-2.791,0-5.447,0.571-7.861,1.601C706.203,62.192,709.156,63.244,712.583,63.244z"/>
				</g>
			</g>
		</g>
		<g id="jupiter">
			<g>
				<path fill="#FCAD9A" d="M568.082,353.826c-12.175,0-22.08-9.905-22.08-22.08s9.905-22.08,22.08-22.08
					c12.175,0,22.08,9.905,22.08,22.08S580.257,353.826,568.082,353.826z"/>
				<circle fill="#E27959" cx="568.082" cy="331.746" r="20.444"/>
				<g>
					<path fill="none" d="M568.082,311.302c-6.311,0-11.811,2.861-15.561,7.355L570,319.242v1.329c0,0-10.929,3.03-20.85,3.815
						c-0.322,0.835-0.662,1.696-0.874,2.58c9.202-0.312,22.455-1.887,36.354-7.267C580.912,314.61,574.867,311.302,568.082,311.302z
						"/>
					<path fill="none" d="M571.608,347.444c-6.04,0.684-10.193-4.479-4.947-7.46c5.247-2.981,7.353-1.006,13.114,1.29
						c1.389,0.553,3.395,0.982,5.637,1.316c0.786-1.254,1.44-2.598,1.942-4.015c-6.054,0.142-10.848,0.247-10.848,0.247
						l-0.073-1.077l11.514-1.169c0.375-1.549,0.579-3.166,0.579-4.83c0-0.251-0.009-0.499-0.019-0.748
						c-7.105,0.204-15.093,1.825-15.093,1.825l-0.167-1.066l15.074-2.887c-0.237-1.681-0.678-3.294-1.298-4.817
						c-10.231,2.051-27.194,5.287-39.362,6.777c-0.013,0.305-0.023,0.609-0.023,0.917c0,2.219,0.358,4.354,1.012,6.354
						c5.992-0.005,10.716-0.002,10.716-0.002l0.049,1.078l-10.051,0.792c3.166,7.196,10.353,12.222,18.718,12.222
						c5.719,0,10.886-2.35,14.597-6.135C578.976,346.598,574.769,347.086,571.608,347.444z"/>
					<path fill="#FF9B73" d="M570,319.242l-17.479-0.584c-1.417,1.698-2.489,3.63-3.3,5.728c9.921-0.785,20.779-3.815,20.779-3.815
						V319.242z"/>
					<path fill="#FF9B73" d="M573.415,332.823c0,0,7.987-1.621,15.093-1.825c-0.025-0.72-0.088-1.43-0.186-2.129l-15.074,2.887
						L573.415,332.823z"/>
					<path fill="#D3674F" d="M576.506,338.822c0,0,4.794-0.105,10.848-0.247c0.231-0.652,0.428-1.319,0.593-1.999l-11.514,1.169
						L576.506,338.822z"/>
					<path fill="#D3674F" d="M559.366,338.098c0,0-4.725-0.003-10.716,0.002c0.208,0.638,0.447,1.26,0.714,1.869l10.051-0.792
						L559.366,338.098z"/>
					<path fill="#FF9B73" d="M584.596,319.699c-13.899,5.379-27.188,6.955-36.39,7.267c-0.299,1.248-0.486,2.539-0.545,3.864
						c12.168-1.49,29.131-4.726,39.362-6.777C586.391,322.496,585.573,321.036,584.596,319.699z"/>
					<path fill="#FF9B73" d="M566.661,339.984c-5.246,2.981-1.093,8.144,4.947,7.46c3.161-0.358,7.368-0.846,11.071-1.389
						c1.03-1.051,1.947-2.212,2.733-3.465c-2.242-0.333-4.248-0.763-5.637-1.316C574.014,338.978,571.908,337.002,566.661,339.984z"
						/>
				</g>
				<circle fill="#D3674F" cx="562.281" cy="321.361" r="1.663"/>
				<ellipse fill="#D3674F" cx="569.972" cy="342.625" rx="2.811" ry="1.663"/>
				<ellipse fill="#FF9B73" cx="564.947" cy="348.085" rx="1.874" ry="1.108"/>
				<ellipse fill="#D3674F" cx="572.273" cy="325.69" rx="1.022" ry="0.605"/>
			</g>
		</g>
		<!-- <g id="saturn">

			<g>
				<path fill="#F2E8BB" d="M625.748,236c-13.437,0-24.369-10.932-24.369-24.369s10.933-24.369,24.369-24.369
					c13.437,0,24.37,10.932,24.37,24.369S639.185,236,625.748,236z"/>
				<path fill="#FFE9A4" d="M621.021,200.273c-20.775,9.249-35.626,21.215-33.173,26.727c2.455,5.512,21.285,2.482,42.059-6.768
					c20.775-9.25,35.627-21.216,33.172-26.728C660.626,187.994,641.796,191.023,621.021,200.273z M628.541,217.162
					c-16.535,7.362-31.316,10.237-33.016,6.421c-1.699-3.816,10.329-12.877,26.863-20.238c16.535-7.363,31.316-10.237,33.015-6.421
					S645.075,209.8,628.541,217.162z"/>
				<circle fill="#D8CA8B" cx="625.748" cy="211.631" r="22.689"/>
				<g>

					<path fill="none" d="M645.51,222.772l-36.138,4.552c1.534,1.601,3.299,2.976,5.243,4.074l27.8-4.378
						C643.603,225.733,644.643,224.308,645.51,222.772z"/>
					<path fill="none" d="M621.592,233.933c1.348,0.25,2.736,0.387,4.155,0.387c3.58,0,6.964-0.832,9.975-2.308L621.592,233.933z"/>
					<path fill="none" d="M625.748,188.942c-8.314,0-15.58,4.476-19.532,11.146l35.038-5.012
						C637.196,191.274,631.746,188.942,625.748,188.942z"/>
					<path fill="none" d="M648.391,210.252l-44.828,6.137c0.145,0.68,0.317,1.351,0.522,2.006l44.347-6.935
						C648.429,211.055,648.415,210.652,648.391,210.252z"/>
					<path fill="none" d="M644.753,199.244l-40.485,5.08c-0.78,2.294-1.209,4.75-1.209,7.307c0,0.656,0.035,1.305,0.089,1.948
						l44.721-6.982C647.266,203.938,646.199,201.458,644.753,199.244z"/>
					<path fill="none" d="M647.75,217.178l-41.699,5.708c0.476,0.832,1,1.632,1.574,2.394l39.357-5.653
						C647.283,218.831,647.54,218.014,647.75,217.178z"/>
					<path fill="#EADBA0" d="M639.345,229.794l-21.761,3.005c1.284,0.496,2.624,0.876,4.008,1.133l14.13-1.921
						C637.002,231.384,638.215,230.641,639.345,229.794z"/>
					<path fill="#EADBA0" d="M648.437,211.631c0-0.058-0.004-0.113-0.004-0.171l-44.347,6.935c0.19,0.608,0.409,1.204,0.648,1.79
						l43.63-6.812C648.407,212.798,648.437,212.218,648.437,211.631z"/>
					<path fill="#BCAF75" d="M648.363,213.374l-43.63,6.812c0.38,0.933,0.821,1.835,1.318,2.701l41.699-5.708
						C648.06,215.947,648.264,214.675,648.363,213.374z"/>
					<path fill="#BCAF75" d="M642.415,227.02l-27.8,4.378c0.95,0.536,1.942,1.004,2.97,1.402l21.761-3.005
						C640.452,228.965,641.478,228.034,642.415,227.02z"/>
					<path fill="#BCAF75" d="M647.869,206.597l-44.721,6.982c0.081,0.954,0.219,1.892,0.415,2.81l44.828-6.137
						C648.316,209.004,648.138,207.784,647.869,206.597z"/>
					<path fill="#A59862" d="M641.253,195.076l-35.038,5.012c-0.788,1.33-1.441,2.749-1.947,4.236l40.485-5.08
						C643.755,197.716,642.58,196.318,641.253,195.076z"/>
					<path fill="#A59862" d="M646.982,219.627l-39.357,5.653c0.54,0.716,1.126,1.397,1.747,2.044l36.138-4.552
						C646.077,221.769,646.572,220.718,646.982,219.627z"/>
				</g>
				<g>
					<path fill="#FFE9A4" d="M650.002,209.283c-0.129-1.348-0.371-2.665-0.712-3.94c-4.865,3.754-12.201,8.013-20.75,11.819
						c-8.844,3.938-17.183,6.59-23.291,7.623c0.73,1.135,1.548,2.21,2.452,3.205c6.577-1.587,14.246-4.214,22.205-7.757
						C637.616,216.801,644.505,212.995,650.002,209.283z"/> 
				</g>
			</g>
		</g>
	</g> -->
	<g id="Light">
		
			<linearGradient id="SVGID_1_" gradientUnits="userSpaceOnUse" x1="1221.9668" y1="6712.002" x2="1372.5986" y2="6712.002" gradientTransform="matrix(-0.7071 0.7071 -0.7071 -0.7071 6231.2402 3880.8896)">
			<stop  offset="0" style="stop-color:#FFFFFF;stop-opacity:0"/>
			<stop  offset="1" style="stop-color:#FFFFFF"/>
		</linearGradient>
		<path class="meteor" fill="url(#SVGID_1_)" d="M514.62,99.646l100.76-100.76c1.582-1.582,4.171-1.582,5.753,0l0,0c1.582,1.582,1.582,4.17,0,5.752
			l-100.76,100.76c-1.582,1.582-4.171,1.582-5.753,0l0,0C513.038,103.816,513.038,101.228,514.62,99.646z"/>
		
			<linearGradient id="SVGID_2_" gradientUnits="userSpaceOnUse" x1="1149.1426" y1="6530.9551" x2="1299.7754" y2="6530.9551" gradientTransform="matrix(-0.7071 0.7071 -0.7071 -0.7071 6231.2402 3880.8896)">
			<stop  offset="0" style="stop-color:#FFFFFF;stop-opacity:0"/>
			<stop  offset="1" style="stop-color:#FFFFFF"/>
		</linearGradient>
		<path class="meteor" fill="url(#SVGID_2_)" d="M694.132,176.171l100.76-100.76c1.582-1.582,4.171-1.582,5.753,0l0,0
			c1.582,1.582,1.582,4.17,0,5.752l-100.76,100.76c-1.582,1.582-4.171,1.582-5.753,0l0,0
			C692.55,180.341,692.55,177.753,694.132,176.171z"/>
		
			<linearGradient id="SVGID_3_" gradientUnits="userSpaceOnUse" x1="1189.4941" y1="6314.1895" x2="1340.127" y2="6314.1895" gradientTransform="matrix(-0.7071 0.7071 -0.7071 -0.7071 6231.2402 3880.8896)">
			<stop  offset="0" style="stop-color:#FFFFFF;stop-opacity:0"/>
			<stop  offset="1" style="stop-color:#FFFFFF"/>
		</linearGradient>
		<path class="meteor" fill="url(#SVGID_3_)" d="M818.874,357.979l100.76-100.76c1.582-1.582,4.171-1.582,5.753,0l0,0
			c1.582,1.582,1.582,4.17,0,5.752l-100.76,100.76c-1.582,1.582-4.171,1.582-5.753,0l0,0
			C817.292,362.148,817.292,359.561,818.874,357.979z"/>
	</g>
	
</g>

	</svg>
	 
  </div>

</div>
<script type="text/javascript">
var inform = '${inform}';
var count = '${count}';
var messages = '${errorMsgs}';
if(inform ==='200'){
	swal('溫馨提醒','輸入錯誤的驗證碼達三次,得重新進行註冊!', 'info');
}else if(messages==='不可為空白'){
		swal('驗證碼:', messages, 'warning');
}else{
		swal('驗證碼輸入錯誤:'+count+'次', messages, 'warning');
	}
	
	



















		var first= " \
	M954.451,624.813c0,0,6.995-28.375-26.451-81.813c-69.418-110.912-2.378-180.567-18.421-226.406C878.081,226.598,795.023,225.71,864,145C927.578,70.606,888.415,0,888.415,0h-700.67c0,0-34.665,140.11,111.365,165.102c72.446,12.398,108.086,79.917,119.429,131.838c11.776,53.901,75.561,120.149,151.067,114.149c55.343-4.397,135.983,28.499,158.482,92.996c14.804,42.437,69.688,55.429,128.993,56.997C917,562.667,954.451,624.813,954.451,624.813z \
	";
	var second= " \
	M954.451,624.813c0,0-47.1-40.059-26.451-81.813c60-121.333-48.419-133.411-18.421-226.406C938.851,225.85,923.998,207.667,864,145C796.324,74.313,888.415,0,888.415,0h-700.67c0,0,110.832,16.95,111.365,165.102c0.225,62.564,70.529,118.74,119.429,131.838c69.219,18.541,130.041,47.962,151.067,114.149c20.49,64.497,90.323,97.511,158.482,92.996c46.579-3.085,103.872,3.252,128.993,56.997C872,593,954.451,624.813,954.451,624.813z \
	";
	//console.log(document.getElementById("start-dream").getAttribute('d'));
	
	document.getElementById("start-dream").setAttribute('d',second);

	var morphing = anime({
		  targets: '#start-dream',
		  d: [
		    { value: first },
			{ value: second },
		  ],
		  easing: 'easeInOutSine', 
		  autoplay: true,
		  duration: 1500,
		  loop: true,
		
		});
 	console.log(morphing);



</script>

    
</body>





</html>