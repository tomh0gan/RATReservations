<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Find Flights</title>
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
		<form class="form-horizontal">
			<fieldset>
				<legend><h1>Find Flights</h1></legend>
				<div class="form-group">
					<label class="col-md-4 control-label" for="type"></label>
					<div class="col-md-4">
						<label class="radio-inline" for="type-0"> <input
							type="radio" name="type" id="type-0" value="1" onclick="dtable()" checked="checked">
							Roundtrip
						</label> <label class="radio-inline" for="type-1"> <input
							type="radio" name="type" id="type-1" value="2" onclick="dtable()"> One way
						</label> <label class="radio-inline" for="type-2"> <input
							type="radio" name="type" id="type-2" value="3" onclick="dtable()"> Multiple
							destinations
						</label>
					</div>
				</div>

				<div class = "well">
				<div class="form-group">
					<label class="col-md-4 control-label" for="flyingfrom">Flying
						from</label>
					<div class="col-md-5">
						<select id="flyingfrom" name="flyingfrom" class="form-control">
							<option value="1">Option one</option>
							<option value="2">Option two</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label" for="flyingto">Flying
						to</label>
					<div class="col-md-5">
						<select id="flyingto" name="flyingto" class="form-control">
							<option value="1">Option one</option>
							<option value="2">Option two</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label" for="departing">Departing</label>
					<div class="col-md-4">
						<select id="departing" name="departing" class="form-control">
							<option value="1">Option one</option>
							<option value="2">Option two</option>
						</select>
					</div>
				</div>

				<div id="returning_div" class="form-group">
					<label class="col-md-4 control-label" for="returning">Returning</label>
					<div class="col-md-4">
						<select id="returning" name="returning" class="form-control">
							<option value="1">Option one</option>
							<option value="2">Option two</option>
						</select>
					</div>
				</div>

				<div class="form-group">
					<label class="col-md-4 control-label" for="passengers">Passengers</label>
					<div class="col-md-2">
						<select id="passengers" name="passengers" class="form-control">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
						</select>
					</div>
				</div>
				</div>
				
				<div id="multiple_destinations_div" style="display:none">
<% 
				for(int i = 2; i < 5; i++) { 
%>					
				<div class="well">
					<legend><h4><b>Flight <%= i %></b></h4></legend>
					<div class="form-group">
					<label class="col-md-4 control-label" for="flyingfrom">Flying from</label>
					<div class="col-md-5">
							<select id="flyingfrom<%= i %>" name="flyingfrom<%= i %>" class="form-control">
								<option value="1">Option one</option>
								<option value="2">Option two</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
					<label class="col-md-4 control-label" for="flyingto">Flying to</label>
						<div class="col-md-5">
							<select id="flyingto<%= i %>" name="flyingto<%= i %>" class="form-control">
								<option value="1">Option one</option>
								<option value="2">Option two</option>
							</select>
						</div>
					</div>
					
					<div class="form-group">
					<label class="col-md-4 control-label" for="departing">Departing</label>
						<div class="col-md-4">
							<select id="departing<%= i %>" name="departing<%= i %>" class="form-control">
								<option value="1">Option one</option>
								<option value="2">Option two</option>
							</select>
						</div>
					</div>
				</div>
<%
				}
%>		
				</div>


				<div class="form-group">
					<label class="col-md-4 control-label" for="buy"></label>
					<div class="col-md-8">
						<button id="buy" name="buy" class="btn btn-primary btn-lg"><span class="glyphicon glyphicon-hand-up"></span> Buy</button>
						<button id="bid" name="bid" class="btn btn-warning btn-lg"><span class="glyphicon glyphicon-tag"></span> Bid</button>
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