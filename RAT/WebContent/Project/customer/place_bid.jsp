<%@ page import="java.sql.*, java.util.*, java.text.*" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<title>RAT - Bids</title>
</head>
<body>
	<%
		String flightType = "";
		if(request.getParameter("flightType") == null) return;
		if(request.getParameter("flightType").equals("ONEWAY")) flightType = "Oneway";
		if(request.getParameter("flightType").equals("ROUNDTRIP")) flightType = "Round trip";
		if(request.getParameter("flightType").equals("MULTDEST")) flightType = "Oneway";
		
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
              <li><a href="home.jsp">Find Flights</a></li>
              <li><a href="view_reservations.jsp">View Reservations</a></li>
              <li class="active"><a href="view_bids.jsp">View Bids</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li><a href="account.jsp">My Account (<%=session.getAttribute("username")%>)</a></li>
      		  <li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
            </ul>
          </div>
        </div>
      </div>
     </div>
     
     <div class="container">
	     <form action="../flights/find_flights.jsp" class="form-horizontal" method="post">
	     	<fieldset>
	     		<legend><%= flightType %> flight from <%= request.getParameter("flyingfrom") +" to "+ request.getParameter("flyingto") %></legend>
	     		<div class = "well">
			     	<div class="form-group">
					<label class="col-md-4 control-label" for="departing">Enter your bid here: </label>
						<div class="col-md-4">
							<input type="text" style="width:100px;" name="departing" class="form-control" required />
						</div>
					</div>
				</div>
			</fieldset>
			<label class="col-md-4 control-label" for="placeBid"></label>
			<div class="col-md-8">
				<button type=submit id="placeBid" name="placeBid" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-hand-up"></span> Place Bid </button>
			</div>
	     </form>
     </div>
     
     
</body>
</html>