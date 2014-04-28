<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<HTML>
<BODY>
	<%
	//Employee Values
	session.removeAttribute("EmployeeFName");
	session.removeAttribute("EmployeeLName");
	session.removeAttribute("EmployeeId");
	session.removeAttribute("EmployeeUsername");
	session.removeAttribute("EmployeePassword");
	session.removeAttribute("OldEmployeeSSN");
	session.removeAttribute("EmployeeSSN");
	session.removeAttribute("EmployeeAddress");
	session.removeAttribute("EmployeeCity");
	session.removeAttribute("EmployeeState");
	session.removeAttribute("EmployeeZip");
	session.removeAttribute("EmployeeEmplType");
	session.removeAttribute("EmployeeHourlyRate");
	//Error message
    session.removeAttribute("EmployeeUsernameError");
	session.removeAttribute("EmployeeSSNError");
	session.removeAttribute("EmployeeFNameError");
	session.removeAttribute("EmployeeLNameError");
	session.removeAttribute("EmployeeAddressError");
	session.removeAttribute("EmployeeCityError");
	session.removeAttribute("EmployeeStateError");
	session.removeAttribute("EmployeeZipError");
	session.removeAttribute("EmployeeHourlyRateError");
	//Redirect
	response.sendRedirect("manager_employee_page.jsp");	
	%>
</BODY>
</HTML>