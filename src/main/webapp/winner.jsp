<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="java.awt.image.BufferedImage" %>
<%@page import="java.io.File" %>
<%@page import="javax.imageio.ImageIO" %>
<%@page import="BeansHome.Actor.ActorDTO" %>
<%@page import="Config.ConfigMgr" %>
<%@ page import="java.net.URL" %>
<%@ page import="org.jsoup.Jsoup"%>
<%@ page import="org.jsoup.nodes.Document"%>
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
        }, 30000);
    </script>
</head>
<%
    ActorDTO winnerActor = (ActorDTO) session.getAttribute("winnerActor");  
    String name = winnerActor.getActorName();
    String winnerFaceName = winnerActor.getFaceName();
    String serverGif = ConfigMgr.getProperty("server.gif");
    String imageUrl = serverGif + winnerActor.getActorWorldcupPhoto();

    int imageWidth = 0;
    int imageHeight = 0;
    int stampTop = 0;
    int stampLeft = 0;
    System.out.println(imageUrl);
    try {

    	 Document document = Jsoup.connect(imageUrl).get();
    	 String title = document.title();
         System.out.println("Page Title: " + title);
         
     
     } catch (Exception e) {
         e.printStackTrace();
     }

 %>

<body>
    <h1>
        <span class="watasi">わたしがあなたの</span><br>
 
        <figure style="position: relative;">
            <!-- 이미지 -->
            <img src="<%=serverGif + winnerActor.getActorWorldcupPhoto() %>" 
                 onerror="this.onerror=null; this.src='no_image.jpg'" 
                 alt="gif" 
                 style="max-width: 100%; height: auto; border-radius: 10px; box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);">
            <figcaption class="namae"><%=name%> </figcaption>
            
            <!-- 스탬프 -->
            <div class="stamp" 
                 style="position: absolute; 
                        top: <%=stampTop %>px; 
                        left: <%=stampLeft %>px; 
                        transform: translate(-50%, -50%);
                        width: 100px; 
                        height: 100px; 
                        border-radius: 50%; 
                        border: 5px solid #E10909; 
                        display: flex; 
                        justify-content: center; 
                        align-items: center; 
                        font-size: 20px; 
                        color: #E10909; 
                        font-family: 'Bagel Fat One', sans-serif;">
                <%=winnerFaceName%>상
            </div>
        </figure> 

        <span class="osi">おし</span>
        <span class="desu">です ☆★</span>
    </h1>
</body>
</html>
