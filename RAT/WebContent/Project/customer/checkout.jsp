<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Checkout</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
  <script type="text/javascript">
	function dtable(){
		if(document.getElementById('type-0').checked){
			document.getElementById('returning_div').style.display = "block";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if(document.getElementById('type-1').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "none";
		}
		if(document.getElementById('type-2').checked){
			document.getElementById('returning_div').style.display = "none";
			document.getElementById('multiple_destinations_div').style.display = "block";
		}
	}
	
	function clearError(){
		document.getElementById("flightError").innerHTML = "";
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
            <a class="navbar-brand" href="#">RAT Reservations</a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="home.jsp">Find Flights</a></li>
              <li><a href="view_reservations.jsp">View Reservations</a></li>
              <li><a href="view_bids.jsp">View Bids</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li><a href="account.jsp">My Account (<%=session.getAttribute("username")%>)</a></li>
      		  <li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
            </ul>
          </div>
        </div>
      </div>
     </div>
	<br>
	<br>
	<div class="container">
		<form action="../flights/find_flights.jsp" class="form-horizontal" method="post">
			<fieldset>
				<legend><h1>Checkout</h1></legend>
				
				<%
					for(int i = 1; i <= Integer.parseInt((String)session.getAttribute("numOfPassengers")); i++){
						%>
							<legend><h3>Passenger <%= i %></h3></legend>
							<div class = "well">
								<div class="form-group">
									<label class="col-md-4 control-label" for="passName<%= i %>">Name</label>
									<div class="col-md-5">
										<input class="form-control" name="passName<%= i %>" type="text" />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="passClass<%= i %>">Class</label>
									<div class="col-md-5">
										<select class="form-control" name="passClass<%= i %>" >
											<option>Economy</option>
											<option>First</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="seatNum<%= i %>">Seat Number</label>
									<div class="col-md-5">
										<p class="help-block"><%= i %></p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="passMeal<%= i %>">Meal</label>
									<div class="col-md-5">
										<select class="form-control" name="passMeal<%= i %>" type="text" >
											<option>Cheese</option>
											<option>Extra Cheese</option>
											<option>Grilled Cheese</option>
											<option>Special Cheese</option>
											<option>Premium Cheese</option>
											<option>Sargento Cheese</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="passFare<%= i %>">Price</label>
									<div class="col-md-5">
										<span class="help-block" name="passFare<%= i %>" >FARE HERE</span>
									</div>
								</div>
							</div>
						<% 
					}
				%>
				<legend><h3>Total</h3></legend>
				<div class = "well">
					<div class="form-group">
						<label class="col-md-4 control-label" for="total">Total: </label>
						<div class="col-md-5">
							<span class="help-block" name="total">TOTAL HERE</span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="buy"></label>
					<div class="col-md-8">
						<button type=submit id="buy" name="buy" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-ok"></span> Buy </button>
						<button type=submit id="buy" name="buy" class="btn btn-danger btn-lg"><span class="glyphicon glyphicon-remove"></span> Cancel </button>
					</div>
				</div>
			</fieldset>
		</form>
	</div>

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>