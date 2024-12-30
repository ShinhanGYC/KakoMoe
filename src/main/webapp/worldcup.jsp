<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>선택된 라운드: ${round}</p>
	<form action="result.jsp" method="get" enctype="multipart/form-data">
	    <label for="name">배우 이름:</label>
	    <input type="text" id="name" name="name" required>
	<button type="submit">결과</button>
	
	</form>
</body>
</html>