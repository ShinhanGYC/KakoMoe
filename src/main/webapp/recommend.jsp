<%@page import="BeansHome.Actor.ActorDTO"%>
<%@page import="BeansHome.Actor.ActorDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recommend Actor</title>
</head>
<%!public ActorDAO ActorDAO = new ActorDAO();%>
<%
    int actorID = 0;
    boolean bContinue = false;

    // 이전 페이지에서 전달된 session 데이터 가져오기
    ActorDTO winnerActor = (ActorDTO) session.getAttribute("winnerActor");
    if (winnerActor != null) {
        actorID = winnerActor.getActorID(); // winnerActor 객체에서 ID 가져오기
    }
%>
<%
    if (actorID > 0 && this.ActorDAO.takeRecommendActorSameFaceCode(actorID)) {
        if (this.ActorDAO.DBMgr != null && this.ActorDAO.DBMgr.Rs != null) {
            bContinue = true;
        }
    }
%>
<body>
    <h1>Recommend Actors</h1>

    <!-- Winner Actor 정보 테이블 -->
    <h2>Winner Actor Information</h2>
    <% if (winnerActor != null) { %>
        <table border="1">
            <thead>
                <tr>
                    <th>Actor ID</th>
                    <th>Name</th>
                    <th>Debut</th>
                    <th>Hit</th>
                    <th>Newest</th>
                    <th>Face Code</th>
                    <th>Face Name</th>
                    <th>Profile Photo</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td><%= winnerActor.getActorID()%></td>
                    <td><%= winnerActor.getActorName() %></td>
                    <td><%= winnerActor.getActorDebut()%></td>
                    <td><%= winnerActor.getActorHit() %></td>
                    <td><%= winnerActor.getActorNewest() %></td>
                    <td><%= winnerActor.getFaceCode() %></td>
                    <td><%= winnerActor.getFaceName() %></td>
                    <td><%= winnerActor.getActorProfilePhoto()%></td>
                </tr>
            </tbody>
        </table>
    <% } else { %>
        <p>No winner actor information found.</p>
    <% } %>

    <!-- 추천 배우 테이블 -->
    <h2>Recommended Actors with Same Face Code</h2>
    <% if (bContinue) { %>
        <table border="1">
            <thead>
                <tr>
                    <th>Actor ID</th>
                    <th>Name</th>
                    <th>Debut</th>
                    <th>Hit</th>
                    <th>Newest</th>
                    <th>Face Code</th>
                    <th>Face Name</th>
                    <th>Profile Photo</th>
                    
					
                </tr>
            </thead>
            <tbody>
                <% 
                while (this.ActorDAO.DBMgr.Rs.next()) { 
                    int id = this.ActorDAO.DBMgr.Rs.getInt("actor_id");
                    String name = this.ActorDAO.DBMgr.Rs.getString("actor_name");
                    String debut = this.ActorDAO.DBMgr.Rs.getString("actor_debut");
                    String hit = this.ActorDAO.DBMgr.Rs.getString("actor_hit");
                    String newest = this.ActorDAO.DBMgr.Rs.getString("actor_newest");
                    int faceCode = this.ActorDAO.DBMgr.Rs.getInt("face_code");
                    String faceName = this.ActorDAO.DBMgr.Rs.getString("face_name");
					String profilePhoto = this.ActorDAO.DBMgr.Rs.getString("actor_profile_photo");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= name %></td>
                    <td><%= debut %></td>
                    <td><%= hit %></td>
                    <td><%= newest %></td>
                    <td><%= faceCode %></td>
                    <td><%= faceName %></td>
                    <td><%= profilePhoto %></td>
                    
                </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>No recommended actors found for the given ID.</p>
    <% } %>
</body>
</html>
