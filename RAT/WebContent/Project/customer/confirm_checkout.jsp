<%@ page import="java.util.*, java.text.SimpleDateFormat, java.sql.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Confirm</title>
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

	//Store all parameters in the objects where they need to go...
	for(int i = 0; i < passengers.size(); i++){
		//PASSENGER NAME
		passengers.get(i).setName(request.getParameter("passName" + i));
		
		for(int j = 0; j < resrLegs.size(); j++){
			String[] classSeatSplit = request.getParameter("passSeatNum"+i+""+j).split("-");
			//CLASS
			resrLegs.get(j).setType(classSeatSplit[0].trim());
			
			//SEAT NUMBER
			resrLegs.get(j).setSeatNum(classSeatSplit[1].trim());
			
			//MEAL
			//NEEDS TO BE IMPLEMENTED
			//resrLegs.get(j).setMeal(request.getParameter("passMeal"+i+""+j));
		}
	}
%>
	<div class="container">
		<fieldset>
			<div class = "well">
				<div class="form-group">
					<label class="col-md-4 control-label" for="total">Total Fare: </label>
					<div class="col-md-5">
						<span class="help-block" name="total"></span>
					</div>
					<label class="col-md-4 control-label" for="total"></label>
					<div class="col-md-5">
						<span class="help-block" name="total"></span>
					</div>
					<label class="col-md-4 control-label" for="total">Total: </label>
					<div class="col-md-5">
						<span class="help-block" name="total"></span>
					</div>
				</div>
			</div>
			<div class="form-group">
				<label class="col-md-4 control-label" for="buy"></label>
				<div class="col-md-8">
					<button type=submit id="buy" name="buy" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-ok"></span> Confirm Reservation </button>
					<button type="reset" id="buy" name="buy" class="btn btn-danger btn-lg"><span class="glyphicon glyphicon-remove"></span> Cancel </button>
				</div>
			</div>
		</fieldset>
	</div>
<!-- END PAGE -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>