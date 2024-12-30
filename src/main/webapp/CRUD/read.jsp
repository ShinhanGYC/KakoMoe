<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="BeansHome.Actor.ActorDAO" %>
<%
    request.setCharacterEncoding("UTF-8");
    String searchName = request.getParameter("name") != null ? request.getParameter("name") : "-1";
    String faceFilter = request.getParameter("face") != null ? request.getParameter("face") : "-1";
    ActorDAO actorDAO = new ActorDAO();
    ResultSet rs = actorDAO.searchActors(searchName, faceFilter);
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Actor Data</title>
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
</head>
<body>
    <h1>Actor Data</h1>
    <div class="search-container">
        <form action="" method="get">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= searchName %>" placeholder="Enter name">
            <label for="face">Face Type:</label>
            <select id="face" name="face">
                <option value="-1" <%= faceFilter.equals("-1") ? "selected" : "" %>>All</option>
                <option value="0" <%= faceFilter.equals("0") ? "selected" : "" %>>Salty</option>
                <option value="1" <%= faceFilter.equals("1") ? "selected" : "" %>>Soy Sauce</option>
                <option value="2" <%= faceFilter.equals("2") ? "selected" : "" %>>Mayonnaise</option>
                <option value="3" <%= faceFilter.equals("3") ? "selected" : "" %>>Miso</option>
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
            <% if (rs != null) {
                while (rs.next()) { %>
                    <tr>
                        <td><%= rs.getInt("actor_id") %></td>
                        <td><%= rs.getString("actor_name") %></td>
                        <td><%= rs.getString("actor_debut") %></td>
                        <td><%= rs.getString("actor_hit") %></td>
                        <td><%= rs.getString("actor_newest") %></td>
                        <td><%= rs.getInt("face_code") %></td>
                        <td><%= rs.getString("face_name") %></td>
                        <td>
                            <img src="<%= rs.getString("actor_profile_photo") != null ? rs.getString("actor_profile_photo") : "https://via.placeholder.com/100" %>" alt="Profile Photo">
                        </td>
                        <td>
                            <img src="<%= rs.getString("actor_worldcup_photo") != null ? rs.getString("actor_worldcup_photo") : "https://via.placeholder.com/100" %>" alt="World Cup Photo">
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
