<!DOCTYPE html>
<HTML>
<BODY>
	<%
		session.removeAttribute("username");
		session.removeAttribute("id");
		session.invalidate();
	%>
	<H1>Successful Logout</H1>
	<BR><A HREF="index.html">Login Page</A>
</BODY>
</HTML>