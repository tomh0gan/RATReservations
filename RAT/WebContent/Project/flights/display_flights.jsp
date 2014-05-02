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
			width: 200px;
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
              <li><a href="../customer/home.jsp">Find Flights</a></li>
              <li><a href="../customer/view_reservations.jsp">View Reservations</a></li>
              <li><a href="../customer/view_bids.jsp">View Bids</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li><a href="../customer/account.jsp">My Account (<%=session.getAttribute("username")%>)</a></li>
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
		<legend>Flight From <%= request.getParameter("flyingfrom") %> to <%= request.getParameter("flyingto") %></legend>
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
				//For Fare
				ArrayList<String> flightNumbersForFare = new ArrayList();
				ArrayList<String> airlineIdForFare = new ArrayList();

				LinkedList<FlightVertex> path = (LinkedList<FlightVertex>) request.getAttribute("path");
				int index = 0;
				String startAirport = request.getParameter("flyingfrom");
				while(index < path.size()){
					if(!flightNumbersForFare.contains(path.get(index).getFlightInfo().getFlightNum())){
						flightNumbersForFare.add(path.get(index).getFlightInfo().getFlightNum());
						airlineIdForFare.add(path.get(index).getFlightInfo().getAirlineId());
					}
%>
						
						<tr>
							<td><%= path.get(index).getFlightInfo().getFlightNum() %></td>
							<td><%= path.get(index).getFlightInfo().getAirlineId() %></td>
							<td><%= path.get(index).getFlightInfo().getLegNumber() %></td>
							<td><%= path.get(index).getFlightInfo().getDepartDate() +" At "+ startAirport %></td>
							<td><%= path.get(index).getFlightInfo().getArrivalDate() +" At "+ path.get(index).getAirport().getAirportName() %></td>
						</tr>
<%
					startAirport = path.get(index).getAirport().getAirportName();
					index++;
				}	
%>
				</tbody>
			</table>
		</div>
		<div>
		<label class="col-md-4 control-label" for="buy"></label>
		<div class="col-md-8">
			<button id="buy" name="buy" class="btn btn-primary btn-lg" onclick="window.open('../customer/checkout.jsp', '_self')"><span class="glyphicon glyphicon-hand-up"></span> Go to checkout</button>
			<button id="bid" name="bid" class="btn btn-warning btn-lg"><span class="glyphicon glyphicon-tag"></span> Bid</button>
		</div>
	</div>
	</div>
<%
	}
	else if(request.getAttribute("flightType").equals("roundtrip")){
%>
	<div class="container">
		<legend>Depart: Flight From <%= request.getParameter("flyingfrom") %> to <%= request.getParameter("flyingto") %></legend>
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
				LinkedList<FlightVertex> path = (LinkedList<FlightVertex>) request.getAttribute("toPath");
				int index = 0;
				String startAirport = request.getParameter("flyingfrom");
				while(index < path.size()){
%>
						<tr>
							<td><%= path.get(index).getFlightInfo().getFlightNum() %></td>
							<td><%= path.get(index).getFlightInfo().getAirlineId() %></td>
							<td><%= path.get(index).getFlightInfo().getLegNumber() %></td>
							<td><%= path.get(index).getFlightInfo().getDepartDate() +" At "+ startAirport %></td>
							<td><%= path.get(index).getFlightInfo().getArrivalDate() +" At "+ path.get(index).getAirport().getAirportName() %></td>
						</tr>
<%
					startAirport = path.get(index).getAirport().getAirportName();
					index++;
				}	
%>
				</tbody>
			</table>
		</div>
		<div>
	</div>
	<div class="container">
		<legend>Return: Flight From <%= request.getParameter("flyingto") %> to <%= request.getParameter("flyingfrom") %></legend>
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
				LinkedList<FlightVertex> pathFrom = (LinkedList<FlightVertex>) request.getAttribute("pathFrom");
				int indexFrom = 0;
				String fromAirport = request.getParameter("flyingto");
				while(indexFrom < pathFrom.size()){
%>
						<tr>
							<td><%= pathFrom.get(indexFrom).getFlightInfo().getFlightNum() %></td>
							<td><%= pathFrom.get(indexFrom).getFlightInfo().getAirlineId() %></td>
							<td><%= pathFrom.get(indexFrom).getFlightInfo().getLegNumber() %></td>
							<td><%= pathFrom.get(indexFrom).getFlightInfo().getDepartDate() +" At "+ fromAirport %></td>
							<td><%= pathFrom.get(indexFrom).getFlightInfo().getArrivalDate() +" At "+ pathFrom.get(indexFrom).getAirport().getAirportName() %></td>
						</tr>
<%
					fromAirport = pathFrom.get(indexFrom).getAirport().getAirportName();
					indexFrom++;
				}	
%>
				</tbody>
			</table>
		</div>
		<div>
		<label class="col-md-4 control-label" for="buy"></label>
			<div class="col-md-8">
				<button id="buy" name="buy" class="btn btn-primary btn-lg" onclick="window.open('../customer/checkout.jsp', '_self')"><span class="glyphicon glyphicon-hand-up"></span> Go to checkout</button>
				<button id="bid" name="bid" class="btn btn-warning btn-lg"><span class="glyphicon glyphicon-tag"></span> Bid </button>
			</div>
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