
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>RAT Reservations - Manager - Customers</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/table.css" rel="stylesheet">
    
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
          <a class="navbar-brand" href="#">RAT Reservations - Reservations</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="help.jsp?help=navManHomScr">Help</a></li>
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
            <%
        	if(request.getParameter("view") != null && request.getParameter("view").equals("flights")){
            	if(request.getParameter("filter")==null){
            		%><li><a href="manager_flights.jsp">Back to All Flights</a></li>  <%
            	}
            	else if(request.getParameter("filter").equals("MostActive")){
            		%><li><a href="manager_flights.jsp?filter=MostActive">Back to Most Active Flights</a></li><%
            	}
            	else if(request.getParameter("filter").equals("Airport")){
            		%><li><a href="manager_flights.jsp?filter=Airport&airport=<%=request.getParameter("airport")%>">Back to Flights By Airport</a></li><%
            	}
            	else if(request.getParameter("filter").equals("OnTime")){
            		%><li><a href="manager_flights.jsp?filter=OnTime">Back to On-time Flights</a></li><%
            	}
            	else if(request.getParameter("filter").equals("Delayed")){
            		%><li><a href="manager_flights.jsp?filter=Delayed">Back to Delayed Flights</a></li><%
            	}
        	}
        	else if(request.getParameter("view") != null && request.getParameter("view").equals("customers")){
        		%><li><a href="manager_customers.jsp">Back to Customers Page</a></li><%
        	}
        	%>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
        <%
        	if(request.getParameter("view") != null && request.getParameter("view").equals("flights")){
            	if(request.getParameter("filter")==null){
            		%> <button type="button" class="btn btn-sm btn-primary" onclick="window.open('manager_flights.jsp', '_self')" >Back</button>  <%
            	}
            	else if(request.getParameter("filter").equals("MostActive")){
            		%> <button type="button" class="btn btn-sm btn-primary" onclick="window.open('manager_flights.jsp?filter=MostActive', '_self')" >Back</button>  <%
            	}
            	else if(request.getParameter("filter").equals("Airport")){
            		%> <button type="button" class="btn btn-sm btn-primary" onclick="window.open('manager_flights.jsp?filter=Airport&airport=<%=request.getParameter("airport")%>', '_self')" >Back</button>  <%
            	}
            	else if(request.getParameter("filter").equals("OnTime")){
            		%> <button type="button" class="btn btn-sm btn-primary" onclick="window.open('manager_flights.jsp?filter=OnTime', '_self')" >Back</button>  <%
            	}
            	else if(request.getParameter("filter").equals("Delayed")){
            		%> <button type="button" class="btn btn-sm btn-primary" onclick="window.open('manager_flights.jsp?filter=Delayed', '_self')" >Back</button>  <%
            	}
        	}
        	else if(request.getParameter("view") != null && request.getParameter("view").equals("customers")){
        		%> <button type="button" class="btn btn-sm btn-primary" onclick="window.open('manager_customers.jsp', '_self')" >Back</button>  <%
        	}
        %>
        
        <%
        	if(request.getParameter("view") != null && request.getParameter("view").equals("flights")){
        		%> <h2 class="sub-header">Reservations For Flight <%=request.getParameter("flightNum")%>, <%=request.getParameter("airId")%></h2>  <%
        	}
        	else{
        		%> <h2 class="sub-header">Reservations For <%=request.getParameter("fname")%> <%=request.getParameter("lname")%></h2>  <%
        	}
        %>
	      
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Reservation Number</th>
                  <th>Customer Name</th>
                  <th>Reservation Date</th>
                  <th>Total Fare</th>
                  <th>Booking Fee</th>
                  <th>Representative SSN</th>
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
			
            java.sql.ResultSet rs = null;
            if(request.getParameter("view") != null && request.getParameter("view").equals("flights")){
            	rs = stmt1.executeQuery("SELECT DISTINCT R.resrNum, R.resrCreated, R.totalFare, R.bookingFee, R.represSSN, P.firstName, P.lastName FROM Reservation R, Customer C, reservation_legs I, Person P WHERE R.accountNum = C.accountNum AND C.id = P.id AND I.resrNum = R.resrNum AND I.airlineId='"+request.getParameter("airId")+"' AND I.flightNum = '"+request.getParameter("flightNum")+"'");	
            }
            else{
            	rs = stmt1.executeQuery("SELECT DISTINCT R.resrNum, R.resrCreated, R.totalFare, R.bookingFee, R.represSSN, P.firstName, P.lastName FROM Reservation R, Customer C, Person P WHERE R.accountNum = C.accountNum AND C.id = P.id  AND P.firstName = '"+request.getParameter("fname")+"' AND P.lastName = '"+request.getParameter("lname")+"'");	 
            }
             	            	
          	while(rs.next())
            {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(6) + " " + rs.getString(7)%></td> 
                          <td><%=rs.getString(2)%></td>
                          <td><%=rs.getString(3)%></td>
                          <td><%=rs.getString(4)%></td>
                          <td><% if(rs.getString(5) == null) out.println("N/A"); else out.println(rs.getString(5)); %></td>        		
                        </tr>
    <%      		
            }
  		} catch(Exception e)
		{
			e.printStackTrace();
			out.print(e.toString());
		}
		finally
		{
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
