<%@page import="BeansHome.Actor.NewActorDAO"%>
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
    <title>배우 DB 조회 페이지</title>
	<%------------------------------------------------------------------------
	[HTML Page - 스타일쉬트 구현 영역]
	[외부 스타일쉬트 연결 : <link rel="stylesheet" href="Hello.css"/>]
	--------------------------------------------------------------------------%>
	 <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .search-container {
            margin-bottom: 20px;
        }
        .search-container label {
            margin-right: 10px;
        }
        .search-container input, .search-container select {
            padding: 8px;
            margin-right: 10px;
        }
        .search-container button {
            padding: 8px 16px;
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
            max-width: 100px;
            height: auto;
        }
    </style>
	<%----------------------------------------------------------------------
	[HTML Page - 자바스크립트 구현 영역]
	[외부 자바스크립트 연결 : <script type="text/javascript" src="Hello.js"/>]
	--------------------------------------------------------------------------%>
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
	// ---------------------------------------------------------------------
	
	// 배우정보 검색용 DAO 객체 
	public NewActorDAO ActorDAO = new NewActorDAO();
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
	String searchName = null;							// 이름
	String faceFilter = null;							// 얼굴상 
	String scheme = request.getScheme();
	String serverName = request.getServerName();
	int serverPort = request.getServerPort();
	String baseUrl = scheme + "://" + serverName + ":" + serverPort;
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 데이터베이스 파라미터]
	// ---------------------------------------------------------------------
	
	// ---------------------------------------------------------------------
	// [JSP 지역 변수 선언 : 일반 변수]
	// ---------------------------------------------------------------------
	boolean bContinue = false;							// 배우 정보 검색 유무
	String  PFP = null;									// 배우 프로필 사진 경로 
	String  GIF = null;									// 배우 GIF 사진 경로
	String  PFPpath = null;								// 배우 프로필 사진 구조
	String  GIFpath = null;								// 배우 GIF 사진 구조

	
	// ---------------------------------------------------------------------
	// [웹 페이지 get/post 파라미터 조건 필터링]
	// ---------------------------------------------------------------------
	searchName = request.getParameter("name"); 							// 이름 파라미터 읽기
	searchName = searchName != null ? searchName : "-1"; 				// 나이 null 확인(-1:전체)
	
	faceFilter = request.getParameter("face");							// 얼굴상 파라미터 읽기
	faceFilter = faceFilter != null ? searchName : "-1";				// 얼굴상 null 확인(-1:전체)
	
	
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
	<jsp:useBean id="ActorDTO" class="BeansHome.Actor.NewActorDTO" scope="request"></jsp:useBean>
	
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법1	: Beans Property에 * 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 전체
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
	--------------------------------------------------------------------------%>
	<%--jsp:setProperty name="ActorDTO" property="*"/> --%>
	
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법2	: Beans Property에 HTML 태그 name 사용
						:---------------------------------------------------
						: name		- <jsp:useBean>의 id
						: property	- HTML 태그 입력양식 객체 name
						:---------------------------------------------------
	주의사항				: HTML 태그의 name 속성 값은 소문자로 시작!
						: HTML 태그에서 데이터 입력 없는 경우 null 입력 됨!
						: Property를 각각 지정 해야 함!
	------------------------------------------------------------------------
	<jsp:setProperty name="HelloDTO" property="data1"/>
	<jsp:setProperty name="HelloDTO" property="data2"/>
	--%>
	<%----------------------------------------------------------------------
	Beans 속성 지정 방법3	: Beans 메서드 직접 호출
						:---------------------------------------------------
						: Beans 메서드를 각각 직접 호출 해야함!
	--------------------------------------------------------------------------%>
<%
	ActorDTO.setActorName(request.getParameter("name"));
	ActorDTO.setFaceCode(0);
%>
<%--------------------------------------------------------------------------
[Beans DTO 읽기 및 로직 구현 영역]
------------------------------------------------------------------------------%>
<%
	if (this.ActorDAO.ReadActorList(ActorDTO) == true)
	{
		if (this.ActorDAO.DBMgr != null && this.ActorDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}
%>
	<body>
	    <h1>Actor Data</h1>
	    <div class="search-container">
	        <form action="" method="get">
	            <label for="name">Name:</label>
	            <input type="text" id="name" name="name" value="<%= searchName %>" placeholder="Enter name">
	            <label for="face">Face Type:</label>
	            <select id="face" name="face">
	                <option value="0" <%= faceFilter.equals("0") ? "selected" : "" %>>전체</option>
	                <option value="1" <%= faceFilter.equals("1") ? "selected" : "" %>>소금</option>
	                <option value="2" <%= faceFilter.equals("2") ? "selected" : "" %>>간장</option>
	                <option value="3" <%= faceFilter.equals("3") ? "selected" : "" %>>마요네즈</option>
	                <option value="4" <%= faceFilter.equals("4") ? "selected" : "" %>>된장</option>
	            </select>
	            <button type="submit">Search</button>
	        </form>
	    </div>
	    <table>
	        <thead>
	            <tr>
	                <th>Actor ID</th>
	                <th>Name</th>
	                <th>Debut</th>
	                <th>Hit</th>
	                <th>Newest</th>
	                <th>Face Code</th>
	                <th>Face Type</th>
	                <th>Profile Photo</th>
	                <th>World Cup Photo</th>
	            </tr>
	        </thead>
	        <tbody>
	            <% if (bContinue == true) {
	                while(this.ActorDAO.DBMgr.Rs.next() == true) { %>
	                    <tr>
	                        <td><%= this.ActorDAO.DBMgr.Rs.getInt("actor_id") %></td>
	                        <td><%= this.ActorDAO.DBMgr.Rs.getString("actor_name") %></td>
	                        <td><%= this.ActorDAO.DBMgr.Rs.getString("actor_debut") %></td>
	                        <td><%= this.ActorDAO.DBMgr.Rs.getString("actor_hit")%></td>
	                        <td><%= this.ActorDAO.DBMgr.Rs.getString("actor_newest") %></td>
	                        <td><%= this.ActorDAO.DBMgr.Rs.getInt("face_code") %></td>
	                        <td><%= this.ActorDAO.DBMgr.Rs.getString("face_name") %></td>
	                        <td>
	                        	<% PFP = this.ActorDAO.DBMgr.Rs.getString("actor_profile_photo") != null ? this.ActorDAO.DBMgr.Rs.getString("actor_profile_photo") : "https://via.placeholder.com/100"; %>
	                        	<% PFPpath = baseUrl +"/profile/" + PFP; %>
	                            <img src="<%=PFPpath%>" alt="Profile Photo">
	                        </td>
	                        <td>
	                        	<% GIF = this.ActorDAO.DBMgr.Rs.getString("actor_worldcup_photo") != null ? this.ActorDAO.DBMgr.Rs.getString("actor_worldcup_photo") : "https://via.placeholder.com/100"; %>
	                           	<% GIFpath = baseUrl +"/gif/" + GIF; %>
	                           	<%System.out.println(GIFpath); %>
	                            <img src="<%=GIFpath%>" alt="World Cup Photo">
	                        </td>
	                    </tr>
	            <% } 
	            } else { %>
	                <tr>
	                    <td colspan="9">No data found</td>
	                </tr>
	            <% } %>
	        </tbody>
	    </table>
	</body>
</html>
			


