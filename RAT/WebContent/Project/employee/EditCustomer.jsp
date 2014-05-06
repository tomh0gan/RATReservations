<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>RAT Reservations - Edit Customer</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <link href="../resources/css/register.css" rel="stylesheet">
    
    <style>
    	.redText{
    		color: red;
    	}
    </style>

</head>

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


	
if(document.editCust.firstName.value == ""){
		alert("Please enter first name")
}
else if(document.editCust.lastName.value == "")
		alert("Please enter last name");
else if(document.editCust.address.value == "")
		alert("Please enter address")
else if(document.editCust.city.value == "")
		alert("Please enter city")
else if(document.editCust.state.value == "")
		alert("Please enter state")
else if(document.editCust.zip.value == "")
		alert("Please enter zip")
else if(document.editCust.zip.value.length != 5)
		alert("Please enter a valid 5 digit zip")
else if(document.editCust.cardNum.value == "")
		alert("Please enter credit card number")
else if(document.editCust.cardNum.value.length  != 16)
		alert("Please enter a valid 16 digit credit card number")
else if(document.editCust.email.value == "")
		alert("Please enter email address")
else if(document.editCust.email.value.indexOf("@") == -1)
		alert("Please enter valid email address")
else if(document.editCust.email.value.indexOf(".") == -1)
		alert("Please enter valid email address")
else{
	i = 0;
	document.editCust.submit()
}


}



// ]]>
</script>
</head>
<body>
	<div class="container">
	<h2 class="col-sm-offset-3 form-register-heading">Edit Customer</h2>
	<form name="editCust" action="custEdit.jsp?custId=<%=rs.getString(1)%>" method="post" class="form-horizontal">
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=firstName>First Name</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(8)%>" name=firstName type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=lastName>Last Name</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(9)%>" name=lastName type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=address>Address</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(10)%>" name=address type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=city>City</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(11)%>" name=city type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=state>State</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(12)%>" name=state type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=zip>Zip</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(13)%>" name=zip type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=cardNum>Credit Card Number</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(3)%>" name=cardNum type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=email>Email</label>
        		<div class="col-sm-5">
        			<input value="<%=rs.getString(4)%>" name=email type="text" class="form-control">
        		</div>
     	</div>
		<div class="form-group">
	      <div class="col-sm-offset-3 col-sm-10">
 			<button class="btn btn-default btn-lg" type="button" onclick="return Button1_onclick()">Save</button>
	      </div>
	      <div class="col-sm-offset-3 col-sm-10">
	      <br /><br />Employee Page: <a href="EmployeeViewCustomers.jsp">Back</a> 
	      </div>
	    </div>
	
	</form>
	</div>
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


</body>
</html>