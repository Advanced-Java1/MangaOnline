import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/ConfirmationServlet")
public class ConfirmationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html; charset=UTF-8");
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession(true);
        String username = (String) session.getAttribute("user");
        String welcome;
        int counter = 0;
        Date createTime = new Date(session.getCreationTime());
        Date lastAccessedTime = new Date(session.getLastAccessedTime());
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().contains("manga") || cookie.getName().contains("manhwa")) {
                cookie.setMaxAge(0);
                response.addCookie(cookie);
            }
        }
        if (session.isNew()) {
            welcome = "Hi "+username+"! It is your first time you are visiting the website";
        } else {
            welcome = "Hi "+username+"!";
            Integer count = (Integer) session.getAttribute("counter");
            if (count!=null) {
                counter = count + 1;
            }
        }
        session.setAttribute("counter", counter);
        request.setAttribute("welcome", welcome);
        request.setAttribute("createTime", createTime);
        request.setAttribute("lastAccessedTime", lastAccessedTime);
        RequestDispatcher requestDispatcher = request.getRequestDispatcher("/confirmation.jsp");
        requestDispatcher.forward(request,response);
    }
}