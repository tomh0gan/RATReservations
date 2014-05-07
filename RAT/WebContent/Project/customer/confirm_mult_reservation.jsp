<%@ page import="java.util.*, java.text.DecimalFormat, java.text.SimpleDateFormat, java.sql.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Confirm Reservation</title>
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
					<li class="active"><a href="home.jsp">Find Flights</a></li>
					<li><a href="view_reservations.jsp">View Reservations</a></li>
					<li><a href="view_bids.jsp">View Bids</a></li>
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

	ArrayList<Res> res = (ArrayList<Res>) session.getAttribute("selectedFlight");
	
	ArrayList<Res_Passenger> passengers = res.get(0).getPassengers();
	ArrayList<Res_Leg> resLegs = passengers.get(0).getLegs();
			
	//Enter in the meals
	for(int k = 0; k < res.size(); k++){
		Res current = res.get(k);
		for(int i = 0; i < resLegs.size(); i++){
			for(int j = 0; j < passengers.size(); j++){
				current.getPassengers().get(j).getLegs().get(i).setMeal(request.getParameter("passMeal"+k+""+i+""+j));
			}
		}	
	}
	
	//Enter the names
	for(int j = 0; j < passengers.size(); j++){
		passengers.get(j).setPassName(request.getParameter("passName"+j));
	}
	
	//Booking Fee
	double bookingFee = Double.parseDouble(request.getParameter("bookingFee"));
	
	//Total Fare
	double totalFare = Double.parseDouble(request.getParameter("totalFare"));
	
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
	<form action="create_reservation_mult.jsp" method=post>
	<div class="container">
		<h3>Flight: <%= resLegs.get(0).getL().getDepAirportId() + " " %><span class="glyphicon glyphicon-arrow-right"></span><%= " " +  resLegs.get(resLegs.size()-1).getL().getArrAirportId()%></h3>
		<h3>Departure: <%= resLegs.get(0).getL().getDepDate() + " At " + resLegs.get(0).getL().getDepTime() %></h3>
		
		<br />
		<br />
		<h4>Summary: </h4>
	</div>
	<br />
	<br />
	<div class="container">
			<label class="col-md-4 control-label" for="totalFare">Total Fare: </label>
				<div class="col-md-5">
					<span class="help-block" ><%= "$" + df.format(totalFare) %></span>
					<input type=hidden name=totalFare value=<%= totalFare %> />
				</div>
				<label class="col-md-4 control-label" for="bookingFee">Booking Fee: </label>
				<div class="col-md-5">
					<span class="help-block"><%= "$" + df.format(bookingFee) %></span>
					<input type=hidden name=bookingFee value=<%= bookingFee %> />
				</div>
				<label class="col-md-4 control-label" for="total">Total: </label>
				<div class="col-md-5">
					<span class="help-block"><%= "$" + df.format(bookingFee + totalFare) %></span>
			</div>
	</div>
	<br />
	<br />
	<br />
	<br />
		<div class="container">
			<label class="col-md-4 control-label" for="buy"></label>
			<div class="col-md-8">
				<button type=submit id="buy" name="buy" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-ok"></span> Confirm </button>
				<button type="reset" id="buy" name="buy" class="btn btn-danger btn-lg" onclick="window.open('passengers_info.jsp','_self');"><span class="glyphicon glyphicon-remove"></span> Back </button>
			</div>
		</div>
	</form>
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