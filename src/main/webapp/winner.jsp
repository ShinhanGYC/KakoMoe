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
    
  	<link rel="stylesheet" href="CSS/winner.css">

<style>
.stamp 
{
    display: flex;
    justify-content: center;                        /*가로 방향 중앙 배치*/
    align-items: center;                            /*세로 방향 중앙 배치*/
    writing-mode: horizontal-tb;                    /*가로 글씨*/
    font-size: 25px;
    color: #E10909;
    font-weight: lighter;
    font-family: 'Jua', sans-serif;
    width: 200px;
    height: 40x;
    background-color: rgba(0, 0, 0, 0);
    box-shadow: 
        0 0 0 3px #E10909,   /* 첫 번째 빨간 테두리 */
        0 0 0 6px #FFFAF0,  /* 두 번째 주황색 테두리 */
        0 0 0 10px #E10909;  /* 세 번째 파란색 테두리 */
    margin-top: 20px;
}

</style>

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
