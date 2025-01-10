<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@page import="javax.imageio.ImageIO" %>
<%@page import="BeansHome.Actor.ActorDTO" %>
<%@page import="Config.ConfigMgr" %>
<%
    ActorDTO winnerActor = (ActorDTO) session.getAttribute("winnerActor");  
    String name = winnerActor.getActorName();
    String winnerFaceName = winnerActor.getFaceName();
    String serverGif = ConfigMgr.getProperty("server.gif");
    String imageUrl = serverGif + winnerActor.getActorWorldcupPhoto();
	String stamp = winnerActor.getFaceName();
 %>
   <!-- <script>
        setTimeout(function() {
            window.location.href = 'recommend.jsp';
        }, 3000);
    </script>- -->     

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
            text-align: center;                             /*텍스트를 수평으로 중앙 정렬*/
            margin: 0;                                      /*기본 여백 없애고, 바디 주변 여백 없게*/
            height: 100vh; 
            display: flex;                                  /*안에 들어있는 것들 가운데 정렬 할 때 필요함*/
            flex-direction: column;                         /*세로 방향 배치*/
            justify-content: center;                        /*세로 방향 중앙 배치*/
            align-items: center;                            /*가로방향 중앙*/
            font-family: 'M PLUS Rounded 1c', sans-serif;
            background-color: #FFFAF0;  
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

        /* 움짤 및 이름 */
        figure
        {
            display: flex;
            flex-direction: row;           /*이미지와 이름을 가로로 배치*/
            justify-content: center;       /*이미지와 이름을 가로로 중앙 정렬*/
            align-items: center;           /*세로로 중앙 정렬*/
            margin: 0;
            position: relative;            /*.stamp의 위치를 기준으로 설정*/
        }

        /* 이미지 스타일 */
        img
        {
            max-width: 100%;                                   /*이미지가 부모의 크기를 넘어가지 않게*/
            height: auto;                                      /*비율 유지*/
            border-radius: 10px;                               /*둥근 모서리*/
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);       /*그림자 - 수평 0, 수직 6px , 흐림 12px*/
        }

        /* 이름 스타일 */
        .namae
        {
            writing-mode: horizontal-tb;                    /*이름을 가로로 설정*/
            font-size: 30px;
            color: black;
            margin-top: 20px;                               /*위쪽 마진*/
            font-family: 'Bagel Fat One', sans-serif;
        }

        /* 도장 스타일 */
        .stamp 
        {
            position: absolute;
            top: 80%;
            left: 70%;
            display: flex;
            justify-content: center;                        /*가로 방향 중앙 배치*/
            align-items: center;                            /*세로 방향 중앙 배치*/
            writing-mode: horizontal-tb;                    /*가로 글씨*/
            font-size: 20px;
            color: #E10909;
            font-family: 'Bagel Fat One', sans-serif;

            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-color: rgba(0, 0, 0, 0);
            border: 5px solid #E10909;
        }

        /* おし */
        .osi
        {
            font-size: 128px;   /*글씨 크게 강조*/
            font-weight: bold;
            color: #EB5C5C;
        }
        /* です ☆★ */
        .desu
        {
            color: #EB5C5C;
        }
    </style>
</head>


<body>
    <h1>
        <span class="watasi">わたしがあなたの</span><br>

        <figure>
            <img src="<%= imageUrl %>" alt="">
            <figcaption class="namae"><%= name %></figcaption>
            <div class="stamp"><%= stamp %>상</div>
        </figure> 

        <span class="osi">おし</span>
        <span class="desu">です ☆★</span>
    </h1>
</body>
</html>
