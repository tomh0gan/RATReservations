<%@ page import="java.sql.*, java.util.*, java.text.*" %>
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
	<% 
		double totalFare = 0;
		DecimalFormat df = new DecimalFormat("#.##");
	%>
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
			<input type="hidden" name=flyingfrom value=<%= request.getParameter("flyingfrom") %> />
			<input type="hidden" name=flyingto value=<%= request.getParameter("flyingto") %> />
			<input type="hidden" name=flightType value=<%= request.getParameter("flightType") %> />
			<input type="hidden" name=departing value=<%= request.getParameter("departing") %> />
			<input type="hidden" name=returning value=<%= request.getParameter("returning") %> />
			<input type="hidden" name=numOfPassengers value=<%= request.getParameter("numOfPassengers") %> />
			<input type="hidden" name=airlineId value=<%= request.getParameter("airlineId") %> />
			<input type="hidden" name=flightNum value=<%= request.getParameter("flightNum") %> />
			<fieldset>
				<legend><h1>Checkout</h1></legend>
				
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
					
					double fareValue = 0;
					String fare = "";
					Statement stmt = conn.createStatement();
					String fareQuery = "SELECT fare FROM Fare WHERE airlineId='"+request.getParameter("airlineId")+"' AND flightNum="+request.getParameter("flightNum")+" AND fareType='"+request.getParameter("flightType")+"' AND class='"+request.getParameter("custClass")+"';";
					ResultSet rs = stmt.executeQuery(fareQuery);
					if(rs.next()){
						fareValue =  Double.parseDouble(rs.getString(1));
						fare = rs.getString(1);
					}
						
					for(int i = 1; i <= Integer.parseInt((String)request.getParameter("numOfPassengers")); i++){
						totalFare += fareValue;
						%>
							<legend><h3>Passenger <%= i %></h3></legend>
							<div class = "well">
								<div class="form-group">
									<label class="col-md-4 control-label" for="passName<%= i %>">Passenger Name: </label>
									<div class="col-md-5">
										<input class="form-control" name="passName<%= i %>" type="text" required />
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="passClass<%= i %>">Class: </label>
									<div class="col-md-5">
										<span class="help-block" id="passFare<%= i %>" name="passFare<%= i %>" ><%= request.getParameter("custClass") %></span>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="seatNum<%= i %>">Seat Number: </label>
									<div class="col-md-5">
										<p class="help-block"><%= i %></p>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="passMeal<%= i %>">Meal: </label>
									<div class="col-md-5">
										<select class="form-control" name="passMeal<%= i %>" type="text" required >
											<option>Cheese</option>
											<option>Grilled Cheese</option>
											<option>Special Cheese</option>
											<option>Premium Cheese</option>
										</select>
									</div>
								</div>
								<div class="form-group">
									<label class="col-md-4 control-label" for="passFare<%= i %>">Price: </label>
									<div class="col-md-5">
										<span class="help-block" id="passFare<%= i %>" name="passFare<%= i %>" ><%= "$" +  fare %></span>
									</div>
								</div>
							</div>
						<% 
					}
				} catch(Exception e){
					System.out.println(e);
				}
				finally{
					try{conn.close();} catch(Exception ee){};
				}
				double bookingFee = 0.1 * totalFare;
				%>
				<legend><h3>Total</h3></legend>
				<div class = "well">
					<div class="form-group">
						<label class="col-md-4 control-label" for="total">Total Fare: </label>
						<div class="col-md-5">
							<span class="help-block" name="total"><%= "$" + df.format(totalFare) %></span>
						</div>
						<label class="col-md-4 control-label" for="total">Booking Fee: </label>
						<div class="col-md-5">
							<span class="help-block" name="total"><%= "$" + df.format(bookingFee) %></span>
						</div>
						<label class="col-md-4 control-label" for="total">Total: </label>
						<div class="col-md-5">
							<span class="help-block" name="total"><%= "$" + df.format(totalFare + bookingFee) %></span>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="buy"></label>
					<div class="col-md-8">
						<button type=submit id="buy" name="buy" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-ok"></span> Continue </button>
						<button type="reset" id="buy" name="buy" class="btn btn-danger btn-lg" onclick="window.open(home.jsp, '_self')"><span class="glyphicon glyphicon-remove"></span> Cancel </button>
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