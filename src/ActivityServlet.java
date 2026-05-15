import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.sql.*;

@MultipartConfig // This is required for file uploads
public class ActivityServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String activity = request.getParameter("activity");
        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("user") : "Unknown";
        
        String detail = ""; // To store filename or status

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/activitydb", "root", "nikhil@1234");

            if ("File Uploaded".equals(activity)) {
                // Get file info
                Part filePart = request.getPart("fileInput"); 
                detail = filePart.getSubmittedFileName();
                // In a real app, you'd save the file to a folder here
            } 
            else if ("Password Changed".equals(activity)) {
                String newPass = request.getParameter("newPassword");
                // UPDATE the real user table
                PreparedStatement psUpdate = con.prepareStatement("UPDATE users SET password=? WHERE username=?");
                psUpdate.setString(1, newPass);
                psUpdate.setString(2, username);
                psUpdate.executeUpdate();
                detail = "Success";
            }

            // Log the activity to the Admin Monitor
            PreparedStatement psLog = con.prepareStatement(
                    "INSERT INTO activity_log (username, action_performed) VALUES (?, ?)");
            psLog.setString(1, username);
            psLog.setString(2, activity + " (" + detail + ")");
            psLog.executeUpdate();

            con.close();
            response.sendRedirect("dashboard.html?status=success&msg=" + activity);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.html?status=error");
        }
    }
}