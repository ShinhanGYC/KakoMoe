<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html lang="ko">

	<head>
		<%----------------------------------------------------------------------
		[HTML Page - 헤드 영역]
		--------------------------------------------------------------------------%>
		<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
	    <meta charset="UTF-8"/>
	    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
		<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
		<meta http-equiv="pragma" content="no-cache"/>
	    <meta name="Description" content="검색 엔진을 위해 웹 페이지에 대한 설명을 명시"/>
	    <meta name="keywords" content="검색 엔진을 위해 웹 페이지와 관련된 키워드 목록을 콤마로 구분해서 명시"/>
	    <meta name="Author" content="문서의 저자를 명시"/>
		<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
	    <title>시작 페이지</title>
	    <%----------------------------------------------------------------------
		[HTML Page - 스타일쉬트 구현 영역]
		[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet">]
		[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet">]
		-----------------------------------------------------------------------%>
	    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
	    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;500;700&display=swap" rel="stylesheet"> <!--플젝설명 폰트(구글폰트)-->
	   
	    
	    <%----------------------------------------------------------------------
		[HTML Page - 스타일쉬트 구현 영역]
		[외부 스타일쉬트 연결 : <>]
		--------------------------------------------------------------------------%>
    <style>
        body 
        {
            text-align: center;                         /*텍스트를 수평으로 중앙 정렬*/
            margin: 0;                                  /*기본 여백 없애고, 바디 주변 여백 없게*/
            height: 100vh; 
            display: flex;                              /*안에 들어있는 것들 가운데 정렬 할 때 필요함*/
            flex-direction: column;                     /*세로 방향 배치*/
            justify-content: center;                    /*세로 방향 중앙 배치*/
            align-items: center;                        /* 가로방향 중앙*/
            font-family: 'Bagel Fat One', sans-serif;
            background-color: #FFFAF0;  
        }
        h1 
        {
            font-size: 96px;
            font-weight: normal;                                /*글씨체가 둥글둥글해서 너무 굵어서 노멀 해야 봐줄만함*/
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);      /*그림자 - 수평 2, 수직 2px , 흐림 5px*/
        }
        .heart 
        {
            color: #EB5C5C;
        }
        .title 
        {
            color: #EF7979;
        }
        .emoji-1, .emoji-2
        {
            color: #EB5C5C;
            font-size: 50px;
            position: absolute;
            animation: emoji-swing 2s ease-in-out infinite; /*애니메이션 : 2초, 계속 흔들리게 */
        }
        /* 왼쪽 하트 */

        /* 하트 이모지 애니메이션 */
        @keyframes emoji-swing     /*좌우로 흔들리는 것 처럼*/
        {
            0% { transform: rotate(0deg); }
            25% { transform: rotate(10deg); }
            50% { transform: rotate(0deg); }
            75% { transform: rotate(-10deg); }
            100% { transform: rotate(0deg); }
        }


        /* 버튼 */
        input[type="submit"] 
        {
            width: 250px;            
            height: 100px;            
            font-size: 70px;         
            background: linear-gradient(135deg, #FFDDBD, #FFB6C1);      /*그라데이션 (135도 방향, 첫번째 색상, 두번째 색상)*/
            color: #EB5C5C;                                               /*버튼 텍스트 색상*/        
            border: none;                                                   /*버튼 테두리 없게*/
            border-radius: 20px;                                            /*둥근 모서리*/
            font-family: 'Bagel Fat One', sans-serif;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);                    /*그림자 - 수평 0, 수직 4px , 흐림 10px*/
            cursor: pointer;                                                /* 버튼에 마우스 올리면 마우스 포인터 손 모양으로 바뀌게*/
            transition: all 0.3s ease;                                      /* 마우스 올렸을 때 부드럽게*/
        }
        /* 버튼에 마우스 올렸을 때 효과 */
        input[type="submit"]:hover
        {
            background: linear-gradient(135deg, #FFB6C1, #FFDDBD);      /*그라데이션 반대로*/
            transform: scale(1.1);                                          /*버튼 크기 1.1배 키우기*/
            box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);                    /*그림자 강조*/
        }

        
        /* 모달창 */
        .modal 
        {
            display: none;                              /*모달창 처음에는 안보이게*/
            position: fixed;                            /*위치 고정*/
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.6);        /*뒷 배경 투명하게*/
            justify-content: center;                    /*세로 중앙*/
            align-items: center;                        /*가로 중앙*/
            font-family: 'Noto Sans KR', sans-serif;
            animation: modal-open 0.5s ease-out;        /*애니메이션 : 0.5초, 천천히 끝나는 효과*/
        }
        /* 애니메이션 - 모달 창 등장 */
        @keyframes modal-open
        {
            from 
            {
                opacity: 0;                     /*투명하게 시작*/
                transform: translateY(-20px);   /*위쪽에서 등장하면서 20px위에 위치*/
            }
            to 
            {
                opacity: 1;                     /*불투명하게 끝*/
                transform: translateY(0);       /*모달 원래 위치*/
            }
        }

        /* 모달창 텍스트 */
        .modal-content 
        {
            background-color: #fff;
            padding: 40px;              /*모달창 내 여백*/
            border-radius: 20px;        /*둥근 모서리*/          
            width: 80%;                 /*너비*/
            max-width: 500px;           /*최대 500px*/
            text-align: center;         /*텍스트 중앙*/
        }
        
        /* 모달창 버튼 */
        .modal-button 
        {
            padding: 10px 20px;
            background: linear-gradient(135deg, #FF7B7B, #FFD1D1);  /*그라데이션 (135도 방향, 첫번째 색상, 두번째 색상)*/
            color: white;
            border: none;
            border-radius: 30px;                                        /*둥근 모서리*/ 
            font-size: 18px;
            font-family: 'Bagel Fat One', sans-serif;
            cursor: pointer;
            transition: all 0.3s ease;                                  /* 마우스 올렸을 때 부드럽게*/
        }
        /* 버튼에 마우스 올렸을 때 효과 */
        .modal-button:hover 
        {
            transform: scale(1.1);                                          /*버튼 크기 1.1배 키우기*/
            background: linear-gradient(135deg, #FFD1D1, #FF7B7B);      /*그라데이션 반대로*/
        }
    </style>
	</head>
	<body>
	<%----------------------------------------------------------------------
	[HTML Page - START]
	--------------------------------------------------------------------------%>
	    <!--시작화면-->
	    <h1>
	     
		    <!-- 심쿵! 바로 뒤에 이모지-1 -->
	       &emsp;<span class="heart">심쿵!</span>
	    <br>
	    <!-- 이상형 뽑기 대작전 바로 뒤에 이모지-2 -->
	    <span class="emoji-1">💘</span> &ensp; <span class="title">이상형 뽑기 대작전</span><span class="emoji-2">💘</span>
	    </h1>
	    <form>
	         &emsp;&emsp;&emsp;&emsp;&ensp;<input type="submit" value="Start" id="StartButton">
	    </form>
	
	
	    <!--모달-->
	    <div id="ProjectModal" class="modal">
	        <div class="modal-content">
	            <h2>게임 설명</h2>
	            <p>이 게임은 일본의 얼굴상과 이상형 월드컵을 활용하여<br>
	                내 취향인 배우의 필모그래피까지 확인하는 게임입니다!<br>
	                클릭하여 게임을 시작하세요!
	            </p>
	            <br>
	            <button class="modal-button" id="StartGameButton">시작하기</button>
	        </div>
	    </div>
	    
	     <%---------------------------------------------------------------------
	    [HTML Page - 자바스크립트 구현 영역]
	    -----------------------------------------------------------------------%>
		<script>
			// -----------------------------------------------------------------
			// [시작화면 Start 버튼 > 모달창]
			// -----------------------------------------------------------------
			document.getElementById("StartButton").onclick = function(event) 
	        {
	            event.preventDefault(); // 이게 있어야 모달 창 계속 볼 수 있음
	            document.getElementById("ProjectModal").style.display = "flex"; // flex 
	        }
			// -----------------------------------------------------------------
	        
			// -----------------------------------------------------------------
			// 모달 창 시작하기 버튼 > round 화면
			// -----------------------------------------------------------------
	        document.getElementById("StartGameButton").onclick = function()
	        {
	            window.location.href = "round.jsp";
	        }
			// -----------------------------------------------------------------
	    </script>
	<%----------------------------------------------------------------------
	[HTML Page - END]	
	--------------------------------------------------------------------------%>
	</body>
</html>
