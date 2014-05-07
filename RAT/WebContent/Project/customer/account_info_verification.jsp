<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>jsp file</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
boolean invalidInput = false;
String invalidInputs = "";

String updateType = request.getParameter("updateType");
String username = (String) session.getAttribute("username");

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

	if(updateType.equals("password")){
		
		String oldPassword = request.getParameter("currPass");
		String password = request.getParameter("newPass1");
		String passwordCopy = request.getParameter("newPass2");
			
			Statement stmt1 = conn.createStatement();
			
			// Checks if old password is correct
			ResultSet rs = stmt1.executeQuery("SELECT * FROM Login WHERE username='"+username+"' AND password='"+oldPassword+"'");
			if(!(rs.next())){
				request.setAttribute("currPassError", "Incorrect password.");
				invalidInput = true;
			}
			else if(!password.matches("[\\w]{1,20}")){				
				request.setAttribute("newPass1Error", "Invalid Password, should be non-empty and at most 20 letters/digits!");
				invalidInput = true;
			}
			else if(!password.equals(passwordCopy)){
				request.setAttribute("newPass1Error", "Your new passwords are not the same! Please try again!");
				invalidInput = true;
			}
	
			if(invalidInput){
				RequestDispatcher rd = request.getRequestDispatcher("get_account_info.jsp");
				rd.forward(request, response);
				return;
			}
			else{
				//EXECUTE SQL TO UPDATE
				Statement stmt2 = conn.createStatement();
				String updateLogin = "UPDATE Login SET password='"+password+"' WHERE username='"+username+"' AND id="+session.getAttribute("id")+"";
				stmt2.addBatch(updateLogin);
				stmt2.executeBatch();
				
				request.setAttribute("successMessagePass", "Password change successful!");
				RequestDispatcher rd = request.getRequestDispatcher("get_account_info.jsp");
				rd.forward(request, response);
				return;
			}
	}
	else if(updateType.equals("account")){
		String email = request.getParameter("email");
		String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		
		if(!email.matches("[\\w]{1,34}@[\\w]{1,10}.[\\w]{3,}")){
			request.setAttribute("emailError", "Invalid Email '"+email+"', should be in the format email@host.com!");
			invalidInput = true;
		}
		else if(!firstName.matches("[a-zA-Z]{1,50}")){
			request.setAttribute("firstNameError", "Invalid First Name '"+firstName+"', should be non-empty and at most 50 letters!");
			invalidInput = true;
		}
		else if(!lastName.matches("[a-zA-Z]{1,50}")){
			request.setAttribute("lastNameError", "Invalid Last Name '"+lastName+"', should be non-empty and at most 50 letters!");
			invalidInput = true;
		}
		if(invalidInput){
			RequestDispatcher rd = request.getRequestDispatcher("get_account_info.jsp");
			rd.forward(request, response);
			return;
		}
		else{
			//EXECUTE SQL TO UPDATE
			Statement stmt2 = conn.createStatement();
			String updatePerson = "UPDATE Person SET firstName='"+firstName+"', lastName='"+lastName+"' WHERE id="+session.getAttribute("id")+";";
			stmt2.addBatch(updatePerson);
			String updateCustomer = "UPDATE Customer SET email='"+email+"' WHERE id="+session.getAttribute("id")+" AND accountNum="+session.getAttribute("accountNum")+";";
			stmt2.addBatch(updateCustomer);
			stmt2.executeBatch();
			
			request.setAttribute("successMessageAcct", "Account information change successful!");
			RequestDispatcher rd = request.getRequestDispatcher("get_account_info.jsp");
			rd.forward(request, response);
			return;
		}
		
	}
	else if(updateType.equals("billing")){
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zipcode = request.getParameter("zipcode");
		String creditCard = request.getParameter("creditCard");
		
		if(!address.matches("[\\w ]{1,100}.")){
			request.setAttribute("addressError", "Invalid Address '"+address+"', should be non-empty and at most 100 letters/digits!");
			invalidInput = true;
		}
		else if(!city.matches("[a-zA-Z ]{1,50}")){
			request.setAttribute("cityError", "Invalid City '"+city+"', should be non-empty and at most 50 letters!");
			invalidInput = true;
		}
		else if(!state.matches("[a-zA-Z ]{1,50}")){
			request.setAttribute("stateError", "Invalid State '"+state+"', should non-empty and at most 50 letters!");
			invalidInput = true;
		}
		else if(!zipcode.matches("[0-9]{5,5}")){
			request.setAttribute("zipcodeError", "Invalid ZIP code '"+zipcode+"', should be 5 digits!");
			invalidInput = true;
		}
		else if(!creditCard.matches("[0-9]{16,16}")){
			request.setAttribute("creditCardError", "Invalid Credit Card Number '"+creditCard+"', should be 16 digits!");
			invalidInput = true;
		}
		if(invalidInput){
			RequestDispatcher rd = request.getRequestDispatcher("get_account_info.jsp");
			rd.forward(request, response);
			return;
		}
		else{
			//EXECUTE SQL TO UPDATE
			Statement stmt2 = conn.createStatement();
			String updatePerson = "UPDATE Person SET address='"+address+"', city='"+city+"', state='"+state+"', zipcode='"+zipcode+"' WHERE id="+session.getAttribute("id")+";";
			stmt2.addBatch(updatePerson);
			String updateCustomer = "UPDATE Customer SET creditCardNum='"+creditCard+"' WHERE id="+session.getAttribute("id")+" AND accountNum="+session.getAttribute("accountNum")+";";
			stmt2.addBatch(updateCustomer);
			stmt2.executeBatch();
			
			request.setAttribute("successMessageBill", "Billing information change successful!");
			RequestDispatcher rd = request.getRequestDispatcher("get_account_info.jsp");
			rd.forward(request, response);
			return;
		}
	}
} catch(Exception e){
	System.out.println(e);
}
finally{
	try{conn.close();} catch(Exception ee){};
}

%>
</body>
</html>