<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>RAT Reservations - Register</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <link href="../resources/css/register.css" rel="stylesheet">
    
    <style>
    	.redText{
    		color: red;
    	}
    </style>
    <script>
		function clearErrorMsg(errorMsgTagId){
    		document.getElementById(errorMsgTagId).innerHTML = "";
		}
	</script>
  </head>

  <body>
     <% if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	   }
  	 %>
    <div class="container">

      <form action="customer_verification.jsp" method="post" class="form-horizontal">
      
      
      	<h2 class="col-sm-offset-3 form-register-heading">Create Customer</h2>
      	
      	
        <br /><br />
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=firstName>First Name</label>
        	<div class="col-sm-5">
        		<input value="${CustomerFName}" name=firstName type="text" class="form-control" placeholder="First name" oninput="clearErrorMsg('fNameError')" required autofocus>
        		<span class="redText" id="fNameError">${CustomerFNameError}</span>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=lastName>Last Name</label>
        	<div class="col-sm-5">
        		<input value="${CustomerLName}" name=lastName type="text" class="form-control" placeholder="Last name" oninput="clearErrorMsg('lNameError')" required>
        		<span class="redText" id="lNameError">${CustomerLNameError}</span>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=email>Email</label>
        	<div class="col-sm-5">
        		<input value="${CustomerEmail}" name=email type="text" class="form-control" placeholder="Email" oninput="clearErrorMsg('emailError')" required>
        		<span class="redText" id="emailError">${CustomerEmailError}</span>
        	</div>
        </div>
	 	<div class="form-group">  
			<label class="col-sm-2 control-label" for=username>Username</label>
			<div class="col-sm-5">
				<input value="${CustomerUsername}" name=username type="text" class="form-control" placeholder="Username" oninput="clearErrorMsg('usernameError')" required>
				<span class="redText" id="usernameError">${CustomerUsernameError}</span>
			</div>
		 </div>       
		<div class="form-group">  
			<label class="col-sm-2 control-label" for=password>Password</label>
			<div class="col-sm-5">
				<input name=password type="password" class="form-control" placeholder="Password" required>
			</div>
		</div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=address>Address</label>
        	<div class="col-sm-5">
        		<input value="${CustomerAddress}" name=address type="text" class="form-control" placeholder="Address" required>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=city>City</label>
        	<div class="col-sm-5">
        		<input value="${CustomerCity}" name=city type="text" class="form-control" placeholder="City" required>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=state>State</label>
        	<div class="col-sm-4">
        	<select id="state" name="state" class="form-control" oninput="clearErrorMsg('stateError')" required>
				<option ${CustomerState==""?"Selected=selected":""} value="">Please Select:</option>
				<option ${CustomerState=="AL"?"Selected=selected":""} value="AL">Alabama</option>
				<option ${CustomerState=="AK"?"Selected=selected":""} value="AK">Alaska</option>
				<option ${CustomerState=="AZ"?"Selected=selected":""} value="AZ">Arizona</option>
				<option ${CustomerState=="AR"?"Selected=selected":""} value="AR">Arkansas</option>
				<option ${CustomerState=="CA"?"Selected=selected":""} value="CA">California</option>
				<option ${CustomerState=="CO"?"Selected=selected":""} value="CO">Colorado</option>
				<option ${CustomerState=="CT"?"Selected=selected":""} value="CT">Connecticut</option>
				<option ${CustomerState=="DE"?"Selected=selected":""} value="DE">Delaware</option>
				<option ${CustomerState=="DC"?"Selected=selected":""} value="DC">District Of Columbia</option>
				<option ${CustomerState=="FL"?"Selected=selected":""} value="FL">Florida</option>
				<option ${CustomerState=="GA"?"Selected=selected":""} value="GA">Georgia</option>
				<option ${CustomerState=="HI"?"Selected=selected":""} value="HI">Hawaii</option>
				<option ${CustomerState=="ID"?"Selected=selected":""} value="ID">Idaho</option>
				<option ${CustomerState=="IL"?"Selected=selected":""} value="IL">Illinois</option>
				<option ${CustomerState=="IN"?"Selected=selected":""} value="IN">Indiana</option>
				<option ${CustomerState=="IA"?"Selected=selected":""} value="IA">Iowa</option>
				<option ${CustomerState=="KS"?"Selected=selected":""} value="KS">Kansas</option>
				<option ${CustomerState=="KY"?"Selected=selected":""} value="KY">Kentucky</option>
				<option ${CustomerState=="LA"?"Selected=selected":""} value="LA">Louisiana</option>
				<option ${CustomerState=="ME"?"Selected=selected":""} value="ME">Maine</option>
				<option ${CustomerState=="MD"?"Selected=selected":""} value="MD">Maryland</option>
				<option ${CustomerState=="MA"?"Selected=selected":""} value="MA">Massachusetts</option>
				<option ${CustomerState=="MI"?"Selected=selected":""} value="MI">Michigan</option>
				<option ${CustomerState=="MN"?"Selected=selected":""} value="MN">Minnesota</option>
				<option ${CustomerState=="MS"?"Selected=selected":""} value="MS">Mississippi</option>
				<option ${CustomerState=="MO"?"Selected=selected":""} value="MO">Missouri</option>
				<option ${CustomerState=="MT"?"Selected=selected":""} value="MT">Montana</option>
				<option ${CustomerState=="NE"?"Selected=selected":""} value="NE">Nebraska</option>
				<option ${CustomerState=="NV"?"Selected=selected":""} value="NV">Nevada</option>
				<option ${CustomerState=="NH"?"Selected=selected":""} value="NH">New Hampshire</option>
				<option ${CustomerState=="NJ"?"Selected=selected":""} value="NJ">New Jersey</option>
				<option ${CustomerState=="NM"?"Selected=selected":""} value="NM">New Mexico</option>
				<option ${CustomerState=="NY"?"Selected=selected":""} value="NY">New York</option>
				<option ${CustomerState=="NC"?"Selected=selected":""} value="NC">North Carolina</option>
				<option ${CustomerState=="ND"?"Selected=selected":""} value="ND">North Dakota</option>
				<option ${CustomerState=="OH"?"Selected=selected":""} value="OH">Ohio</option>
				<option ${CustomerState=="OK"?"Selected=selected":""} value="OK">Oklahoma</option>
				<option ${CustomerState=="OR"?"Selected=selected":""} value="OR">Oregon</option>
				<option ${CustomerState=="PA"?"Selected=selected":""} value="PA">Pennsylvania</option>
				<option ${CustomerState=="RI"?"Selected=selected":""} value="RI">Rhode Island</option>
				<option ${CustomerState=="SC"?"Selected=selected":""} value="SC">South Carolina</option>
				<option ${CustomerState=="SD"?"Selected=selected":""} value="SD">South Dakota</option>
				<option ${CustomerState=="TN"?"Selected=selected":""} value="TN">Tennessee</option>
				<option ${CustomerState=="TX"?"Selected=selected":""} value="TX">Texas</option>
				<option ${CustomerState=="UT"?"Selected=selected":""} value="UT">Utah</option>
				<option ${CustomerState=="VT"?"Selected=selected":""} value="VT">Vermont</option>
				<option ${CustomerState=="VT"?"Selected=selected":""} value="VA">Virginia</option>
				<option ${CustomerState=="WA"?"Selected=selected":""} value="WA">Washington</option>
				<option ${CustomerState=="WV"?"Selected=selected":""} value="WV">West Virginia</option>
				<option ${CustomerState=="WI"?"Selected=selected":""} value="WI">Wisconsin</option>
				<option ${CustomerState=="WY"?"Selected=selected":""} value="WY">Wyoming</option>
			</select>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=zipcode>Zipcode</label>
        	<div class="col-sm-5">
        		<input value="${CustomerZip}" name=zipcode type="text" class="form-control" placeholder="Zipcode" oninput="clearErrorMsg('zipError')" required>
        		<span class="redText" id="zipError">${CustomerZipError}</span>
        	</div>
        </div>
        <div class="form-group">
        	<label class="col-sm-2 control-label"  for=creditCard >Credit card </label>  
        	<div class="col-sm-5">
        		<input value="${CustomerCreditCard}" name=creditCard type="text" class="form-control" oninput="clearErrorMsg('creditCardError')" placeholder="xxxxxxxxxxxxxxxx" required>
        		<span class="redText" id="creditCardError">${CustomerCreditCardError}</span>
        	</div>
        </div>
        <br />
        <br />
	    <div class="form-group">
	      <div class="col-sm-offset-3 col-sm-10">
 			<button class="btn btn-default btn-lg" type="submit">Submit</button>
	      </div>
	      <div class="col-sm-offset-3 col-sm-10">
	      <br /><br />Manager Page: <a href="manager_customers.jsp">Back</a> 
	      </div>
	    </div>       
      </form>
    </div> 
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>

  </body>
</html>