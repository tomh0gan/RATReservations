<%@ page import="java.sql.*, java.util.Properties, java.util.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>RAT - View Reservations</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
	<style>
		button{
			width: 100px;
		}
	</style>
</head>
<body>
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
            <a class="navbar-brand" href="#">RAT Reservations - Flights</a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="home.jsp">Find Flights</a></li>
              <li class="active"><a href="view_reservations.jsp">View Reservations</a></li>
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
<%
	if(request.getAttribute("flightType").equals("oneWay")){
%>
	<div class="container">
		<legend>One-Way Flight From <%= request.getParameter("from") %> to <%= request.getParameter("to") %></legend>
		<div class="well">
			<table class="table table-striped">
				<thead>
					<tr>
					<th>Flight Number</th>
					<th>Airline</th>
					<th>Leg Number</th>
					<th>Departs</th>
					<th>Arrives</th>
					</tr>
				</thead>
				<tbody>
<% 
				LinkedList<FlightVertex> path = (LinkedList<FlightVertex>) request.getAttribute("path");
				System.out.println(path.size());
				int index = 0;
				while(index < path.size()){
%>
						<tr>
							<td><%= path.get(index).getFlightInfo().getFlightNum() %></td>
							<td><%= path.get(index).getFlightInfo().getAirlineId() %></td>
							<td><%= path.get(index).getFlightInfo().getLegNumber() %></td>
							<td><%= "DEPARTS" %></td>
							<td><%= "ARRIVES" %></td>
						</tr>
<%
					index++;
				}	
%>
				</tbody>
			</table>
		</div>
		<div>
		<label class="col-md-4 control-label" for="buy"></label>
		<div class="col-md-8">
			<button id="buy" name="buy" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-hand-up"></span> Buy</button>
			<button id="bid" name="bid" class="btn btn-warning btn-lg"><span class="glyphicon glyphicon-tag"></span> Bid</button>
		</div>
	</div>
	</div>
<%
	}
	else if(request.getAttribute("flightType").equals("roundTrip")){
%>
	<div class="container">
		<legend>Reservation History</legend>
		<div class="well">
			<table class="table table-striped">
				<thead>
					<tr>
					<th>Reservation Date</th>
					<th>Total Fare</th>
					</tr>
				</thead>
				<tbody>
<% 
				
%>
					<tr>
					<td></td>
					<td></td>
					</tr>
<%
				
%>
				</tbody>
			</table>
		</div>
	</div>
<%
	}
%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>