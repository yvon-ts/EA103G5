<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.members.model.*"%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Xducation-會員轉跳</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.css" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/limonte-sweetalert2/6.10.3/sweetalert2.js" type="text/javascript"></script>
    
</head>



<style>
@import url("https://fonts.googleapis.com/css?family=Ubuntu:400,400i,700,700i");
*, *:before, *:after {
  margin: 0;
  padding: 0;
  word-break: break-all;
  box-sizing: border-box;
}

html {
  font-size: 10px;
}

body {
  font-family:'Gochi Hand';
  color: #0099CC;
  font-size: 30px;
  background-color: #0099CC;
}

header, footer {
  display: block;
}

a, a:link, a:visited {
  color: #4d4d4d;
  text-decoration: none;
}

img {
  border: 0;
}

ul {
  list-style: none;
}

.center {
  margin: auto;
  width: 110rem;
}

.rocket-loader {
  -webkit-animation: moveParticles 6s linear infinite;
          animation: moveParticles 6s linear infinite;
  background: -webkit-gradient(linear, left top, right top, from(gray), color-stop(10%, transparent)) 0 20%/180% 0.2rem repeat-x, -webkit-gradient(linear, left top, right top, from(gray), color-stop(20%, transparent)) 0 80%/150% 0.2rem repeat-x, -webkit-gradient(linear, left top, right top, from(gray), color-stop(5%, transparent)) 0 65%/100% 0.2rem repeat-x, -webkit-gradient(linear, left top, right top, from(gray), color-stop(5%, transparent)) 0 40%/220% 0.2rem repeat-x, -webkit-gradient(linear, left top, left bottom, from(0), color-stop(white), to(white));
  background: linear-gradient(90deg, gray, transparent 10%) 0 20%/180% 0.2rem repeat-x, linear-gradient(90deg, gray, transparent 20%) 0 80%/150% 0.2rem repeat-x, linear-gradient(90deg, gray, transparent 5%) 0 65%/100% 0.2rem repeat-x, linear-gradient(90deg, gray, transparent 5%) 0 40%/220% 0.2rem repeat-x, linear-gradient(0, white, white);
  border: 1px solid rgba(0, 0, 0, 0.1);
  border-radius: 50%;
  box-shadow: inset 0 0 60px 0 rgba(0, 0, 0, 0.1);
  height: 125px;
  left: 50%;
  overflow: hidden;
  position: absolute;
  text-align: center;
  top: 50%;
  -webkit-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
  width: 125px;
}
.rocket-loader::before {
  -webkit-animation: blink 1s infinite;
          animation: blink 1s infinite;
  bottom: 6%;
  content: "Loading";
  font-size: 20px;
  left: 0;
  position: absolute;
  right: 0;
}

@-webkit-keyframes moveParticles {
  100% {
    background-position-x: -500rem;
  }
}

@keyframes moveParticles {
  100% {
    background-position-x: -500rem;
  }
}
/* .rocket {
  -webkit-animation: moveRocket 2s linear infinite;
          animation: moveRocket 2s linear infinite;
  background: lightgray;
  background: -webkit-gradient(linear, left top, left bottom, from(#990000), color-stop(red), to(#990000));
  background: linear-gradient(#990000, red, #990000);
  border-left: 3px solid rgba(0, 0, 0, 0.4);
  border-radius: 50%/30%;
  height: 15%;
  left: 50%;
  position: absolute;
  top: 50%;
  -webkit-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
  width: 35%; 
} */
.rocket::before, .rocket::after {
  content: "";
  position: absolute;
}
/* .rocket::before {
  -webkit-animation: rotateFins 1s infinite;
          animation: rotateFins 1s infinite;
  background: #bababa;
  background: -webkit-gradient(linear, left top, left bottom, from(#990000), color-stop(red), to(#990000));
  background: linear-gradient(#990000, red, #990000);
  border: 2px solid transparent;
  border-radius: 0 50% 50% 0;
  height: 140%;
  top: 50%;
  -webkit-transform: translate(0, -50%);
          transform: translate(0, -50%);
  left: 6px;
  width: 20%;
} */
.rocket::after {
  border: 7px solid transparent;
  border-left: 14px solid rgba(0, 0, 0, 0.4);
  border-radius: 15%;
  right: -16px;
  top: 2px;
}
/* .rocket-extras {
  -webkit-animation: moveExtras 1s infinite;
          animation: moveExtras 1s infinite;
  background: rgba(0, 0, 0, 0.4);
  height: 2px;
  left: 12px;
  margin: -2px 0 0;
  position: absolute;
  top: 50%;
  -webkit-transform: translate(0, -50%);
          transform: translate(0, -50%);
  width: 10px;
} */
.rocket-extras::before, .rocket-extras::after {
  content: "";
  position: absolute;
}
.rocket-extras::before {
  background: white;
  border-radius: 50%;
  height: 5px;
  right: -7px;
  top: -1px;
  width: 5px;
}
.rocket-extras::after {
  background: #cc0000;
  border-top: 1px solid #660000;
  height: 1px;
  left: -10px;
  top: 1px;
  width: 6px;
}

@-webkit-keyframes moveRocket {
  0%, 100% {
    -webkit-transform: translate(-50%, calc(-50% - 1rem));
            transform: translate(-50%, calc(-50% - 1rem));
  }
  50% {
    -webkit-transform: translate(-50%, calc(-50% + 1rem));
            transform: translate(-50%, calc(-50% + 1rem));
  }
}

@keyframes moveRocket {
  0%, 100% {
    -webkit-transform: translate(-50%, calc(-50% - 1rem));
            transform: translate(-50%, calc(-50% - 1rem));
  }
  50% {
    -webkit-transform: translate(-50%, calc(-50% + 1rem));
            transform: translate(-50%, calc(-50% + 1rem));
  }
}
@-webkit-keyframes rotateFins {
  0%, 100% {
    height: 140%;
  }
  50% {
    border-top: 2px solid #660000;
    border-bottom: 2px solid #660000;
    height: 110%;
  }
}
@keyframes rotateFins {
  0%, 100% {
    height: 140%;
  }
  50% {
    border-top: 2px solid #660000;
    border-bottom: 2px solid #660000;
    height: 110%;
  }
}
@-webkit-keyframes moveExtras {
  0%, 100% {
    -webkit-transform: translate(0, calc(-50% + 0.1rem));
            transform: translate(0, calc(-50% + 0.1rem));
  }
  50% {
    -webkit-transform: translate(0, calc(-50% - 0.1rem));
            transform: translate(0, calc(-50% - 0.1rem));
  }
}
@keyframes moveExtras {
  0%, 100% {
    -webkit-transform: translate(0, calc(-50% + 0.1rem));
            transform: translate(0, calc(-50% + 0.1rem));
  }
  50% {
    -webkit-transform: translate(0, calc(-50% - 0.1rem));
            transform: translate(0, calc(-50% - 0.1rem));
  }
}
/* .jet {
  height: 10px;
  left: -10px;
  position: absolute;
  top: calc(50% - 5px);
  width: 10px;
} */
.jet::before, .jet::after, .jet span {
  -webkit-animation: moveSmoke 0.3s infinite;
          animation: moveSmoke 0.3s infinite;
  background: #e09100;
  border-radius: 50%;
  content: "";
  -webkit-filter: blur(2px);
          filter: blur(2px);
  height: 8px;
  left: -6px;
  opacity: 1;
  position: absolute;
  -webkit-transform: translate(0, 0) scale(1);
          transform: translate(0, 0) scale(1);
  top: 1px;
  width: 15px;
}
.jet::after {
  -webkit-animation-delay: 0.1s;
          animation-delay: 0.1s;
}
.jet span {
  -webkit-animation-delay: 0.2s;
          animation-delay: 0.2s;
}

@-webkit-keyframes moveSmoke {
  100% {
    -webkit-filter: blur(3px);
            filter: blur(3px);
    opacity: 0;
    -webkit-transform: translate(-40px, 0) scale(2);
            transform: translate(-40px, 0) scale(2);
  }
}

@keyframes moveSmoke {
  100% {
    -webkit-filter: blur(3px);
            filter: blur(3px);
    opacity: 0;
    -webkit-transform: translate(-40px, 0) scale(2);
            transform: translate(-40px, 0) scale(2);
  }
}
@-webkit-keyframes blink {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.2;
  }
}
@keyframes blink {
  0%, 100% {
    opacity: 1;
  }
  50% {
    opacity: 0.2;
  }
}
img.rocket1{
width:70px;
height:70px;
 position: absolute;
 z-index:6;
margin-left: -32px;
 margin-top: 20px;
 -webkit-animation-name: spaceboots;
  -webkit-animation-duration: 0.8s;
  -webkit-transform-origin: 50% 50%;
  -webkit-animation-iteration-count: infinite;
  -webkit-animation-timing-function: linear;
 
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


.fast{
width:100%;
height:600px;
position: absolute;
z-index:1;

}



h1 {
  color: #FFF;
  font-weight: 300;
  position: absolute;
  top: 50%;
  left: 50%;
  letter-spacing: 3px;
  margin: 280px 0 0 -220px;
  -webkit-animation: flash 1.3s linear infinite;
  animation: flash 1.3s linear infinite;
}

.fast-line {
  position: absolute;
  top: 10%;
  height: 2px;
  width: 250px;
  background: #FFF;
  border-radius: 50%;
  -webkit-animation: line 0.7s linear infinite;
  animation: line 0.6s linear infinite;
}
.fast-line:nth-child(1) {
  left: 30%;
  top: 25%;
  -webkit-animation: line 0.6s ease-in-out infinite;
  animation: line 0.4s ease-in-out infinite;
}
.fast-line:nth-child(2) {
  left: 70%;
  top: 40%;
  -webkit-animation: line 1.8s linear infinite;
  animation: line 0.45s linear infinite;
}
.fast-line:nth-child(3) {
  left: 90%;
  top: 80%;
  -webkit-animation: line 0.45s ease-in-out infinite;
  animation: line 0.4s ease-in-out infinite;
}
.fast-line:nth-child(4) {
  left: 50%;
  top: 50%;
  -webkit-animation: line 0.35s ease-in-out infinite;
  animation: line 0.8s ease-in-out infinite;
}
.fast-line:nth-child(5) {
  left: 10%;
  top: 65%;
  -webkit-animation: line 0.25s ease-in-out infinite;
  animation: line 0.5s ease-in-out infinite;
}






@keyframes line {
  0% {
    left: 100%;
  }
  100% {
    left: -100%;
    opacity: 0;
  }
}
@-webkit-keyframes line {
  0% {
    left: 100%;
  }
  100% {
    left: -100%;
    opacity: 0;
  }
}
@keyframes flash {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0;
  }
}
@-webkit-keyframes slash {
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0;
  }
}

div#title{
color:#fff;
position: absolute;
z-index:2;
width:100%;
height:300px;
  letter-spacing: 3px;
  margin: 100px 0 0 0px;
  font-size:50px;
text-align:center;
}





</style>









<body>
<div id="title"><p>只差一步...您就可以成為我們Xducation的會員<br>我們已經向您剛剛註冊的手機號碼,發送了簡訊認證碼<br></p></div>

<div class="rocket-loader">

<img class="rocket1" src="<%=request.getContextPath()%>/front-end/members/assets/img/rocket.png" alt="">
  <div class="rocket">
  	
    <div class="rocket-extras"></div>
    <div class="jet"><span></span></div>
  </div>
</div>


<div class='fast'>


<h1>網頁會自動跳轉</h1>
<div class="fast-line"></div>
<div class="fast-line"></div>
<div class="fast-line"></div>
<div class="fast-line"></div>
<div class="fast-line"></div>
<div class="fast-line"></div>


</div>




   <%--  <h1>
        Hello 3秒後跳轉
    </h1>
    <a href="<%=request.getContextPath()%>/front-end/members/vCodeMembers.jsp">若無跳轉請按此</a> --%>
    
  

    <script>
        setTimeout(function () {
            // window.location.href = './input.html'
            window.open('<%=request.getContextPath()%>/front-end/members/vCodeMembers.jsp', '_self')
        },3000)
       </script> 
      
</body>


<script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/2.0.1/TweenMax.min.js"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/16327/DrawSVGPlugin.js?r=12"></script>
<script src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/16327/MorphSVGPlugin.min.js"></script>




</html>