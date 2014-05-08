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
	function updateName(nameId, size, outer, index){
		var val = document.getElementById(nameId).value;
		for(var j = 0; j < outer; j++){
			for(var i = 0; i < size; i++){
				document.getElementById("passName"+j+""+i+""+index).value = val;
			}	
		}
	}
	
	function updateForm(way){
		if(way == "bid"){
			document.infoForm.action='make_bid_mult.jsp';
			return true;
		}
		else{
			document.infoForm.action='confirm_mult_reservation.jsp';
			return true;
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
					<li><a href="help.jsp">Help</a></li>
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
	ArrayList<ArrayList<Res>> multResults;
	ArrayList<Res> depResults;
	ArrayList<Res> retResults;
	
	ArrayList<Res> path = new ArrayList<Res>();

	//MultDest or Roundtrip
	if(request.getParameter("type").equals("multDest")){
		//Extract chosen path
		multResults = (ArrayList<ArrayList<Res>>)session.getAttribute("multResults");
		for(int i = 0; i < multResults.size(); i++){
			ArrayList<Res> temp = multResults.get(i);
			for(int j = 0; j < temp.size(); j++){
				//Determine location
				int index = Integer.parseInt(request.getParameter("index"+i));
				if(index == j){
					path.add(temp.get(j));	
				}
			}
		}
		
	}
	else if(request.getParameter("type").equals("roundtrip")){
		//Extract chosen path
		depResults = (ArrayList<Res>)session.getAttribute("dep_results");
		for(int i = 0; i < depResults.size(); i++){
			int index = Integer.parseInt(request.getParameter("depIndex"));
			if(index == i){
				path.add(depResults.get(index));	
			}
		}
		retResults = (ArrayList<Res>)session.getAttribute("ret_results");
		for(int i = 0; i < depResults.size(); i++){
			int index = Integer.parseInt(request.getParameter("retIndex"));
			if(index == i){
				path.add(retResults.get(index));	
			}
		}
		
		
	}
			
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
		<form name=infoForm action="confirm_mult_reservation.jsp" class="form-horizontal" method="post">
			<fieldset>
				<legend>Checkout</legend>
				<div class="container">
				<fieldset>
				<%
				
				for(int k = 0; k < path.size(); k++){
				Res current = path.get(k);
				ArrayList<Res_Leg> resLegs = current.getPassengers().get(0).getLegs();
				%>
				<legend>Flight <%= k+1 %></legend>
					<%
					for(int i = 0; i < resLegs.size(); i++){
					ArrayList<Res_Passenger> passengers = current.getPassengers();
					%>
					<legend>Leg <%= i+1 + " " + resLegs.get(i).getL().getDepAirportId() + " "%><span class="glyphicon glyphicon-arrow-right"></span><%=" " + resLegs.get(i).getL().getArrAirportId() + " - Departs " + resLegs.get(i).getL().getDepDate() + " At " +  resLegs.get(i).getL().getDepTime() %></legend>
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
									<input class="form-control" id="passName<%= k %><%= i %><%= j %>" name="passName<%= j %>" onkeyup="updateName('passName<%= k %><%= i %><%= j %>', <%= resLegs.size() %>, <%= path.size() %>, <%= j %>)" type="text" required />
								</div>
							</div>
							<br />
							<br />
							<div class="form-group">
								<label class="col-md-4 control-label" for="passSeatNum<%= i %><%= j %>">Seat Number: </label>
								<div class="col-md-5">
									<span class="help-block" id="passSeatNum<%= i %><%= j %>" ><%= ++maxSeat + " - " + resLegs.get(i).getLClass().toUpperCase() %></span>
									<% passengers.get(j).getLegs().get(i).setSeatNum(maxSeat); %>
									<input type=hidden name="passSeatNum<%= k %><%= i %><%= j %>" value="<%= maxSeat%>"  />	
								</div>
							</div>
							<div class="form-group">
								<label class="col-md-4 control-label" for="passMeal<%= i %><%= j %>">Meal: </label>
								<div class="col-md-5">
									<select class="form-control" name="passMeal<%= k %><%= i %><%= j %>" type="text" required >
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
					<%
					} 
					%>
					</fieldset>
					</div>
					
				<legend>Total</legend>
				<div class = "well">
					<div class="form-group">
						<%
						//Determine cost
						double totalFare = 0;
						for(int i = 0; i < path.size(); i++){
							totalFare += path.get(i).getCost();
						}
						double bookingFee = totalFare * 0.1;
						%>
						<label class="col-md-4 control-label" for="totalFare">Total Fare: </label>
						<div class="col-md-5">
							<span class="help-block""><%= "$" + df.format(totalFare) %></span>
							<input type=hidden name=totalFare value=<%= totalFare %> />
						</div>
						<label class="col-md-4 control-label" for="bookingFee">Booking Fee: </label>
						<div class="col-md-5">
							<span class="help-block""><%= "$" + df.format(bookingFee) %></span>
							<input type=hidden name=bookingFee value=<%= bookingFee %> />
						</div>
						<label class="col-md-4 control-label" for="total">Total: </label>
						<div class="col-md-5">
							<span class="help-block"><%= "$" + df.format(bookingFee + totalFare) %></span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="buy"></label>
					<div class="col-md-8">
						<button type=submit id="buy" name="buy" class="btn btn-primary btn-lg" onclick="return updateForm('buy');"><span class="glyphicon glyphicon-ok"></span> Buy </button>&nbsp;&nbsp;
						<button type="submit" id="bid" name="bid" class="btn btn-info btn-lg" onclick="return updateForm('bid');"><span class="glyphicon glyphicon-thumbs-up"></span>Bid</button>&nbsp;&nbsp;
						<button type="reset" id="buy" name="buy" class="btn btn-danger btn-lg" onclick="window.history.back()"> Back </button>
					</div>
				</div>
			</fieldset>
		</form>	
	</div>
	
<%	
	session.setAttribute("selectedFlight", path);
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