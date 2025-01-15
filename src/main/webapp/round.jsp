<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
	    <title>라운드 설정 페이지</title>
	    
	    <%----------------------------------------------------------------------
		[HTML Page - 스타일쉬트 구현 영역]
		[외부 스타일쉬트 연결 : <link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">]
		-----------------------------------------------------------------------%>
    	<link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
    
    	<%----------------------------------------------------------------------
		[HTML Page - 스타일쉬트 구현 영역]
		[외부 스타일쉬트 연결 : <CSS/round.css>]
		--------------------------------------------------------------------------%>
		<link rel="stylesheet" href="CSS/round.css">
		<style> <style type="text/css"> </style>
	</head>

		
	<body>
		<%----------------------------------------------------------------------
		[HTML Page - 바디 영역]
		--------------------------------------------------------------------------%>
	    <h1>
	        <span class="title">이상형 월드컵</span><br>
	        <span class="round">라운드를 선택하세요</span>
	    </h1>
	    <%----------------------------------------------------------------------
			Action : ServletRoundInit.java | value : 32강, 16강 | parameter : round
	    --------------------------------------------------------------------------%> 
	    <form action="ServletRoundInit" method="get" enctype="multipart/form-data">
	        <input type="submit" value="32강"  name = "round" style="margin-right: 100px;">
	        <input type="submit" value="4강"  name = "round">
	    </form>
	</body>
</html>