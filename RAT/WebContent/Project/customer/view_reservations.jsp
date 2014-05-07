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
		
        java.sql.ResultSet rs = stmt.executeQuery("SELECT R.resrCreated, R.totalFare, R.resrNum FROM Reservation R"
			    							   + " WHERE EXISTS (SELECT * FROM reservation_legs S"
			   								   + " WHERE R.ResrNum = S.ResrNum AND concat(S.depDate,' ',S.depTime) > NOW())"
			   								   + " AND R.AccountNum="+session.getAttribute("accountNum")
			   								   + " AND r.resrNum NOT IN (SELECT B.resrNum FROM reverse_bid B);");
%>
	<div class="container">
		<legend>Current Reservations</legend>
		<div class="well">
			<table class="table table-striped">
				<thead>
					<tr>
					<th>Reservation Date</th>
					<th>Total Fare</th>
					<th>View</th>
					</tr>
				</thead>
				<tbody>
<% 
				while(rs.next()){
%>
					<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('customer_reservation.jsp?resrNum=<%=rs.getString(3) %>', '_self')" >View</button></td>
					</tr>
<%
				}
%>
				</tbody>
			</table>
		</div>
	</div>
<%
			rs = stmt.executeQuery("SELECT R.resrCreated, R.totalFare, R.resrNum FROM Reservation R"
		  		 + " WHERE EXISTS (SELECT * FROM reservation_legs S"
		  		 + " WHERE R.ResrNum = S.ResrNum AND concat(S.depDate,' ',S.depTime) <= NOW())"
		   		 + " AND R.AccountNum="+session.getAttribute("accountNum")
		   		 + " AND r.resrNum NOT IN (SELECT B.resrNum FROM reverse_bid B);");
%>
	<div class="container">
		<legend>Reservation History</legend>
		<div class="well">
			<table class="table table-striped">
				<thead>
					<tr>
					<th>Reservation Date</th>
					<th>Total Fare</th>
					<th>View</th>
					</tr>
				</thead>
				<tbody>
<% 
				while(rs.next()){
%>
					<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('customer_reservation.jsp?resrNum=<%=rs.getString(3) %>', '_self')" >View</button></td>
					</tr>
<%
				}
%>
				</tbody>
			</table>
		</div>
	</div>
<%
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