<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@page import="javax.imageio.ImageIO" %>
<%@page import="BeansHome.Actor.ActorDTO" %>
<%@page import="Config.ConfigMgr" %>



<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>우승자 페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="CSS/winner.css">
    <script>
        setTimeout(function() {
            window.location.href = 'recommend.jsp';
        }, 300000);
    </script>
</head>
<%
    ActorDTO winnerActor = (ActorDTO) session.getAttribute("winnerActor");  
    String name = winnerActor.getActorName();
    String winnerFaceName = winnerActor.getFaceName();
    String serverGif = ConfigMgr.getProperty("server.gif");
    String imageUrl = serverGif + winnerActor.getActorWorldcupPhoto();

 %>

<body>
    <h1>
        <span class="watasi">わたしがあなたの</span><br>

<figure>
    <!-- 이미지 -->
    <img src="<%=imageUrl%>" 
         onerror="this.onerror=null; this.src='no_image.jpg'" 
         alt="gif">
    
    <!-- 배우 이름 -->
    <figcaption class="namae"><%=name%></figcaption>

    <!-- 스탬프 -->
    <div class="stamp" ><%=winnerFaceName%>상</div>
</figure>

        <span class="osi">おし</span>
        <span class="desu">です ☆★</span>
    </h1>
</body>
<script>
    window.onload = function() {
        const figure = document.querySelector('figure');
        const img = document.querySelector('figure img');
        const stamp = document.querySelector('.stamp');

        img.onload = function() {
            const figureWidth = figure.offsetWidth; // figure의 가로 크기
            const figureHeight = figure.offsetHeight; // figure의 세로 크기
            const imgWidth = img.offsetWidth; // img의 가로 크기
            const imgHeight = img.offsetHeight; // img의 세로 크기

            // figure 세로 크기 조정
            let adjustedHeight = Math.max(figureHeight, 640);
            if (figureHeight > 640) {
                adjustedHeight += 63.33;
            }

            // 스탬프 위치 계산
            const stampTop = Math.min(imgHeight, adjustedHeight) - stamp.offsetHeight / 2;
            const stampLeft = imgWidth; // img의 우측

            // 스탬프 위치 설정
            stamp.style.top = `${stampTop}px`;
            stamp.style.left = `${stampLeft}px`;
        };
    };
</script>
</html>
