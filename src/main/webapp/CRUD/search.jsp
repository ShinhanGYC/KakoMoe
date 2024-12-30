<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="BeansHome.Actor.ActorDTO" %>
<%@ page import="BeansHome.Actor.ActorDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<%--<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">--%>
    <meta charset="UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate"/>
	<meta http-equiv="pragma" content="no-cache"/>
    <meta name="Description" content="검색 엔진을 위해 웹 페이지에 대한 설명을 명시"/>
    <meta name="keywords" content="검색 엔진을 위해 웹 페이지와 관련된 키워드 목록을 콤마로 구분해서 명시"/>
    <meta name="Author" content="문서의 저자를 명시"/>
	<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Beans를 활용한 검색</title>
<style>
    body {
        font-family: Arial, sans-serif;
        margin: 20px;
    }
    .search-container {
        margin-bottom: 20px;
    }
    .search-container input[type="text"] {
        padding: 10px;
        width: 300px;
        font-size: 16px;
    }
    .search-container button {
        padding: 10px 20px;
        font-size: 16px;
        cursor: pointer;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    table th, table td {
        border: 1px solid #ddd;
        padding: 8px;
        text-align: center;
    }
    table th {
        background-color: #f4f4f4;
    }
    td img {
        width: 100%; /* 이미지가 td에 맞게 늘어남 */
        height: auto; /* 비율을 유지하며 높이를 조정 */
        max-width: 200px; /* 최대 너비 제한 */
        max-height: 200px; /* 최대 높이 제한 */
    }
    td {
        width: 220px; /* 고정된 td 크기 */
        height: 220px; /* 고정된 td 크기 */
    }
</style>
   	<script type="text/javascript">
	// -----------------------------------------------------------------
	// [브라우저 갱신 완료 시 호출 할 이벤트 핸들러 연결 - 필수]
	// -----------------------------------------------------------------
	// window.onload = DocumentInit(InitMsg);
	// -----------------------------------------------------------------
	// [브라우저 갱신 완료 및 초기화 구현 함수 - 필수]
	// -----------------------------------------------------------------
	// 브라우저 갱신 완료 까지 기다리는 함수 - 필수
	// 일반적인 방식 : setTimeout(()=>alert('페이지가 모두 로드되었습니다!'), 50);
	function DocumentInit(callback)
	{
		var IntervalID = setInterval(
			function (callback)
            {
				var performanceTiming = window.performance.timing;
				var loadEventEnd = performanceTiming.loadEventEnd;
               	
                if (loadEventEnd > 0)
                {
                   	clearInterval(IntervalID);
                   	
                   	callback();
				}
            }, 50, callback);
       }
	// 브라우저 갱신 완료 시 호출되는 콜백 함수 - 필수
	function InitMsg()
       {
           alert('페이지가 모두 로드되었습니다!');
       }
	// -----------------------------------------------------------------
	// [사용자 함수 및 로직 구현]
	// -----------------------------------------------------------------
	
	// -----------------------------------------------------------------
	</script>
</head>
<%--------------------------------------------------------------------------
[JSP 전역 변수/함수 선언 영역 - 선언문 영역]
	- this 로 접근 가능 : 같은 페이지가 여러번 갱신 되더라도 변수/함수 유지 됨
	- 즉 현재 페이지가 여러번 갱신 되는 경우 선언문은 한번만 실행 됨
------------------------------------------------------------------------------%>
<%!
	// ---------------------------------------------------------------------
	// [JSP 전역 변수/함수 선언]
	// --------------------------------------------------------------------

	
	// 배우정보 검색용 DAO 객체 
	public ActorDAO actorDAO = new ActorDAO();
	// ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[JSP 지역 변수 선언 및 로직 구현 영역 - 스크립트릿 영역]
	- this 로 접근 불가 : 같은 페이지가 여러번 갱신되면 변수/함수 유지 안 됨
	- 즉 현재 페이지가 여러번 갱신 될 때마다 스크립트릿 영역이 다시 실행되어 모두 초기화 됨
------------------------------------------------------------------------------%>
<%
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 웹 페이지 get/post 파라미터]
	// ---------------------------------------------------------------------
	String sName = null;								// 이름

	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	int nRowCount = 0;								// 사원정보 검색 레코드 수
	boolean bContinue = false;						// 사원정보 검색 유무
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	sName = request.getParameter("name");				// 나이 파라미터 읽기
	sName = (sName != null && !sName.trim().isEmpty()) ? sName : "";	// 나이 null 확인("")

	// ---------------------------------------------------------------------
	// [일반 변수 조건 필터링]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
%>
<%--------------------------------------------------------------------------
[Beans/DTO 선언 및 속성 지정 영역]
------------------------------------------------------------------------------%>
	<%----------------------------------------------------------------------
	Beans 객체 사용 선언	: id	- 임의의 이름 사용 가능(클래스 명 권장)
						: class	- Beans 클래스 명
 						: scope	- Beans 사용 기간을 request 단위로 지정 Hello.HelloDTO 
	--------------------------------------------------------------------------%>
	<jsp:useBean id="ActorDTO" class="BeansHome.Actor.ActorDTO" scope="request"></jsp:useBean>
	
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법1	: Beans Property에 * 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 전체
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
	--------------------------------------------------------------------------%>
	<jsp:setProperty name="ActorDTO" property="*"/>
	
<%
	// HelloDTO.setData1(request.getParameter("data1"));
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	if (this.actorDAO.ReadActorList(ActorDTO) == true)
	{
		if (this.actorDAO.DBMgr != null && this.actorDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}
%>

<body>
    <div class="search-container">
        <form action="search.jsp" method="post" accept-charset="UTF-8">
            <input type="text" name="name" value="<%=sName %>" placeholder="이름을 입력하세요">
            <button type="submit">검색</button>
        </form>
    </div>


    <%-- DAO 선언 및 데이터 검색 --%>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>이름</th>
                <th>사진</th>
            </tr>
        </thead>
        <tbody>
        <%-- 검색 결과를 출력 --%>
    	<%
			if (bContinue == true) {
				
				while (this.actorDAO.DBMgr.Rs.next() == true) {
					String photo = this.actorDAO.DBMgr.Rs.getString("photo");
					out.println("<tr>");
					out.println("<td>" + this.actorDAO.DBMgr.Rs.getInt("actno") + "</td>");
					out.println("<td>" + this.actorDAO.DBMgr.Rs.getString("name") + "</td>");
					out.println("<td><img alt=\"photo \" src=http://localhost:8081/images/" + photo +  "></td>");
					out.println("</tr>");
					System.out.println(photo);
				}
			}
			
    	
    	
    	
    	
    	%>
        </tbody>
    </table>
</body>
</html>




