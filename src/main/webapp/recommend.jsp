<%@page import="BeansHome.Actor.NewActorDTO"%>
<%@page import="BeansHome.Actor.NewActorDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recommend Actor</title>
<script>
    function recommendActor() {
        let actorId = document.getElementById("actorId").value;
        if (!actorId) {
            alert("Please enter an actor ID.");
            return;
        }
        document.getElementById("recommendForm").submit();
    }
</script>
</head>
<%!
	public NewActorDAO ActorDAO = new NewActorDAO();

%>
<%
	int actorID;
	String actorIdString = null;
	boolean bContinue = false;
%>
<%
	actorIdString = request.getParameter("actorId");
	actorIdString = actorIdString == null ? "0" : actorIdString;
	actorID = Integer.parseInt(actorIdString);
	
%>
<%
	if (this.ActorDAO.takeRecommendActorSameFaceCode(actorID) == true)
	{
		if (this.ActorDAO.DBMgr != null && this.ActorDAO.DBMgr.Rs != null)
		{
			bContinue = true;
		}
	}
%>
<body>
    <h1>Recommend Actors with Same Face Code</h1>
    <form id="recommendForm" method="post" action="recommend.jsp">
        <label for="actorId">Actor ID:</label>
        <input type="text" id="actorId" name="actorId" required>
        <button type="button" onclick="recommendActor()">Submit</button>
    </form>
    	<% if (bContinue == true) {
    		while(this.ActorDAO.DBMgr.Rs.next() == true) { %>
    						<p><%= this.ActorDAO.DBMgr.Rs.getInt("actor_id") %></p>
	                        <p><%= this.ActorDAO.DBMgr.Rs.getString("actor_name") %></p>
	                        <p><%= this.ActorDAO.DBMgr.Rs.getString("actor_debut") %></p>
	                        <p><%= this.ActorDAO.DBMgr.Rs.getString("actor_hit")%></p>
	                        <p><%= this.ActorDAO.DBMgr.Rs.getString("actor_newest") %></p>
	                        <p><%= this.ActorDAO.DBMgr.Rs.getInt("face_code") %></p>
	                        <p><%= this.ActorDAO.DBMgr.Rs.getString("face_name") %></p>
    
			<%}} %>
</body>
</html>
