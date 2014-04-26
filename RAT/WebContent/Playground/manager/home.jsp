<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>RAT Reservations - Manager</TITLE>
</HEAD>
<BODY>
		Welcome <%= session.getAttribute("username")  %> 
	<BR>your id is <%= session.getAttribute("id") %>
	<BR>you are a manager
	<BR><A HREF="../logout.jsp">Logout</A>
</BODY>
</HTML>