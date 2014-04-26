<!DOCTYPE html>
<HTML>
<BODY>
	<%
	String username=request.getParameter("username");
	String password=request.getParameter("password");
	
	// currently no database integration
	if(username.equals("employee") && password.equals("pw")){
		session.setAttribute("username", username);
		response.sendRedirect("employee/home.jsp");
	}
	else if(username.equals("customer") && password.equals("pw")){
		session.setAttribute("username", username);
		response.sendRedirect("customer/home.jsp");
	}
	else if(username.equals("manager") && password.equals("pw")){
		session.setAttribute("username", username);
		response.sendRedirect("manager/home.jsp");
	}
	else{
		response.sendRedirect("error.html");
	}
	%>
</BODY>
</HTML>