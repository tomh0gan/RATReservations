<%@ page import="java.util.GregorianCalendar, java.text.SimpleDateFormat, java.sql.*" %>
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
	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
	String mysURL = "jdbc:mysql://localhost:3306/rat"; 
	String mysUserID = "tester"; 
	String mysPassword = "test";
	
	Connection conn=null;
	
	try{	
		Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops=System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
		
		conn = java.sql.DriverManager.getConnection(mysURL,sysprops);
		
		Statement stmt = conn.createStatement();
%>
<div class="container">
	<form class="form-horizontal" action="find_flights.jsp" method="post">
		<fieldset>
		<!-- FORM NAME -->
			<legend>Find Flights</legend>
			<div class="well">
			
		<!-- FLYING FROM -->
			<div class="form-group">
				<label class="col-md-4 control-label" for="depAirport">Flying from</label>
				<div class="col-md-5">
					<select id="depAirport" name="depAirport" class="form-control" required>
						<option disabled selected value="" style="display:none">Select Airport</option>
<%
					ResultSet rs = stmt.executeQuery("SELECT * FROM airports ORDER BY name ASC;");
 	       	 		while(rs.next()){	     
%>
						<optgroup label="<%=rs.getString("name")%>">
						<option value="<%=rs.getString("airportId")%>">
						<%=rs.getString("airportId")%>: <%=rs.getString("city")%>, <%=rs.getString("country")%></option>
						</optgroup>
<%
 	       	 		}
%>
					</select>
				  </div>
			</div>

		<!-- FLYING TO -->
			<div class="form-group">
				<label class="col-md-4 control-label" for="arrAirport">Flying to</label>
				<div class="col-md-5">
			   		<select id="arrAirport" name="arrAirport" class="form-control" required>
			   			<option disabled selected value="" style="display:none">Select Airport</option>
<%
					rs = stmt.executeQuery("SELECT * FROM airports ORDER BY name ASC;");
 	       	 		while(rs.next()){	     
%>
						<optgroup label="<%=rs.getString("name")%>">
						<option value="<%=rs.getString("airportId")%>">
						<%=rs.getString("airportId")%>: <%=rs.getString("city")%>, <%=rs.getString("country")%></option>
						</optgroup>
<%
 	       	 		}
%>
					</select>
				</div>
			</div>
			
		<!-- DEPARTING -->
			<div class="form-group">
				<label class="col-md-4 control-label" for="depDate">Departing</label>
				<div class="col-md-3">
					<input id="depDate" name="depDate" type="date" class="form-control input-md" 
						min="<%= ((new SimpleDateFormat("yyyy-MM-dd")).format((new GregorianCalendar()).getTime())) %>" required>
				</div>
			</div>

		<!-- SEARCH FLIGHTS -->
			<div class="form-group">
				<label class="col-md-6 control-label" for="search"></label>
				<div class="col-md-4">
					<button id="search" name="search" class="btn btn-primary"><span class="glyphicon glyphicon-search"></span> Search</button>
				</div>
			</div>
			</div>
		</fieldset>
	</form>
</div>
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