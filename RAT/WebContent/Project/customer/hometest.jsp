<!DOCTYPE html>
<html>
  <head>
  	<title>Rat Reservations - Customer - Home</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
     <link href="../resources/css/bootstrap.min.css" rel="stylesheet">
  <script type="text/javascript">
	function dtable(){
		if(document.getElementById('tt1').checked){
			document.getElementById("returnCol1").style.display = "block";
			document.getElementById("returnCol2").style.display = "block";
		}
		if(document.getElementById('tt2').checked){
			document.getElementById("returnCol1").style.display = "none";
			document.getElementById("returnCol2").style.display = "none";
		}
		if(document.getElementById('tt3').checked)
			window.alert("3");
	}
  </script>
  </head>
  <body>
	<div class="navbar navbar-inverse navbar-static-top">
		<div class = "container">
			<a href="#" class="navbar-brand">RAT Reservations</a>
		</div>
	</div>
	
	<form name="search_flights">
	<table class="table table-bordered">
		<thead>
			<tr>
				<th><h2>Search Flights</h2></th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
					<table class="table table-bordered">
						<tbody>
							<tr>
								<td>
								<label class="radio">
								<input type="radio" name="tripType" id="tt1" checked onclick="dtable()">
								Roundtrip
								</label>
								</td>
								<td>
								<label class="radio">
								<input type="radio" name="tripType" id="tt2" onclick="dtable()">
								One way
								</label>
								</td>
								<td>
								<label class="radio">
								<input type="radio" name="tripType" id="tt3" onclick="dtable()">
								Multiple destinations
								</label>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>Flying from</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>drop down here</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>Flying to</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>drop down here</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
			<tr>
				<td>
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>Departing</th>
								
								<th id="returnCol1">Returning</th>
								
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>drop down here</td>
								
								<td id="returnCol2">drop down here</td>
								
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
	</form>
	
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="js/bootstrap.min.js"></script>
  </body>
</html>