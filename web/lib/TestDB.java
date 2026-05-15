import java.sql.*;

public class TestDB {
    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            Connection con = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/activitydb",
                "root",
                "nikhil@1234"
            );

            System.out.println("Connected successfully!");

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}