<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 17.10.2020
  Time: 22:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title>Confirmation page</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<center>
    <div class="container bg-secondary text-light">
        <br>
        <h1><c:out value="${requestScope.welcome}"/></h1>
        <h2> Creation time: <c:out value="${requestScope.createTime}"/></h2>
        <h2> Last access time: <c:out value="${requestScope.lastAccessedTime}"/></h2>
        <h2> You have visited this page: <c:out value="${sessionScope.counter+1}"/>
            <c:if test="${sessionScope.counter+1 == 1}">time</h2></c:if>
        <c:if test="${sessionScope.counter+1 > 1}">times</h2></c:if>
        <h2> Total price: <c:out value="${sessionScope.totalprice}"/></h2>
        <h2> Number of items: <c:out value="${sessionScope.numberOfItems}"/></h2>
        <br><br>
    </div><br>
    <a href="items.jsp" class="btn btn-primary">Item List</a>
</center>
</body>
</html>
