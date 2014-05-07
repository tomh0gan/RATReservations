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
					<li class="active"><a href="RecordReservation.jsp">Find Flights</a></li>

				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="Employee.jsp">Home</a></li>
					<li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- END NAV --><br><br>
<!-- START PAGE -->
<%

	ArrayList<Res> results = (ArrayList<Res>)session.getAttribute("results");
	Res selected = results.get(Integer.parseInt(request.getParameter("index")));
	
	ArrayList<Res_Passenger> passengers = selected.getPassengers();
	
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
		<form action="EmployeeConfirmReservation.jsp" class="form-horizontal" method="post">
			<fieldset>
				<legend>Checkout</legend>
				<%
				int seatCount = 1;
				for(int i = 1; i <= passengers.size(); i++){
					ArrayList<Res_Leg> legs = passengers.get(0).getLegs();
				%>
				<legend>Passenger <%= i %></legend>
					<div class = "well">
						<div class="form-group">
							<label class="col-md-4 control-label" for="passName<%= i %>">Passenger Name: </label>
							<div class="col-md-5">
								<input class="form-control" name="passName<%= i %>" type="text" required />
							</div>
						</div>
						<br />

						<%
						for(int j = 0; j < legs.size(); j++){
							legs.get(j).getL().getDepDate();
						%>
						<h3>Leg <%= j+1 + " " + legs.get(j).getL().getDepAirportId() + " -> " + legs.get(j).getL().getArrAirportId() + " - Departs " + legs.get(j).getL().getDepDate() + " At " +  legs.get(j).getL().getDepTime() %></h3>					
						<br />
						<div class="form-group">
							<label class="col-md-4 control-label" for="passSeatNum<%= i %><%= j %>">Seat Number: </label>
							<div class="col-md-5">
								<select class="form-control" name="passSeatNum<%= i %><%= j %>" required>
								<%
								int numberOfClasses = 0;
								Statement numOfClassesStmt = conn.createStatement();
								String numOfClassesQuery = "SELECT type FROM fare_classtype WHERE airlineId='"+legs.get(j).getL().getAirlineId()+"';";
								ResultSet numOfClassesRs = numOfClassesStmt.executeQuery(numOfClassesQuery);
								while(numOfClassesRs.next()){
									numberOfClasses++;
								}
								int numOfSeats = 0;
								Statement numOfSeatsStmt = conn.createStatement();
								String numOfSeatsQuery = "SELECT numOfSeats FROM Flight WHERE airlineId='"+legs.get(j).getL().getAirlineId()+"' AND flightNum="+legs.get(j).getL().getFlightNum()+";";
								ResultSet numOfSeatsRs = numOfSeatsStmt.executeQuery(numOfSeatsQuery);
								if(numOfSeatsRs.next()){
									numOfSeats = Integer.parseInt(numOfSeatsRs.getString(1));
								}
								ArrayList<Integer> seatNumbers = new ArrayList<Integer>();
								Statement seatNumStmt = conn.createStatement();
								String seatNumQuery = "SELECT seatNum FROM reservation_legs WHERE airlineId='"+legs.get(j).getL().getAirlineId()+"' AND class='"+legs.get(j).getLClass()+"' AND flightNum="+legs.get(j).getL().getFlightNum()+" AND legNum="+legs.get(j).getL().getLegNum()+" AND depDate='"+legs.get(j).getL().getDepDate()+"';";
								ResultSet seatNumRs = seatNumStmt.executeQuery(seatNumQuery);
								while(seatNumRs.next()){
									System.out.println(seatNumRs.getString(1));
									seatNumbers.add(Integer.parseInt(seatNumRs.getString(1)));
								}
								for(int k = 1; k <= (numOfSeats/numberOfClasses); k++){
									if(!seatNumbers.contains(k)){
										if(seatCount == i){
											%><option selected value="<%= k %>"><%= legs.get(j).getLClass() + " - " + k %></option> <%	
										}
										else{
											%><option value="<%= k %>"><%= legs.get(j).getLClass() + " - " + k %></option> <%	
										}
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
									<option>Steak</option>
									<option>Salad</option>
									<option>Cheeseburger</option>
									<option>Pasta</option>
									<option>Fish</option>
								</select>
							</div>
						</div>
						<%
						}
						%>
						<div class="form-group">
							<label class="col-md-4 control-label" for="passFare<%= i %>">Price: </label>
							<div class="col-md-5">
								<span class="help-block" id="passFare<%= i %>" ><%= "TO DO: PRICE FOR EACH LEG" %></span>
								<input type=hidden name="passFare<%= i %>" value="<%= "TO DO: PRICE FOR EACH LEG" %>"  />
							</div>	
						</div>
					</div>
					<%
					seatCount++;
					}
					%>
				<legend>Total</legend>
				<div class = "well">
					<div class="form-group">
						<%
						DecimalFormat df = new DecimalFormat("#.00");
						double bookingFee = selected.getCost() * 0.1;
						%>
						<label class="col-md-4 control-label" for="totalFare">Total Fare: </label>
						<div class="col-md-5">
							<span class="help-block" name="totalFare"><%= "$" + df.format(selected.getCost()) %></span>
						</div>
						<label class="col-md-4 control-label" for="bookingFee">Booking Fee: </label>
						<div class="col-md-5">
							<span class="help-block" name="bookingFee"><%= "$" + df.format(bookingFee) %></span>
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