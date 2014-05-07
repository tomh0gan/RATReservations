<%@ page import="java.util.GregorianCalendar, java.text.SimpleDateFormat, java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Find Flights</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<!-- START SCRIPT -->
 <script type="text/javascript">
	function dtable(){
		if(document.getElementById('type-0').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if(document.getElementById('type-1').checked){
			document.getElementById('returning_div').style.display = "block";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if(document.getElementById('type-2').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "block";
		}
	}
	
	function clearErrorMsg(errorMsgTagId){
		document.getElementById(errorMsgTagId).innerHTML = "";
	}
  </script>
  <style>
	.redText{ color: red; }
  </style>
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
						<li><a href="view_reservations.jsp">View Reservations</a></li>
						<li><a href="#">View Bids</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="get_account_info.jsp">My Account (<%=session.getAttribute("username")%>)
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
		<form class="form-horizontal" action="generate.jsp" method="post">
			<fieldset>
				<legend>Search Flights</legend>

				<!-- SEARCH TYPE -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="flightType"></label>
					<div class="col-md-4">
						<label class="radio-inline" for="type-0"> 
							<input type="radio" name="flightType" id="type-0" value="oneway" onclick="dtable()" checked> One way
						</label> 
						<label class="radio-inline" for="type-1"> 
							<input type="radio" name="flightType" id="type-1" value="roundtrip" onclick="dtable()"> Round-trip
						</label> 
						<label class="radio-inline" for="type-2"> 
							<input type="radio" name="flightType" id="type-2" value="multdest" onclick="dtable()"> Multiple destinations
						</label>
					</div>
				</div>



			<div class="well">				
				<!-- DEPATURE AIRPORT -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="depAirportId">Flying from</label>
					<div class="col-md-6">
						<select id="depAirportId" name="depAirportId" class="form-control" required>
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
					<label class="col-md-4 control-label" for="arrAirportId">Flying to</label>
					<div class="col-md-6">
						<select id="arrAirportId" name="arrAirportId" class="form-control" required>
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
						<input id="depDate" name="depDate" type="date" class="form-control input-md" min="<%=((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime()))%>" required>
					</div>
				</div>
				
				<!-- RETURNING -->
				<div id="returning_div" class="form-group" style="display:none">
					<label class="col-md-4 control-label" for="retDate">Returning</label>
					<div class="col-md-3">
						<input id="retDate" name="retDate" type="date" class="form-control input-md" min="<%=((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime()))%>">
					</div>
				</div>
				
				<!-- CLASS -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="class">Class</label>
					<div class="col-md-2">
						<select id="class" name="class" class="form-control">
							<option value="economy">Economy</option>
							<option value="business">Business</option>
							<option value="first">First</option>
						</select>
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