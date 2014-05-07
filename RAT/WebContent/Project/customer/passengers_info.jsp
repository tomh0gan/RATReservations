<%@ page import="java.util.*, java.text.DecimalFormat, java.text.SimpleDateFormat, java.sql.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Passenger Info</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<!-- START SCRIPT --> 
<script>
	function updateName(nameId, size, index){
		var val = document.getElementById(nameId).value;
		for(var i = 0; i < size; i++){
			document.getElementById("passName"+i+""+index).value = val;
		}
	}
</script>
<!-- END SCRIPT --> 
</head>
<body>
<!-- START NAV -->
<div class="container">
	<div class="navbar navbar-default" style="margin-top:20px;">
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
					<li><a href="#">View Bids</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="get_account_info.jsp">My Account (<%=session.getAttribute("username")%>)</a></li>
					<li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- END NAV --><br><br>
<!-- START PAGE -->
<%
	DecimalFormat df = new DecimalFormat("#.00");

	ArrayList<Res> results = (ArrayList<Res>)session.getAttribute("results");
	Res selected = results.get(Integer.parseInt(request.getParameter("index")));
	
	ArrayList<Res_Passenger> passengers = selected.getPassengers();
	ArrayList<Res_Leg> resLegs = passengers.get(0).getLegs();
			
	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
	String mysUserID = "tester"; 
	String mysPassword = "test";
	
	Connection conn=null;
	try{	
		Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops=System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
		
		conn = java.sql.DriverManager.getConnection(mysURL,sysprops);
	%>
	<div class="container">
		<form action="confirm_reservation.jsp" class="form-horizontal" method="post">
			<fieldset>
				<legend>Checkout</legend>
				<%
				for(int i = 0; i < resLegs.size(); i++){
				%>
				<legend>Leg <%= i+1 + " " + resLegs.get(i).getL().getDepAirportId() + " -> " + resLegs.get(i).getL().getArrAirportId() + " - Departs " + resLegs.get(i).getL().getDepDate() + " At " +  resLegs.get(i).getL().getDepTime() %></legend>
						<%
						int numberOfClasses = 0;
						Statement numOfClassesStmt = conn.createStatement();
						String numOfClassesQuery = "SELECT type FROM fare_classtype WHERE airlineId='"+resLegs.get(i).getL().getAirlineId()+"';";
						ResultSet numOfClassesRs = numOfClassesStmt.executeQuery(numOfClassesQuery);
						while(numOfClassesRs.next()){
							numberOfClasses++;
						}
						int numOfSeats = 0;
						Statement numOfSeatsStmt = conn.createStatement();
						String numOfSeatsQuery = "SELECT numOfSeats FROM Flight WHERE airlineId='"+resLegs.get(i).getL().getAirlineId()+"' AND flightNum="+resLegs.get(i).getL().getFlightNum()+";";
						ResultSet numOfSeatsRs = numOfSeatsStmt.executeQuery(numOfSeatsQuery);
						if(numOfSeatsRs.next()){
							numOfSeats = Integer.parseInt(numOfSeatsRs.getString(1));
						}
						int maxSeat = 0;
						Statement stmt = conn.createStatement();
						String getMaxSeat = "SELECT max(seatNum) FROM reservation_legs WHERE airlineId='"+resLegs.get(i).getL().getAirlineId()+"' AND flightNum="+resLegs.get(i).getL().getFlightNum()+" AND legNum="+resLegs.get(i).getL().getLegNum()+" AND depDate='"+resLegs.get(i).getL().getDepDate()+"' AND class='"+resLegs.get(i).getLClass()+"';";
						ResultSet maxSeatRs = stmt.executeQuery(getMaxSeat);
						if(maxSeatRs.next()){
							maxSeat = maxSeatRs.getInt(1);
						}
						if((maxSeat)+passengers.size() > (numOfSeats/numberOfClasses)){
							//No seats remain
							response.sendRedirect("home.jsp");
						}
						for(int j = 0; j < passengers.size(); j++){
						%>
						<div class = "well">
						<h5>Passenger <%= j+1 %></h5>					
						<div class="form-group">
							<label class="col-md-4 control-label" for="passName<%= j %>">Passenger Name: </label>
							<div class="col-md-5">
								<input class="form-control" id="passName<%= i %><%= j %>" name="passName<%= j %>" onkeyup="updateName('passName<%= i %><%= j %>', <%= resLegs.size() %>, <%= j %>)" type="text" required />
							</div>
						</div>
						<br />
						<br />
						<div class="form-group">
							<label class="col-md-4 control-label" for="passSeatNum<%= i %><%= j %>">Seat Number: </label>
							<div class="col-md-5">
								<span class="help-block" id="passSeatNum<%= i %><%= j %>" ><%= ++maxSeat + " - " + resLegs.get(i).getLClass().toUpperCase() %></span>
								<% resLegs.get(i).setSeatNum(maxSeat); %>
								<input type=hidden name="passSeatNum<%= i %><%= j %>" value="<%= maxSeat%>"  />	
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="passMeal<%= i %><%= j %>">Meal: </label>
							<div class="col-md-5">
								<select class="form-control" name="passMeal<%= i %><%= j %>" type="text" required >
									<option>Grilled Cheese</option>
									<option>Steak</option>
									<option>Salad</option>
									<option>Cheeseburger</option>
									<option>Pasta</option>
									<option>Fish</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="passFare<%= i %>">Price: </label>
							<div class="col-md-5">
								<span class="help-block" id="passFare<%= i %>" ><%= "$" + df.format(resLegs.get(i).getCost()) %></span>
								<input type=hidden name="passFare<%= i %>" value="<%= "$" + df.format(resLegs.get(i).getCost())  %>"  />
							</div>	
						</div>
						</div>
						<%
						}
						%>
					<%
					}
					%>
				<legend>Total</legend>
				<div class = "well">
					<div class="form-group">
						<%
						double bookingFee = selected.getCost() * 0.1;
						selected.setBookingFee(bookingFee);
						%>
						<label class="col-md-4 control-label" for="totalFare">Total Fare: </label>
						<div class="col-md-5">
							<span class="help-block" name="totalFare"><%= "$" + df.format(selected.getCost()) %></span>
						</div>
						<label class="col-md-4 control-label" for="bookingFee">Booking Fee: </label>
						<div class="col-md-5">
							<span class="help-block" name="bookingFee"><%= "$" + df.format(bookingFee) %></span>
							<input type=hidden name=bookingFee value=<%= bookingFee %> />
						</div>
						<label class="col-md-4 control-label" for="total">Total: </label>
						<div class="col-md-5">
							<span class="help-block" name="total"><%= "$" + df.format(bookingFee + selected.getCost()) %></span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="buy"></label>
					<div class="col-md-8">
						<button type=submit id="buy" name="buy" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-ok"></span> Continue </button>
						<button type="reset" id="buy" name="buy" class="btn btn-danger btn-lg"><span class="glyphicon glyphicon-remove"></span> Cancel </button>
					</div>
				</div>
			</fieldset>
		</form>	
	</div>
	
<%	
	session.setAttribute("selectedFlight", selected);
	} catch(Exception e){
		System.out.println(e);
	} finally {
		try {
			conn.close();
			} catch(Exception ee){ }
	}
%>
<!-- END PAGE -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>