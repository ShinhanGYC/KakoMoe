<%@page import="BeansHome.Actor.ActorDAO"%>
<%@page import="BeansHome.Actor.ActorDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<%


String getRound = (String)session.getAttribute("round");
getRound = getRound == null ? "-1" : getRound;

if (getRound.equals("-1")) {
	response.sendRedirect("error.jsp");
	return;
}

int currentRound = Integer.parseInt(getRound);
int roundPage = 0;




%>
<%
    // 특정 조건(값이 1이면 종료)
    if (currentRound == 1) {
        response.sendRedirect("winner.jsp");
        return;
    }

    // 다음 라운드로 업데이트
    session.setAttribute("currentRound", currentRound / 2);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이상형월드컵 <%= currentRound %>강(<%=currentRound / 2%>/<%=roundPage%>)</title>
    <!-- 기존 스타일 및 스크립트 유지 -->
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
    </style>
</head>
<body>
    <h1><%= currentRound %>강</h1>

    <!-- 움짤 구성 -->
    <div class="gif-box">
        <figure class="gif-item">
            <img src="./1693.gif" alt="사카구치 켄타로">
            <figcaption>사카구치 켄타로</figcaption>
        </figure>    

        <div class="vs">VS</div>

        <figure class="gif-item">    
            <img src="./2542.gif" alt="아야노 고">
            <figcaption>아야노 고</figcaption>
        </figure>
    </div>

    <form method="post" action="game.jsp" id="next-round-form">
	
        <input type="hidden" name="selected" id="selected-value">
    </form>

    <script>
        const gifItems = document.querySelectorAll('.gif-item img');
        const selectedValue = document.getElementById('selected-value');
        const nextRoundForm = document.getElementById('next-round-form');

        gifItems.forEach(function(gif) {
            gif.addEventListener('click', function() {
                // 다른 선택 해제
                gifItems.forEach(function(item) {
                    item.classList.remove('selected');
                });
                // 선택된 이미지 강조
                gif.classList.add('selected');
                selectedValue.value = gif.alt; // 선택된 이미지 값 저장

                // 3초 후 폼 자동 제출
                setTimeout(function() {
                    nextRoundForm.submit();
                }, 3000);
            });
        });
    </script>
</body>
</html>
