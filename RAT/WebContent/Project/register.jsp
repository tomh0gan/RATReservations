<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - My Account</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="resources/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
	function clearErrorMsg(errorMsgTagId){
		document.getElementById(errorMsgTagId).innerHTML = "";
	}
</script>
<style>
	.redText{ color: red; }
	.greenText{ color: green; }
</style>
</head>
<body>
	<% session.invalidate(); %>
	<div class="container">
		<h1>Rat Reservations - Create Account</h1>
	</div>
	<br/>
	<br/>
	<form class="form-horizontal" action="account_register.jsp" method="post">
	<div class="container">
			<fieldset>
				<legend>Login Information</legend>
				<div class="well">
					<div class="form-group">
						<label class="col-md-4 control-label" for="username">Username: </label>
						<div class="col-md-5">
							<input id="username" name="username" type="text" placeholder="Username" class="form-control input-md" value="${username}" oninput="clearErrorMsg('usernameError')" required />
							<span class="redText" id="usernameError">${usernameError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="currPass">Password: </label>
						<div class="col-md-5">
							<input id="password" name="password" type="password" placeholder="Password" class="form-control input-md" oninput="clearErrorMsg('passwordError')" required />
							<span class="redText" id="passwordError">${passwordError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="currPass">Confirm Password: </label>
						<div class="col-md-5">
							<input id="confirmpassword" name="confirmpassword" type="password" placeholder="Confirm Password" class="form-control input-md" oninput="clearErrorMsg('confirmpasswordError')" required />
							<span class="redText" id="confirmpasswordError">${confirmPasswordError}</span>
						</div>
					</div>
				</div>
			</fieldset>
	</div>
	<div class="container">
			<fieldset>
				<legend>Account Info</legend>
				<div class="well">
				    <p class=greenText id=successMessageAcct>${successMessageAcct}</p>
					<div class="form-group">
						<label class="col-md-4 control-label" for="firstName">First
							Name</label>
						<div class="col-md-5">
							<input id="firstName" name="firstName" type="text" placeholder="First Name" value="${firstName}" 
							class="form-control input-md" oninput="clearErrorMsg('emailError')" required />
							<span class="redText" id="firstNameError">${firstNameError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="lastName">Last
							Name</label>
						<div class="col-md-5">
							<input id="lastName" name="lastName" type="text" placeholder="Last Name" value="${lastName}"
								 class="form-control input-md" oninput="clearErrorMsg('firstNameError')" required />
							<span class="redText" id="lastNameError">${lastNameError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="email">Email</label>
						<div class="col-md-5">
							<input id="email" name="email" type="text" placeholder="Email" value="${email}"
							 class="form-control input-md" oninput="clearErrorMsg('lastNameError')" required  />
							<span class="redText" id="emailError">${emailError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="submitEditInfo"></label>
				</div>
			</fieldset>
	</div>
	<div class="container">
			<fieldset>
				<legend>Billing Info</legend>
				<div class="well">
					<p class=greenText id=successMessageBill>${successMessageBill}</p>
					<div class="form-group">
						<label class="col-md-4 control-label" for="address">Address</label>
						<div class="col-md-5">
							<input id="address" name="address" type="text" value="${address}" placeholder="Address"
							 class="form-control input-md" oninput="clearErrorMsg('addressError')" required />
							<span class="redText" id="addressError">${addressError}</span>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="city">City</label>
						<div class="col-md-5">
							<input id="city" name="city" type="text" value="${city}" placeholder="City" 
							class="form-control input-md" oninput="clearErrorMsg('cityError')" required />
							<span class="redText" id="cityError">${cityError}</span>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="state" oninput="clearErrorMsg('stateError')" required >State</label>
						<div class="col-md-5">
							<select id="state" name="state" class="form-control">
								<option ${state==""?"Selected=selected":""} value="">Please Select:</option>
								<option ${state=="AL"?"Selected=selected":""} value="AL">Alabama</option>
								<option ${state=="AK"?"Selected=selected":""} value="AK">Alaska</option>
								<option ${state=="AZ"?"Selected=selected":""} value="AZ">Arizona</option>
								<option ${state=="AR"?"Selected=selected":""} value="AR">Arkansas</option>
								<option ${state=="CA"?"Selected=selected":""} value="CA">California</option>
								<option ${state=="CO"?"Selected=selected":""} value="CO">Colorado</option>
								<option ${state=="CT"?"Selected=selected":""} value="CT">Connecticut</option>
								<option ${state=="DE"?"Selected=selected":""} value="DE">Delaware</option>
								<option ${state=="DC"?"Selected=selected":""} value="DC">District Of Columbia</option>
								<option ${state=="FL"?"Selected=selected":""} value="FL">Florida</option>
								<option ${state=="GA"?"Selected=selected":""} value="GA">Georgia</option>
								<option ${state=="HI"?"Selected=selected":""} value="HI">Hawaii</option>
								<option ${state=="ID"?"Selected=selected":""} value="ID">Idaho</option>
								<option ${state=="IL"?"Selected=selected":""} value="IL">Illinois</option>
								<option ${state=="IN"?"Selected=selected":""} value="IN">Indiana</option>
								<option ${state=="IA"?"Selected=selected":""} value="IA">Iowa</option>
								<option ${state=="KS"?"Selected=selected":""} value="KS">Kansas</option>
								<option ${state=="KY"?"Selected=selected":""} value="KY">Kentucky</option>
								<option ${state=="LA"?"Selected=selected":""} value="LA">Louisiana</option>
								<option ${state=="ME"?"Selected=selected":""} value="ME">Maine</option>
								<option ${state=="MD"?"Selected=selected":""} value="MD">Maryland</option>
								<option ${state=="MA"?"Selected=selected":""} value="MA">Massachusetts</option>
								<option ${state=="MI"?"Selected=selected":""} value="MI">Michigan</option>
								<option ${state=="MN"?"Selected=selected":""} value="MN">Minnesota</option>
								<option ${state=="MS"?"Selected=selected":""} value="MS">Mississippi</option>
								<option ${state=="MO"?"Selected=selected":""} value="MO">Missouri</option>
								<option ${state=="MT"?"Selected=selected":""} value="MT">Montana</option>
								<option ${state=="NE"?"Selected=selected":""} value="NE">Nebraska</option>
								<option ${state=="NV"?"Selected=selected":""} value="NV">Nevada</option>
								<option ${state=="NH"?"Selected=selected":""} value="NH">New Hampshire</option>
								<option ${state=="NJ"?"Selected=selected":""} value="NJ">New Jersey</option>
								<option ${state=="NM"?"Selected=selected":""} value="NM">New Mexico</option>
								<option ${state=="NY"?"Selected=selected":""} value="NY">New York</option>
								<option ${state=="NC"?"Selected=selected":""} value="NC">North Carolina</option>
								<option ${state=="ND"?"Selected=selected":""} value="ND">North Dakota</option>
								<option ${state=="OH"?"Selected=selected":""} value="OH">Ohio</option>
								<option ${state=="OK"?"Selected=selected":""} value="OK">Oklahoma</option>
								<option ${state=="OR"?"Selected=selected":""} value="OR">Oregon</option>
								<option ${state=="PA"?"Selected=selected":""} value="PA">Pennsylvania</option>
								<option ${state=="RI"?"Selected=selected":""} value="RI">Rhode Island</option>
								<option ${state=="SC"?"Selected=selected":""} value="SC">South Carolina</option>
								<option ${state=="SD"?"Selected=selected":""} value="SD">South Dakota</option>
								<option ${state=="TN"?"Selected=selected":""} value="TN">Tennessee</option>
								<option ${state=="TX"?"Selected=selected":""} value="TX">Texas</option>
								<option ${state=="UT"?"Selected=selected":""} value="UT">Utah</option>
								<option ${state=="VT"?"Selected=selected":""} value="VT">Vermont</option>
								<option ${state=="VT"?"Selected=selected":""} value="VA">Virginia</option>
								<option ${state=="WA"?"Selected=selected":""} value="WA">Washington</option>
								<option ${state=="WV"?"Selected=selected":""} value="WV">West Virginia</option>
								<option ${state=="WI"?"Selected=selected":""} value="WI">Wisconsin</option>
								<option ${state=="WY"?"Selected=selected":""} value="WY">Wyoming</option>
							</select>
							<span class="redText" id="stateError">${stateError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="zipCode">ZIP
							code</label>
						<div class="col-md-4">
							<input id="zipCode" name="zipcode" type="text" value="${zipcode}" placeholder="Zip Code" 
							class="form-control input-md" oninput="clearErrorMsg('zipcodeError')" required />
							<span class="redText" id="zipcodeError">${zipcodeError}</span>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="creditCard">Credit
							Card</label>
						<div class="col-md-6">
							<input id="creditCard" name="creditCard" type="text" placeholder="xxxxxxxxxxxxxxxx" value="${creditCard}" 
							class="form-control input-md" oninput="clearErrorMsg('creditCardError')" required />
							<span class="redText" id="creditCardError">${creditCardError}</span>
						</div>
					</div>
				</div>
			</fieldset>
	</div>
	<div class="container">
		<div class="form-group">
			<label class="col-md-4 control-label" for="submitEditInfo"></label>
			<div class="col-md-4">
				<button id="submitEditInfo" name="submitEditInfo" class="btn btn-primary">Submit</button>
			</div>
		</div>
	</div>
	<br/><br/><br/>
	</form>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
</body>
</html>