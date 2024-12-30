<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>배우 등록</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="file"] {
            padding: 10px;
            width: 300px;
            font-size: 16px;
        }
        button {
            padding: 10px 20px;
            font-size: 16px;
            cursor: pointer;
        }
    </style>
    <script>
        function showAlert() {
            const resultMessage = "<%= request.getAttribute("resultMessage") != null ? request.getAttribute("resultMessage") : "" %>";
            if (resultMessage) {
                alert(resultMessage);
				window.location.href = "insertActor.jsp";
            }
        }
    </script>
</head>
<body onload="showAlert()">
    <h1>배우 등록</h1>
    <form action="ActorInsertServlet" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="actno">배우 번호:</label>
            <input type="text" id="actno" name="actno" required>
        </div>
        <div class="form-group">
            <label for="name">배우 이름:</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="photo">사진:</label>
            <input type="file" id="photo" name="photo" accept="image/*" required>
        </div>
        <button type="submit">등록</button>
    </form>
</body>
</html>
