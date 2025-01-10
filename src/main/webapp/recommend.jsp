<%@page import="BeansHome.Actor.ActorDTO"%>
<%@page import="BeansHome.Actor.ActorDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet"> <!--플젝설명 폰트(구글폰트)-->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <style>
        body
        {
            margin: 0;                      /*기본 여백 없애고, 바디 주변 여백 없게*/
            padding: 20px;
            display: flex;                  /*안에 들어있는 것들 가운데 정렬 할 때 필요함*/
            align-items: center;            /*가로방향 중앙*/
            flex-direction: column;         /*세로 방향 배치*/
            background-color: #FFFAF0;  
        }


        /* 우승자 정보 */
        .filmo
        {
            display: flex;
            gap: 20px;
            justify-content: center;
            flex-wrap: nowrap;
            margin-top: 30px;
        }
        /* 우승자 사진 */
        .actor_photo
        {
            width: 300px;
            height: 300px;
            border-radius: 10px;                                    /*둥근 모서리*/
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);            /*그림자 - 수평 0, 수직 6px , 흐림 12px*/
            margin-top: 35%;
            transition: border 0.3s ease, box-shadow 0.3s ease;     /*마우스 올렸을 때 부드럽게*/
        }
        /* 사진 효과 */
        .actor_photo:hover
        {
            box-shadow: 0 10px 50px rgba(237, 100, 100, 0.5); 
        }
        /* 우승자 이름 */
        .actor_name
        {
            font-size: 25px;
            color: black;
            margin-top: 20px;
            background: rgba(0, 0, 0, 0);
            box-shadow: 0 0px 0px rgba(0, 0, 0, 0);     /*그림자 없앰*/
            text-align: center; 
        }


        /* 우승자 필모 */
        figcaption
        {
            width: 180px;
            height: 60px;
            transform: translateX(30%);                                      /*버튼들 필모 사진 중간에 위치하게 좌측으로 30% 이동*/
            font-size: 40px;
            background: linear-gradient(135deg, #FFDDBD, #FFB6C1);      /*그라데이션 (135도 방향, 첫번째 색상, 두번째 색상)*/
            color: #EB5C5C;
            border: none;
            border-radius: 10px;
            font-family: 'Bagel Fat One', sans-serif;
            text-align: center;
            margin-bottom: 20px;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);                    /*그림자 - 수평 0, 수직 4px , 흐림 10px*/

        }
        /* 우승자 필모 사진 */
        .poster
        {
            width: 300px;
            height: 400px;
            border-radius: 10px;                                    /*둥근 모서리*/
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);            /*그림자 - 수평 0, 수직 6px , 흐림 12px*/
            margin-top: 10%;
            transition: border 0.3s ease, box-shadow 0.3s ease;     /*마우스 올렸을 때 부드럽게*/
        }
        /* 사진 효과 */
        .poster:hover
        {
            box-shadow: 0 10px 50px rgba(237, 100, 100, 0.5); 
        }
        /* 우승자 필모 제목 */
        .name
        {
            font-size: 25px;
            color: black;
            margin-top: 20px;
            text-align: center; 
            font-family: 'Bagel Fat One', sans-serif;
        }


        /* 이런 배우는 어떠세요 */
        .other_actor
        {
            font-size: 30px;
            color: #EB5C5C;
            margin-top: 10px;
            background-color: rgba(0, 0, 0, 0);
            font-weight: bold;
            font-family: 'Noto Sans KR', sans-serif;
        }


        /* 다른 배우 추천 */
        .recommend
        {
            display: flex;
            gap: 300px;
            margin-top: 10px;
        }
        .recommend_set
        {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 20px;
        }
        /* 다른 배우 사진 */
        .recommend_actor_photo
        {
            width: 300px;
            height: 300px;
            border-radius: 10px;                                  /*둥근 모서리*/
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);          /*그림자 - 수평 0, 수직 6px , 흐림 12px*/
            transition: border 0.3s ease, box-shadow 0.3s ease;   /*마우스 올렸을 때 부드럽게*/
        }
        /* 사진 효과 */
        .recommend_actor_photo:hover
        {
            box-shadow: 0 10px 50px rgba(237, 100, 100, 0.5); 
        }

        /* 다른 배우 이름, 다른 배우 필모 이름 */
        .recommend_actor_name, .recommend_filmo_name
        {
            font-size: 25px;
            color: black;
            margin-top: 0px;
            text-align: center; 
            font-family: 'Bagel Fat One', sans-serif;
        }
        /* 다른 배우 필모 사진 */
        .recommend_flimo_photo
        {
            width: 300px;
            height: 400px;
            border-radius: 10px;                                    /*둥근 모서리*/
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);            /*그림자 - 수평 0, 수직 6px , 흐림 12px*/
            transition: border 0.3s ease, box-shadow 0.3s ease;     /*마우스 올렸을 때 부드럽게*/
        }
        /* 사진 효과 */
        .recommend_flimo_photo:hover
        {
            box-shadow: 0 10px 50px rgba(237, 100, 100, 0.5); 
        }


        /* 다시하기 버튼 */
        input[type="submit"] 
        {
            width: 180px;
            height: 60px;           
            font-size: 40px;         
            background: linear-gradient(135deg, #FFDDBD, #FFB6C1);      /*그라데이션 (135도 방향, 첫번째 색상, 두번째 색상)*/
            color: #EB5C5C;            
            border: none;            
            border-radius: 10px;  
            font-family: 'Bagel Fat One', sans-serif;
            margin-top: 40px;
            transform: translateX(370%);  
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);                    /*그림자 - 수평 0, 수직 4px , 흐림 10px*/
            cursor: pointer;                                                /*버튼에 마우스 올리면 마우스 포인터 손 모양으로 바뀌게*/
            transition: all 0.3s ease;                                      /*마우스 올렸을 때 부드럽게*/
        }
        /* 버튼에 마우스 올렸을 때 효과 */
        input[type="submit"]:hover
        {
            background: linear-gradient(135deg, #FFB6C1, #FFDDBD);      /*그라데이션 반대로*/
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);                    /*그림자 강조*/
        }
    </style>


<title>Recommend Actor</title>
<script src="apikey.js"></script>
</head>

<%!public ActorDAO ActorDAO = new ActorDAO();%>
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

<%! 
    String apiKey = "API_KEY"; // 반드시 올바른 API 키를 입력

    String fetchFromApi(String query, String key) { 
        String result = null;
        if (query != null && !query.trim().isEmpty()) {
            try {
                String apiUrl = "https://api.themoviedb.org/3/search/multi?api_key=" + apiKey 
                                + "&query=" + java.net.URLEncoder.encode(query, "UTF-8") 
                                + "&language=ko-KR";
                java.net.URL url = new java.net.URL(apiUrl);
                java.net.HttpURLConnection connection = (java.net.HttpURLConnection) url.openConnection();
                connection.setRequestMethod("GET");

                try (java.io.BufferedReader reader = new java.io.BufferedReader(
                        new java.io.InputStreamReader(connection.getInputStream()))) {
                    StringBuilder responseBuilder = new StringBuilder();
                    String line;
                    while ((line = reader.readLine()) != null) {
                        responseBuilder.append(line);
                    }

                    String response = responseBuilder.toString();
                    
                    int resultsIndex = response.indexOf("\"results\":");
                    if (resultsIndex != -1) {
                        int firstObjectIndex = response.indexOf("{", resultsIndex);
                        int keyIndex = response.indexOf("\"" + key + "\":", firstObjectIndex);
                        if (keyIndex != -1) {
                        	int start = -1;
		                	int end = -1;
		                	if (key.equals("id")){
		                		start = response.indexOf(":", keyIndex + key.length() + 2) + 1;
		                		end = response.indexOf(",", start);
		                	} else if (key.equals("poster_path")){
		                		start = response.indexOf(":", keyIndex + key.length() + 2) + 1;
		                        // null 체크
		                        String temp = response.substring(start).trim();
		                        if (temp.startsWith("null")) {
		                            result = null;
		                            return result;
		                        }
		                        // 문자열 값인 경우
		                        start = response.indexOf("\"", start) + 1;
		                        end = response.indexOf("\"", start);
		                	} else {
		                		start = response.indexOf("\"", keyIndex + key.length() + 3) + 1;
		                		end = response.indexOf("\"", start);
		                	}
         	
		                    if (start != -1 && end != -1) {
		                    	result = response.substring(start, end);
		                    }
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return result;
    }
%>



<body>
    <!-- Winner Actor 정보 테이블 -->
    <div class="filmo">
       <figure>
          <% if (winnerActor != null) { %>
          <a href="https://www.themoviedb.org/person/<%=winnerActor.getActorID() %>?language=ko-KR">
          <img class="actor_photo" src="./photo/<%= winnerActor.getActorProfilePhoto() %>" alt="배우 사진"></a>
          <figcaption class="actor_name"><%= winnerActor.getActorName() %></figcaption>
          <br><br><br><br><br><br><br><br><br>
            <p class="other_actor">이런 <%= winnerActor.getFaceName() %>상 배우는 어떠세요? 🎬</p>
       </figure>
       
       <% String [] winnerActorContents = {winnerActor.getActorDebut(),winnerActor.getActorHit(),winnerActor.getActorNewest()};
       	  String[] categories = {"데뷔작", "대표작", "최신작"}; %>
       	  
       <% for (int i = 0; i< 3; i++) {
    	   String posterPath = fetchFromApi(winnerActorContents[i], "poster_path");
    	   String mediaId = fetchFromApi(winnerActorContents[i], "id");
    	   String mediaType = fetchFromApi(winnerActorContents[i], "media_type");
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
    <div class="recommend">
	    <% if (bContinue){
		    while (this.ActorDAO.DBMgr.Rs.next()){
		    	String HitName = "";
		    	String HitPosterPath = fetchFromApi(this.ActorDAO.DBMgr.Rs.getString("actor_hit"), "poster_path");
		    	String mediaId = fetchFromApi(this.ActorDAO.DBMgr.Rs.getString("actor_hit"), "id");
		    	String mediaType = fetchFromApi(this.ActorDAO.DBMgr.Rs.getString("actor_hit"), "media_type");
		    	
		    	if (mediaType.equals("movie")){
		    		HitName = fetchFromApi(this.ActorDAO.DBMgr.Rs.getString("actor_hit"), "title");
		    	} else if (mediaType.equals("tv")){
		    		HitName = fetchFromApi(this.ActorDAO.DBMgr.Rs.getString("actor_hit"), "name");
		    	}
	    %>
	        <div class="recommend_set">
	            <a href="https://www.themoviedb.org/person/<%=this.ActorDAO.DBMgr.Rs.getInt("actor_id") %>?language=ko-KR">
	            <img class="recommend_actor_photo" src="./photo/<%= this.ActorDAO.DBMgr.Rs.getString("actor_profile_photo") %>" alt="배우사진"></a>
	            <div class="recommend_actor_name"><%= this.ActorDAO.DBMgr.Rs.getString("actor_name") %></div>
	            <% if (HitPosterPath != null) { %>
	            <a href="https://www.themoviedb.org/<%=mediaType%>/<%=mediaId%>?language=ko-KR">
	            <img class="recommend_flimo_photo" src="https://image.tmdb.org/t/p/w500<%= HitPosterPath %>" alt="히트작"></a>
	            <div class="recommend_filmo_name"><%=HitName %></div>
	            <% } else { %>
	            	<a href="https://www.themoviedb.org/<%=mediaType%>/<%=mediaId%>?language=ko-KR">
	            	<img class="recommend_flimo_photo" src="https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg" alt="히트작"></a>
	            	<div class="recommend_filmo_name"><%=HitName %></div>
	            <% } %>
	        </div>
				<% }
		    }%>
	
    </div>
    
    <form>
        <input type="submit" value="다시하기" id="retrybutton">
    </form>
    
    <script>
        // 다시하기 버튼 > start 화면
        document.getElementById("retrybutton").onclick = function()
        {
            window.location.href = "start.html";
        }
    </script>
        
</body>
</html>



