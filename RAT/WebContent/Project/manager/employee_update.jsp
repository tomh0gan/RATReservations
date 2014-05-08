<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<% if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	   }
  	 %>
	<%
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String firstName = (String) request.getAttribute("EmployeeFName");
	String lastName = (String) request.getAttribute("EmployeeLName");
	String id = (String) request.getAttribute("EmployeeId");
	String oldSsn = (String) request.getAttribute("OldEmployeeSSN");
	String ssn = (String) request.getAttribute("EmployeeSSN");
	String address = (String) request.getAttribute("EmployeeAddress");
	String city = (String) request.getAttribute("EmployeeCity");
	String state = (String) request.getAttribute("EmployeeState");
	String zipcode = (String) request.getAttribute("EmployeeZip");
	String emplType = (String) request.getAttribute("EmployeeEmplType");
	String hourlyRate = (String) request.getAttribute("EmployeeHourlyRate");
	
	System.out.println(firstName);
	
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

		a = "UPDATE Person SET firstName='" + firstName + "', lastName='"+lastName+"', address='"+address+"', city='"+city+"', state='"+state+"', zipcode="+zipcode+" WHERE id="+id+";";
		stmt2.addBatch(a);
		b = "UPDATE Login SET type='" + emplType + "'WHERE id=" + id + ";";
		stmt2.addBatch(b);
		c = "UPDATE Employee SET ssn='"+ssn+"', isManager="+position+", hourlyRate="+hourlyRate+" WHERE ssn='"+oldSsn+"';";
		stmt2.addBatch(c);
		
		stmt2.executeBatch();
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