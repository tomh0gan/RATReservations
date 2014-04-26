<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>RAT Reservations - Employee</TITLE>
</HEAD>
<BODY>
		Welcome <%= session.getAttribute("username")  %> 
	<BR>your id is <%= session.getAttribute("id") %>
	<BR>you are an employee
	<BR><A HREF="../logout.jsp">Logout</A>
</BODY>
</HTML>