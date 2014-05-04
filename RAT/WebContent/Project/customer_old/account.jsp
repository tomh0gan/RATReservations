<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - My Account</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript">
	function dtable() {
		if (document.getElementById('type-0').checked) {
			document.getElementById('returning_div').style.display = "block";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if (document.getElementById('type-1').checked) {
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if (document.getElementById('type-2').checked) {
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "block";
		}
	}
</script>
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
						<li><a href="account.jsp"><b>My Account (<%=session.getAttribute("username")%>)
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
		<form class="form-horizontal">
			<fieldset>
				<legend>Change Password</legend>
				<div class="well">
					<div class="form-group">
						<label class="col-md-4 control-label" for="currPass">Current
							Password</label>
						<div class="col-md-5">
							<input id="currPass" name="currPass" type="password"
								placeholder="" class="form-control input-md" required>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="newPass1">
							New Password</label>
						<div class="col-md-5">
							<input id="newPass1" name="newPass1" type="password"
								placeholder="" class="form-control input-md" required>

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="newPass2">Retype
							New Password</label>
						<div class="col-md-5">
							<input id="newPass2" name="newPass2" type="password"
								placeholder="" class="form-control input-md" required>
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
		<form class="form-horizontal">
			<fieldset>
				<legend>Edit Account Info</legend>
				<div class="well">
					<div class="form-group">
						<label class="col-md-4 control-label" for="firstName">First
							Name</label>
						<div class="col-md-5">
							<input id="firstName" name="firstName" type="text"
								placeholder="currFirstName" class="form-control input-md">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="lastName">Last
							Name</label>
						<div class="col-md-5">
							<input id="lastName" name="lastName" type="text"
								placeholder="currLastName" class="form-control input-md">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="email">Email</label>
						<div class="col-md-5">
							<input id="email" name="email" type="text"
								placeholder="currEmail" class="form-control input-md">
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
		<form class="form-horizontal">
			<fieldset>
				<legend>Edit Billing Info</legend>
				<div class="well">
					<div class="form-group">
						<label class="col-md-4 control-label" for="address">Address</label>
						<div class="col-md-5">
							<input id="address" name="address" type="text"
								placeholder="currAddress" class="form-control input-md">

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="city">City</label>
						<div class="col-md-5">
							<input id="city" name="city" type="text" placeholder="currCity"
								class="form-control input-md">

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="state">State</label>
						<div class="col-md-5">
							<select id="state" name="state" class="form-control">
								<option value="1">Option one</option>
								<option value="2">Option two</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="zipCode">ZIP
							code</label>
						<div class="col-md-4">
							<input id="zipCode" name="zipCode" type="text"
								placeholder="currZipcode" class="form-control input-md">

						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="creditCard">Credit
							Card</label>
						<div class="col-md-6">
							<input id="creditCard" name="creditCard" type="text"
								placeholder="xxxxxxxxxxxxLASTFOUR" class="form-control input-md">
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