<!DOCTYPE html>
<HTML>
<BODY>
	<%
		session.removeAttribute("username");
		session.removeAttribute("id");
		session.invalidate();
	%>
	<H1>Successfully Logged Out</H1>
	<BR><A HREF="index.html">Login Page</A>
</BODY>
</HTML>