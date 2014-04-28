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

    <title>RAT Reservations - Register Customer</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <link href="../resources/css/register.css" rel="stylesheet">
    
    <style>
    	.redText{
    		color: red;
    	}
    </style>


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
<body>
	<div class="container">
	<h2 class="col-sm-offset-3 form-register-heading">Add Customer</h2>
	<form name="addCust" action="custAdded.jsp" method="post" class="form-horizontal">
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=firstName>First Name</label>
        		<div class="col-sm-5">
        			<input value="" name=firstName type="text" class="form-control" placeholder="First name">
        		</div>
     	</div>
     	<div class="form-group">  
        		<label class="col-sm-2 control-label" for=lastName>Last Name</label>
        		<div class="col-sm-5">
        			<input value="" name=lastName type="text" class="form-control" placeholder="Last name">
        		</div>
     	</div>
	
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=address>Address</label>
        		<div class="col-sm-5">
        			<input value="" name=address type="text" class="form-control" placeholder="Address">
        		</div>
     	</div>

		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=city>City</label>
        		<div class="col-sm-5">
        			<input value="" name=city type="text" class="form-control" placeholder="City">
        		</div>
     	</div>
	
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=state>State</label>
        		<div class="col-sm-5">
        			<input value="" name=state type="text" class="form-control" placeholder="State">
        		</div>
     	</div>
     	
     	<div class="form-group">  
        		<label class="col-sm-2 control-label" for=zip>Zip</label>
        		<div class="col-sm-5">
        			<input value="" name=zip type="text" class="form-control" placeholder="Zip">
        		</div>
     	</div>
	
		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=cardNo>Credit Card Number</label>
        		<div class="col-sm-5">
        			<input value="" name=cardNo type="text" class="form-control" placeholder="Credit Card Number">
        		</div>
     	</div>

		<div class="form-group">  
        		<label class="col-sm-2 control-label" for=email>Email</label>
        		<div class="col-sm-5">
        			<input value="" name=email type="text" class="form-control" placeholder="Email">
        		</div>
     	</div>

	
	<div class="form-group">
	      <div class="col-sm-offset-3 col-sm-10">
 			<button class="btn btn-default btn-lg" type="submit" onclick="return Button1_onclick()">Submit</button>
	      </div>
	      <div class="col-sm-offset-3 col-sm-10">
	      <br /><br />Employee Page: <a href="EmployeeViewCustomers.jsp">Back</a> 
	      </div>
	    </div>
	
	
	</form>
    </div>	
</body>
</html>