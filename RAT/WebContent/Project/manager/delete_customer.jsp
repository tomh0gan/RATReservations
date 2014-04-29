<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
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
		
		String accountNum = request.getParameter("accountNum");
		String id = request.getParameter("id");
		
		Statement stmt1 = conn.createStatement();
		String retrieve = "SELECT resrNum FROM Reservation WHERE accountNum='"+ accountNum +"'";
		java.sql.ResultSet rs = stmt1.executeQuery(retrieve);
		while(rs.next()){
			String d = "DELETE FROM Reservation WHERE resrNum=" + rs.getString(1) + ";";
			stmt1.execute(d);
		}
		
		Statement stmt2 = conn.createStatement();
		String a,b,c;
		a = "DELETE FROM Customer WHERE accountNum = '" + accountNum + "' ";
		stmt2.execute(a);
		b = "DELETE FROM Login WHERE id = '" + id + "' ";
		stmt2.addBatch(b);
		c = "DELETE FROM Person WHERE id = '" + id + "' ";
		stmt2.addBatch(c);
		
		stmt2.executeBatch();
		response.sendRedirect("manager_customers.jsp");
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	%>
</BODY>
</HTML>