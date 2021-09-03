<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	person展示<br>
	<c:forEach items="${list}" var="per" >
		id:${per.id}--姓名:${per.name }<br>
	</c:forEach>
</body>
</html>