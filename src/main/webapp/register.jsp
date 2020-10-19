<%@ page import="java.sql.*" %><%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 14.10.2020
  Time: 17:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Registration form</title>
    <link rel="stylesheet" href="css/login.css">
</head>
<body>
    <div class="wrapper fadeInDown">
        <div id="formContent">
            <h2 class="active">Register</h2>
            <div class="fadeIn first">
                <img width="100" src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/User_font_awesome.svg/1200px-User_font_awesome.svg.png" id="icon" alt="User Icon"/>
            </div>
            <form method="post" action="register.jsp">
                <input type="text" id="login" class="fadeIn second" name="username" placeholder="username" required>
                <input type="email" id="email" class="fadeIn second" name="email" placeholder="email" required>
                <input type="password" id="password" class="fadeIn third" name="password" placeholder="password" required>
                <input type="submit" class="fadeIn fourth" value="Register">
            </form>
        </div>
    </div>
<%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mangaOnline?serverTimezone=UTC","root","");
        String username,email,password;
        username=request.getParameter("username");
        email=request.getParameter("email");
        password=request.getParameter("password");
        String query;
        if(username!=null) {
            query="insert into users values('"+username+"','"+email+"','"+password+"')";
            Statement stmt=con.createStatement();
            ResultSet check= stmt.executeQuery("select * from users where username='"+username+"' or email='"+email+"'");
            if(check.next()) {
                out.println("<script>alert('A user with same data has already been registered');</script>");
            } else {
                PreparedStatement pst=con.prepareStatement(query);
                int i=pst.executeUpdate();
                Statement st=con.createStatement();
                ResultSet rs=st.executeQuery("select * from users");
                response.sendRedirect("index.jsp");
            }
        }
    } catch(Exception e) {
        out.println(e);
    }
%>
</body>
</html>
