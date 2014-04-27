<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
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
	session.setAttribute("EmployeeSSN", ssn);
	session.setAttribute("EmployeeAddress", address);
	session.setAttribute("EmployeeCity", city);
	session.setAttribute("EmployeeState", state);
	session.setAttribute("EmployeeZip", zipcode);
	session.setAttribute("EmployeeEmplType", emplType);
	session.setAttribute("EmployeeHourlyRate", hourlyRate);
	
	// check if input in "valid"
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
	else{
		session.removeAttribute("EmployeeUsernameError");
	}
	if(!ssn.matches("[0-9]{9,9}")){			
		session.setAttribute("EmployeeSSNError", "A SSN should contain 9 digits!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeSSNError");
	}
	if(!firstName.matches("[a-zA-Z]{1,50}")){
		session.setAttribute("EmployeeFNameError", "Please enter a first name!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeFNameError");
	}
	if(!lastName.matches("[a-zA-Z]{1,50}")){
		session.setAttribute("EmployeeLNameError", "Please enter a last name!");
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
		session.setAttribute("EmployeeCityError", "Please enter a city!");
		invalidInput = true;
	}
	else{
		session.removeAttribute("EmployeeCityError");
	}
	if(!state.matches("[a-zA-Z ]{1,50}")){
		session.setAttribute("EmployeeStateError", "Please enter a state!");
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
	if(invalidInput == true){
		response.sendRedirect("create_employee.jsp");
		return;
	}
	
	session.setAttribute("EmployeeFName", "");
	session.setAttribute("EmployeeLName", "");
	session.setAttribute("EmployeeUsername", "");
	session.setAttribute("EmployeeSSN", "");
	session.setAttribute("EmployeeAddress", "");
	session.setAttribute("EmployeeCity", "");
	session.setAttribute("EmployeeState", "");
	session.setAttribute("EmployeeZip", "");
	session.setAttribute("EmployeeEmplType", "");
	session.setAttribute("EmployeeHourlyRate", "");
	
	java.util.Date date1 = new java.util.Date();
	java.text.DateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	int position = 0;
	if(emplType.equals("manager")) position=1;
	
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
		
		// checks if username is already in use
		ResultSet rs = stmt1.executeQuery("SELECT * FROM Login WHERE username='"+username+"'");
		if(rs.next()){
			invalidInputs += "- The username '"+username+"' is already in use.";
			session.setAttribute("error", invalidInputs);
			response.sendRedirect("errors/register_error.jsp");
			return;
		}
		
		Statement stmt2 = conn.createStatement();
		String a,b,c;
		a = "INSERT INTO person (firstName, lastName, address, city, state, zipcode) VALUES ('"+firstName+"', '"+lastName+"', '"+address+"', '"+city+"', '"+state+"', '"+zipcode+"')";
		stmt2.addBatch(a);
		b = "INSERT INTO login (username, password, type, id) VALUES ('"+username+"', '"+password+"', '"+emplType+"', (SELECT MAX(id) from person))";
		stmt2.addBatch(b);
		c = "INSERT INTO Employee (id, ssn, isManager, startDate, hourlyRate) VALUES ((SELECT MAX(id) from person), '" + ssn + "', " + position + ", '" + sdf.format(date1) + "', " + hourlyRate + ")";
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