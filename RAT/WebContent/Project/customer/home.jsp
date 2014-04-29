<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
<title>RAT Reservations - Customer</title>
</head>
<body>
	Welcome, <%= session.getAttribute("name") %> (<%= session.getAttribute("username")  %>)
	<br>
	<a href="account.jsp">My Account</a>
	<br>
	<a href="reservations.jsp">My Reservations</a>
	<br><br>
	
	
	
	<br><a href="../logout.jsp">Logout</a>
</body>
</html>