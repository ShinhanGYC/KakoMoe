<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
        }

        .dashboard {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .dashboard button {
            width: 200px;
            padding: 15px;
            border: none;
            border-radius: 5px;
            color: white;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .dashboard .create {
            background-color: #4caf50; /* Green */
        }

        .dashboard .create:hover {
            background-color: #45a049;
        }

        .dashboard .read {
            background-color: #2196f3; /* Blue */
        }

        .dashboard .read:hover {
            background-color: #1e88e5;
        }

        .dashboard .update {
            background-color: #ffc107; /* Amber */
        }

        .dashboard .update:hover {
            background-color: #ffb300;
        }

        .dashboard .delete {
            background-color: #f44336; /* Red */
        }

        .dashboard .delete:hover {
            background-color: #e53935;
        }
    </style>
</head>
<body>
    <div class="dashboard">
        <form action="create.jsp" method="get">
            <button type="submit" class="create">Create</button>
        </form>
        <form action="read.jsp" method="get">
            <button type="submit" class="read">Read</button>
        </form>
        <form action="update.jsp" method="get">
            <button type="submit" class="update">Update</button>
        </form>
        <form action="delete.jsp" method="get">
            <button type="submit" class="delete">Delete</button>
        </form>
    </div>
</body>
</html>
