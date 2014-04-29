<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description" content="">
<meta name="author" content="">
<link rel="shortcut icon" href="../../assets/ico/favicon.ico">

<title>RAT Reservations - Customer - My Reservations</title>

<!-- Bootstrap core CSS -->
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">

<!-- Custom styles for this template -->
<link href="../resources/css/table.css" rel="stylesheet">
</head>

<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">My Reservations</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="../logout.jsp">Logout</a></li>
				</ul>
				<form class="navbar-form navbar-right">
					<button type="button" class="form-control" onclick="window.open('home.jsp','_self');">Home</button>
				</form>
			</div>
		</div>
	</div>

	<div class="container-fluid">
		<div class="row">
			<div class="col-sm-3 col-md-2 sidebar">
				<ul class="nav nav-sidebar">
					<li><a href="reservations.jsp">Current Reservations</a></li>
					<li><a href="reservations.jsp?filter=PastRes">Past Reservations</a></li>
					<li><a href="reservations.jsp?filter=CurrBids">Current Bids</a></li>
					<li><a href="reservations.jsp?filter=PastBids">Past Bids</a></li>
					<li><a href="reservations.jsp?filter=Suggestions">Suggestions</a></li>
				</ul>
			</div>
		</div>
	</div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../../dist/js/bootstrap.min.js"></script>
	<script src="../../assets/js/docs.min.js"></script>
</body>
</html>