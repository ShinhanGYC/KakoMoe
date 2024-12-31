<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>라운드 설정 페이지</title>

    <link href="https://fonts.googleapis.com/css2?family=Bagel+Fat+One&display=swap" rel="stylesheet"> <!--게임화면 폰트(구글폰트)-->
    <style>
        body 
         {
            font-family: 'Bagel Fat One', sans-serif;
            text-align: center; 
            margin: 0;
            height: 100vh; 
            display: flex;
            flex-direction: column;
            justify-content: center; 
            align-items: center; 
        }
        h1
        {
            font-weight: normal;
        }
        .title
        {
            font-size: 96px;
            color: #F39999;
        }
        .round
        {
            font-size: 48px;
            color: #AF6E6E;
        }

        form
        {
            margin-top: 40px;
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
    </style>
</head>


<body>
    <h1>
        <span class="title">이상형 월드컵</span><br>
        <span class="round">라운드를 선택하세요</span>
    </h1>
    <form action="roundInitServlet" method="get" enctype="multipart/form-data">
        <input type="submit" value="32강"  name = "round" style="margin-right: 100px;">
        <input type="submit" value="16강"  name = "round">
    </form>

</body>
</html>