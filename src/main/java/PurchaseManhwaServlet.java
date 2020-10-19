import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/PurchaseManhwaServlet")
public class PurchaseManhwaServlet extends HttpServlet {
    private static int SERIAL_ID=0;
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String item = "manhwa"+id+"n"+SERIAL_ID;
        SERIAL_ID++;
        Cookie itemCookie = new Cookie(item,id);
        itemCookie.setMaxAge(60);
        response.addCookie(itemCookie);
        Cookie[] cookies = request.getCookies();
        for (Cookie cookie : cookies) {
            if (cookie.getName().contains("manga") || cookie.getName().contains("manhwa")) {
                cookie.setMaxAge(-1);
                response.addCookie(cookie);
            }
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().contains("manga") || cookie.getName().contains("manhwa")) {
                cookie.setMaxAge(60);
                response.addCookie(cookie);
            }
        }
        response.sendRedirect("items.jsp");
    }
}
