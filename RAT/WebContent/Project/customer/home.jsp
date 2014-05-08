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
			document.getElementById('flight1_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "none";
			document.getElementById('departing_div').style.display = "block";
			document.getElementById('flex_div').style.display = "none";
		}
		if(document.getElementById('type-1').checked){
			document.getElementById('returning_div').style.display = "block";
			document.getElementById('flight1_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "none";
			document.getElementById('departing_div').style.display = "block";
			document.getElementById('flex_div').style.display = "none";
		}
		if(document.getElementById('type-2').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('flight1_div').style.display = "block";
			document.getElementById('multiple_destinations_div').style.display = "block";
			document.getElementById('departing_div').style.display = "block";
			document.getElementById('flex_div').style.display = "none";
		}
		if(document.getElementById('type-3').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('flight1_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "none";
			document.getElementById('departing_div').style.display = "none";
			document.getElementById('flex_div').style.display = "block";
		}
	}
	
	function selectCheckBox(flightType){
		if(flightType == 'oneway'){
			document.getElementById('type-0').checked = true;
		}
		else if(flightType == 'roundtrip'){
			document.getElementById('type-1').checked = true;
		}
		else if(flightType == 'multdest'){
			document.getElementById('type-2').checked = true;
		}
		else if(flightType == 'flex'){
			document.getElementById('type-3').checked = true;
		}
		else{
			document.getElementById('type-0').checked = true;
		}
		dtable();
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
<body onload="selectCheckBox('${ReturnedFlightType}');">
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
					<a class="navbar-brand" href="#">RAT Reservations<img width="30" height="30" class="img" src="../images/rat-md.png"></a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li class="active"><a href="#">Find Flights</a></li>
						<li><a href="view_reservations.jsp">View Reservations</a></li>
						<li><a href="view_bids.jsp">View Bids</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="help.jsp">Help</a></li>
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
					<div class="col-md-6">
						<label class="radio-inline" for="type-0"> 
							<input type="radio" name="flightType" id="type-0" value="oneway" onclick="dtable()" checked> One-Way
						</label> 
						<label class="radio-inline" for="type-1"> 
							<input type="radio" name="flightType" id="type-1" value="roundtrip" onclick="dtable()"> Round-Trip
						</label> 
						<label class="radio-inline" for="type-2"> 
							<input type="radio" name="flightType" id="type-2" value="multdest" onclick="dtable()"> Multi-City
						</label>
						<label class="radio-inline" for="type-3"> 
							<input type="radio" name="flightType" id="type-3" value="flex" onclick="dtable()"> Flexible Date
						</label>
					</div>
				</div>

			<div class="well">	
			<p class=redText id=searchErrs>${SearchError}</p>
			<div id="flight1_div" style="display:none">
			<legend><h4><b>Flight 1</b></h4></legend>
			</div>			
			
				<!-- DEPATURE AIRPORT -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="depAirportId">Flying from</label>
					<div class="col-md-6">
						<select id="depAirportId" name="depAirportId" class="form-control" required>
							<option value="" style="display:none">Choose Airport</option>
							<option value="BTL">Berlin Tegel (Berlin, Germany)</option>
							<option value="COI">Chicago O'Hare International (Chicago, USA)</option>
							<option value="HJA">Hartsfield-Jackson Atlanta Int (Atlanta, USA)</option>
							<option value="IIL">Ivato International (Antananarivo, Madagascar)</option>
							<option value="JFK">John F. Kennedy International (New York, USA)</option>
							<option value="LAI">Los Angeles International (Los Angeles, USA)</option>
							<option value="LGA">LaGuardia (New York, USA)</option>
							<option value="LNH">London Heathrow (London, United Kingdom)</option>
							<option value="LNI">Logan International (Boston, USA)</option>
							<option value="SFI">San Francisco International (San Francisco, USA)</option>
							<option value="TYI">Tokyo International (Tokyo, Japan)</option>
						</select>
					</div>
				</div>

				<!-- ARRIVAL AIRPORT -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="arrAirportId">Flying to</label>
					<div class="col-md-6">
						<select id="arrAirportId" name="arrAirportId" class="form-control" required>
							<option value="" style="display:none">Choose Airport</option>
							<option value="BTL">Berlin Tegel (Berlin, Germany)</option>
							<option value="COI">Chicago O'Hare International (Chicago, USA)</option>
							<option value="HJA">Hartsfield-Jackson Atlanta Int (Atlanta, USA)</option>
							<option value="IIL">Ivato International (Antananarivo, Madagascar)</option>
							<option value="JFK">John F. Kennedy International (New York, USA)</option>
							<option value="LAI">Los Angeles International (Los Angeles, USA)</option>
							<option value="LGA">LaGuardia (New York, USA)</option>
							<option value="LNH">London Heathrow (London, United Kingdom)</option>
							<option value="LNI">Logan International (Boston, USA)</option>
							<option value="SFI">San Francisco International (San Francisco, USA)</option>
							<option value="TYI">Tokyo International (Tokyo, Japan)</option>
						</select>
					</div>
				</div>

				<!-- DEPARTING -->
				<div id="departing_div" class="form-group">
					<label class="col-md-4 control-label" for="depDate">Departing</label>
					<div class="col-md-3">
						<input id="depDate" name="depDate" type="date" class="form-control input-md" min="<%=((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime()))%>">
					</div>
				</div>
				
				<!-- FLEX START -->
				<div id="flex_div" style="display:none">
				<div class="form-group">
					<label class="col-md-4 control-label" for="flexDateStart">Between</label>
					<div class="col-md-3">
						<input id="flexDateStart" name="flexDateStart" type="date" class="form-control input-md" min="<%=((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime()))%>">
					</div>
				</div>
				
				<!-- FLEX END -->
				<div class="form-group" >
					<label class="col-md-4 control-label" for="flexDateEnd">and</label>
					<div class="col-md-3">
						<input id="flexDateEnd" name="flexDateEnd" type="date" class="form-control input-md" min="<%=((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime()))%>">
					</div>
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
			</div>
				<!-- MULTI -->
				<div id="multiple_destinations_div" style="display:none">
<% 
				for(int i = 1; i < 4; i++) { 
%>					
				<div class="well">
					<legend><h4><b>Flight <%= i+1 %></b></h4></legend>
					
					<!-- MULT DEPATURE AIRPORT -->
					<div class="form-group">
					<label class="col-md-4 control-label" for="depAirportId">Flying from</label>
					<div class="col-md-5">
							<select id="depAirportId<%= i %>" name="depAirportId<%= i %>" class="form-control">
							<option value="" style="display:none">Choose Airport</option>
							<option value="BTL">Berlin Tegel (Berlin, Germany)</option>
							<option value="COI">Chicago O'Hare International (Chicago, USA)</option>
							<option value="HJA">Hartsfield-Jackson Atlanta Int (Atlanta, USA)</option>
							<option value="IIL">Ivato International (Antananarivo, Madagascar)</option>
							<option value="JFK">John F. Kennedy International (New York, USA)</option>
							<option value="LAI">Los Angeles International (Los Angeles, USA)</option>
							<option value="LGA">LaGuardia (New York, USA)</option>
							<option value="LNH">London Heathrow (London, United Kingdom)</option>
							<option value="LNI">Logan International (Boston, USA)</option>
							<option value="SFI">San Francisco International (San Francisco, USA)</option>
							<option value="TYI">Tokyo International (Tokyo, Japan)</option>
							</select>
						</div>
					</div>
					
					<!-- MULT ARRIVAL AIRPORT -->
					<div class="form-group">
					<label class="col-md-4 control-label" for="arrAirportId">Flying to</label>
						<div class="col-md-5">
							<select id="arrAirportId<%= i %>" name="arrAirportId<%= i %>" class="form-control">
							<option value="" style="display:none">Choose Airport</option>
							<option value="BTL">Berlin Tegel (Berlin, Germany)</option>
							<option value="COI">Chicago O'Hare International (Chicago, USA)</option>
							<option value="HJA">Hartsfield-Jackson Atlanta Int (Atlanta, USA)</option>
							<option value="IIL">Ivato International (Antananarivo, Madagascar)</option>
							<option value="JFK">John F. Kennedy International (New York, USA)</option>
							<option value="LAI">Los Angeles International (Los Angeles, USA)</option>
							<option value="LGA">LaGuardia (New York, USA)</option>
							<option value="LNH">London Heathrow (London, United Kingdom)</option>
							<option value="LNI">Logan International (Boston, USA)</option>
							<option value="SFI">San Francisco International (San Francisco, USA)</option>
							<option value="TYI">Tokyo International (Tokyo, Japan)</option></select>
						</div>
					</div>
					
					<!-- MULT DEPARTING -->
					<div class="form-group">
					<label class="col-md-4 control-label" for="depDate">Departing</label>
					<div class="col-md-3">
						<input id="depDate<%= i %>" name="depDate<%= i %>" type="date" class="form-control input-md" min="<%=((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime()))%>">
					</div>
				</div>
				</div>
<%
				}
%>		
				</div>
				
				<!-- SEARCH BUTTON -->
				<div class="form-group">
					<label class="col-md-4 control-label" for="search"></label>
					<div class="col-md-4">
						<button id="search" name="search" class="btn btn-block btn-warning">Search</button>
						<a href="generate.jsp?flightType=bestSelling" class="btn btn-default btn-block">Best Selling Flights</a>
						<a href="generate.jsp?flightType=suggest" class="btn btn-default btn-block">Personalized Suggestions</a>
					</div>
				</div>
			
			</fieldset>
		</form>
	</div>
	<br><br><br><br><br><br><br>
	<!-- END PAGE -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>