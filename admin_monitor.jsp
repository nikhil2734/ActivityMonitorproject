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

        /* Vibrant Glowing Title */
        h2 {
            font-weight: 800;
            letter-spacing: -0.5px;
            color: #ffffff;
            text-shadow: 0 0 15px rgba(255, 255, 255, 0.4), 0 0 30px rgba(99, 102, 241, 0.3);
            margin-top: 50px;
            text-align: center;
        }

        .monitor-card {
            background: var(--glass);
            backdrop-filter: blur(25px);
            -webkit-backdrop-filter: blur(25px);
            border: 1px solid var(--border);
            border-radius: 24px;
            overflow: hidden;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.6);
            margin-top: 30px;
        }

        .table {
            color: #e2e8f0 !important;
            margin-bottom: 0;
            vertical-align: middle;
        }

        /* VISIBLE HEADERS SECTION */
        .table thead {
            background: rgba(255, 255, 255, 0.08);
        }

        .table thead th {
            border: none;
            color: #ffffff !important; /* Forces bright white */
            font-weight: 700;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 1.5px;
            padding: 22px;
            text-shadow: 0 0 8px rgba(255, 255, 255, 0.5);
        }

        .table tbody tr {
            border-bottom: 1px solid var(--border);
            transition: background 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(255, 255, 255, 0.03);
        }

        .table td {
            padding: 20px;
            border: none;
            font-size: 0.95rem;
        }

        .id-text {
            color: #818cf8;
            font-weight: 800;
            font-family: monospace;
        }

        .user-text {
            color: #ffffff;
            font-weight: 600;
        }

        .action-pill {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 10px;
            font-size: 0.85rem;
            font-weight: 700;
            background: rgba(34, 211, 238, 0.15);
            color: #22d3ee;
            border: 1px solid rgba(34, 211, 238, 0.3);
            text-shadow: 0 0 10px rgba(34, 211, 238, 0.5);
        }

        .time-text {
            color: #94a3b8;
            font-size: 0.85rem;
        }

        .container {
            max-width: 1000px;
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
                    <th>ID</th>
                    <th>USER</th>
                    <th>ACTION</th>
                    <th>TIME</th>
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