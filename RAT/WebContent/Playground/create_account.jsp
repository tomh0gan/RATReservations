<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema";
	String mysUserID = "tester";
	String mysPassword = "test";
	
	boolean invalidInput = false;
	String invalidInputs = "";
	
	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String firstName = request.getParameter("firstName");
	String lastName = request.getParameter("lastName");
	String address = request.getParameter("address");
	String city = request.getParameter("city");
	String state = request.getParameter("state");
	// Now you may be thinking, but russell these are integer values... you're wrong! change them in your database.
	String zipcode = request.getParameter("zipcode");
	String creditCard = request.getParameter("creditCard");
	
	// refer to http://docs.oracle.com/javase/7/docs/api/java/util/regex/Pattern.html
	if(!username.matches("[\\w]{1,20}")){	
		invalidInputs += "- Invalid Username, should be non-empty and at most 20 letters/digits.\n";
		invalidInput = true;
	}
	if(!password.matches("[\\w]{1,20}")){				
		invalidInputs += "- Invalid Password, should be non-empty and at most 20 letters/digits.\n";
		invalidInput = true;
	}
	if(!email.matches("[\\w]{1,34}@[\\w]{1,10}.[\\w]{3,}")){			
		invalidInputs += "- Invalid Email, should be in the format email@host.com.\n";
		invalidInput = true;
	}
	if(!firstName.matches("[a-zA-Z]{1,50}")){
		invalidInputs += "- Invalid First Name, should be non-empty and at most 50 letters.\n";
		invalidInput = true;
	}
	if(!lastName.matches("[a-zA-Z]{1,50}")){
		invalidInputs += "- Invalid Last Name, should be non-empty and at most 50 letters.\n";
		invalidInput = true;
	}
	if(!address.matches("[\\w ]{1,100}")){
		invalidInputs += "- Invalid Address, should be non-empty and at most 100 letters/digits.\n";
		invalidInput = true;
	}
	if(!city.matches("[a-zA-Z ]{1,50}")){
		invalidInputs += "- Invalid City, should be non-empty and at most 50 letters.\n";
		invalidInput = true;
	}
	if(!state.matches("[a-zA-Z ]{1,50}")){
		invalidInputs += "- Invalid State, should non-empty and at most 50 letters.\n";
		invalidInput = true;
	}
	if(!zipcode.matches("[0-9]{5,}")){
		invalidInputs += "- Invalid ZIP code, should be 5 digits.\n";
		invalidInput = true;
	}
	if(!creditCard.matches("[0-9]{16,}")){
		invalidInputs += "- Invalid Credit Card Number, should be 16 digits.\n";
		invalidInput = true;
	}
	if(invalidInput == true){
		System.out.println(invalidInputs);
	}
	%>
</BODY>
</HTML>