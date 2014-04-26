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
	int zipcode = Integer.parseInt(request.getParameter("zipcode"));
	int creditCard = Integer.parseInt(request.getParameter("creditCard"));
	
	if(!username.matches("[\\w]{1,20}")){	
		invalidInputs += "- Invalid Username \n";
		invalidInput = true;
	}
	if(!password.matches("[\\w]{1,20}")){				
		invalidInputs += "- Invalid Password \n";
		invalidInput = true;
	}
	if(!email.matches("[\\w]{1,34}@[\\w]{1,10}.[\\w]{3,}")){			
		invalidInputs += "- Invalid Email \n";
		invalidInput = true;
	}
	if(!firstName.matches("[a-zA-Z]{1,50}")){
		invalidInputs += "- Invalid First Name \n";
		invalidInput = true;
	}
	if(!lastName.matches("[a-zA-Z]{1,50}")){
		invalidInputs += "- Invalid Last Name \n";
		invalidInput = true;
	}
	if(!address.matches("[\\w ]{1,100}")){
		invalidInputs += "- Invalid Address \n";
		invalidInput = true;
	}
	if(!city.matches("[a-zA-Z ]{1,50}")){
		invalidInputs += "- Invalid City \n";
		invalidInput = true;
	}
	if(!state.matches("[a-zA-Z ]{1,50}")){
		invalidInputs += "- Invalid State \n";
		invalidInput = true;
	}
	
	if(invalidInput == true){
		System.out.println(invalidInputs);
	}
	%>
</BODY>
</HTML>