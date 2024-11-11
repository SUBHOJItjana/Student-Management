<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.*"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            color: #333;
            margin: 0;
            padding: 20px;
        }
        h1 {
            color: #608BC1;
            margin:10px 35%;
        }
        h2 {
            color: #333;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #ffffff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }
        th, td {
            border: 1px solid #dddddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #133E87;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        .error-message {
            color: red;
            font-weight: bold;
        }
        .action-buttons {
            display: flex;
            gap: 5px;
        }
        .action-buttons button {
            padding: 5px 10px;
            color: white;
            border: none;
            cursor: pointer;
        }
        .update-button {
            background-color: #28a745;
        }
        .delete-button {
            background-color: #dc3545;
        }
    </style>
</head>
<body>
<h1>Welcome to Dashboard</h1>
 <%
        String url = "jdbc:postgresql://localhost:5432/Student_Management?user=postgres&password=root";
        String driver = "org.postgresql.Driver";

        String userEmail = request.getParameter("uemail");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        PrintWriter pw = response.getWriter();

        try {
            Class.forName(driver);

            conn = DriverManager.getConnection(url);

            // Fetch specific user details
            String sql = "SELECT name, email, std, phone FROM students WHERE email = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                int std = rs.getInt("std");
                String phone = rs.getString("phone");

                out.println("<h2>Student Details:</h2>");
                out.println("<table>");
                out.println("<tr><th>Name</th><td>" + name + "</td></tr>");
                out.println("<tr><th>Email</th><td>" + email + "</td></tr>");
                out.println("<tr><th>Standard</th><td>" + std + "</td></tr>");
                out.println("<tr><th>Phone</th><td>" + phone + "</td></tr>");
                out.println("</table>");
            } else {
                out.println("<p class='error-message'>No user found with the provided email.</p>");
            }

            // Close previous statement and result set
            rs.close();
            pstmt.close();

            // Fetch all students
            String sql1 = "SELECT name, email, std, phone FROM students WHERE email = ?";
            pstmt = conn.prepareStatement(sql1);
            pstmt.setString(1, userEmail);
            rs = pstmt.executeQuery();

            out.println("<h2>All Students:</h2>");
            out.println("<table>");
            out.println("<tr><th>Name</th><th>Email</th><th>Standard</th><th>Phone</th><th>Actions</th></tr>");

            while (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                int std = rs.getInt("std");
                String phone = rs.getString("phone");

                out.println("<tr>");
                out.println("<td>" + name + "</td>");
                out.println("<td>" + email + "</td>");
                out.println("<td>" + std + "</td>");
                out.println("<td>" + phone + "</td>");
                out.println("<td>");
                out.println("<div class='action-buttons'>");
                out.println("<form action='UpdateStudent.jsp' method='POST' style='display:inline;'>");
                out.println("<input type='hidden' name='email' value='" + email + "'>");
                out.println("<button class='update-button'>Update</button>");
                out.println("</form>");
                out.println("<form action='DeleteStudent.jsp' method='POST' style='display:inline;'>");
                out.println("<input type='hidden' name='email' value='" + email + "'>");
                out.println("<button class='delete-button'>Delete</button>");
                out.println("</form>");
                out.println("</div>");
                out.println("</td>");
                out.println("</tr>");
            }
            out.println("</table>");

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p class='error-message'>Error accessing the database: " + e.getMessage() + "</p>");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            out.println("<p class='error-message'>JDBC Driver not found: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>

</body>
</html>
