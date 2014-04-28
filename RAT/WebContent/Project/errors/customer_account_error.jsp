<!DOCTYPE html>
<html>
<head></head>
<body>
<H1>Invalid Input</H1>
	<%= session.getAttribute("error") %>
	<% session.removeAttribute("error"); %>
	<BR><A HREF="../customer/account.jsp">Return</A>
</body>
</html>