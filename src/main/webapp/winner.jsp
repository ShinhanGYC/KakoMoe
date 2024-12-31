<%@page import="BeansHome.Actor.ActorDTO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>winner</title>
    <link href="https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c&display=swap" rel="stylesheet"> <!--일본어 폰트(구글폰트)-->
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
    
    <style>
       body 
        {
            text-align: center; 
            margin: 0;
            height: 100vh; 
            display: flex;                  /*안에 들어있는 것들 가운데 정렬 할 때 필요함*/
            flex-direction: column;         /*세로 배치*/
            justify-content: center;        /*중앙 배치*/
            align-items: center;            /* 가로방향 중앙*/
            font-family: 'M PLUS Rounded 1c', sans-serif;
        }
       h1
        {
            writing-mode: vertical-rl;      /*세로 글씨*/
            font-size: 80px;
            font-weight: normal;            

        }


        /*わたしがあなたの*/
        .watasi
        {
            color: #EB5C5C;
        }
        

        /*움짤 및 이름*/
        figure
        {
            display: flex;
            align-items: center;
            margin: 0;
        }
        .namae
        {
            writing-mode: horizontal-tb;    /*가로 글씨*/
            font-size: 30px;
            color: black;
            margin-top: 20px;
            font-family: 'Bagel Fat One', sans-serif;
        }
        img
        {
            position: relative;
        }
        .stamp 
        {
            position: absolute;
            top: 55%; 
            left: 67%; 
            
            display: flex; 
            justify-content: center; 
            align-items: center; 

            writing-mode: horizontal-tb;    /*가로 글씨*/
            font-size: 20px; 
            color: #E10909; 
            font-family: 'Bagel Fat One', sans-serif; 

            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: rgba(0, 0, 0, 0);
            border: 5px solid #E10909;
        }

        /*おしです*/
        .osi
        {
            font-size: 128px;           /*오시는 크고 굵게*/
            font-weight: bold;
            color: #EB5C5C;
        }
        .desu
        {
            color: #EB5C5C;
        }
    </style>
</head>
<%
ActorDTO firstActor = (ActorDTO) session.getAttribute("firstActor");  
	String name = firstActor.getActorName();
	String stamp = null;
	if (firstActor.getFaceCode() == 1) {
		stamp = "소금";
	}
	else if (firstActor.getFaceCode() == 2) {
		stamp = "간장";
	}
	else if (firstActor.getFaceCode() == 3) {
		stamp = "마요네즈";
	}
	else{
		stamp = "된장";
	}
%>

<body>
    <h1>
        <span class="watasi">わたしがあなたの</span><br>
 
        <figure>
            <img src="./123.gif" alt="gif"><br>
            <figcaption class="namae"><%=name%> </figcaption>
            <div class="stamp"><%=stamp%>상</div>
        </figure> 

        <span class="osi">おし</span>
        <span class="desu">です ☆★</span>
    </h1>
        
</body>
</html>