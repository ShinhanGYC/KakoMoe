<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="BeansHome.Actor.ActorDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="Config.ConfigMgr" %>

<%
// ---------------------------------------------------------------------
// [JSP 지역 변수 선언 : 웹 페이지 get/post 파라미터]
// ---------------------------------------------------------------------
int totalRound = 0;  			 // 전체 라운드 수
int currentRound  = 0; 			 // 현재 라운드
ActorDTO leftActor = null; 		 // 왼쪽 배우 정보
ActorDTO rightActor = null; 	 // 오른쪽 배우 정보
List<ActorDTO> actorList = null; // 현재 배우 리스트
String serverGif = null;		 // 서버 GIF 경로 설정
// ---------------------------------------------------------------------
%>


<%
// ---------------------------------------------------------------------
// [비정상적인 접근 확인하기 -> play.jsp를 다이렉트로 접속시 에러 페이지 연결]
// ---------------------------------------------------------------------
if (session.getAttribute("totalRound") == null || session.getAttribute("currentRound") == null || session.getAttribute("currentPair") == null) {
    response.sendRedirect("error.jsp");  // 세션에 라운드 정보가 없으면 오류 페이지로 리다이렉션
    session.invalidate();
    return;
}


//---------------------------------------------------------------------
//[서버URL 가져오기 | serverGif]
//[파라미터 가져오기 | totalRound, currnetRound, actorList]
//---------------------------------------------------------------------
serverGif = ConfigMgr.getProperty("server.gif");  // 서버 GIF 경로 가져오기
totalRound = (Integer) session.getAttribute("totalRound");  // 전체 라운드 수 가져오기
currentRound = (Integer) session.getAttribute("currentRound");  // 현재 라운드 번호 가져오기
actorList = (List<ActorDTO>)session.getAttribute("currentPair");  // 현재 대결에 참여하는 배우 리스트 가져오기

leftActor = actorList.get(0);  // 왼쪽 배우
rightActor = actorList.get(1); // 오른쪽 배우

%>

<!DOCTYPE html>
<html lang="ko">
<head>
	<%----------------------------------------------------------------------
	[HTML Page - 헤드 영역]
	--------------------------------------------------------------------------%>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
     <%----------------------------------------------------------------------
	[HTML Page - 타이틀 구현 영역]
	--------------------------------------------------------------------------%>
   		
        <% if (totalRound == 2) { %>  
        <%="결승" %>
        <% } else { %> 
        <%= totalRound %>강(<%=totalRound / 2%>/<%=currentRound%>)
        <% } %>
    </title>
	 <%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">]
	--------------------------------------------------------------------------%>
    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!-- 게임화면 폰트(구글폰트) -->
    
  	<%----------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <CSS/start.css>]
	--------------------------------------------------------------------------%>
    <link rel="stylesheet" href="CSS/play.css"> 
    <style> <style type="text/css"> </style>
</head>

<body>
	<%----------------------------------------------------------------------
	[HTML Page - 바디 영역]
	--------------------------------------------------------------------------%>
    <!-- 강 수 표시 -->
    <h1>
    	<!-- 결승일 경우 -->
        <% if (totalRound == 2) { %> 
        <%="결승" %>
        <% } else { %> 
        <!-- 그 외의 라운드 -->
        <%=totalRound + "강"%>
        <% } %>
    </h1>

    <!-- 현재 진행 표시 -->
    <div id="ongoing">
        <% if (totalRound == 2) { %>
        <!-- 결승일 경우 -->
        <%="당신의 최애는?"%> 
        <!-- 질문 표시 -->
        <% } else { %> 
        <!-- 현재 라운드 진행 상황 표시 -->
        (<%=totalRound / 2%>/<%=currentRound%>) 
        <% } %>
    </div>
	
    <!-- 움짤 -->
    <form id="roundForm" action="ServletRoundPlay" method="post">  <!-- 폼 제출을 위한 폼 정의 -->
        <div class="gif-box">
            <!-- 왼쪽 배우 움짤 -->
            <figure class="gif-item">
                <img src="<%= serverGif + leftActor.getActorWorldcupPhoto() %>" onerror="this.onerror=null; this.src='no_image.jpg'"  alt="No Image" data-actor-id="<%= leftActor.getActorID() %>">
                <figcaption><%= leftActor.getActorName() %></figcaption>  <!-- 배우 이름 표시 -->
            </figure>    

            <div class="vs">VS</div>  <!-- VS 텍스트 -->

            <!-- 오른쪽 배우 움짤 -->
            <figure class="gif-item">    
                <img src="<%= serverGif + rightActor.getActorWorldcupPhoto() %>"  onerror="this.onerror=null; this.src='no_image.jpg'"  alt="No Image" data-actor-id="<%= rightActor.getActorID() %>">
                <figcaption><%= rightActor.getActorName() %></figcaption>  <!-- 배우 이름 표시 -->
            </figure>
        </div>
        <input type="hidden" id="selectedActor" name="selectedActor" value="">  <!-- 선택된 배우 ID를 저장할 hidden input 필드 -->
    </form>
	<%---------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역]
	-----------------------------------------------------------------------%>
    <script>
        const gifItems = document.querySelectorAll('.gif-item img');  			// 모든 움짤 이미지 요소 선택
        const vsText = document.querySelector('.vs');  							// 'VS' 텍스트 요소 선택
        const ongoing = document.querySelector('#ongoing'); 					// 진행 표시 요소 선택
        const figures = document.querySelectorAll('.gif-item');  				// 모든 움짤 요소 선택
        const selectedActorInput = document.getElementById('selectedActor');    // hidden input 요소 선택
        const roundForm = document.getElementById('roundForm');  				// 폼 요소 선택

        // 각 움짤 이미지에 클릭 이벤트 리스너 추가
        gifItems.forEach(function(gif) {
            gif.addEventListener('click', function() {
                // 하나의 움짤만 선택되도록 처리
                gifItems.forEach(function(item) {
                    item.classList.remove('selected');  // 선택 해제
                });
                gif.classList.add('selected');  // 클릭한 움짤에 'selected' 클래스 추가

                // 강 수는 남기고, 나머지 요소들 숨기기
                document.querySelector('h1').classList.remove('hidden');  // 강 수 제목은 보이도록
                document.querySelector('#ongoing').classList.add('hidden');  // 진행 상태 숨기기
                vsText.classList.add('hidden');  // 'VS' 텍스트 숨기기
                figures.forEach(function(figure) {
                    if (!figure.contains(gif.closest('figure'))) {
                        figure.classList.add('hidden');  // 선택되지 않은 움짤 숨기기
                    }
                });
                const selectedFigCaption = gif.closest('figure').querySelector('figcaption');
                selectedFigCaption.classList.add('hidden');  // 선택된 움짤의 배우 이름 숨기기

                // 선택된 배우 ID 저장
                const selectedActorId = gif.dataset.actorId;
                selectedActorInput.value = selectedActorId;

                // 3초 뒤에 폼 제출
                setTimeout(function() {
                    roundForm.submit();  // 폼 제출
                }, 2000); // 2000ms = 2초 뒤에 제출
            });
        });
    </script>
</body>

</html>
