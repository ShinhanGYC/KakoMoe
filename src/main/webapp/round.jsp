<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

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
            font-weight: normal;
            text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.3);    /*그림자 - 수평 2, 수직 2px , 흐림 5px*/
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
            margin-top: 40px;   /*제목에서 40px 떨어지게*/
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