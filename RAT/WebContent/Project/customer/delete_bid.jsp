<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%	
	
	if(request.getParameter("resrNum") == null){
		response.sendRedirect("home.jsp");
	}
	
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema";
	String mysUserID = "tester";
	String mysPassword = "test";
	
	String resrNum = request.getParameter("resrNum");
	
	Connection conn = null;
	try{
		Class.forName(mysJDBCDriver).newInstance();
		Properties sysprops = System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
		
		conn = DriverManager.getConnection(mysURL,sysprops);
		
		Statement stmt2 = conn.createStatement();
		String a,b,c,d;
		a = "DELETE FROM reservation_legs WHERE resrNum="+resrNum+"";
		stmt2.execute(a);
		b = "DELETE FROM reservation_passengers WHERE resrNum="+resrNum+"";
		stmt2.addBatch(b);
		c = "DELETE FROM reverse_bid WHERE resrNum="+resrNum+"";
		stmt2.addBatch(c);
		d ="DELETE FROM reservation WHERE resrNum="+resrNum+"";
		
		stmt2.executeBatch();
		response.sendRedirect("view_bids.jsp");
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	%>
</BODY>
</HTML>