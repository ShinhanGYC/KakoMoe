<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@page import="javax.imageio.ImageIO" %>
<%@page import="BeansHome.Actor.ActorDTO" %>
<%@page import="Config.ConfigMgr" %>
<%
	
//---------------------------------------------------------------------
//[변수 선언]
//---------------------------------------------------------------------
    ActorDTO winnerActor = null;
    String name = null;
    String winnerFaceName = null;
    String serverGif = null;
    String imageUrl =  null;
	String stamp =  null;
 %>
 
 <%
//---------------------------------------------------------------------
//[파라미터 가져오기 | winnerActor]
//---------------------------------------------------------------------

//---------------------------------------------------------------------
//[파라미터 값 읽기 | winnerActor]
//---------------------------------------------------------------------
winnerActor = (ActorDTO) session.getAttribute("winnerActor");  
name = winnerActor.getActorName();
winnerFaceName = winnerActor.getFaceName();
serverGif = ConfigMgr.getProperty("server.gif");
imageUrl = serverGif + winnerActor.getActorWorldcupPhoto();
stamp = winnerActor.getFaceName();
 

 %>
<%----------------------------------------------------------------------
[HTML Page - 헤드 영역]
--------------------------------------------------------------------------%>
<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>우승자 페이지</title>
     <%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c&display=swap"" rel="stylesheet">]
	[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">]]
	[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet"> 
	-----------------------------------------------------------------------%>
    <link href="https://fonts.googleapis.com/css2?family=M+PLUS+Rounded+1c&display=swap" rel="stylesheet"> <!--일본어 폰트(구글폰트)-->
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet"> <!--도장 폰트(구글폰트)-->
    
    
   	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <CSS/start.css>]
	--------------------------------------------------------------------------%>
  	<link href="CSS/winner.css" rel="stylesheet">

	<%---------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역]
	-----------------------------------------------------------------------%>

	<script>
	<%---------------------------------------------------------------------
	// [리다이렉트 함수 : 3초뒤에 recommnd.jsp로 이동]
	--------------------------------------------------------------------------%>
	        setTimeout(function() {
	            window.location.href = 'recommend.jsp';
	        }, 3000);
	        
	</script>

</head>

<%----------------------------------------------------------------------
[HTML Page - 바디 영역]
--------------------------------------------------------------------------%>
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
