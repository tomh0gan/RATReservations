<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String firstName = (String) request.getAttribute("CustomerFName");
	String lastName = (String) request.getAttribute("CustomerLName");
	String username = (String) request.getAttribute("CustomerUsername");
	String password = (String) request.getAttribute("CustomerPassword");
	String email = (String) request.getAttribute("CustomerEmail");
	String address = (String) request.getAttribute("CustomerAddress");
	String city = (String) request.getAttribute("CustomerCity");
	String state = (String) request.getAttribute("CustomerState");
	String zipcode = (String) request.getAttribute("CustomerZip");
	String creditCard = (String) request.getAttribute("CustomerCreditCard");
	
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
		
		Statement stmt2 = conn.createStatement();
		String a,b,c;
		a = "INSERT INTO person (firstName, lastName, address, city, state, zipcode) VALUES ('"+firstName+"', '"+lastName+"', '"+address+"', '"+city+"', '"+state+"', '"+zipcode+"')";
		stmt2.addBatch(a);
		b = "INSERT INTO login (username, password, type, id) VALUES ('"+username+"', '"+password+"', 'customer', (SELECT MAX(id) from person))";
		stmt2.addBatch(b);
		c = "INSERT INTO customer (id, creditCardNum, email) VALUES ((SELECT MAX(id) from person), '"+creditCard+"', '"+email+"')";
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