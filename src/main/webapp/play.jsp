<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="BeansHome.Actor.ActorDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="Config.ConfigMgr" %>

<%
// 현재 라운드와 상태 관리
int totalRound = 0;
int currentRound  = 0;
ActorDTO leftActor = null;
ActorDTO rightActor = null;
List<ActorDTO> actorList = null;
String serverGif = ConfigMgr.getProperty("server.gif");

//-------------------------------//
if (session.getAttribute("totalRound") == null || session.getAttribute("currentRound") == null) {
	response.sendRedirect("error.jsp");
	return;
}

totalRound = (Integer) session.getAttribute("totalRound");
currentRound = (Integer) session.getAttribute("currentRound");
actorList = (List)session.getAttribute("currentPair");


leftActor = actorList.get(0);
rightActor = actorList.get(1);


if (actorList == null || actorList.isEmpty()) {		
	response.sendRedirect("error.jsp");
	return;
}


%>


<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
		<% if (totalRound == 2) { %>
		<%="결승" %>
		<% } else { %>
		<%= totalRound %>강(<%=totalRound / 2%>/<%=currentRound%>)
		<% } %>
    </title>

    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
    <link rel="stylesheet" href="CSS/play.css">
    <style> <style type="text/css"> </style>
</head>


<body>
    <!--강 수 표시-->
    
    <h1>
	    <% if (totalRound == 2) { %>
	    <%="결승" %>
		<% } else { %>
		<%=totalRound + "강"%>
		<% } %>
	
    </h1>
    
	<!--현재 진행 표시-->
	<div id="ongoing">
		<% if (totalRound == 2) { %>
		<%="당신의 최애는?"%>
		<% } else { %>
		(<%=totalRound / 2%>/<%=currentRound%>)
		<% } %>
	</div>
	
	
    <!--움짤-->
    <form id="roundForm" action="ServletRoundPlay" method="post">
        <div class="gif-box">
            <figure class="gif-item">
                <img src="<%= serverGif + leftActor.getActorWorldcupPhoto() %>" onerror="this.onerror=null; this.src='no_image.jpg'"  alt="No Image" data-actor-id="<%= leftActor.getActorID() %>">
                <figcaption><%= leftActor.getActorName() %></figcaption>
            </figure>    

            <div class="vs">VS</div>

            <figure class="gif-item">    
                <img src="<%= serverGif + rightActor.getActorWorldcupPhoto() %>"  onerror="this.onerror=null; this.src='no_image.jpg'"  alt="No Image" data-actor-id="<%= rightActor.getActorID() %>">
                <figcaption><%= rightActor.getActorName() %></figcaption>
            </figure>
        </div>
        <input type="hidden" id="selectedActor" name="selectedActor" value="">
    </form>

    <script>
        const gifItems = document.querySelectorAll('.gif-item img');
        const vsText = document.querySelector('.vs');
        const ongoing = document.querySelector('#ongoing');
        const figures = document.querySelectorAll('.gif-item');
        const selectedActorInput = document.getElementById('selectedActor');
        const roundForm = document.getElementById('roundForm');

        gifItems.forEach(function(gif) {
			gif.addEventListener('click', function() {
	             // 하나의 움짤만 선택되도록 
	             gifItems.forEach(function(item) {
	                 item.classList.remove('selected');
	             });
	             // 선택된 움짤에 효과 추가
	             gif.classList.add('selected');
	
	             // 강 수는 남기고, 나머지 요소들 숨기기
	             document.querySelector('h1').classList.remove('hidden');      
	             document.querySelector('#ongoing').classList.add('hidden');   /*진행 상태 숨기기*/
	             vsText.classList.add('hidden');                               /*vs 텍스트 숨기기*/
	             figures.forEach(function(figure) {
	                 if (!figure.contains(gif.closest('figure'))) 
	                 {
	                     figure.classList.add('hidden');                       /*선택 안 된 움짤 숨기기*/
	                 }
             	});
               	const selectedFigCaption = gif.closest('figure').querySelector('figcaption');
  	                selectedFigCaption.classList.add('hidden');  
				
			
                // 선택된 배우 ID 저장
                const selectedActorId = gif.dataset.actorId;
                selectedActorInput.value = selectedActorId;
                // 3초 뒤에 폼 제출
                setTimeout(function() {
                    roundForm.submit();
                }, 3000); // 3000ms = 3초
				});
            });
    </script>
</body>

</html>