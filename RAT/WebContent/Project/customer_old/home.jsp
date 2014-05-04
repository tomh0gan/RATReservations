<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Find Flights</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
  <script type="text/javascript">
	function dtable(){
		if(document.getElementById('type-0').checked){
			document.getElementById('returning_div').style.display = "block";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if(document.getElementById('type-1').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if(document.getElementById('type-2').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "block";
		}
	}
	
	function clearError(){
		document.getElementById("flightError").innerHTML = "";
	}
  </script>
</head>
<body onload="dtable();" >
	 <div class="container">
      <div class="navbar navbar-default" role="navigation" style="margin-top:20px;">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">RAT Reservations</a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="home.jsp">Find Flights</a></li>
              <li><a href="view_reservations.jsp">View Reservations</a></li>
              <li><a href="view_bids.jsp">View Bids</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li><a href="account.jsp">My Account (<%=session.getAttribute("username")%>)</a></li>
      		  <li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
            </ul>
          </div>
        </div>
      </div>
     </div>
	<br>
	<br>
	<div class="container">
		<form action="../flights/find_available_flights.jsp" class="form-horizontal" method="post">
			<fieldset>
				<legend><h1>Find Flights</h1></legend>
				<div class="form-group">
					<label class="col-md-4 control-label" for="type"></label>
					<div class="col-md-4">
						<label class="radio-inline" for="type-0"> 
							<input type="radio" name="flightType" id="type-0" value="ROUNDTRIP" onclick="dtable()" ${flightType=="ROUNDTRIP"?"checked":""} required> Round-trip
						</label> 
						<label class="radio-inline" for="type-1"> 
							<input type="radio" name="flightType" id="type-1" value="ONEWAY" onclick="dtable()" ${flightType=="ONEWAY"?"checked":""} > One way
						</label> 
						<label class="radio-inline" for="type-2"> 
							<input type="radio" name="flightType" id="type-2" value="MULTDEST" onclick="dtable()" ${flightType=="MULTDEST"?"checked":""} > Multiple destinations
						</label>
					</div>
				</div>
				<div class = "well">
				<div class="form-group">
					<label class="col-md-5 control-label" id="flightError" style="color: red;"> ${flightErrorMsg} </label>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="flyingfrom">Flying
						from</label>
					<div class="col-md-5">
						<select id="flyingfrom" name="flyingfrom" class="form-control" onfocus="clearError()" required>
							<option value="">Please choose:</option>
							<option ${flyingfrom0=="Berlin Tegel"?"Selected=selected":""} value="Berlin Tegel">Berlin, Germany (Berlin Tegel)</option>
							<option ${flyingfrom0=="Chicago O'Hare International"?"Selected=selected":""} value="Chicago O'Hare International">Chicago, USA (Chicago O'Hare International)</option>
							<option ${flyingfrom0=="Hartsfield-Jackson Atlanta Int"?"Selected=selected":""} value="Hartsfield-Jackson Atlanta Int">Atlanta, USA (Hartsfield-Jackson Atlanta Int)</option>
							<option ${flyingfrom0=="Ivato International"?"Selected=selected":""} value="Ivato International">Antananarivo, Madagascar (Ivato International)</option>
							<option ${flyingfrom0=="John F. Kennedy International"?"Selected=selected":""} value="John F. Kennedy International">New York, USA (John F. Kennedy International)</option>
							<option ${flyingfrom0=="Los Angeles International"?"Selected=selected":""} value="Los Angeles International">Los Angeles, USA (Los Angeles International)</option>
							<option ${flyingfrom0=="LaGuardia"?"Selected=selected":""} value="LaGuardia">New York, USA (LaGuardia)</option>
							<option ${flyingfrom0=="London Heathrow"?"Selected=selected":""} value="London Heathrow">London, United Kingdom (London Heathrow)</option>
							<option ${flyingfrom0=="Logan International"?"Selected=selected":""} value="Logan International">Boston, USA (Logan International)</option>
							<option ${flyingfrom0=="San Francisco International"?"Selected=selected":""} value="San Francisco International">San Francisco, USA (San Francisco International)</option>
							<option ${flyingfrom0=="Tokyo International"?"Selected=selected":""} value="Tokyo International">Tokyo, Japan (Tokyo International)</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label" for="flyingto">Flying
						to</label>
					<div class="col-md-5">
						<select id="flyingto" name="flyingto" class="form-control" onfocus="clearError()" required>
							<option value="">Please choose:</option>
							<option ${flyingto0=="Berlin Tegel"?"Selected=selected":""} value="Berlin Tegel">Berlin, Germany (Berlin Tegel)</option>
							<option ${flyingto0=="Chicago O'Hare International"?"Selected=selected":""} value="Chicago O'Hare International">Chicago, USA (Chicago O'Hare International)</option>
							<option ${flyingto0=="Hartsfield-Jackson Atlanta Int"?"Selected=selected":""} value="Hartsfield-Jackson Atlanta Int">Atlanta, USA (Hartsfield-Jackson Atlanta Int)</option>
							<option ${flyingto0=="Ivato International"?"Selected=selected":""} value="Ivato International">Antananarivo, Madagascar (Ivato International)</option>
							<option ${flyingto0=="John F. Kennedy International"?"Selected=selected":""} value="John F. Kennedy International">New York, USA (John F. Kennedy International)</option>
							<option ${flyingto0=="Los Angeles International"?"Selected=selected":""} value="Los Angeles International">Los Angeles, USA (Los Angeles International)</option>
							<option ${flyingto0=="LaGuardia"?"Selected=selected":""} value="LaGuardia">New York, USA (LaGuardia)</option>
							<option ${flyingto0=="London Heathrow"?"Selected=selected":""} value="London Heathrow">London, United Kingdom (London Heathrow)</option>
							<option ${flyingto0=="Logan International"?"Selected=selected":""} value="Logan International">Boston, USA (Logan International)</option>
							<option ${flyingto0=="San Francisco International"?"Selected=selected":""} value="San Francisco International">San Francisco, USA (San Francisco International)</option>
							<option ${flyingto0=="Tokyo International"?"Selected=selected":""} value="Tokyo International">Tokyo, Japan (Tokyo International)</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label" for="departing">Departing</label>
					<div class="col-md-4">
						<input type="date" name="departing" class="form-control" value="${departing}" onfocus="clearError()" required />
					</div>
				</div>

				<div id="returning_div" class="form-group">
					<label class="col-md-4 control-label" for="returning">Returning</label>
					<div class="col-md-4">
						<input type="date" name="returning" class="form-control" value="${returning}" onfocus="clearError()" />
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label" for="passengers">Passengers</label>
					<div class="col-md-2">
						<select id="passengers" name="passengers" class="form-control" onfocus="clearError()" required>
							<option ${numOfPassengers=="1"?"Selected=selected":""} value="1" >1</option>
							<option ${numOfPassengers=="2"?"Selected=selected":""} value="2" >2</option>
							<option ${numOfPassengers=="3"?"Selected=selected":""} value="3" >3</option>
							<option ${numOfPassengers=="4"?"Selected=selected":""} value="4" >4</option>
							<option ${numOfPassengers=="5"?"Selected=selected":""} value="5" >5</option>
							<option ${numOfPassengers=="6"?"Selected=selected":""} value="6" >6</option>
						</select>
					</div>
				</div>
				</div>
				
				<div id="multiple_destinations_div" style="display:none">
<% 
				for(int i = 2; i < 5; i++) { 
%>					
				<div class="well">
					<legend><h4><b>Flight <%= i %></b></h4></legend>
					<div class="form-group">
					<label class="col-md-4 control-label" for="flyingfrom">Flying from</label>
					<div class="col-md-5">
							<select id="flyingfrom<%= i %>" name="flyingfrom<%= i %>" class="form-control" onfocus="clearError()">
								<option value="">Please choose:</option>
								<option ${flyingfrom=="Berlin Tegel"?"Selected=selected":""} value="Berlin Tegel">Berlin, Germany (Berlin Tegel)</option>
								<option ${flyingfrom=="Chicago O'Hare International"?"Selected=selected":""} value="Chicago O'Hare International">Chicago, USA (Chicago O'Hare International)</option>
								<option ${flyingfrom=="Hartsfield-Jackson Atlanta Int"?"Selected=selected":""} value="Hartsfield-Jackson Atlanta Int">Atlanta, USA (Hartsfield-Jackson Atlanta Int)</option>
								<option ${flyingfrom=="Ivato International"?"Selected=selected":""} value="Ivato International">Antananarivo, Madagascar (Ivato International)</option>
								<option ${flyingfrom=="John F. Kennedy International"?"Selected=selected":""} value="John F. Kennedy International">New York, USA (John F. Kennedy International)</option>
								<option ${flyingfrom=="Los Angeles International"?"Selected=selected":""} value="Los Angeles International">Los Angeles, USA (Los Angeles International)</option>
								<option ${flyingfrom=="LaGuardia"?"Selected=selected":""} value="LaGuardia">New York, USA (LaGuardia)</option>
								<option ${flyingfrom=="London Heathrow"?"Selected=selected":""} value="London Heathrow">London, United Kingdom (London Heathrow)</option>
								<option ${flyingfrom=="Logan International"?"Selected=selected":""} value="Logan International">Boston, USA (Logan International)</option>
								<option ${flyingfrom=="San Francisco International"?"Selected=selected":""} value="San Francisco International">San Francisco, USA (San Francisco International)</option>
								<option ${flyingfrom=="Tokyo International"?"Selected=selected":""} value="Tokyo International">Tokyo, Japan (Tokyo International)</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
					<label class="col-md-4 control-label" for="flyingto">Flying to</label>
						<div class="col-md-5">
							<select id="flyingto<%= i %>" name="flyingto<%= i %>" class="form-control" onfocus="clearError()">
								<option value="">Please choose:</option>
								<option ${flyingto=="Berlin Tegel"?"Selected=selected":""} value="Berlin Tegel">Berlin, Germany (Berlin Tegel)</option>
								<option ${flyingto=="Chicago O'Hare International"?"Selected=selected":""} value="Chicago O'Hare International">Chicago, USA (Chicago O'Hare International)</option>
								<option ${flyingto=="Hartsfield-Jackson Atlanta Int"?"Selected=selected":""} value="Hartsfield-Jackson Atlanta Int">Atlanta, USA (Hartsfield-Jackson Atlanta Int)</option>
								<option ${flyingto=="Ivato International"?"Selected=selected":""} value="Ivato International">Antananarivo, Madagascar (Ivato International)</option>
								<option ${flyingto=="John F. Kennedy International"?"Selected=selected":""} value="John F. Kennedy International">New York, USA (John F. Kennedy International)</option>
								<option ${flyingto=="Los Angeles International"?"Selected=selected":""} value="Los Angeles International">Los Angeles, USA (Los Angeles International)</option>
								<option ${flyingto=="LaGuardia"?"Selected=selected":""} value="LaGuardia">New York, USA (LaGuardia)</option>
								<option ${flyingto=="London Heathrow"?"Selected=selected":""} value="London Heathrow">London, United Kingdom (London Heathrow)</option>
								<option ${flyingto=="Logan International"?"Selected=selected":""} value="Logan International">Boston, USA (Logan International)</option>
								<option ${flyingto=="San Francisco International"?"Selected=selected":""} value="San Francisco International">San Francisco, USA (San Francisco International)</option>
								<option ${flyingto=="Tokyo International"?"Selected=selected":""} value="Tokyo International">Tokyo, Japan (Tokyo International)</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
					<label class="col-md-4 control-label" for="departing">Departing</label>
						<div class="col-md-4">
							<input type="date" id="departing<%= i %>" name="departing<%= i %>" class="form-control" onfocus="clearError()" />
						</div>
					</div>
				</div>
<%
				}
%>		
				</div>


				<div class="form-group">
					<label class="col-md-4 control-label" for="search"></label>
					<div class="col-md-8">
						<button type=submit id="search" name="search" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-search"></span> Search for Flight</button>
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