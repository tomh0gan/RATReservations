<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
<title>RAT Reservations - Customer</title>
</head>
<body>
	
	Welcome, <%= session.getAttribute("name") %> (<%= session.getAttribute("username")  %>)
	<br>
	<a href="home.jsp">Home</a>
	<br>
	<h1>Change Password</h1>
	<form action="change_password.jsp" method="post">
		<table>
		<tr><td>Current Password</td>	<td><input type="password" name="passCurr"></tr>
		<tr><td>New Password</td>		<td><input type="password" name="passNew"></tr>
		</table>
		<input type="submit" value="Submit">
	</form>
	
	<h1>Change Billing Information</h1>
	<form action="edit_information.jsp" method="post">
	<table border="1">	
	<col width="100">
	<col width="200">
	<col width="200">
	<tr><td>First Name</td>		<td>First Name</td>		<td><input type="text" name="email"></td></tr>
	<tr><td>Last Name</td>		<td>Last Name</td>		<td><input type="text" name="email"></td></tr>
	<tr><td>Email</td>			<td>Current Email</td>		<td><input type="text" name="email"></td></tr>
	<tr><td>Credit Card</td>	<td>Last Name</td>		<td><input type="text" name="email"></td></tr>
	<tr><td>Address</td>		<td>Address</td>		<td><input type="text" name="email"></td></tr>
	<tr><td>City</td>			<td>City</td>		<td><input type="text" name="email"></td></tr>
	<tr><td>State</td>			<td>State</td>		<td><input type="text" name="email"></td></tr>
	<tr><td>ZIP code</td>		<td>ZIP code</td>		<td><input type="text" name="email"></td></tr>
	</table>
	<br><input type="submit" value="Submit">
	</form>
	
	
	
	
	<br><a href="../logout.jsp">Logout</a>
</body>
</html>