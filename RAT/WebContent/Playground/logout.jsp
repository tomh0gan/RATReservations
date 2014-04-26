<!DOCTYPE html>
<HTML>
<BODY>
	<%
		session.removeAttribute("username");
		session.removeAttribute("password");
		session.invalidate();
	%>
	Logout Successful
	<BR><A HREF="index.html">Login Page</A>
</BODY>
</HTML>