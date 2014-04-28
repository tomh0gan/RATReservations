<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String firstName = (String) session.getAttribute("EmployeeFName");
	String lastName = (String) session.getAttribute("EmployeeLName");
	String username = (String) session.getAttribute("EmployeeUsername");
	String password = (String) session.getAttribute("EmployeePassword");
	String ssn = (String) session.getAttribute("EmployeeSSN");
	String address = (String) session.getAttribute("EmployeeAddress");
	String city = (String) session.getAttribute("EmployeeCity");
	String state = (String) session.getAttribute("EmployeeState");
	String zipcode = (String) session.getAttribute("EmployeeZip");
	String emplType = (String) session.getAttribute("EmployeeEmplType");
	String hourlyRate = (String) session.getAttribute("EmployeeHourlyRate");
	
	java.util.Date date1 = new java.util.Date();
	java.text.DateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema";
	String mysUserID = "tester";
	String mysPassword = "test";
	
	int position = 0;
	if(emplType.equals("manager")) position=1;
	
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
		b = "INSERT INTO login (username, password, type, id) VALUES ('"+username+"', '"+password+"', '"+emplType+"', (SELECT MAX(id) from person))";
		stmt2.addBatch(b);
		c = "INSERT INTO Employee (id, ssn, isManager, startDate, hourlyRate) VALUES ((SELECT MAX(id) from person), '" + ssn + "', " + position + ", '" + sdf.format(date1) + "', " + hourlyRate + ")";
		stmt2.addBatch(c);
		
		stmt2.executeBatch();
		response.sendRedirect("clear_employee_attributes.jsp");
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	%>
</BODY>
</HTML>