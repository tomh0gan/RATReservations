<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	boolean edit = false;
	if(username == null){
		edit = true;
	}
	String ssn = request.getParameter("ssn");
	if(ssn.contains("-")){
		String[] sepSsn = ssn.split("-");
		ssn = "";
		for(int i = 0; i < sepSsn.length; i++){ ssn+=sepSsn[i]; }
	}
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zipcode = request.getParameter("zipcode");
	String emplType = request.getParameter("emplType");
	String hourlyRate = request.getParameter("hourlyRate");
	if(hourlyRate.contains("$")){
		hourlyRate = hourlyRate.substring(hourlyRate.indexOf("$"));
	}
	
	session.setAttribute("EmployeeFName", firstName);
	session.setAttribute("EmployeeLName", lastName);
	session.setAttribute("EmployeeUsername", username);
	session.setAttribute("EmployeePassword", password);
	session.setAttribute("EmployeeSSN", ssn);
	session.setAttribute("EmployeeAddress", address);
	session.setAttribute("EmployeeCity", city);
	session.setAttribute("EmployeeState", state);
	session.setAttribute("EmployeeZip", zipcode);
	session.setAttribute("EmployeeEmplType", emplType);
	session.setAttribute("EmployeeHourlyRate", hourlyRate);
	
	// check if input in "valid"
	if(!edit){
		if(!username.matches("[\\w]{1,20}")){	
			session.setAttribute("EmployeeUsernameError", "Invalid Username, should be non-empty and at most 20 letters/digits");
			invalidInput = true;
		}
		else{
			session.removeAttribute("EmployeeUsernameError");
		}
		if(!password.matches("[\\w]{1,20}")){				
			invalidInputs += "- Invalid Password, should be non-empty and at most 20 letters/digits<BR>";
			invalidInput = true;
		}
	}
	if(!ssn.matches("[0-9]{9,9}")){			
		session.setAttribute("EmployeeSSNError", "A SSN should contain 9 digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeSSNError");
	}
	if(!firstName.matches("[a-zA-Z]{1,50}")){
		session.setAttribute("EmployeeFNameError", "A name should not contain any digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeFNameError");
	}
	if(!lastName.matches("[a-zA-Z]{1,50}")){
		session.setAttribute("EmployeeLNameError", "A name should not contain any digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeLNameError");
	}
	if(!address.matches("[\\w ]{1,100}")){
		session.setAttribute("EmployeeAddressError", "Please enter an address!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeAddressError");
	}
	if(!city.matches("[a-zA-Z ]{1,50}")){
		session.setAttribute("EmployeeCityError", "A city should not contain any digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeCityError");
	}
	if(!state.matches("[a-zA-Z ]{1,50}")){
		session.setAttribute("EmployeeStateError", "A state should not contain any digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeStateError");
	}
	if(!zipcode.matches("[0-9]{5,5}")){
		session.setAttribute("EmployeeZipError", "A zip code should be 5 digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeZipError");
	}
	if(!hourlyRate.matches("[0-9]{1,3}.[0-9]{2,2}")){
		session.setAttribute("EmployeeHourlyRateError", "An hourly rate should have a decimal point followed by 2 digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeHourlyRateError");
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
		if(!edit){
			//checks if the ssn is already in use
			ResultSet rs = stmt1.executeQuery("SELECT * FROM Employee WHERE ssn='"+ssn+"'");
			if(rs.next()){
				session.setAttribute("EmployeeSSNError", "The ssn '"+ssn+"' is already in use!");
				if(edit) response.sendRedirect("employee_info.jsp?type=edit");
				else response.sendRedirect("employee_info.jsp?type=create");
				return;
			}	
		}
		
		// checks if username is already in use
		ResultSet rs1 = stmt1.executeQuery("SELECT * FROM Login WHERE username='"+username+"'");
		if(rs1.next()){
			session.setAttribute("EmployeeUsernameError", "The username '"+username+"' is already in use.");
			response.sendRedirect("employee_info.jsp?type=create");
			return;
		}
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	if(invalidInput == true){
		if(edit){
			response.sendRedirect("employee_info.jsp?type=edit");
		}
		else{
			System.out.println("Reached");
			response.sendRedirect("employee_info.jsp?type=create");
		}
	}
	else{
		if(edit){
			response.sendRedirect("employee_update.jsp");
		}
		else{
			response.sendRedirect("employee_creation.jsp");
		}
	}
	%>
</body>
</html>