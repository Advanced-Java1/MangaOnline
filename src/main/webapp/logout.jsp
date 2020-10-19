<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 18.10.2020
  Time: 04:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Log out</title>
</head>
<body>
<%
    response.setContentType("text/html");
    Cookie[] cookies = request.getCookies();
    if(cookies != null){
        for(Cookie cookie : cookies){
            cookie.setMaxAge(0);
            response.addCookie(cookie);
        }
    }
    HttpSession httpSession = request.getSession(true);
    httpSession.removeAttribute("user");
    httpSession.setMaxInactiveInterval(0);
    httpSession.invalidate();
    response.sendRedirect("index.jsp");
%>
</body>
</html>
