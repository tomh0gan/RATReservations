<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	 <% if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	   }
  	 %>
	<%	
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
		
		String id = request.getParameter("id");
		String ssn = request.getParameter("ssn");
		
		
		Statement stmt1 = conn.createStatement();
		stmt1.execute("START TRANSACTION;");
		String retrieve = "SELECT resrNum FROM Reservation WHERE represSSN='"+ ssn +"'";
		java.sql.ResultSet rs = stmt1.executeQuery(retrieve);
		while(rs.next()){
			String u = "UPDATE Reservation SET represSSN=null WHERE resrNum=" + rs.getString(1) + " AND represSSN= " + ssn +";";
			stmt1.addBatch(u);
		}
		stmt1.executeBatch();
		stmt1.execute("COMMIT;");
		
		
		Statement stmt2 = conn.createStatement();
		stmt2.execute("START TRANSACTION;");
		String a,b,c;
		a = "DELETE FROM Employee WHERE id = '" + id + "' ";
		stmt2.execute(a);
		b = "DELETE FROM Login WHERE id = '" + id + "' ";
		stmt2.addBatch(b);
		c = "DELETE FROM Person WHERE id = '" + id + "' ";
		stmt2.addBatch(c);
		
		stmt2.executeBatch();
		stmt2.execute("COMMIT;");
		response.sendRedirect("manager_employee_page.jsp");
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	%>
</BODY>
</HTML>