<%@page import="BeansHome.Actor.ActorDAO"%>
<%@page import="BeansHome.Actor.ActorDTO" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Actor List</title>
</head>

<body>
    <!-- 라운드 정보 출력 -->
    <p>선택된 라운드: 
        <%
    String round = (String) session.getAttribute("round");
                if (round != null) {
                    out.print(round);
                } else {
                    out.print("정보 없음");
                }
    %>
    </p>

    <!-- ActorDTOList 출력 -->
    <%
    ArrayList<ActorDTO> actorList =  (ArrayList) session.getAttribute("list");
            if (actorList != null && !actorList.isEmpty()) {
                ActorDTO firstActor = actorList.get(0);
                session.setAttribute("winnerActor", firstActor);
    %>
        <p>참가자 수: <%=actorList.size()%></p>
        <h2>참가자 리스트</h2>
		<table border="1">
		    <thead>
		        <tr>
		            <th>ID</th>
		            <th>이름</th>
		            <th>얼굴 코드</th>
		            <th>사진</th>
		        </tr>
		    </thead>
		    <tbody>
		        <%
		        for (ActorDTO actor : actorList) {
		        %>
		        <tr>
		            <td><%= actor.getActorID() %></td>
		            <td><%= actor.getActorName() %></td>
		            <td><%= actor.getFaceCode() %></td>
		            <td><img src="<%= actor.getActorWorldcupPhoto() %>" alt="사진" style="width:100px; height:auto;"></td>
		        </tr>
		        <% 
		            }
		        %>
		    </tbody>
		</table>

        <!-- 결과 페이지로 이동 버튼 -->
        <form action="winner.jsp" method="post">
            <button type="submit">결과 페이지로 이동</button>
        </form>

    <%
        } else {
    %>
        <p>참가자가 없습니다.</p>
    <%
        }
    %>
</body>
</html>
