<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<html>
<head></head>
<body>

<%
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String passCurr = request.getParameter("passCurr");
	String passNew = request.getParameter("passNew");
	
	if(passCurr.equals(passNew)){
		invalidInputs += "- 'Current Password' and 'New Password' input are the same<BR>";
		invalidInput = true;
	}
	else{
		if(!passCurr.matches("[\\w]{1,20}")){
			invalidInputs += "- 'Current Password' input invalid, should be non-empty and at most 20 letters/digits<BR>";
			invalidInput = true;
		}
		if(!passNew.matches("[\\w]{1,20}")){
			invalidInputs += "- 'New Password' input invalid, should be non-empty and at most 20 letters/digits<BR>";
			invalidInput = true;
		}
	}
	if(invalidInput){
		System.out.println(invalidInputs);
		session.setAttribute("error", invalidInputs);
		response.sendRedirect("../errors/customer_account_error.jsp");
		return;
	}
	
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema";
	String mysUserID = "tester";
	String mysPassword = "test";
	
	Connection conn = null;
	try{
		Class.forName(mysJDBCDriver).newInstance();
		Properties sysprops = System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
		
		conn = DriverManager.getConnection(mysURL,sysprops);
		
		Statement stmt1 = conn.createStatement();
		
		ResultSet rs = stmt1.executeQuery("SELECT * FROM login WHERE id="+session.getAttribute("id"));
		if(rs.next()){
			if(passCurr.equals(rs.getString("password"))){
				stmt1.executeUpdate("UPDATE login SET password='"+passNew+"' WHERE id="+session.getAttribute("id"));
				response.sendRedirect("change_password_success.jsp");
				
			}else{
				session.setAttribute("error", "- 'Current Password' is incorrect<BR>");
				response.sendRedirect("../errors/customer_account_error.jsp");
			}
		}
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
%>
</body>
</html>