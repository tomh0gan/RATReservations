<%@ page import="java.sql.*, java.util.Properties" %>
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
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
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
            <li><a href="reservations.jsp?filter=Suggest">Suggestions</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
		  <%
		  if(request.getParameter("filter")!=null && request.getParameter("filter").equals("PastRes")){
			  %> <h2 class="sub-header">Past Reservations</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("CurrBids")){
			  %> <h2 class="sub-header">Current Bids</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("PastBids")){
			  %> <h2 class="sub-header">Past Bids</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("Suggest")){
			  %> <h2 class="sub-header">Suggestions</h2> <% 
		  }
		  else{
			  %> <h2 class="sub-header">Current Reservations</h2> <% 
		  }
		  %>
		<div class ="table-responsive">
			<table class="table table-striped">
				<thead><tr>
					<%
					if(request.getParameter("filter") != null 
					&& (request.getParameter("filter").equals("CurrBids") ||
					request.getParameter("filter").equals("PastBids"))){
					%>
						<th>Flight</th>
						<th>Departure<th>
						<th>Arrival<th>
						<th>Fare</th>
						<th>Status</th>
						<th>Additional Options</th>
						<th>Bid Options</th>
					<%
					}
					else if(request.getParameter("filter") != null 
							&& request.getParameter("filter").equals("Suggest")){
					%>
						<th>Don't</th>
						<th>Know</th>
						<th>What</th>
						<th>To</th>
						<th>Put</th>
						<th>Here</th>
					<%
					} else {
					%>
						<th>Flight</th>
						<th>Departure<th>
						<th>Arrival<th>
						<th>Fare</th>
						<th>Additional Options</th>
					<% 
					}
					%>
				</tr></thead>
				<tbody>
				<%
					String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
					String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
		     		String mysUserID = "tester"; 
		    		String mysPassword = "test";
					
		    		Connection conn=null;
		    		try{
		                Class.forName(mysJDBCDriver).newInstance();
		        		java.util.Properties sysprops=System.getProperties();
		        		sysprops.put("user",mysUserID);
		        		sysprops.put("password",mysPassword);
		        		
		        		conn=DriverManager.getConnection(mysURL,sysprops);
		        		
		        		Statement stmt1=conn.createStatement();
						
						if(request.getParameter("filter") != null 
						&& (request.getParameter("filter").equals("CurrBids") ||
						request.getParameter("filter").equals("PastBids"))){
						%>
							<tr>
								<td>Flight</td>
								<td>Departure<td>
								<td>Arrival<td>
								<td>Fare</td>
								<td>Status</td>
								<td>"A" Button</td>
								<td>"B" Button</td>
							</tr>
						<%
						}
						else if(request.getParameter("filter") != null 
								&& request.getParameter("filter").equals("Suggest")){
						%>
							<tr>
								<td>Don't</td>
								<td>Know</td>
								<td>What</td>
								<td>To</td>
								<td>Put</td>
								<td>Here</td>
							</tr>
						<%
						} else {
							ResultSet rs = stmt1.executeQuery("SELECT I.airlineId, I.flightNum, I.legNum, L.depAirportId, L.depTime, L.arrAirportId, L.arrTime, R.totalFare" 
									+" FROM reservation R, includes I, leg L WHERE ((((R.accountNum="+session.getAttribute("accountNum")+" AND R.resrNum=I.resrNum) AND L.airlineId = I.airlineId) "
											+"AND L.flightNUM = I.flightNum) AND L.legNum = I.legNum)");
							while(rs.next())
							{
						%>
							<tr>
								<td><%= rs.getString(1) + "-" + rs.getString(2) + "-" + rs.getString(3) %></td>
								<td><%= rs.getString(4) + " at " + rs.getString(5) %><td>
								<td><%= rs.getString(6) + " at " + rs.getString(7) %><td>
								<td><%= rs.getString(8) %></td>
								<td>"A" Button</td>
							</tr>
						<% 
							}
						}
		    		} catch(Exception e)
					{
						e.printStackTrace();
					}
					finally{
					
						try{conn.close();}catch(Exception ee){};
					}
		    		
				%>

				</tbody>
			</table>
		</div>
        </div>
      </div>
    </div>

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <script src="../../dist/js/bootstrap.min.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
  </body>
</html>
