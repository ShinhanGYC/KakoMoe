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
    <style>
        body 
        {
            text-align: center; 
            margin: 0;
            height: 100vh; 
            display: flex;                  /*안에 들어있는 것들 가운데 정렬 할 때 필요함*/
            flex-direction: column;         /*세로 배치*/
            justify-content: flex-start;    /*상단 배치*/
            align-items: center;            /* 가로방향 중앙*/
            font-family: 'Bagel Fat One', sans-serif;
        }
        h1
        {
            /*round 페이지 버튼이랑 같은 사이즈*/
            width: 250px;            
            height: 100px;            
            font-size: 70px;         
            background-color: #FFDDBD;  
            color: #EB5C5C;            
            border: none;            
            border-radius: 10px;  
            font-family: 'Bagel Fat One', sans-serif;
            text-align: center;       
        }

        /*움짤*/
        .gif-box
        {
            display: flex;              /*움짤 가로로*/
            justify-content: center;    /*중간 정렬*/
            align-items: center;
            gap: 100px;
        }
        figure
        {
            display: flex;
            flex-direction: column; /*움짤이랑 이름 세로로*/
            align-items: center;
        }
        figcaption
        {
            font-size: 30px;
            color: black;
            margin-top: 20px;
        }
        img /*움짤 크기*/
        {
            width: 700px;
            height: 400px;
        }
        .vs
        {
            position: absolute;     
            top: 35%;
            left: 50%;
            transform: translateX(-50%); /*가로 중앙 정렬*/
            font-size: 70px;
            color: #ED6464;
            font-weight: bold;
        }

        /* 선택된 움짤 */
        .selected {
            position: absolute;
            top: 50%;               
            left: 50%;              
            transform: translate(-50%, -50%) scale(1.6); /* 크기 1.6배 커지게 */
            z-index: 10;            /* 클릭된 움짤이 다른 요소 위로 이동되게 */
            transition: transform 0.5s ease, left 0.5s ease, top 0.5s ease; /*부드럽게 선택되게*/
        }

        /* 선택하면 선택된 움짤이랑 강 수 외 나머지는 안보이게 */
        .hidden {
            display: none;
        }
    </style>
</head>
<%
	


%>
<body>
    <!--강 수 표시-->
    
    <h1>
    <% if (totalRound == 2) { %>
    <%="결승" %>
	<% } else { %>
	<%=totalRound + "강"%>
	<% } %>
	
    </h1>

    <!--움짤-->
    <form id="roundForm" action="roundPlayServlet" method="post">
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
        const figures = document.querySelectorAll('.gif-item');
        const selectedActorInput = document.getElementById('selectedActor');
        const roundForm = document.getElementById('roundForm');

        gifItems.forEach(function(gif) {
            gif.addEventListener('click', function() {
                // 선택된 값 초기화 및 효과 추가
                gifItems.forEach(function(item) {
                    item.classList.remove('selected');
                });
                gif.classList.add('selected');

                // 숨기기 처리
                document.querySelector('h1').classList.remove('hidden');
                vsText.classList.add('hidden');
                figures.forEach(function(figure) {
                    if (!figure.contains(gif.closest('figure'))) {
                        figure.classList.add('hidden');
                    }
                });

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