import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class ActivityServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String activity = request.getParameter("activity");

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("user") : "Unknown";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/activitydb", "root", "nikhil@1234");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO activity_log (username, action_performed) VALUES (?, ?)");

            ps.setString(1, username);
            ps.setString(2, activity);

            int result = ps.executeUpdate();

            con.close();

            if (result > 0) {
                // ✅ Redirect to dashboard with success message
                response.sendRedirect("dashboard.html?status=success&msg=" + activity);
            } else {
                response.sendRedirect("dashboard.html?status=error");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.html?status=error");
        }
    }
}