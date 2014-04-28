<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit Customer</title>


<%
String custId = request.getParameter("custid");
String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
String mysUserID = "tester"; 
String mysPassword = "test";

String stuId = ""+session.getValue("login");
		java.sql.Connection conn=null;
	try 
	{
    	Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops=System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);

		//connect to the database
    	conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
    	System.out.println("Connected successfully to database using JConnect");
    
    	java.sql.Statement stmt1=conn.createStatement();

		java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Customer C, Person P " +
													"WHERE C.id = "+custId+" AND C.id = P.id");
		
		rs.next();

%>

<script language="javascript" type="text/javascript">
// <!CDATA[
function Button1_onclick() {
	
if(document.editCust.firstName.value == "")
		alert("Please enter first name")
else if(document.editCust.lastName.value == "")
		alert("Please enter last name")
else if(document.editCust.address.value == "")
		alert("Please enter address")
else if(document.editCust.city.value == "")
		alert("Please enter city")
else if(document.editCust.state.value == "")
		alert("Please enter state")
else if(document.editCust.zip.value == "")
		alert("Please enter zip")
else if(document.editCust.cardNum.value == "")
		alert("Please enter credit card number")
else if(document.editCust.email.value == "")
		alert("Please enter email")
else{
	document.editCust.submit()
	}
}



// ]]>
</script>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Edit Customer</h1>
	<form name="editCust" action="custEdit.jsp?custId=<%=rs.getString(1)%>" method="post">
	<p>First Name: <input type="text" value="<%=rs.getString(8)%>" name="firstName"></p>
	<p>Last Name: <input type="text" value="<%=rs.getString(9)%>" name="lastName"></p>
	<p>Address: <input type="text" value="<%=rs.getString(10)%>" name="address"></p>
	<p>City: <input type="text" value="<%=rs.getString(11)%>" name="city"></p>
	<p>State: <input type="text" value="<%=rs.getString(12)%>" name="state"></p>
	<p>Zip: <input type="text" value="<%=rs.getString(13)%>" name="zip"></p>
	<p>Credit Card Number: <input type="text" value="<%=rs.getString(3)%>" name="cardNum"></p>
	<p>Email: <input type="text" value="<%=rs.getString(4)%>" name="email"></p>
	<input id="submitButton" type="button" value="Save" onclick="return Button1_onclick()" />
	</form>
<%	
	} catch(Exception e)
	{
		e.printStackTrace();
		out.print(e.toString());
	}
	finally{
	
		try{conn.close();}catch(Exception ee){};
	}
%>

<input id="Button2" type="button" value="Cancel" onclick="window.open('EmployeeViewCustomers.jsp','_self');" />
</body>
</html>