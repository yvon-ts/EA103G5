<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
﻿
<!DOCTYPE html>
<html>

<head>
    <title>Card &ndash; the better way to collect credit cards</title>
	<style>
        .demo-container {
            width: 100%;
            max-width: 350px;
            margin: 50px auto;
            background-color: #6699cc;
            padding: 20px 10px 10px 10px;
            border-radius: 20px;
        }
        #front{
            width: 100%;
            line-height: 40px;
            margin-top: 5px;  
            border-bottom: 2px #e0eaf4 solid;
            color: #e0eaf4;
            font-family: monospace;
            font-size: 30px;

        }
        #front span{
            margin-left: 13px;
        }
        #line{
            background-color: #555;
            width: 106%;
            line-height: 40px;
            padding: 0px 15px;
            margin-left: -10px;
            margin-top: 5px;
            color: #555;
        }
        form {
            margin: 30px;
        }
       input{
            width: 200px;
            margin: 10px auto;
            background-color: #e0eaf4;
            border: 0;
            line-height: 25px;
            border-radius: 5px;
            font-family: monospace;
        }
        #card-num .num{
            display: inline-block;
            width: 50px;
            margin-right: 5px;
        }

    </style>
</head>

<body>
    <div class="demo-container">
        <div id="front"><span>Credit Card</span></div>
        <div class="card-wrapper"></div>
        <div class="form-container active">
            <form action="">
                <div id="card-num">
                    <input class="num" type="tel">
                    <font style="color: #e0eaf4;">-</font>
                    <input class="num" type="tel">
                    <font style="color: #e0eaf4;">-</font>
                    <input class="num" type="tel">
                    <font style="color: #e0eaf4;">-</font>
                    <input class="num" type="tel">
                </div>
                <input id="card-name"placeholder="FULL NAME" type="text" name="name">
            </form>
        </div>
    </div>
    <div class="demo-container">
        <div id="line">line</div>
        <div class="card-wrapper"></div>
        <div class="form-container active">
            <form action="">
                <input id="exp" placeholder="MM/YY" type="tel" name="expiry">
                <input id="cvc" placeholder="CVC" type="tel" name="cvc">
            </form>
        </div>
    </div>
</body>

</html>