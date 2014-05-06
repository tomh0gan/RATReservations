<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - My Account</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
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
	<div class="container">
		<div class="navbar navbar-default" role="navigation"
			style="margin-top: 20px;">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">RAT Reservations</a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li><a href="home.jsp">Find Flights</a></li>
						<li><a href="view_reservations.jsp">View Reservations</a></li>
						<li><a href="view_bids.jsp">View Bids</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="get_account_info.jsp"><b>My Account (<%=session.getAttribute("username")%>)
							</b></a></li>
						<li><div>
								<a class="btn btn-default navbar-btn" href="../logout.jsp">Log
									out</a>
							</div></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<br>
	<div class="container">
		<form class="form-horizontal" action="account_info_verification.jsp?updateType=password" method="post">
			<fieldset>
				<legend>Change Password</legend>
				<div class="well">
					<p class=greenText id=successMessagePass>${successMessagePass}</p>
					<div class="form-group">
						<label class="col-md-4 control-label" for="currPass">Current
							Password</label>
						<div class="col-md-5">
							<input id="currPass" name="currPass" type="password"
								 class="form-control input-md" oninput="clearErrorMsg('currPassError')" required />
							<span class="redText" id="currPassError">${currPassError}</span>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="newPass1">
							New Password</label>
						<div class="col-md-5">
							<input id="newPass1" name="newPass1" type="password"
								 class="form-control input-md" oninput="clearErrorMsg('newPass1Error')" required />
							<span class="redText" id="newPass1Error">${newPass1Error}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="newPass2">Retype
							New Password</label>
						<div class="col-md-5">
							<input id="newPass2" name="newPass2" type="password"
								 class="form-control input-md" required />
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="changePassword"></label>
						<div class="col-md-4">
							<button id="changePassword" name="changePassword"
								class="btn btn-primary">Submit</button>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
	<div class="container">
		<form class="form-horizontal" action="account_info_verification.jsp?updateType=account" method="post">
			<fieldset>
				<legend>Edit Account Info</legend>
				<div class="well">
				    <p class=greenText id=successMessageAcct>${successMessageAcct}</p>
					<div class="form-group">
						<label class="col-md-4 control-label" for="firstName">First
							Name</label>
						<div class="col-md-5">
							<input id="firstName" name="firstName" type="text" value="${firstName}"
								 class="form-control input-md" oninput="clearErrorMsg('emailError')" />
							<span class="redText" id="firstNameError">${firstNameError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="lastName">Last
							Name</label>
						<div class="col-md-5">
							<input id="lastName" name="lastName" type="text" value="${lastName}"
								 class="form-control input-md" oninput="clearErrorMsg('firstNameError')" />
							<span class="redText" id="lastNameError">${lastNameError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="email">Email</label>
						<div class="col-md-5">
							<input id="email" name="email" type="text" value="${email}"
								 class="form-control input-md" oninput="clearErrorMsg('lastNameError')"  />
							<span class="redText" id="emailError">${emailError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="submitEditInfo"></label>
						<div class="col-md-4">
							<button id="submitEditInfo" name="submitEditInfo"
								class="btn btn-primary">Submit</button>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
	<div class="container">
		<form class="form-horizontal" action="account_info_verification.jsp?updateType=billing" method="post">
			<fieldset>
				<legend>Edit Billing Info</legend>
				<div class="well">
					<p class=greenText id=successMessageBill>${successMessageBill}</p>
					<div class="form-group">
						<label class="col-md-4 control-label" for="address">Address</label>
						<div class="col-md-5">
							<input id="address" name="address" type="text" value="${address}"
								 class="form-control input-md" oninput="clearErrorMsg('addressError')"/>
							<span class="redText" id="addressError">${addressError}</span>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="city">City</label>
						<div class="col-md-5">
							<input id="city" name="city" type="text" value="${city}"
								class="form-control input-md" oninput="clearErrorMsg('cityError')"/>
							<span class="redText" id="cityError">${cityError}</span>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="state" oninput="clearErrorMsg('stateError')">State</label>
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
							<input id="zipCode" name="zipcode" type="text" value="${zipcode}"
								 class="form-control input-md" oninput="clearErrorMsg('zipcodeError')"/>
							<span class="redText" id="zipcodeError">${zipcodeError}</span>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="creditCard">Credit
							Card</label>
						<div class="col-md-6">
							<input id="creditCard" name="creditCard" type="text" value="${creditcard}"
								 class="form-control input-md" oninput="clearErrorMsg('creditCardError')"/>
							<span class="redText" id="creditCardError">${creditCardError}</span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="submitEditInfo"></label>
						<div class="col-md-4">
							<button id="submitEditInfo" name="submitEditInfo"
								class="btn btn-primary">Submit</button>
						</div>
					</div>
				</div>
			</fieldset>
		</form>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>