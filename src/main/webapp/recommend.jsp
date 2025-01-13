<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@page import="BeansHome.Actor.ActorDTO"%>
<%@page import="BeansHome.Actor.ActorDAO"%>

<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="org.json.simple.parser.JSONParser" %>
<%@ page import="API.FindContentsInfo" %>
<%@ page import="Config.ConfigMgr" %>



<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<%----------------------------------------------------------------------
			[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>    
	<title>Recommend Actor</title>
	<%----------------------------------------------------------------------
			[HTML Page - 스타일쉬트 구현 영역]
			[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">]
			[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">]
	-----------------------------------------------------------------------%>
	<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet"> <!--플젝설명 폰트(구글폰트)-->
		
	<%----------------------------------------------------------------------
			[HTML Page - 스타일쉬트 구현 영역]
			[외부 스타일쉬트 연결 : <CSS/recommend.css>]
	--------------------------------------------------------------------------%>
	<link rel="stylesheet" href="CSS/recommend.css">
	<style type="text/css"></style>
</head>

<%!public ActorDAO ActorDAO = new ActorDAO();
String serverUrl = ConfigMgr.getProperty("server.url");
String serverPfp = ConfigMgr.getProperty("server.pfp");%>
<%
    int actorID = 0;
    boolean bContinue = false;

    // 이전 페이지에서 전달된 session 데이터 가져오기
    ActorDTO winnerActor = (ActorDTO) session.getAttribute("winnerActor");
    if (winnerActor != null) {
        actorID = winnerActor.getActorID(); // winnerActor 객체에서 ID 가져오기
    }
%>
<%
    if (actorID > 0 && this.ActorDAO.takeRecommendActorSameFaceCode(actorID)) {
        if (this.ActorDAO.DBMgr != null && this.ActorDAO.DBMgr.Rs != null) {
            bContinue = true;
        }
    }
%>


<body>
    <%---------------------------------------------------------------------
			[우승 배우 컨텐츠  - JSP 구현 영역]
    -----------------------------------------------------------------------%>
    <div class="filmo">
       <figure>
       	  <figcaption class="winner-tag">우승자</figcaption>
          <% if (winnerActor != null) { %>
          <a href="https://www.themoviedb.org/person/<%=winnerActor.getActorID() %>?language=ko-KR">
          <img class="actor_photo" src="<%=serverPfp %>/<%= winnerActor.getActorProfilePhoto() %>" alt="배우 사진"></a>
          <div class="actor_name"><%= winnerActor.getActorName() %></div>
       </figure>
       
       <% String [] winnerActorContents = {winnerActor.getActorDebut(),winnerActor.getActorHit(),winnerActor.getActorNewest()};
            String[] categories = {"데뷔작", "대표작", "최신작"}; %>
       
       <% for (int i = 0; i< 3; i++) {
          FindContentsInfo contents = new FindContentsInfo(winnerActorContents[i]);
          int mediaId = contents.getId();
          String posterPath = contents.getPosterPath();
          String mediaType = contents.getMediaType();
       %>

       <figure>
          <figcaption><%= categories[i] %></figcaption>
          <% if (posterPath != null) { %>
             <a href="https://www.themoviedb.org/<%=mediaType%>/<%=mediaId%>?language=ko-KR">
             <img class="poster" src="https://image.tmdb.org/t/p/w500<%= posterPath %>" alt="<%= categories[i] %> Poster"></a>
             <div class="name"><%= winnerActorContents[i] %></div>
          <% } else { %>
              <a href="https://www.themoviedb.org/<%=mediaType%>/<%=mediaId%>?language=ko-KR">
             <img class="poster" src="https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" alt="<%= categories[i] %> Poster"></a>
              <div class="name"><%= winnerActorContents[i] %></div>
          <% } %>
       </figure>      
       <% } %>
        <% } else { %>
        <p>No winner actor information found.</p>
    <% } %>
    </div>
    
    <!--이런 배우는 어떠세요-->
    <div class="other_actor">이런 <%= winnerActor.getFaceName() %>상 배우는 어떠세요? 🎬</div>
    
   <%---------------------------------------------------------------------
			[동일 얼굴상 배우 3명 - JSP 구현 영역]
    -----------------------------------------------------------------------%>
    <div class="recommend">
       <% if (bContinue){
          while (this.ActorDAO.DBMgr.Rs.next()){
             FindContentsInfo contents = new FindContentsInfo(this.ActorDAO.DBMgr.Rs.getString("actor_hit"));
             int mediaId = contents.getId();
             String HitPosterPath = contents.getPosterPath();
             String mediaType = contents.getMediaType();
       %>

           <div class="recommend_set">
               <a href="https://www.themoviedb.org/person/<%=this.ActorDAO.DBMgr.Rs.getInt("actor_id") %>?language=ko-KR">
               <img class="recommend_actor_photo" src="<%=serverPfp %>/<%= this.ActorDAO.DBMgr.Rs.getString("actor_profile_photo") %>" alt="배우사진"></a>
               <div class="recommend_actor_name"><%= this.ActorDAO.DBMgr.Rs.getString("actor_name") %></div>
               <% if (HitPosterPath != null) { %>
               <a href="https://www.themoviedb.org/<%=mediaType%>/<%=mediaId%>?language=ko-KR">
               <img class="recommend_flimo_photo" src="https://image.tmdb.org/t/p/w500<%= HitPosterPath %>" alt="히트작"></a>
               <div class="recommend_filmo_name"><%=this.ActorDAO.DBMgr.Rs.getString("actor_hit") %></div>
               <% } else { %>
                  <a href="https://www.themoviedb.org/<%=mediaType%>/<%=mediaId%>?language=ko-KR">
                  <img class="recommend_flimo_photo" src="https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" alt="히트작"></a>
                  <div class="recommend_filmo_name"><%=this.ActorDAO.DBMgr.Rs.getString("actor_hit") %></div>
               <% } %>
           </div>
            <% }
          }%>
   
    </div>
    
    <div class="heart-shine" id="hs">💖</div>
    <div class="heart-shine2" id="hs2">💖</div>
    
    <form>
        <input type="submit" value="다시하기" id="retrybutton">
    </form>
    
    <script>
	    <%---------------------------------------------------------------------
	    		[HTML Page - 자바스크립트 구현 영역]
	    -----------------------------------------------------------------------%>
        // 다시하기 버튼 > start 화면
        document.getElementById("retrybutton").onclick = function(event)
        {
            event.preventDefault(); // 이게 있어야 새로고침 방지 
            window.location.href = "round.jsp"; 
        }
        
     	// 💖 스크롤하면 따라오게
        window.addEventListener('scroll', function () 
        {
            const retryButton = document.getElementById('hs'); 
            const scrollTop = window.scrollY; 
            const windowHeight = window.innerHeight; 
            const elementHeight = retryButton.offsetHeight; 
        
            let newTop = scrollTop + 20; 

            // 화면 하단을 넘지 않도록 설정
            if (newTop + elementHeight > windowHeight) 
            {
                newTop = windowHeight - elementHeight; 
            }

            retryButton.style.top = newTop + 'px'; 
        });

        // 💖 스크롤하면 따라오게
        window.addEventListener('scroll', function () 
        {
            const retryButton = document.getElementById('hs2'); 
            const scrollTop = window.scrollY; // 현재 스크롤 위치
            const windowHeight = window.innerHeight; // 화면 높이
            const elementHeight = retryButton.offsetHeight; // 요소 높이
        
            let newTop = scrollTop; 

            // 화면 하단을 넘지 않도록 설정
            if (newTop + elementHeight > windowHeight) 
            {
                newTop = windowHeight - elementHeight; 
            }

            retryButton.style.top = newTop + 'px'; 
        });
    </script>
        
</body>
</html>



