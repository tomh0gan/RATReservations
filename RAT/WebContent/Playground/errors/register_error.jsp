<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>RAT Reservations - Registration Error</TITLE>
</HEAD>
<BODY>
	<H1>Invalid Input</H1>
	<%= session.getAttribute("error") %>
	<% session.invalidate(); %>
	<BR><A HREF="../register.html">Return</A>
</BODY>
</HTML>