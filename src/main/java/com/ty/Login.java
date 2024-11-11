package com.ty;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/loginservlet")
public class Login extends HttpServlet {

	private static final long serialVersionUID = 1L;
	static String url = "jdbc:postgresql://localhost:5432/Student_Management?user=postgres&password=root";
	static String driver = "org.postgresql.Driver";
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String email = req.getParameter("uemail");
		String password = req.getParameter("upassword");
		
		try {
			Class.forName(driver);
			Connection conn = DriverManager.getConnection(url);
			
			String sql = "SELECT email FROM students WHERE email = ? AND password = ?";
			PreparedStatement pstm = conn.prepareStatement(sql);
			
			// Set parameters correctly
			pstm.setString(1, email);
			pstm.setString(2, password);

            ResultSet rs = pstm.executeQuery();
            PrintWriter pw = resp.getWriter();
            System.out.println(rs);
            
            if (rs.next()) {
            	System.out.println("Executing Query");
            	System.out.println("Forwarding to Dashboard...");
            	req.setAttribute(email, "uemail");

            	RequestDispatcher rd = req.getRequestDispatcher("DashBoard.jsp");
                rd.forward(req, resp);
            } else {
            	RequestDispatcher rd = req.getRequestDispatcher("Registration.jsp");

                rd.include(req, resp);
                pw.print("<h1>Invalid Credentials or User Does Not Exist</h1>");
            }
            
            rs.close();
            pstm.close();
            conn.close();
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}
}
