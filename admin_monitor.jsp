<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Monitor | MonitorX</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --primary: #6366f1;
            --accent: #22d3ee;
            --glass: rgba(255, 255, 255, 0.05);
            --border: rgba(255, 255, 255, 0.1);
            --header-bg: #2d3436; /* Dark background matching image_955df7.png */
        }

        body {
            margin: 0;
            font-family: 'Plus Jakarta Sans', sans-serif;
            min-height: 100vh;
            background: #0f172a;
            color: white;
            background: radial-gradient(circle at 50% 50%, #1e1b4b 0%, #0f172a 100%);
            padding-bottom: 50px;
        }

        h2 {
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #ffffff;
            text-shadow: 0 0 15px rgba(255, 255, 255, 0.4), 0 0 30px rgba(99, 102, 241, 0.3);
            margin-top: 50px;
            text-align: center;
        }

        .monitor-card {
            background: white; /* Changed to white background for table area to match image_955df7.png */
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            margin-top: 30px;
            border: 1px solid var(--border);
        }

        .table {
            margin-bottom: 0;
            vertical-align: middle;
            background-color: white;
        }

        /* STYLED HEADER MATCHING image_955df7.png */
        .table thead {
            background-color: var(--header-bg);
        }

        .table thead th {
            border: none;
            color: #000000 !important;
            font-weight: 700;
            padding: 15px 20px;
            font-size: 0.9rem;
            text-align: left;
        }

        /* TABLE BODY STYLING */
        .table tbody tr {
            border-bottom: 1px solid #eee;
            transition: background 0.2s ease;
        }

        .table tbody tr:nth-of-type(even) {
            background-color: #f9f9f9; /* Light alternating stripes */
        }

        .table tbody tr:hover {
            background: rgba(99, 102, 241, 0.05);
        }

        .table td {
            padding: 12px 20px;
            border: none;
            font-size: 0.9rem;
            color: #333; /* Dark text for readability on white background */
        }

        /* VIBRANT ELEMENTS MAINTAINED */
        .id-text {
            color: #1e1b4b;
            font-weight: 700;
        }

        .user-text {
            color: #444;
            font-weight: 500;
        }

        .action-pill {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            background: rgba(34, 211, 238, 0.1);
            color: #0891b2;
            border: 1px solid rgba(34, 211, 238, 0.2);
        }

        .time-text {
            color: #666;
            font-size: 0.85rem;
        }

        .container {
            max-width: 1100px;
        }
    </style>
</head>

<body>

<div class="container">
    <h2>Admin Activity Monitor</h2>

    <div class="monitor-card">
        <table class="table">
            <thead>
                <tr>
                    <th style="width: 10%;">ID</th>
                    <th style="width: 20%;">User</th>
                    <th style="width: 35%;">Action</th>
                    <th style="width: 35%;">Time</th>
                </tr>
            </thead>
            <tbody>
<%
try {
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = DriverManager.getConnection(
        "jdbc:mysql://localhost:3306/activitydb", "root", "nikhil@1234");

    Statement st = con.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM activity_log ORDER BY id DESC");

    while(rs.next()) {
%>
                <tr>
                    <td class="id-text"><%= rs.getInt("id") %></td>
                    <td class="user-text"><%= rs.getString("username") %></td>
                    <td><span class="action-pill"><%= rs.getString("action_performed") %></span></td>
                    <td class="time-text"><%= rs.getString("action_time") %></td>
                </tr>
<%
    }
    con.close();
} catch(Exception e) {
%>
                <tr><td colspan="4" class="text-center text-danger">Error: <%= e.getMessage() %></td></tr>
<%
}
%>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>