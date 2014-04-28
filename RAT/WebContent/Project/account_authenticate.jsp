<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema";
	String mysUserID = "tester";
	String mysPassword = "test";
	
	if((!username.matches("[\\w]{1,20}")) || (!password.matches("[\\w]{1,20}"))){
		response.sendRedirect("errors/login_error.html");
	}
	
	Connection conn = null;
	try{
		Class.forName(mysJDBCDriver).newInstance();
		Properties sysprops = System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
	
		conn = DriverManager.getConnection(mysURL,sysprops);
		
		conn.setAutoCommit(false);
		Statement stmt1 = conn.createStatement();
		
		ResultSet rs = stmt1.executeQuery("SELECT * FROM Login WHERE username='"+username+"' AND password='"+password+"'");
		if(rs.next()){
			session.setAttribute("username",rs.getString("username"));
			session.setAttribute("id",rs.getInt("id"));
			String type = rs.getString("type");
			
			rs = stmt1.executeQuery("SELECT * FROM person WHERE id="+session.getAttribute("id"));
			rs.next();
			session.setAttribute("name", rs.getString("firstName") + " " + rs.getString("lastName"));
			
			response.sendRedirect(type+"/home.jsp");
		}
		else{
			// Invalid login info
			response.sendRedirect("errors/login_error.html");
		}
	} catch(Exception e){}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	%>
</BODY>
</HTML>