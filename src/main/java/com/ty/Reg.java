package com.ty;

import java.io.IOException;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
@WebServlet("/reg")
public class Reg extends HttpServlet{
	
	
	static  String url = "jdbc:postgresql://localhost:5432/Student_Management?user=postgres&password=root";
	static String driver = "org.postgresql.Driver";
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
	PrintWriter pw=resp.getWriter();
	
	
		
		String name=req.getParameter("name");
		String email=req.getParameter("email");
		BigDecimal phone = new BigDecimal(req.getParameter("phone"));
		BigDecimal std=new BigDecimal(req.getParameter("std"));
		String pass=req.getParameter("pass");
	
		
			try {
				
				
			Class.forName(driver);
			
			Connection conn=DriverManager.getConnection(url);
			String sql="INSERT into students VALUES(?,?,?,?,?)";
			
			
			
			
			PreparedStatement pstmt=conn.prepareStatement(sql);
			
			
			  pstmt.setString(3, name);
	            pstmt.setString(1, email);
	            pstmt.setBigDecimal(5, phone);
	            pstmt.setBigDecimal(4, std);
	            pstmt.setString(2, pass);
	            
	            int rowcount=pstmt.executeUpdate();
	            if(rowcount>0) {
	            	pw.print("<h2>Registration Succesfull!!!</h2>");
	            	req.setAttribute(name, "un");
	            	RequestDispatcher rd=req.getRequestDispatcher("Login.jsp");
	            	
	            	rd.forward(req, resp); 
	            }
	            
	            else {
	            	pw.print("<h3>Registration is Unsuccesfull Please try again!</h3>");
	            	RequestDispatcher rd=req.getRequestDispatcher("Registration.jsp");
	            	rd.include(req, resp);
	            	
	            }
	            
	            
	            pstmt.close();
	            conn.close();
		} catch (ClassNotFoundException | SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			pw.print("<h4> "+e.getMessage()+"</h4>");
			
			
			
			
			
		}
	
		
	}

}
