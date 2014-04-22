<% 	
    	String firstName = request.getParameter("firstName");
    	request.setAttribute("EmployeeFName", firstName);
    	String lastName = request.getParameter("lastName");
    	request.setAttribute("EmployeeLName", lastName);
    	String ssn = request.getParameter("ssn");
    	request.setAttribute("EmployeeSSN", ssn);
    	String address = request.getParameter("address");
    	request.setAttribute("EmployeeAddress", address);
    	String city = request.getParameter("city");
    	request.setAttribute("EmployeeCity", city);
    	String state = request.getParameter("state");
    	request.setAttribute("EmployeeState", state);
    	String zip = request.getParameter("zip");
    	request.setAttribute("EmployeeZip", zip);
    	String emplType = request.getParameter("emplType");
    	request.setAttribute("EmployeeEmplType", emplType);
    	String hourlyRate = request.getParameter("hourlyRate");
    	request.setAttribute("EmployeeHourlyRate", hourlyRate);
    	
    	RequestDispatcher dispatch = request.getRequestDispatcher("ManagerAddEmployeePage.jsp");
    	
    	//Check input for errors
    	//First name
    	if(firstName.equals("")){
    		request.setAttribute("EmployeeFNameError", "Please enter a first name!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		request.setAttribute("EmployeeFNameError", "");
    	}
    	//Last name
    	if(lastName == null || lastName.equals("")){
    		request.setAttribute("EmployeeLNameError", "Please enter a last name!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		request.setAttribute("EmployeeLNameError", "");
    	}
    	//SSN
    	if(ssn == null || ssn.equals("")){
    		request.setAttribute("EmployeeSSNError", "Please enter a SSN!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		boolean error = false;
    		if(ssn.contains("-") && ssn.length() == 11){
    			String[] ssns = ssn.split("-");
    			if(ssns.length == 3){
    				ssn = ssns[0] + ssns[1] + ssns[2];
    			}
    			else{
    				error = true;
    			}
    		}
    		if(ssn.length() == 9){
        		try{
        			Integer.parseInt(ssn);	
        		}catch(NumberFormatException e){
            		error = true;
        		}	
    		}
    		else{
    			error = true;	
    		}
    		if(!error){
    			request.setAttribute("EmployeeSSNError", "");
    		}
    		else{
        		request.setAttribute("EmployeeSSNError", "Please enter a  correct SSN!");
        		dispatch.forward(request, response);
        		return;
    		}
    	}
    	//Address
    	if(address == null || address.equals("")){
    		request.setAttribute("EmployeeAddressError", "Please enter an address!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		request.setAttribute("EmployeeAddressError", "");
    	}
    	//City
    	if(city == null || city.equals("")){
    		request.setAttribute("EmployeeCityError", "Please enter a city!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		request.setAttribute("EmployeeCityError", "");
    	}
    	//State
    	if(state == null || state.equals("")){
    		request.setAttribute("EmployeeStateError", "Please enter a state!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		request.setAttribute("EmployeeStateError", "");
    	}
    	//Zipcode
    	if(zip == null || zip.equals("")){
    		request.setAttribute("EmployeeZipError", "Please enter a zip code!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		boolean error = false;
    		if(!(zip.length() == 5)){
    			String[] zips = zip.split("-");
    			if((zips[0].length() == 5) && (zips[1].length() == 4)){
    	    		try{
    	    			Integer.parseInt(zips[0]);
    	    			Integer.parseInt(zips[1]);
    	    		}catch(NumberFormatException e){
    	        		error = true;
    	    		}
    			}
    			else{
    				error = true;	
    			}
    		}
    		else if(zip.length() == 5){
        		try{
        			Integer.parseInt(zip);	
        		}catch(NumberFormatException e){
            		error = true;
        		}	
    		}
    		
    		if(!error){
    			request.setAttribute("EmployeeZipError", "");
    		}
    		else{
        		request.setAttribute("EmployeeZipError", "Please enter a correct zip code!");
        		dispatch.forward(request, response);
        		return;
    		}
    	}
    	//Position
    	if(emplType == null || emplType.equals("")){
    		request.setAttribute("EmployeeEmplTypeError", "Please enter a position!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		request.setAttribute("EmployeeEmplTypeError", "");
    	}
    	//Salary
        if(hourlyRate == null || hourlyRate.equals("")){
    		request.setAttribute("EmployeeHourlyRateError", "Please enter an hourly rate!");
    		dispatch.forward(request, response);
    		return;
    	}
    	else{
    		try{
    			Double.parseDouble(hourlyRate);	
    		}catch(NumberFormatException e){
        		request.setAttribute("EmployeeHourlyRateError", "Please enter a correct hourly rate!");
        		dispatch.forward(request, response);
        		return;
    		}	
    		request.setAttribute("EmployeeHourlyRateError", "");
    	}
    	
		// code start here
		String Id = request.getParameter("Id");
		String Name = request.getParameter("Name");
		String Password1 = request.getParameter("Password1");
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
     	String mysUserID = "tester"; 
    	String mysPassword = "test";
   
		
		java.sql.Connection conn=null;
		try 
		{
            Class.forName(mysJDBCDriver).newInstance();
    		java.util.Properties sysprops=System.getProperties();
    		sysprops.put("user",mysUserID);
    		sysprops.put("password",mysPassword);
        
			//connect to the database
            conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            System.out.println("Connected successfully to database using JConnect");
            
            java.sql.Statement stmt1=conn.createStatement();
			stmt1.executeUpdate("INSERT INTO Person (firstName, lastName, address, city, state, zipCode) VALUES ('" + firstName + "', '" + lastName + "', '" + address + "', '" + city + "', '" + state + "', " + zip +")", java.sql.Statement.RETURN_GENERATED_KEYS);
			java.sql.ResultSet rs1 = stmt1.getGeneratedKeys();
			int autoIncId = -1;
			if (rs1.next()) {
				autoIncId = rs1.getInt(1);
			} else {
			    System.out.println("Could not retrieve id");
			}
			
			int posType = -1;
			if(emplType.equals("Employee")) posType = 0;
			else if(emplType.equals("Employee")) posType = 1; 
			
			java.util.Date date1 = new java.util.Date();
			java.text.DateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
			
			java.sql.Statement stmt2=conn.createStatement();
			stmt2.executeUpdate("INSERT INTO Employee VALUES (" + autoIncId + ", '" + ssn + "', " + posType + ", '" + sdf.format(date1) + "', " + hourlyRate + ")");
			stmt1.close();
		} catch(Exception e)
		{
			e.printStackTrace();
			out.print(e.toString());
		}
		finally{
			try{conn.close();}catch(Exception ee){};
		}
/*
	}
*/
%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<br />
	<br />
	<br />
	<h1> <%= firstName + " " + lastName %> added!</h1>
	<input id="Button1" name="ViewEmployees" type="button" value="Home" onclick="window.open('ManagerEmployeePage.jsp','_self');" />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
    RAT Reservations<br />
    Department of Computer Science<br />
	</span>    
</body>
</html>