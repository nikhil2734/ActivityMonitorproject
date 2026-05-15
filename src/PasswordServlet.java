import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.sql.*;

public class PasswordServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("user") : "Unknown";
        String newPassword = request.getParameter("newpassword");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/activitydb", "root", "nikhil@1234");

            // Update the user's password
            PreparedStatement ps = con.prepareStatement("UPDATE users SET password=? WHERE username=?");
            ps.setString(1, newPassword);
            ps.setString(2, username);
            int result = ps.executeUpdate();

            // Log the action
            PreparedStatement logPs = con.prepareStatement(
                    "INSERT INTO activity_log(username, action_performed) VALUES (?, ?)");
            logPs.setString(1, username);
            logPs.setString(2, "Password Changed");
            logPs.executeUpdate();

            con.close();
            if (result > 0) {
                response.sendRedirect("dashboard.html?status=success&msg=Password Updated Successfully");
            } else {
                response.sendRedirect("dashboard.html?status=error");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.html?status=error");
        }
    }
}