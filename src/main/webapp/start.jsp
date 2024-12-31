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
	            text-align: center; 
	            margin: 0;
	            height: 100vh; 
	            display: flex;                  /*안에 들어있는 것들 가운데 정렬 할 때 필요함*/
	            flex-direction: column;         /*세로 배치*/
	            justify-content: center;        /*중앙 배치*/
	            align-items: center;            /* 가로방향 중앙*/
	            font-family: 'Bagel Fat One', sans-serif;
	        }
	        h1 
	        {
	            font-size: 96px;
	            font-weight: normal;            /*글씨체가 둥글둥글해서 너무 굵어서 노멀 해야 봐줄만함*/
	        }
	        .heart 
	        {
	            color: #EB5C5C;
	        }
	        .title 
	        {
	            color: #EF7979;
	        }
	
	
	        /* 버튼 */
	        input[type="submit"] 
	        {
	            width: 250px;            
	            height: 100px;            
	            font-size: 70px;         
	            background-color: #FFDDBD;  
	            color: #EB5C5C;            
	            border: none;            
	            border-radius: 10px;  
	            font-family: 'Bagel Fat One', sans-serif;
	        }
	
	        
	        /* 모달 */
	        .modal 
	        {
	            display: none; 
	            position: fixed;
	            width: 100%;
	            height: 100%;
	            background-color: rgba(0,0,0,0.5); /* 뒷 배경 투명하게 */
	            justify-content: center;
	            align-items: center;
	            font-family: 'Noto Sans KR', sans-serif;
	        }
	        .modal-content 
	        {
	            background-color: #fff;
	            padding: 40px;
	            border-radius: 10px;
	            width: 80%;
	            max-width: 500px;
	            text-align: center;
	        }
	        .modal-button 
	        {
	            padding: 10px 20px;
	            background-color: #EB5C5C;
	            color: #fff;
	            border: none;
	            border-radius: 5px;
	            font-size: 18px;
	            font-family: 'Bagel Fat One', sans-serif;
	        }
	    </style>
	</head>
	<body>
	<%----------------------------------------------------------------------
	[HTML Page - START]
	--------------------------------------------------------------------------%>
	    <!--시작화면-->
	    <h1><span class="heart">심쿵!</span><br>
	        <span class="title">이상형 뽑기 대작전</span>
	    </h1>
	    <form>
	        <input type="submit" value="Start" id="StartButton">
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
