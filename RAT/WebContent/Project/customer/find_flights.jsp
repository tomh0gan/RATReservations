<%@ page import="java.sql.*, java.util.ArrayList" %>
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
	ArrayList<ArrayList<String[]>> foundFlights = null;
	try{	
		Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops=System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
		conn = java.sql.DriverManager.getConnection(mysURL,sysprops);
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();
		
		// Initially, selects all legs which are departing from a specified airport on a specified day
		String q = "SELECT * FROM legs WHERE depAirportId='" + request.getParameter("depAirport") +
				"' AND (depTime >= '" + request.getParameter("depDate") +
				" 00:00:00' AND depTime <= '"+ request.getParameter("depDate") +" 23:59:59');";
		ResultSet rs1 = stmt1.executeQuery(q);
		
		ArrayList<String[]> possibleDeps = new ArrayList<String[]>();
		
		// Placing them in an array list
		while(rs1.next()){
			String[] possibleDep = new String[8];
			for(int i = 0; i < 8; i++){
				possibleDep[i] = rs1.getString(i+1);
			}
			possibleDeps.add(possibleDep);
		}
		
		// Then, follow all of the possible "leads," we could add any type of pruning we'd like here
			// the max layover time is 2 hours and the minimum is 15 min
			// the max amount of flight legs is 3, meaning 2 possible layovers max (could increase)
		// Storing the flights that are correct in this.
		foundFlights = new ArrayList<ArrayList<String[]>>();
		
		for(String[] possibleDep : possibleDeps){
			ArrayList<String[]> findingFlights = new ArrayList<String[]>();
			findingFlights.add(possibleDep);
			
			if(possibleDep[5].equals(request.getParameter("arrAirport"))){
				foundFlights.add(findingFlights);
			}
			else{
				q = "SELECT * FROM legs WHERE depAirportId = '" + possibleDep[5] + 
						"' AND (TIMEDIFF(depTime,'" + possibleDep[6] + "') <= '02:00:00')" +
						" AND (TIMEDIFF(depTime,'" + possibleDep[6] + "') > '00:15:00');";
				ResultSet rs2 = stmt2.executeQuery(q);
				while(rs2.next()){
					String[] possible2 = new String[8];
					for(int i = 0; i < 8; i++){
						possible2[i] = rs2.getString(i+1);
					}
					findingFlights.add(possible2);
					if(possible2[5].equals(request.getParameter("arrAirport"))){
						foundFlights.add(findingFlights);
					}
					else{
						q = "SELECT * FROM legs WHERE depAirportId = '" + possible2[5] + 
								"' AND (TIMEDIFF(depTime,'" + possible2[6] + "') <= '02:00:00')" +
								" AND (TIMEDIFF(depTime,'" + possible2[6] + "') > '00:15:00');";
						ResultSet rs3 = stmt3.executeQuery(q);
						while(rs3.next()){
							String[] possible3 = new String[8];
							for(int i = 0; i < 8; i++){
								possible3[i] = rs3.getString(i+1);
							}
							findingFlights.add(possible3);
							if(possible3[5].equals(request.getParameter("arrAirport"))){
								foundFlights.add(findingFlights);
							}
						}
					}
				}
			}
		}
		
	} catch(Exception e){
		System.out.println(e);
	} finally {
		try {
			conn.close();
			} catch(Exception ee){ }
	}
	
	if(foundFlights.isEmpty()){
%>
	nothing found
<% 
	} else {
%>
<div class="container">
	<table class = "table table-hover">
		<thead>
			<tr>
				<th>D(Airport)</th>
				<th>D(Time)</th>
				<th>A(Airport)</th>
				<th>A(Time)</th>
				<th>Total Time</th>
				<th># of Stops</th>
				<th>Cost</th>
			</tr>
		</thead>
		<tbody>
<% 
	for(ArrayList<String[]> flight : foundFlights){
%>
			<tr>
				<td><%= request.getParameter("depAirport") %></td>
				<td>x</td>
				<td><%= request.getParameter("arrAirport") %></td>
				<td>x</td>
				<td>x</td>
				<td><%= flight.size() %></td>
				<td>x</td>
				<td><a href="#" class="btn btn-xs btn-info"><span class="glyphicon glyphicon-ok"></span> Buy</a></td>
				<td><a href="#" class="btn btn-xs btn-warning"><span class="glyphicon glyphicon-tag"></span> Bid</a></td>
			<tr>
<%
	}
%>
		</tbody>
	</table>
</div>
<%
	}
%>
<!-- END PAGE -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>