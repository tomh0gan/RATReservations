<%@ page import="java.util.*, java.text.SimpleDateFormat, java.sql.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Passenger Info</title>
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
					<li class="active"><a href="#">Find Flights</a></li>
					<li><a href="#">View Reservations</a></li>
					<li><a href="#">View Bids</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="#">My Account (<%=session.getAttribute("username")%>)</a></li>
					<li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- END NAV --><br><br>
<!-- START PAGE -->
<%

	//How are we going to retrieve the legs, passengers, and resrLegs?
	ArrayList<Leg> legs = (ArrayList<Leg>)session.getAttribute("legs");
	ArrayList<Passenger> passengers = (ArrayList<Passenger>)session.getAttribute("passengers");
	ArrayList<ReservationLeg> resrLegs = (ArrayList<ReservationLeg>)session.getAttribute("resrLegs");
	
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
		<form action="confirm_checkout.jsp" class="form-horizontal" method="post">
			<fieldset>
				<legend>Checkout</legend>
				<%
				for(int i = 1; i < passengers.size(); i++){
				%>
				<legend>Passenger <%= i %></legend>
					<div class = "well">
						<div class="form-group">
							<label class="col-md-4 control-label" for="passName<%= i %>">Passenger Name: </label>
							<div class="col-md-5">
								<input class="form-control" name="passName<%= i %>" type="text" required />
							</div>
						</div>
						<%
						for(int j = 0; j < legs.size(); j++){
							Statement classStmt = conn.createStatement();
							String classQuery = "SELECT type FROM fare_classtype WHERE airlineId='"+legs.get(j).getAirlineId()+"';";
							ResultSet classRs = classStmt.executeQuery(classQuery);
							ArrayList<String> flightClasses = new ArrayList<String>();
							while(classRs.next()){
								flightClasses.add(classRs.getString(1));
							}
						%>
						<h3>Flight<%= i %></h3>
					
						<div class="form-group">
							<%
								int numOfSeats = 0;
								Statement numOfSeatsStmt = conn.createStatement();
								String numOfSeatsQuery = "SELECT numOfSeats FROM Flight WHERE airlineId='"+legs.get(j).getAirlineId()+"' AND flightNum="+legs.get(j).getFlightNum()+";";
								ResultSet numOfSeatsRs = numOfSeatsStmt.executeQuery(numOfSeatsQuery);
								if(numOfSeatsRs.next()){
									numOfSeats = Integer.parseInt(numOfSeatsRs.getString(1));
								}
								ArrayList<String> seatNumbers = new ArrayList<String>();
								Statement seatNumStmt = conn.createStatement();
								String seatNumQuery = "SELECT seatNum FROM reservation_legs WHERE airlineId='"+legs.get(j).getAirlineId()+"' AND flightNum="+legs.get(j).getFlightNum()+" AND legNum="+legs.get(j).getLegNum()+" AND depTime='"+legs.get(j).getDepTime()+"';";
								ResultSet seatNumRs = seatNumStmt.executeQuery(seatNumQuery);
								while(seatNumRs.next()){
									seatNumbers.add(seatNumRs.getString(1));
								}
								
							%>
							<label class="col-md-4 control-label" for="passSeatNum<%= i %><%= j %>">Seat Number: </label>
							<div class="col-md-5">
								<select class="form-control" name="passSeatNum<%= i %><%= j %>" required>
									<%
									for(int m = 0; m < flightClasses.size(); i++){
										for(int k = 1; k <= numOfSeats/2; k++){
											%> <option value="<%= flightClasses.get(m) + " - " + k + flightClasses.get(m).charAt(0) %>"><%= flightClasses.get(m) + " - " + k + flightClasses.get(m).charAt(0) %></option> <%
										}	
									}
									%>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="passMeal<%= i %><%= j %>">Meal: </label>
							<div class="col-md-5">
								<select class="form-control" name="passMeal<%= i %><%= j %>" type="text" required >
									<option>Grilled Cheese</option>
									<option>Asiago Steak</option>
									<option>Salad with Feta Cheese</option>
									<option>Cheeseburger</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="passFare<%= i %>">Ticket Price: </label>
							<div class="col-md-5">
								<span class="help-block" id="passFare<%= i %>" ></span>
								<input type=hidden name="passFare<%= i %>" value=""  />
							</div>	
						</div>
						<%
						}
						%>
					</div>
					<%
					}
					%>
				<legend>Total</legend>
				<div class = "well">
					<div class="form-group">
						<label class="col-md-4 control-label" for="total">Total Fare: </label>
						<div class="col-md-5">
							<span class="help-block" name="total">Total Fare Here</span>
						</div>
						<label class="col-md-4 control-label" for="total">Booking Fee: </label>
						<div class="col-md-5">
							<span class="help-block" name="total">Booking Fee Here</span>
						</div>
						<label class="col-md-4 control-label" for="total">Total: </label>
						<div class="col-md-5">
							<span class="help-block" name="total">Total Here</span>
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