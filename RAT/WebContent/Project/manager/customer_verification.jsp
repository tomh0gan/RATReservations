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
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String email = request.getParameter("email");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	String zipcode = request.getParameter("zipcode");
	String creditCard = request.getParameter("creditCard");
	
	request.setAttribute("CustomerFName", firstName);
	request.setAttribute("CustomerLName", lastName);
	request.setAttribute("CustomerUsername", username);
	request.setAttribute("CustomerPassword", password);
	request.setAttribute("CustomerEmail", email);
	request.setAttribute("CustomerAddress", address);
	request.setAttribute("CustomerCity", city);
	request.setAttribute("CustomerState", state);
	request.setAttribute("CustomerZip", zipcode);
	request.setAttribute("CustomerCreditCard", creditCard);
	
	// check if input in "valid"
	if(!username.matches("[\\w]{1,20}")){	
		request.setAttribute("CustomerUsernameError", "Invalid Username, should be non-empty and at most 20 letters/digits");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerUsernameError");
	}
	if(!password.matches("[\\w]{1,20}")){				
		invalidInputs += "- Invalid Password, should be non-empty and at most 20 letters/digits<BR>";
		invalidInput = true;
	}
	if(!email.matches("[\\w]{1,34}@[\\w]{1,10}.[\\w]{3,}")){			
		request.setAttribute("CustomerEmailError", "Incorrect email format! An email should be in the format email@host.com!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerEmailError");
	}
	if(!firstName.matches("[a-zA-Z]{1,50}")){
		request.setAttribute("CustomerFNameError", "A name should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerFNameError");
	}
	if(!lastName.matches("[a-zA-Z]{1,50}")){
		request.setAttribute("CustomerLNameError", "A name should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerLNameError");
	}
	if(!address.matches("[\\w ]{1,100}")){
		request.setAttribute("CustomerAddressError", "Please enter an address!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerAddressError");
	}
	if(!city.matches("[a-zA-Z ]{1,50}")){
		request.setAttribute("CustomerCityError", "A city should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerCityError");
	}
	if(!state.matches("[a-zA-Z ]{1,50}")){
		request.setAttribute("CustomerStateError", "A state should not contain any digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerStateError");
	}
	if(!zipcode.matches("[0-9]{5,5}")){
		request.setAttribute("CustomerZipError", "A zip code should be 5 digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerZipError");
	}
	if(!creditCard.matches("[0-9]{16,16}")){
		request.setAttribute("CustomerCreditCardError", "Invalid Credit Card Number, should be 16 digits!");
		invalidInput = true;
	}
	else{
		request.removeAttribute("CustomerCreditCardError");
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
		ResultSet rs1 = stmt1.executeQuery("SELECT * FROM Login WHERE username='"+username+"'");
		if(rs1.next()){
			request.setAttribute("CustomerUsernameError", "The username '"+username+"' is already in use.");
			return;
		}
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	if(invalidInput == true){
		RequestDispatcher rd = request.getRequestDispatcher("create_customer.jsp");
		rd.forward(request, response);
	}
	else{
		RequestDispatcher rd = request.getRequestDispatcher("customer_creation.jsp");
		rd.forward(request, response);
	}
	%>
</body>
</html>