<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String confirmPassword = request.getParameter("confirmpassword");
	String email = request.getParameter("email");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zipcode = request.getParameter("zipcode");
	String creditCard = request.getParameter("creditCard");
	
	request.setAttribute("username", username);
	request.setAttribute("email", email);
	request.setAttribute("firstName", firstName);
	request.setAttribute("lastName", lastName);
	request.setAttribute("address", address);
	request.setAttribute("city", city);
	request.setAttribute("state", state);
	request.setAttribute("zipcode", zipcode);
	request.setAttribute("creditCard", creditCard);
	
	// check if input in "valid"
	if(!username.matches("[\\w]{1,20}")){	
		request.setAttribute("usernameError", "Invalid Username, should be non-empty and at most 20 letters/digits!");
		invalidInput = true;
	}
	if(!password.matches("[\\w]{1,20}")){				
		request.setAttribute("passwordError", "Invalid Password, should be non-empty and at most 20 letters/digits!");
		invalidInput = true;
	}
	else if(!password.equals(confirmPassword)){
		request.setAttribute("passwordError", "Confirmation password does not match!");
		invalidInput = true;
	}
	if(!email.matches("[\\w]{1,34}@[\\w]{1,10}.[\\w]{3,}")){			
		request.setAttribute("emailError", "Invalid Email, should be in the format email@host.com");
		invalidInput = true;
	}
	if(!firstName.matches("[a-zA-Z]{1,50}")){
		request.setAttribute("firstNameError", "Invalid First Name, should be non-empty and at most 50 letters");
		invalidInput = true;
	}
	if(!lastName.matches("[a-zA-Z]{1,50}")){
		request.setAttribute("lastNameError", "Invalid Last Name, should be non-empty and at most 50 letters");
		invalidInput = true;
	}
	if(!address.matches("[\\w ]{1,100}.")){
		request.setAttribute("addressError", "Invalid Address, should be non-empty and at most 100 letters/digits");
		invalidInput = true;
	}
	if(!city.matches("[a-zA-Z ]{1,50}")){
		request.setAttribute("cityError", "Invalid City, should be non-empty and at most 50 letters");
		invalidInput = true;
	}
	if(!state.matches("[a-zA-Z ]{1,50}")){
		request.setAttribute("stateError", "Invalid State, should be non-empty!");
		invalidInput = true;
	}
	if(!zipcode.matches("[0-9]{5,5}")){
		request.setAttribute("zipcodeError", "Invalid ZIP code, should be 5 digits");
		invalidInput = true;
	}
	if(!creditCard.matches("[0-9]{16,16}")){
		request.setAttribute("creditCardError", "Invalid Credit Card Number, should be 16 digits");
		invalidInput = true;
	}
	if(invalidInput == true){
		RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
		rd.forward(request, response);
		return;
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
		b = "INSERT INTO login (username, password, type, id) VALUES ('"+username+"', '"+password+"', 'customer', (SELECT MAX(id) from person))";
		stmt2.addBatch(b);
		c = "INSERT INTO customer (id, creditCardNum, email) VALUES ((SELECT MAX(id) from person), '"+creditCard+"', '"+email+"')";
		stmt2.addBatch(c);
		
		stmt2.executeBatch();
		response.sendRedirect("account_created.jsp");
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	%>
</BODY>
</HTML>