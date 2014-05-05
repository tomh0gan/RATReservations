
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>RAT Reservations - Manager - Flights</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/table.css" rel="stylesheet">

	<%			
    	String airport=  request.getParameter("airport");   		
    	session.setAttribute("ManagerFlight", airport);
        if(!(airport==null))
        	airport = airport.replace("'", "''");
    %>
	<script>
		function getDropdown(){
			var url = "manager_flights.jsp?filter=Airport&airport=" + document.getElementById("AirportDropdown").value;
		    window.open(url, '_self');
		}
	</script>
  </head>

  <body>
	 <% if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	   }
  	 %>
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">RAT Reservations - Flights</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="help.jsp?help=manFli">Help</a></li>
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
            <li><a href="manager_flights.jsp">All Flights</a></li>
            <li><a href="manager_flights.jsp?filter=MostActive">Most Active Flights</a></li>
            <li><a href="manager_flights.jsp?filter=Airport">Flights by Airport</a></li>
            <li><a href="manager_flights.jsp?filter=OnTime">On-time Flights</a></li>
            <li><a href="manager_flights.jsp?filter=Delayed">Delayed Flights</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
          <%
          if(request.getParameter("filter") != null){
          	if(request.getParameter("filter").equals("Airport")){
          		%>
          		<select style="height: 40px;" id="AirportDropdown" name="AirportDropdown">
          			<option ${ManagerFlight==""?"selected=selected":""} value="">Please select an airport: </option>
          			<option ${ManagerFlight=="Berlin Tegel"?"selected=selected":""} value="Berlin Tegel">Berlin Tegel</option>
          			<option ${ManagerFlight=="Chicago O'Hare International"?"selected=selected":""} value="Chicago O'Hare International" >Chicago O'Hare International</option>
          			<option ${ManagerFlight=="Hartsfield-Jackson Atlanta Int"?"selected=selected":""} value="Hartsfield-Jackson Atlanta Int" >Hartsfield-Jackson Atlanta Int</option>
          			<option ${ManagerFlight=="Ivato International"?"selected=selected":""} value="Ivato International" >Ivato International</option>
          			<option ${ManagerFlight=="John F. Kennedy International"?"selected=selected":""} value="John F. Kennedy International" >John F. Kennedy International</option>
          			<option ${ManagerFlight=="Los Angeles International"?"selected=selected":""} value="Los Angeles International" >Los Angeles International</option>
          			<option ${ManagerFlight=="LaGuardia"?"selected=selected":""} value="LaGuardia" >LaGuardia</option>
          			<option ${ManagerFlight=="London Heathrow"?"selected=selected":""} value="London Heathrow" >London Heathrow</option>
          			<option ${ManagerFlight=="Logan International"?"selected=selected":""} value="Logan International" >Logan International</option>
          			<option ${ManagerFlight=="San Francisco International"?"selected=selected":""} value="San Francisco International" >San Francisco International</option>
          			<option ${ManagerFlight=="Tokyo International"?"selected=selected":""} value="Tokyo International" >Tokyo International</option>
          		</select>
          		<button class="btn btn-lg btn-primary" onclick="getDropdown()">Go</button>
          		<% 
          	}
          }
          %>
		  <%
		  if(request.getParameter("filter")!=null && request.getParameter("filter").equals("MostActive")){
			  %> <h2 class="sub-header">Most Active Flights</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("Airport")){
			  %> <h2 class="sub-header">${ManagerFlight}</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("OnTime")){
			  %> <h2 class="sub-header">On-Time Flights</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("Delayed")){
			  %> <h2 class="sub-header">Delayed Flights</h2> <% 
		  }
		  else{
			  %> <h2 class="sub-header">All Flights</h2> <% 
		  }
		  %>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                <%
                if(request.getParameter("filter") != null && request.getParameter("filter").equals("MostActive")){
                %>
                  <th>Airline</th>
                  <th>Flight Number</th>
                  <th>Count</th>
                  <th>Reservations</th>
                  <th>Revenue</th>
                	<%
                }
                else {
                %>
                  <th>Airline</th>
                  <th>Flight Number</th>
                  <th>Number of Seats</th>
                  <th>Operating Days</th>
                  <th>Min Length of Stay</th>
                  <th>Max Length of Stay</th>
                  <th>Reservations</th>
                  <th>Revenue</th>
                <%
                }
                %>
                </tr>
              </thead>
              <tbody>
<%
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
     	String mysUserID = "tester"; 
    	String mysPassword = "test";
        
  		java.sql.Connection conn=null;
		try 
		{
            Class.forName(mysJDBCDriver).newInstance();
    		java.util.Properties sysprops=System.getProperties();
    		sysprops.put("user",mysUserID);
    		sysprops.put("password",mysPassword);
        
    		//connect to the database
            conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            System.out.println("Connected successfully to database using JConnect");
            
            java.sql.Statement stmt1=conn.createStatement();
        
            if(request.getParameter("filter") != null && request.getParameter("filter").equals("MostActive")){
            	stmt1.execute("CREATE VIEW FlightReservation(airlineId, flightNum, ResrCount) AS SELECT I.airlineId, I.flightNum, COUNT(DISTINCT I.resrNum) FROM Includes I GROUP BY I.airlineId, I.flightNum;");
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM FlightReservation WHERE ResrCount >= (SELECT MAX(ResrCount) FROM FlightReservation)"); 	            	
          	    while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2)%></td>
                          <td><%=rs.getString(3)%></td>
                          <td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('reservations.jsp?view=flights&airId=<%=rs.getString(1)%>&flightNum=<%=rs.getString(2)%>&filter=<%=request.getParameter("filter")%>', '_self')" >Reservations</button></td>
                          <td><button type="button" class="btn btn-sm btn-success" onclick="window.open('manager_revenue_page.jsp?view=flightsRev&revFilter=MostActive&filter=FlightNum&airline=<%=rs.getString(1)%>&value=<%=rs.getString(2)%>', '_self')" >Revenue</button></td>            		
                        </tr>
    <%      		
            	}
          	    stmt1.execute("DROP VIEW FlightReservation;");
            }
            else if(request.getParameter("filter") != null && request.getParameter("filter").equals("Airport")){
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT DISTINCT F.* FROM Flight F, Leg L, Airport A WHERE F.airlineId = L.airlineId AND F.flightNum = L.FlightNum AND (L.depAirportId = A.airportId OR L.arrAirportId = A.airportId) AND A.airportName = '"+ airport + "' ");
          	    while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2)%></td>
                          <td><%=rs.getString(3)%></td>
                          <td><%=rs.getString(4)%></td>
                          <td><%=rs.getString(5)%></td>
                          <td><%=rs.getString(6)%></td>
                          <td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('reservations.jsp?view=flights&airId=<%=rs.getString(1)%>&flightNum=<%=rs.getString(2)%>&filter=<%=request.getParameter("filter")%>&airport=<%=airport%>', '_self')" >Reservations</button></td>  
                          <td><button type="button" class="btn btn-sm btn-success" onclick="window.open('manager_revenue_page.jsp?view=flightsRev&revFilter=Airport&filter=FlightNum&airline=<%=rs.getString(1)%>&value=<%=rs.getString(2)%>', '_self')" >Revenue</button></td>  
                        </tr>
    <%      		
            	}
            }
            else if(request.getParameter("filter") != null && request.getParameter("filter").equals("OnTime")){
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Flight F WHERE NOT EXISTS ( SELECT * FROM Leg L WHERE F.airlineId = L.airlineId AND F.flightNum = L.flightNum AND (actArrTime > arrTime OR actDepTime > depTime)) ");
          	    while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2)%></td>
                          <td><%=rs.getString(3)%></td>
                          <td><%=rs.getString(4)%></td>
                          <td><%=rs.getString(5)%></td>
                          <td><%=rs.getString(6)%></td>
                          <td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('reservations.jsp?view=flights&airId=<%=rs.getString(1)%>&flightNum=<%=rs.getString(2)%>&filter=<%=request.getParameter("filter")%>', '_self')" >Reservations</button></td>            		
                          <td><button type="button" class="btn btn-sm btn-success" onclick="window.open('manager_revenue_page.jsp?view=flightsRev&revFilter=OnTime&filter=FlightNum&airline=<%=rs.getString(1)%>&value=<%=rs.getString(2)%>', '_self')" >Revenue</button></td>  
                        </tr>
    <%      		
            	}
            }
            else if(request.getParameter("filter") != null && request.getParameter("filter").equals("Delayed")){
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Flight F WHERE EXISTS ( SELECT * FROM Leg L WHERE F.airlineId = L.airlineId AND F.flightNum = L.flightNum AND (actArrTime > arrTime OR actDepTime > depTime)) ");
          	    while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2)%></td>
                          <td><%=rs.getString(3)%></td>
                          <td><%=rs.getString(4)%></td>
                          <td><%=rs.getString(5)%></td>
                          <td><%=rs.getString(6)%></td>
                          <td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('reservations.jsp?view=flights&airId=<%=rs.getString(1)%>&flightNum=<%=rs.getString(2)%>&filter=<%=request.getParameter("filter")%>', '_self')" >Reservations</button></td>            		
                          <td><button type="button" class="btn btn-sm btn-success" onclick="window.open('manager_revenue_page.jsp?view=flightsRev&revFilter=Delayed&filter=FlightNum&airline=<%=rs.getString(1)%>&value=<%=rs.getString(2)%>', '_self')" >Revenue</button></td>  
                        </tr>
    <%      		
            	}
            }
            else{
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Flight");
          	    while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2)%></td>
                          <td><%=rs.getString(3)%></td>
                          <td><%=rs.getString(4)%></td>
                          <td><%=rs.getString(5)%></td>
                          <td><%=rs.getString(6)%></td>
                          <td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('reservations.jsp?view=flights&airId=<%=rs.getString(1)%>&flightNum=<%=rs.getString(2)%>', '_self')" >Reservations</button></td>     
                          <td><button type="button" class="btn btn-sm btn-success" onclick="window.open('manager_revenue_page.jsp?view=flightsRev&filter=FlightNum&airline=<%=rs.getString(1)%>&value=<%=rs.getString(2)%>', '_self')" >Revenue</button></td>          		
                        </tr>
    <%      		
            	}
            }
  			} catch(Exception e)
			{
				e.printStackTrace();
				out.print(e.toString());
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
	<script src="../resources/js/bootstrap.min.js"></script>
  </body>
</html>
