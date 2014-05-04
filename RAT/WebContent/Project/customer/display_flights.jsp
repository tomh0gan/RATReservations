<%@ page import="java.sql.*, java.util.Properties, java.util.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>RAT - Display Flights</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
	<style>
		button{
			width: 200px;
		}
	</style>
	<script>
		function changeFormAction(changeUrl){
			document.flightForm.action = changeUrl;
			return true;
		}
	</script>
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
	String airline = "";
	String flightNum = "";
	if(request.getAttribute("flightType").equals("ONEWAY")){
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
				LinkedList<FlightVertex> path = (LinkedList<FlightVertex>) request.getAttribute("path");
				int index = 0;
				String startAirport = request.getParameter("flyingfrom");
				while(index < path.size()){
					if(airline.equals("")) airline = path.get(index).getFlightInfo().getAirlineId();
					if(flightNum.equals("")) flightNum = path.get(index).getFlightInfo().getFlightNum();
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
<%
	}
	else if(request.getAttribute("flightType").equals("ROUNDTRIP")){
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
					if(airline.equals("")) airline = path.get(index).getFlightInfo().getAirlineId();
					if(flightNum.equals("")) flightNum = path.get(index).getFlightInfo().getFlightNum();
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
		<%
	}
%>
		<div>
		<form action="../customer/checkout.jsp" class="form-horizontal" method="post" name=flightForm>
			<input type="hidden" name=flyingfrom value="${flyingfrom}" />
			<input type="hidden" name=flyingto value="${flyingto}" />
			<input type="hidden" name=flightType value="${flightType}" />
			<input type="hidden" name=departing value="${departing}" />
			<input type="hidden" name=returning value="${returning}" />
			<input type="hidden" name=numOfPassengers value="${numOfPassengers}" />
			<input type="hidden" name=airlineId value="<%=airline %>" />
			<input type="hidden" name=flightNum value="<%=flightNum %>" />
			<div class="form-group">
				<label class="col-md-4 control-label" for="custClass">Choose class: </label>
				<div class="col-md-5">
					<select id="custClass" name="custClass" class="form-control" required>
					<% 
					String mysJDBCDriver = "com.mysql.jdbc.Driver";
					String mysURL = "jdbc:mysql://localhost:3306/rat_schema";
					String mysUserID = "tester";
					String mysPassword = "test";
					
					Connection conn = null;
					try{
						Class.forName(mysJDBCDriver).newInstance();
						Properties sysprops = System.getProperties();
						sysprops.put("user",mysUserID);
						sysprops.put("password",mysPassword);
						
						conn = DriverManager.getConnection(mysURL,sysprops);
						
						Statement stmt = conn.createStatement();
						String classes = "SELECT class FROM Fare WHERE airlineId='"+airline+"' AND flightNum="+flightNum+" AND fareType='"+request.getAttribute("flightType")+"';";
						ResultSet rs = stmt.executeQuery(classes);
												
						while(rs.next()){
							%> <option value=<%=rs.getString(1) %> ><%=rs.getString(1) %></option> <% 
						}
						
					} catch(Exception e){
						System.out.println(e);
					}
					finally{
						try{conn.close();} catch(Exception ee){};
					}
					%>
					</select>
				</div>
			</div>
			<label class="col-md-4 control-label" for="buy"></label>
			<div class="col-md-8">
				<button type=submit id="buy" name="buy" class="btn btn-primary btn-lg" onClick="return changeFormAction('../customer/checkout.jsp');"><span class="glyphicon glyphicon-hand-up"></span> Go to checkout</button>
				<button type=submit  id="bid" name="bid" class="btn btn-warning btn-lg" onClick="return changeFormAction('../customer/place_bid.jsp');"><span class="glyphicon glyphicon-tag"></span> Bid </button>
			</div>
		  </form>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>