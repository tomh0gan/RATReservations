<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - View Reservations</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">

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
              <li><a href="home.jsp">Find Flights</a></li>
              <li class="active"><a href="view_reservations.jsp">View Reservations</a></li>
              <li><a href="view_bids.jsp">View Bids</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
              <li><a href="get_account_info.jsp">My Account (<%=session.getAttribute("username")%>)</a></li>
      		  <li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
            </ul>
          </div>
        </div>
      </div>
     </div>
	<br>
<%
	String resrNum = request.getParameter("resrNum");

	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
	String mysUserID = "tester"; 
	String mysPassword = "test";

	java.sql.Connection conn=null;
	try {
        Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops=System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
    
        conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
        java.sql.Statement stmt=conn.createStatement();
		
        ArrayList<String> passengers = new ArrayList<String>();
        ArrayList<String> names = new ArrayList<String>();
        java.sql.ResultSet rs = stmt.executeQuery("SELECT DISTINCT passengerId, name FROM reservation_passengers WHERE resrNum="+resrNum+";");
        while(rs.next()){
        	passengers.add(rs.getString(1));
        	names.add(rs.getString(2));
        }
        for(int i = 0; i < passengers.size(); i++){
%>
        	<div class="container">
        		<legend>Passenger <%= i+1 %>: <%= names.get(i) %></legend>
        		<div class="well">
        			<table class="table table-striped">
        				<thead>
        					<tr>
	        					<th>AirlineId</th>
	        					<th>Flight Number</th>
	        					<th>Leg Number</th>
	        					<th>Departing Airport</th>
	        					<th>Departure Time</th>
	        					<th>Arriving Airport</th>
	        					<th>Arrival Time</th>
	        					<th>Class</th>
	        					<th>Seat Number</th>
	        					<th>Cost</th>
        					</tr>
        				</thead>
        				<tbody>
						<% 
						java.sql.Statement stmt2=conn.createStatement();
						java.sql.ResultSet rs2 = stmt2.executeQuery("SELECT L.airlineId, L.flightNum, L.legNum, L.depAirportId, L.depDate, L.depTime, L.arrAirportId, L.arrDate, L.arrTime, R.class, R.seatNum, R.total"
																  + " FROM leg L, reservation_legs R"
																  + " WHERE R.resrNum="+resrNum+" AND R.passengerId="+passengers.get(i)+" AND R.airlineId=L.airlineId AND R.flightNum=L.flightNum AND R.legNum=L.legNum AND R.depDate=L.depDate AND R.depTime=L.depTime ORDER BY depDate;");
						
						
        				while(rs2.next()){
						%>
        					<tr>
        						<td><%= rs2.getString(1) %></<td>
	        					<td><%= rs2.getString(2) %></td>
	        					<td><%= rs2.getString(3) %></td>
	        					<td><%= rs2.getString(4) %></td>
	        					<td><%= rs2.getString(5) + " AT " + rs2.getString(6) %></td>
	        					<td><%= rs2.getString(7) %></td>
	        					<td><%= rs2.getString(8) + "AT" + rs2.getString(9)%></td>
	        					<td><%= rs2.getString(10) %></td>
	        					<td><%= rs2.getString(11) %></td>
	        					<td><%= "$" + rs2.getString(12) %></td>
        					</tr>
						<%
        				}
						%>
        				</tbody>
        			</table>
        		</div>
        	</div>
<%	
        }
	} catch(Exception e){
		out.print(e.toString());
	}
	finally{try{conn.close();}catch(Exception ee){};}
%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>