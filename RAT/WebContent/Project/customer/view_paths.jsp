<%@ page import="java.util.GregorianCalendar, java.text.SimpleDateFormat, java.sql.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Find Flights</title>
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
		<div class="navbar navbar-default" style="margin-top: 20px;">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
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
						<li><a href="#">My Account (<%=session.getAttribute("username")%>)
						</a></li>
						<li><div>
								<a class="btn btn-default navbar-btn" href="../logout.jsp">Log
									out</a>
							</div></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- END NAV -->
	<br>
	<br>
	<!-- START PAGE -->

	<!-- END PAGE -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>