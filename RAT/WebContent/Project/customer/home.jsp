<%@ page import="java.util.GregorianCalendar, java.text.SimpleDateFormat, java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Find Flights</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<!-- START SCRIPT -->
<script>
	
</script>
<!-- END SCRIPT -->
</head>
<body>
	<!-- START NAV -->
	<div class="container">
		<div class="navbar navbar-default" style="margin-top: 20px;">
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
						<li class="active"><a href="#">Find Flights</a></li>
						<li><a href="#">View Reservations</a></li>
						<li><a href="#">View Bids</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="#">My Account (<%=session.getAttribute("username")%>)
						</a></li>
						<li><div>
								<a class="btn btn-default navbar-btn" href="../logout.jsp">Log
									out</a>
							</div></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- END NAV -->
	<br>
	<br>
	<!-- START PAGE -->
	<div class="container">
		<form class="form-horizontal" action="generate_paths.jsp" method="post">
			<fieldset>
				<legend>Search Flights</legend>

				<!-- DEPATURE AIRPORT -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="depAirportId">Flying
						from</label>
					<div class="col-md-6">
						<select id="depAirportId" name="depAirportId" class="form-control"
							required>
							<option value="">pick departure airport</option>
							<option value="BTL">BTL</option>
							<option value="COI">COI</option>
							<option value="HJA">HJA</option>
							<option value="IIL">IIL</option>
							<option value="JFK">JFK</option>
							<option value="LAI">LAI</option>
							<option value="LGA">LGA</option>
							<option value="LNH">LNH</option>
							<option value="LNI">LNI</option>
							<option value="SFI">SFI</option>
							<option value="TYI">TYI</option>
						</select>
					</div>
				</div>

				<!-- ARRIVAL AIRPORT -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="arrAirportId">Flying
						to</label>
					<div class="col-md-6">
						<select id="arrAirportId" name="arrAirportId" class="form-control"
							required>
							<option value="">pick arrival airport</option>
							<option value="BTL">BTL</option>
							<option value="COI">COI</option>
							<option value="HJA">HJA</option>
							<option value="IIL">IIL</option>
							<option value="JFK">JFK</option>
							<option value="LAI">LAI</option>
							<option value="LGA">LGA</option>
							<option value="LNH">LNH</option>
							<option value="LNI">LNI</option>
							<option value="SFI">SFI</option>
							<option value="TYI">TYI</option>
						</select>
					</div>
				</div>

				<!-- DEPARTING -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="depDate">Departing</label>
					<div class="col-md-3">
						<input id="depDate" name="depDate" type="date"
							class="form-control input-md" required>
							<!-- min="<%=((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime()))%>" -->
					</div>
				</div>

				<!-- NUM OF PASSENGERS -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="numOfPassengers">Passengers</label>
					<div class="col-md-2">
						<select id="numOfPassengers" name="numOfPassengers"
							class="form-control">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
						</select>
					</div>
				</div>

				<!-- SEARCH BUTTON -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="search"></label>
					<div class="col-md-4">
						<button id="search" name="search" class="btn btn-warning">Search</button>
					</div>
				</div>

			</fieldset>
		</form>
	</div>
	<!-- END PAGE -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>