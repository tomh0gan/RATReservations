<%@ page import="Flights.*, java.util.ArrayList, java.text.DecimalFormat"%>
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
						<li class="active"><a href="home.jsp">Find Flights</a></li>
						<li><a href="view_reservations.jsp">View Reservations</a></li>
						<li><a href="#">View Bids</a></li>
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
	<form action="passengers_mult_info.jsp?type=roundtrip" method=post>
<%
	DecimalFormat df = new DecimalFormat("#.00");
	ArrayList<Res>dep_results = (ArrayList<Res>)session.getAttribute("dep_results");
	ArrayList<Res>ret_results = (ArrayList<Res>)session.getAttribute("ret_results");
%>
<div class="container">
	<h1><%=dep_results.get(0).getPassengers().get(0).getLegs().get(0).getL().getDepAirportId() %>
	to <%=dep_results.get(0).getPassengers().get(0).getLegs().get(dep_results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrAirportId() %></h1>
	<h3>For <%=dep_results.get(0).getPassengers().size() %>
	<%= Character.toString(dep_results.get(0).getPassengers().get(0).getLegs().get(0).getLClass().charAt(0)).toUpperCase()+dep_results.get(0).getPassengers().get(0).getLegs().get(0).getLClass().substring(1) %> Class 
	Passenger(s)</h3>
	
	<table class="table table-hover">
		<thead>
			<tr>
			<th>Departure</th>
			<th> </th>
			<th>Arrival</th>
			<th>Stops</th>
			<th>Price</th>
			<th>Select</th>
			</tr>
		</thead>
		<tbody>
<%
			int dep_index = 0;
			for(Res r :dep_results) {
%>
			<tr>
				<td>
				<%=dep_results.get(dep_index).getPassengers().get(0).getLegs().get(0).getL().getDepDate() %>
				<%=dep_results.get(dep_index).getPassengers().get(0).getLegs().get(0).getL().getDepTime()  %>
				</td>
				<td><span class="glyphicon glyphicon-arrow-right"></span> </td>
				<td>
				<%=dep_results.get(dep_index).getPassengers().get(0).getLegs().get(dep_results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrDate() %>
				<%=dep_results.get(dep_index).getPassengers().get(0).getLegs().get(dep_results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrTime()  %>
				</td>
				<td><%=dep_results.get(dep_index).getPassengers().get(0).getLegs().size()-1 %></td>
				<td><%= "$" + df.format(dep_results.get(dep_index).getCost()) %></td>
				<td><%
					if(dep_index==0){
						%><input type="radio" name=depIndex value="<%= dep_index %>" checked /><%
					}
					else{
						%><input type="radio" name=depIndex value="<%= dep_index %>" /><%
					}
				%></td>
			</tr>
<%
				dep_index++;
			}
%>
		</tbody>
	</table>
</div>
<div class="container">
	<h1><%=ret_results.get(0).getPassengers().get(0).getLegs().get(0).getL().getDepAirportId() %>
	to <%=ret_results.get(0).getPassengers().get(0).getLegs().get(ret_results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrAirportId() %></h1>
	<h3>For <%=ret_results.get(0).getPassengers().size() %>
	<%= Character.toString(ret_results.get(0).getPassengers().get(0).getLegs().get(0).getLClass().charAt(0)).toUpperCase()+ret_results.get(0).getPassengers().get(0).getLegs().get(0).getLClass().substring(1) %> Class 
	Passenger(s)</h3>
	
	<table class="table table-hover">
		<thead>
			<tr>
			<th>Departure</th>
			<th> </th>
			<th>Arrival</th>
			<th>Stops</th>
			<th>Price</th>
			<th>Select</th>
			</tr>
		</thead>
		<tbody>
<%
			int ret_index = 0;
			for(Res r :ret_results) {
%>
			<tr>
				<td>
				<%=ret_results.get(ret_index).getPassengers().get(0).getLegs().get(0).getL().getDepDate() %>
				<%=ret_results.get(ret_index).getPassengers().get(0).getLegs().get(0).getL().getDepTime()  %>
				</td>
				<td><span class="glyphicon glyphicon-arrow-right"></span> </td>
				<td>
				<%=ret_results.get(ret_index).getPassengers().get(0).getLegs().get(ret_results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrDate() %>
				<%=ret_results.get(ret_index).getPassengers().get(0).getLegs().get(ret_results.get(0).getPassengers().get(0).getLegs().size()-1).getL().getArrTime()  %>
				</td>
				<td><%=ret_results.get(ret_index).getPassengers().get(0).getLegs().size()-1 %></td>
				<td><%= "$" + df.format(ret_results.get(ret_index).getCost()) %></td>
				<td><%
					if(ret_index==0){
						%><input type="radio" name=retIndex value="<%= ret_index %>" checked /><%
					}
					else{
						%><input type="radio" name=retIndex value="<%= ret_index %>" /><%
					}
				%></td>
			</tr>
<%
				ret_index++;
			}
%>
		</tbody>
	</table>
</div>
<div class="container">
	<br><br><br><br>
	<p class="text-right"><button type=submit class="btn btn-sm btn-success"><span class="glyphicon glyphicon-check"></span> Select</button></p>
</div>
</form>
	<!-- END PAGE -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>