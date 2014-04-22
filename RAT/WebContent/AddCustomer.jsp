<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Customer</title>

<script language="javascript" type="text/javascript">
// <!CDATA[

function Button1_onclick() {
if(document.addCust.firstName.value == "")
		alert("Please enter first name")
else if(document.addCust.lastName.value == "")
		alert("Please enter last name")
else if(document.addCust.address.value == "")
		alert("Please enter address")
else if(document.addCust.city.value == "")
		alert("Please enter city")
else if(document.addCust.state.value == "")
		alert("Please enter state")
else if(document.addCust.zip.value == "")
		alert("Please enter zip")
else if(document.addCust.cardNo.value == "")
		alert("Please enter credit card number")
else if(document.addCust.email.value == "")
		alert("Please enter email")
else{
	document.addCust.submit()
	}
}



// ]]>
</script>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Add Customer</h1>
	<form name="addCust" action="custAdded.jsp" method="post">
	<p>First Name: <input type="text" value="" name="firstName"></p>
	<p>Last Name: <input type="text" value="" name="lastName"></p>
	<p>Address: <input type="text" value="" name="address"></p>
	<p>City: <input type="text" value="" name="city"></p>
	<p>State: <input type="text" value="" name="state"></p>
	<p>Zip: <input type="text" value="" name="zip"></p>
	<p>Credit Card Number: <input type="text" value="" name="cardNo"></p>
	<p>Email: <input type="text" value="" name="email"></p>
	<input id="submitButton" type="button" value="Submit" onclick="return Button1_onclick()" />
	</form>
	

</body>
</html>