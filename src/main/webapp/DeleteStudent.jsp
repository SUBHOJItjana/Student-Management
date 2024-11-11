
<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            text-align: center;
            margin-top: 50px;
        }
        .message {
            background-color: #ffffff;
            padding: 20px;
            display: inline-block;
            border-radius: 4px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        .success {
            color: #28a745;
        }
        .error {
            color: #dc3545;
        }
        a {
            color: #007BFF;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<%
    String url = "jdbc:postgresql://localhost:5432/Student_Management?user=postgres&password=root";
    String driver = "org.postgresql.Driver";

    String email = request.getParameter("email");

    Connection conn = null;
    PreparedStatement pstmt = null;
    PrintWriter pw=response.getWriter();

    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url);

        String sql = "DELETE FROM students WHERE email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);

        int deletedRows = pstmt.executeUpdate();
        if (deletedRows > 0) {
            pw.println("<div class='message success'>Student deleted successfully.</div>");
        } else {
            pw.println("<div class='message error'>Error deleting student.</div>");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
<br><br>
<a href="DashBoard.jsp">Return to Dashboard</a>
</body>
</html>
