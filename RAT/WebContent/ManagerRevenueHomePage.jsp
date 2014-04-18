<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manager Revenue Page</title>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Manager Revenue Page</h1>
	<input id="Button1" name="ViewSalesReport" type="button" value="View Sales Reports" onclick="window.open('ManagerRevenueSalesReports.jsp','_self');" />
	<br />
	<br />
	<input id="Button2" name="ViewRevenueSummary" type="button" value="View Revenue Summary Listings" onclick="window.open('ManagerRevenueSummary.jsp','_self');" />
	<br />
	<br />
	<input id="Button3" name="ViewRevenueGenerated" type="button" value="View Customer/Customer Rep Revenue" onclick="window.open('ManagerRevenueGenerated.jsp','_self');" />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<br />
	<input id="BotButton1" type="button" value="Back" onclick="window.open('Manager.jsp','_self');" />
    <input id="BotButton2" type="button" value="Logout" onclick="window.open('main.jsp','_self');" />
    <br />
    <span style="font-size: 8pt">
    <br />
    RAT Reservations<br />
    Department of Computer Science<br />
	</span>    
</body>
</html>