<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - View Bids</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<script>
 function deleteBid(resrNum){
	 var resp=confirm("Are you sure you want to delete this bid?");
	 if(resp == true){
		 window.open('delete_bid.jsp?resrNum='+resrNum+'', '_self');
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
            <a class="navbar-brand" href="#">RAT Reservations<img width="30" height="30" class="img" src="../images/rat-md.png"></a>
          </div>
          <div class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="home.jsp">Find Flights</a></li>
              <li><a href="view_reservations.jsp">View Reservations</a></li>
              <li class="active"><a href="view_bids.jsp">View Bids</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            	<li><a href="help.jsp">Help</a></li>
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

        java.sql.ResultSet rs = stmt.executeQuery("SELECT resrCreated, bid, reverse_bid.resrNum, status" + 
        								" FROM reservation JOIN reverse_bid on reservation.resrNum = reverse_bid.resrNum" +
        								" AND reverse_bid.accountNum = "+session.getAttribute("accountNum")+" AND reverse_bid.status='pending';");
%>
	<div class="container">
		<legend>Pending Bids</legend>
		<div class="well">
			<table class="table table-striped">
				<thead>
					<tr>
					<th>Reservation Date</th>
					<th>Bid</th>
					<th>View</th>
					<th>Status</th>
					<th>Cancel</th>
					</tr>
				</thead>
				<tbody>
<% 
				while(rs.next()){
%>
					<tr>
					<td><%=rs.getString(1)%></td>
					<td><%=rs.getString(2)%></td>
					<td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('customer_bid.jsp?resrNum=<%=rs.getString(3) %>', '_self')" >View</button></td>
					<td><%=rs.getString(4)%></td>
					<td><button type="button" class="btn btn-sm btn-danger" onclick="return deleteBid(<%= rs.getString(3) %>);">Cancel</button></td>
					</tr>
<%
				}
%>
				</tbody>
			</table>
		</div>
<%
		java.sql.ResultSet rs2 = stmt.executeQuery("SELECT resrCreated, bid, reverse_bid.resrNum, status" + 
		" FROM reservation JOIN reverse_bid on reservation.resrNum = reverse_bid.resrNum" +
		" AND reverse_bid.accountNum = "+session.getAttribute("accountNum")+" AND reverse_bid.status <> 'pending';");
%>	
		<legend>Processed Bids</legend>
		<div class="well">
			<table class="table table-striped">
				<thead>
					<tr>
					<th>Reservation Date</th>
					<th>Bid</th>
					<th>View</th>
					<th>Status</th>
					</tr>
				</thead>
				<tbody>
<% 
				while(rs2.next()){
%>
					<tr>
					<td><%=rs2.getString(1)%></td>
					<td><%=rs2.getString(2)%></td>
					<td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('customer_bid.jsp?resrNum=<%=rs2.getString(3) %>', '_self')" >View</button></td>
					<td><%=rs2.getString(4)%></td>
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