<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Student</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        h2 {
            color: #608BC1;
            margin:10px 40%
        }
        form {
            background-color: #ffffff;
            padding: 20px;
            max-width: 400px;
            margin: auto;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 8px;
            margin: 10px 0;
            box-sizing: border-box;
            border: 1px solid #dddddd;
            border-radius: 4px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
            margin:auto 150px;
        }
        input[type="submit"]:hover {
            background-color: #4CAF08;
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
    ResultSet rs = null;
    PrintWriter pw = response.getWriter();  // Get PrintWriter

    try {
        Class.forName(driver);
        conn = DriverManager.getConnection(url);

        // Fetch the student's current details
        String sql = "SELECT name, std, phone FROM students WHERE email = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, email);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String name = rs.getString("name");
            int std = rs.getInt("std");
            String phone = rs.getString("phone");

            pw.println("<h2>Update Student Details</h2>");
            pw.println("<form action='UpdateStudentAction.jsp' method='POST'>");
            pw.println("<input type='hidden' name='email' value='" + email + "'>");
            pw.println("Name: <input type='text' name='name' value='" + name + "' required><br>");
            pw.println("Standard: <input type='number' name='std' value='" + std + "' required><br>");
            pw.println("Phone: <input type='text' name='phone' value='" + phone + "' required><br>");
            pw.println("<input type='submit' value='Update'>");
            pw.println("</form>");
        } else {
            pw.println("<p>No student found with the provided email.</p>");
        }

    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</body>
</html>
