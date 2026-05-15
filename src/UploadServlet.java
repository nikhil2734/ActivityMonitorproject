import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.MultipartConfig;
import java.sql.*;

@MultipartConfig
public class UploadServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String username = (session != null) ? (String) session.getAttribute("user") : "Unknown";

        // 1. Handle the file upload
        Part filePart = request.getPart("myfile");
        String fileName = filePart.getSubmittedFileName();
        
        // Change this path to a real folder on the laptop
        String uploadPath = "C:" + File.separator + "uploads"; 
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);

        // 2. Log to Database
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/activitydb", "root", "nikhil@1234");

            PreparedStatement ps = con.prepareStatement(
                    "INSERT INTO activity_log(username, action_performed) VALUES (?, ?)");
            ps.setString(1, username);
            ps.setString(2, "Uploaded file: " + fileName);
            ps.executeUpdate();
            con.close();

            response.sendRedirect("dashboard.html?status=success&msg=File Uploaded Successfully");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("dashboard.html?status=error");
        }
    }
}