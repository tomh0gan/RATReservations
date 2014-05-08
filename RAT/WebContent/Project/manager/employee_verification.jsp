<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<% if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	   }
  	 %>
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
	String oldSsn = "";
	if(request.getParameter("oldSsn") != null){
		oldSsn = request.getParameter("oldSsn");
	}
	String id = request.getParameter("id");
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
	
	request.setAttribute("EmployeeId", id);
	request.setAttribute("EmployeeFName", firstName);
	request.setAttribute("EmployeeLName", lastName);
	request.setAttribute("EmployeeUsername", username);
	request.setAttribute("EmployeePassword", password);
	request.setAttribute("EmployeeSSN", ssn);
	request.setAttribute("OldEmployeeSSN", oldSsn);
	request.setAttribute("EmployeeAddress", address);
	request.setAttribute("EmployeeCity", city);
	request.setAttribute("EmployeeState", state);
	request.setAttribute("EmployeeZip", zipcode);
	request.setAttribute("EmployeeEmplType", emplType);
	request.setAttribute("EmployeeHourlyRate", hourlyRate);
	
	// check if input in "valid"
	if(!edit){
		if(!username.matches("[\\w]{1,20}")){	
			request.setAttribute("EmployeeUsernameError", "Invalid Username, should be non-empty and at most 20 letters/digits");
			invalidInput = true;
		}
		else{
			request.removeAttribute("EmployeeUsernameError");
		}
		if(!password.matches("[\\w]{1,20}")){				
			invalidInputs += "- Invalid Password, should be non-empty and at most 20 letters/digits<BR>";
			invalidInput = true;
		}
	}
	if(!ssn.matches("[0-9]{9,9}")){			
		request.setAttribute("EmployeeSSNError", "A SSN should contain 9 digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeSSNError");
	}
	if(!firstName.matches("[a-zA-Z]{1,50}")){
		request.setAttribute("EmployeeFNameError", "A name should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeFNameError");
	}
	if(!lastName.matches("[a-zA-Z]{1,50}")){
		request.setAttribute("EmployeeLNameError", "A name should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeLNameError");
	}
	if(!address.matches("[\\w ]{1,100}.")){
		request.setAttribute("EmployeeAddressError", "Please enter an address!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeAddressError");
	}
	if(!city.matches("[a-zA-Z ]{1,50}")){
		request.setAttribute("EmployeeCityError", "A city should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeCityError");
	}
	if(!state.matches("[a-zA-Z ]{1,50}")){
		request.setAttribute("EmployeeStateError", "A state should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeStateError");
	}
	if(!zipcode.matches("[0-9]{5,5}")){
		request.setAttribute("EmployeeZipError", "A zip code should be 5 digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeZipError");
	}
	if(!hourlyRate.matches("[0-9]{1,3}.[0-9]{2,2}")){
		request.setAttribute("EmployeeHourlyRateError", "An hourly rate should have a decimal point followed by 2 digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("EmployeeHourlyRateError");
	}
	//Checks if employee is making an incorrect hourly rate
	if(emplType.equals("employee") && !invalidInput){
		double sal = Double.parseDouble(hourlyRate);
		if(sal > 12){
			request.setAttribute("EmployeeHourlyRateError", "An employee cannot earn more than $12.00 an hour!");
			invalidInput = true;
		}
		else if(sal < 7){
			request.setAttribute("EmployeeHourlyRateError", "An employee has to earn more than $7.00 an hour!");
			invalidInput = true;
		}
		else{
			request.removeAttribute("EmployeeHourlyRateError");
		}
	}
	//Checks if manager is making less than their minimum
	if(emplType.equals("manager") && !invalidInput){
		double sal = Double.parseDouble(hourlyRate);
		if(sal < 14){
			request.setAttribute("EmployeeHourlyRateError", "A manager cannot earn less than $14.00 an hour!");
			invalidInput = true;
		}
		else{
			request.removeAttribute("EmployeeHourlyRateError");
		}
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
		if(!(ssn.equals(oldSsn))){
			//checks if the ssn is already in use
			ResultSet rs = stmt1.executeQuery("SELECT * FROM Employee WHERE ssn='"+ssn+"'");
			if(rs.next()){
				request.setAttribute("EmployeeSSNError", "The ssn '"+ssn+"' is already in use!");
				if(edit){
					RequestDispatcher rd = request.getRequestDispatcher("employee_info.jsp?type=edit");
					rd.forward(request, response);
					//response.sendRedirect("employee_info.jsp?type=edit");
				}
				else{
					RequestDispatcher rd = request.getRequestDispatcher("employee_info.jsp?type=create");
					rd.forward(request, response);
					//response.sendRedirect("employee_info.jsp?type=create");
				}
				return;
			}	
		}
		
		// checks if username is already in use
		ResultSet rs1 = stmt1.executeQuery("SELECT * FROM Login WHERE username='"+username+"'");
		if(rs1.next()){
			request.setAttribute("EmployeeUsernameError", "The username '"+username+"' is already in use.");
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
			RequestDispatcher rd = request.getRequestDispatcher("employee_info.jsp?type=edit");
			rd.forward(request, response);
			//response.sendRedirect("employee_info.jsp?type=edit");
		}
		else{
			RequestDispatcher rd = request.getRequestDispatcher("employee_info.jsp?type=create");
			rd.forward(request, response);
			//response.sendRedirect("employee_info.jsp?type=create");
		}
	}
	else{
		if(edit){
			RequestDispatcher rd = request.getRequestDispatcher("employee_update.jsp");
			rd.forward(request, response);
			//response.sendRedirect("employee_update.jsp");
		}
		else{
			RequestDispatcher rd = request.getRequestDispatcher("employee_creation.jsp");
			rd.forward(request, response);
			//response.sendRedirect("employee_creation.jsp");
		}
	}
	%>
</body>
</html>