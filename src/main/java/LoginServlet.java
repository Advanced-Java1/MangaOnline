import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/mangaOnline?serverTimezone=UTC","root","");
            String username,password;
            username=request.getParameter("username");
            password =request.getParameter("password");
            PreparedStatement pst=con.prepareStatement("select username from users where username=? and password=?");
            pst.setString(1,username);
            pst.setString(2,password);
            HttpSession httpSession = request.getSession(true);
            ResultSet rs=pst.executeQuery();
            if(username!=null && password!=null ) {
                while(rs.next()) {
                    httpSession.setAttribute("user",username);
                    httpSession.setMaxInactiveInterval(-1);
                    response.sendRedirect("items.jsp");
                }
                response.sendRedirect("index.jsp");
            }
        } catch(Exception e) {
            System.out.println(e.getMessage());
        }
    }
}
