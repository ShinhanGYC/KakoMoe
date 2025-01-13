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

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>우승자 페이지</title>
    <link href="https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c&display=swap" rel="stylesheet"> <!--일본어 폰트(구글폰트)-->
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet"> <!--도장 폰트(구글폰트)-->
    
    
    
  	<link href="CSS/winner.css" rel="stylesheet">

<script>
        setTimeout(function() {
            window.location.href = 'recommend.jsp';
        }, 3000);
        
</script>

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
