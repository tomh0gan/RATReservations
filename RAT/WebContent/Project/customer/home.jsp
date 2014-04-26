<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>RAT Reservations - Customer</TITLE>
</HEAD>
<BODY>
	Welcome <%= session.getAttribute("username")  %> 
	<BR>your id is <%= session.getAttribute("id") %>
	<BR>you are a customer
	<BR><A HREF="../logout.jsp">Logout</A>
</BODY>
</HTML>