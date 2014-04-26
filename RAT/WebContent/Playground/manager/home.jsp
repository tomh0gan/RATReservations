<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>RAT Reservations - Manager</TITLE>
	<style type="text/css">
    	body {
			background: #E8E8E8;
			color: #111111;
			font-family: Georgia, "Times New Roman", Times, serif;
			padding: 20px;
		}
		
		img {
		   top:0;
		   left:0;
		}		
	</style>
</HEAD>
<BODY>
	<img src="titlebar.png" alt="TitleBar"></img>
	<h1>Welcome <%= session.getAttribute("username")  %></h1>
	<BR><div>your id is <%= session.getAttribute("id") %></div>
	<BR><A HREF="../logout.jsp">Logout</A>
</BODY>
</HTML>