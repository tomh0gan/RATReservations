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

      <form action="employee_verification.jsp" method="post" class="form-horizontal">
      	<%
      	if(request.getParameter("type") != null && request.getParameter("type").equals("edit")){
      		%><h2 class="col-sm-offset-3 form-register-heading">Edit Employee</h2><% 
      	}
      	else{
      		%><h2 class="col-sm-offset-3 form-register-heading">Create Employee</h2><% 
      	}
      	%>
        <br /><br />
        <div class="form-group">
        	<input type=hidden name=id value="${EmployeeId}" />  
        	<label class="col-sm-2 control-label" for=firstName>First Name</label>
        	<div class="col-sm-5">
        		<input name=firstName value="${EmployeeFName}" type="text" class="form-control" placeholder="First name" oninput="clearErrorMsg('fnameError')" required autofocus>
        		<span class="redText" id="fnameError">${EmployeeFNameError}</span>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=lastName>Last Name</label>
        	<div class="col-sm-5">
        		<input value="${EmployeeLName}" name=lastName type="text" class="form-control" placeholder="Last name" oninput="clearErrorMsg('lnameError')" required>
        		<span class="redText" id="lnameError">${EmployeeLNameError}</span>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=ssn>SSN</label>
        	<div class="col-sm-5">
        		<input value="${EmployeeSSN}" name=ssn type="text" class="form-control" placeholder="SSN" oninput="clearErrorMsg('ssnError')" required>
        		<span class="redText" id="ssnError">${EmployeeSSNError}</span>
        		<input type=hidden value="${OldEmployeeSSN}" name=oldSsn />
        	</div>
        </div>
        <%
	      	if(request.getParameter("type") == null || !(request.getParameter("type").equals("edit"))){
	      		%>
	      			        <div class="form-group">  
					        	<label class="col-sm-2 control-label" for=username>Username</label>
					        	<div class="col-sm-5">
					        		<input value="${EmployeeUsername}" name=username type="text" class="form-control" placeholder="Username" oninput="clearErrorMsg('usernameError')" required>
					        		<span class="redText" id="usernameError">${EmployeeUsernameError}</span>
					        	</div>
					        </div>       
					        <div class="form-group">  
					        	<label class="col-sm-2 control-label" for=password>Password</label>
					        	<div class="col-sm-5">
					        		<input name=password type="password" class="form-control" placeholder="Password" required>
					        	</div>
					        </div>
	      		<% 
	      	}
        %>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=address>Address</label>
        	<div class="col-sm-5">
        		<input value="${EmployeeAddress}" name=address type="text" class="form-control" placeholder="Address" required>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=city>City</label>
        	<div class="col-sm-5">
        		<input value="${EmployeeCity}" name=city type="text" class="form-control" placeholder="City" required>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=state>State</label>
        	<div class="col-sm-4">
        	<select id="state" name="state" class="form-control" oninput="clearErrorMsg('stateError')" required>
				<option ${EmployeeState==""?"Selected=selected":""} value="">Please Select:</option>
				<option ${EmployeeState=="AL"?"Selected=selected":""} value="AL">Alabama</option>
				<option ${EmployeeState=="AK"?"Selected=selected":""} value="AK">Alaska</option>
				<option ${EmployeeState=="AZ"?"Selected=selected":""} value="AZ">Arizona</option>
				<option ${EmployeeState=="AR"?"Selected=selected":""} value="AR">Arkansas</option>
				<option ${EmployeeState=="CA"?"Selected=selected":""} value="CA">California</option>
				<option ${EmployeeState=="CO"?"Selected=selected":""} value="CO">Colorado</option>
				<option ${EmployeeState=="CT"?"Selected=selected":""} value="CT">Connecticut</option>
				<option ${EmployeeState=="DE"?"Selected=selected":""} value="DE">Delaware</option>
				<option ${EmployeeState=="DC"?"Selected=selected":""} value="DC">District Of Columbia</option>
				<option ${EmployeeState=="FL"?"Selected=selected":""} value="FL">Florida</option>
				<option ${EmployeeState=="GA"?"Selected=selected":""} value="GA">Georgia</option>
				<option ${EmployeeState=="HI"?"Selected=selected":""} value="HI">Hawaii</option>
				<option ${EmployeeState=="ID"?"Selected=selected":""} value="ID">Idaho</option>
				<option ${EmployeeState=="IL"?"Selected=selected":""} value="IL">Illinois</option>
				<option ${EmployeeState=="IN"?"Selected=selected":""} value="IN">Indiana</option>
				<option ${EmployeeState=="IA"?"Selected=selected":""} value="IA">Iowa</option>
				<option ${EmployeeState=="KS"?"Selected=selected":""} value="KS">Kansas</option>
				<option ${EmployeeState=="KY"?"Selected=selected":""} value="KY">Kentucky</option>
				<option ${EmployeeState=="LA"?"Selected=selected":""} value="LA">Louisiana</option>
				<option ${EmployeeState=="ME"?"Selected=selected":""} value="ME">Maine</option>
				<option ${EmployeeState=="MD"?"Selected=selected":""} value="MD">Maryland</option>
				<option ${EmployeeState=="MA"?"Selected=selected":""} value="MA">Massachusetts</option>
				<option ${EmployeeState=="MI"?"Selected=selected":""} value="MI">Michigan</option>
				<option ${EmployeeState=="MN"?"Selected=selected":""} value="MN">Minnesota</option>
				<option ${EmployeeState=="MS"?"Selected=selected":""} value="MS">Mississippi</option>
				<option ${EmployeeState=="MO"?"Selected=selected":""} value="MO">Missouri</option>
				<option ${EmployeeState=="MT"?"Selected=selected":""} value="MT">Montana</option>
				<option ${EmployeeState=="NE"?"Selected=selected":""} value="NE">Nebraska</option>
				<option ${EmployeeState=="NV"?"Selected=selected":""} value="NV">Nevada</option>
				<option ${EmployeeState=="NH"?"Selected=selected":""} value="NH">New Hampshire</option>
				<option ${EmployeeState=="NJ"?"Selected=selected":""} value="NJ">New Jersey</option>
				<option ${EmployeeState=="NM"?"Selected=selected":""} value="NM">New Mexico</option>
				<option ${EmployeeState=="NY"?"Selected=selected":""} value="NY">New York</option>
				<option ${EmployeeState=="NC"?"Selected=selected":""} value="NC">North Carolina</option>
				<option ${EmployeeState=="ND"?"Selected=selected":""} value="ND">North Dakota</option>
				<option ${EmployeeState=="OH"?"Selected=selected":""} value="OH">Ohio</option>
				<option ${EmployeeState=="OK"?"Selected=selected":""} value="OK">Oklahoma</option>
				<option ${EmployeeState=="OR"?"Selected=selected":""} value="OR">Oregon</option>
				<option ${EmployeeState=="PA"?"Selected=selected":""} value="PA">Pennsylvania</option>
				<option ${EmployeeState=="RI"?"Selected=selected":""} value="RI">Rhode Island</option>
				<option ${EmployeeState=="SC"?"Selected=selected":""} value="SC">South Carolina</option>
				<option ${EmployeeState=="SD"?"Selected=selected":""} value="SD">South Dakota</option>
				<option ${EmployeeState=="TN"?"Selected=selected":""} value="TN">Tennessee</option>
				<option ${EmployeeState=="TX"?"Selected=selected":""} value="TX">Texas</option>
				<option ${EmployeeState=="UT"?"Selected=selected":""} value="UT">Utah</option>
				<option ${EmployeeState=="VT"?"Selected=selected":""} value="VT">Vermont</option>
				<option ${EmployeeState=="VT"?"Selected=selected":""} value="VA">Virginia</option>
				<option ${EmployeeState=="WA"?"Selected=selected":""} value="WA">Washington</option>
				<option ${EmployeeState=="WV"?"Selected=selected":""} value="WV">West Virginia</option>
				<option ${EmployeeState=="WI"?"Selected=selected":""} value="WI">Wisconsin</option>
				<option ${EmployeeState=="WY"?"Selected=selected":""} value="WY">Wyoming</option>
			</select>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=zipcode>Zipcode</label>
        	<div class="col-sm-5">
        		<input value="${EmployeeZip}" name=zipcode type="text" class="form-control" placeholder="Zipcode" oninput="clearErrorMsg('zipError')" required>
        		<span class="redText" id="zipError">${EmployeeZipError}</span>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=city>Position</label>
        	<div class="col-sm-5">
        	    <div class="radio">
				  <label>
				    <input type="radio" name="emplType" id="emplType1" value="employee" ${EmployeeEmplType=='employee'?"checked":""} required>
				    Employee
				  </label>
				</div>
				<div class="radio">
				  <label>
				    <input type="radio" name="emplType" id="emplType2" value="manager" ${EmployeeEmplType=='manager'?"checked":""}>
				    Manager
				  </label>
				</div>
        	</div>
        </div>
        <div class="form-group">  
        	<label class="col-sm-2 control-label" for=hourlyRate>Hourly Rate</label>
        	<div class="col-sm-5">
        	<input value="${EmployeeHourlyRate}" name=hourlyRate type="text" class="form-control" oninput="clearErrorMsg('hourlyRateError')" placeholder="Hourly Rate" required>
			<span class="redText" id="hourlyRateError">${EmployeeHourlyRateError}</span>
        	</div>
        </div>
        <br />
        <br />
	    <div class="form-group">
	      <div class="col-sm-offset-3 col-sm-10">
 			<button class="btn btn-default btn-lg" type="submit">Submit</button>
	      </div>
	      <div class="col-sm-offset-3 col-sm-10">
	      <br /><br />Employee Page: <a href="manager_employee_page.jsp">Back</a> 
	      </div>
	    </div>       
      </form>
    </div> 
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>

  </body>
</html>