<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>RAT Reservations - Customer</TITLE>
</HEAD>
<BODY>
	Welcome, <%= session.getAttribute("name") %> (<%= session.getAttribute("username")  %>).
	<BR>
	
	
	
	<BR><A HREF="../logout.jsp">Logout</A>
</BODY>
</HTML>