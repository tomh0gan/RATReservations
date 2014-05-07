<%@ page import="Flights.*, java.util.ArrayList"%>
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
<%
	ArrayList<Res> results = (ArrayList<Res>)session.getAttribute("results");
%>
<div class="container">
	<h1><%= results.get(0).getPassengers().get(0).getLegs().get(0).getL().getDepAirportId() %>
	to <%= results.get(0).getPassengers().get(0).getLegs().get(results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrAirportId() %></h1>
	<h3>For <%= results.get(0).getPassengers().size() %>
	<%= Character.toString(results.get(0).getPassengers().get(0).getLegs().get(0).getLClass().charAt(0)).toUpperCase()+results.get(0).getPassengers().get(0).getLegs().get(0).getLClass().substring(1) %> Class 
	Passenger(s)</h3>
	
	<table class="table table-hover">
		<thead>
			<tr>
			<th>Departure</th>
			<th> </th>
			<th>Arrival</th>
			<th>Stops</th>
			<th>Price</th>
			<th> </th>
			</tr>
		</thead>
		<tbody>
<%
			int index = 0;
			for(Res r : results) {
%>
			<tr>
				<td>
				<%= results.get(0).getPassengers().get(0).getLegs().get(0).getL().getDepDate() %>
				<%= results.get(0).getPassengers().get(0).getLegs().get(0).getL().getDepTime()  %>
				</td>
				<td><span class="glyphicon glyphicon-arrow-right"></span></td>
				<td>
				<%= results.get(0).getPassengers().get(0).getLegs().get(results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrDate() %>
				<%= results.get(0).getPassengers().get(0).getLegs().get(results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrTime()  %>
				</td>
				<td><%= results.get(0).getPassengers().get(0).getLegs().size()-1 %></td>
				<td><%= results.get(0).getCost() %></td>
				<td><a href="passenger_info.jsp?index=<%=index %>" class="btn btn-sm btn-success"><span class="glyphicon glyphicon-check"></span> Select</a></td>
			</tr>
<%
				index++;
			}
%>
		</tbody>
	</table>
</div>
	<!-- END PAGE -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>