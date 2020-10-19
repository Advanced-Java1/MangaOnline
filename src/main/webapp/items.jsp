<%@ page import="java.sql.*" %>
<%@ page import="items.Manga" %>
<%@ page import="java.util.*" %>
<%@ page import="items.Item" %>
<%@ page import="items.Manhwa" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 13.10.2020
  Time: 14:58
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<html>
<head>
    <title>Manga</title>
    <link rel="stylesheet" href="css/items.css">
</head>
<body>
    <header>
        <h1 style="margin-left: 3vw;">Hello, <c:out value="${sessionScope.user}"/>!</h1>
        <div class="buttons">
            <div><a href="cart.jsp" class="button" style="text-decoration: none;">Shopping cart</a></div>
            <div><a href="logout.jsp" class="button" style="text-decoration: none;">Log out</a></div>
        </div>
    </header>
    <div id="tables">
    <%
        Deque<Item> itemDeque = new LinkedList<>();
        int n=0, m=0;
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mangaOnline?serverTimezone=UTC","root","");
            PreparedStatement pst = con.prepareStatement("select * from manga");
            ResultSet rs=pst.executeQuery();
            while(rs.next()) {
                Manga manga = new Manga(rs.getInt("id"),rs.getString("name"),rs.getString("author"),rs.getString("genre"),rs.getInt("price"));
                itemDeque.addFirst(manga);
                n++;
            }
            pst = con.prepareStatement("select * from manhwa");
            rs=pst.executeQuery();
            while(rs.next()) {
                Manhwa manhwa = new Manhwa(rs.getInt("id"),rs.getString("name"),rs.getString("author"),rs.getString("genre"),rs.getInt("price"));
                itemDeque.addFirst(manhwa);
                m++;
            }
        } catch(Exception e) {
            out.println(e);
        }
        Manga[] mangaArray = new Manga[n];
        Manhwa[] manhwaArray = new Manhwa[m];
        for (int i=0; i<m; i++) {
            manhwaArray[i]= (Manhwa) itemDeque.pollFirst();
        }
        for (int i=0; i<n; i++) {
            mangaArray[i]= (Manga) itemDeque.pollFirst();
        }
        for (int i=0; i<n; i++) {
            for (int j=0; j<n-1; j++) {
                if (mangaArray[j].compareTo(mangaArray[j+1]) == -1) {
                    Manga temp = mangaArray[j];
                    mangaArray[j] = mangaArray[j+1];
                    mangaArray[j+1] = temp;
                }
            }
        }
        for (int i=0; i<m; i++) {
            for (int j=0; j<m-1; j++) {
                if (manhwaArray[j].compareTo(manhwaArray[j+1]) == -1) {
                    Manhwa temp = manhwaArray[j];
                    manhwaArray[j] = manhwaArray[j+1];
                    manhwaArray[j+1] = temp;
                }
            }
        }
        Deque<Manga> mangaList = new ArrayDeque<>();
        Deque<Manhwa> manhwaList = new ArrayDeque<>();
        out.println("<div><h2>Manga list</h2><table class='blueTable'>" +
                "<thead><tr><th>Name</th><th>Author</th><th>Genre</th><th>Price</th></tr></thead><tbody>");
        for (int i=0; i<n; i++) {
            mangaList.addLast(mangaArray[i]);
            out.println("<tr><td>"+mangaList.getLast().getName()+"</td>" +
                    "<td>"+mangaList.getLast().getAuthor()+"</td>" +
                    "<td>"+mangaList.getLast().getGenre()+"</td>" +
                    "<td><form method='post' action='PurchaseMangaServlet'>"+
                    "<input name='id' type='text' style='display: none;' value='"+
                    mangaList.getLast().getId()+"'>"+
                    "<input class='purchase' type='submit' value='"+
                    " $"+mangaList.getLast().getPrice()+"'></form>" +
                    "</td></tr></tbody>");
        }
        out.println("</table></div>");
        out.println("<div><h2>Manhwa list</h2><table class='blueTable'>" +
                "<thead><tr><th>Name</th><th>Author</th><th>Genre</th><th>Price</th></tr></thead><tbody>");
        for (int i=0; i<m; i++) {
            manhwaList.addLast(manhwaArray[i]);
            out.println("<tr><td>"+manhwaList.getLast().getName()+"</td>" +
                    "<td>"+manhwaList.getLast().getAuthor()+"</td>" +
                    "<td>"+manhwaList.getLast().getGenre()+"</td>" +
                    "<td><form method='post' action='PurchaseManhwaServlet'>"+
                    "<input name='id' type='text' style='display: none;' value='"+
                    manhwaList.getLast().getId()+"'>" +
                    "<input class='purchase' type='submit' value='"+
                    " $"+manhwaList.getLast().getPrice()+"'></form>" +
                    "</td></tr></tbody>");
        }
        out.println("</table></div>");
    %>
    </div>
</body>
</html>
