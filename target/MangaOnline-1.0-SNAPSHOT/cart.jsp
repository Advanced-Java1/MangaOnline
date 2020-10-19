<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 16.10.2020
  Time: 18:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping cart</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<%@page import="java.util.ArrayList"%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="items.Item" %>
<%@ page import="items.Manga" %>
<%@ page import="java.util.List" %>
<%@ page import="items.Manhwa" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Shopping cart</title>
    <link rel="stylesheet" href="css/cart.css">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
</head>
<body>
    <%
        ArrayList<String> mangaList = new ArrayList<>();
        ArrayList<String> manhwaList = new ArrayList<>();
        List<Item> items = new ArrayList<>();
        Integer totalprice = 0;
        Integer numberOfItems = 0;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if(cookie.getName().contains("manga")) {
                    mangaList.add(cookie.getValue());
                    numberOfItems++;
                }
                if(cookie.getName().contains("manhwa")) {
                    manhwaList.add(cookie.getValue());
                    numberOfItems++;
                }
            }
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mangaOnline?serverTimezone=UTC","root","");
                Statement stmt = con.createStatement();
                for (String id : mangaList) {
                    ResultSet rs = stmt.executeQuery("select * from manga where id="+id);
                    while (rs.next()) {
                        Manga manga = new Manga(rs.getInt("id"),rs.getString("name"),rs.getString("author"),rs.getString("genre"),rs.getInt("price"));
                        items.add(manga);
                        totalprice+=manga.getPrice();
                    }
                }
                for (String id : manhwaList) {
                    ResultSet rs = stmt.executeQuery("select * from manhwa where id="+id);
                    while (rs.next()) {
                        Manhwa manhwa = new Manhwa(rs.getInt("id"),rs.getString("name"),rs.getString("author"),rs.getString("genre"),rs.getInt("price"));
                        items.add(manhwa);
                        totalprice+=manhwa.getPrice();
                    }
                }
            } catch(Exception e) {
                System.out.println(e.getMessage());
            }
        }
        request.setAttribute("items", items);
        session.setAttribute("totalprice",totalprice);
        session.setAttribute("numberOfItems",numberOfItems);
    %>

    <h2>Shopping cart</h2>

    <div class="container">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-responsive" data-pattern="priority-columns">
                    <table class="table table-bordered table-hover">
                        <thead>
                        <c:if test="${!empty items}">
                            <caption class="text-center">Items</caption>
                        <tr>
                            <th data-priority="1">Name</th>
                            <th data-priority="2">Author</th>
                            <th data-priority="3">Genre</th>
                            <th data-priority="4">Price</th>
                        </tr>
                        </c:if>
                        <c:if test="${empty items}">
                            <caption class="text-center">No Items</caption>
                        </c:if>
                        </thead>
                        <tbody>
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td><c:out value="${item.getName()}"/></td>
                                <td><c:out value="${item.getAuthor()}"/></td>
                                <td><c:out value="${item.getGenre()}"/></td>
                                <td><c:out value="${item.getPrice()}"/></td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <center>
                    <c:if test="${empty items}">
                        <a style="text-decoration: none;" class="btn btn-primary" href="items.jsp">Go Back</a>
                    </c:if>
                    <c:if test="${!empty items}">
                        <form action="ConfirmationServlet" method="post">
                            <button type="submit" class="btn btn-primary">Pay</button>
                        </form>
                    </c:if>
                    </center>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
