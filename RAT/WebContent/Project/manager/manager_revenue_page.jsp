
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>RAT Reservations - Manager - Revenue</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/table.css" rel="stylesheet">
	<script>
		function getInput(){   
			var url = "";
			var filter = "<%= request.getParameter("filter") %>";
			if(filter==="FlightNum"){
				url = "manager_revenue_page.jsp?filter="+filter+"&value="+document.getElementById("value").value+"&airline="+document.getElementById("value2").value;
			}
			else{
				url = "manager_revenue_page.jsp?filter="+filter+"&value="+document.getElementById("value").value;	
			}
		    window.open(url, '_self');
		}
		
    	function getMonth(){
    		var month=document.getElementById("MonthDropdown").value;
    		var year=document.getElementById("YearDropdown").value;
    		var url = "manager_revenue_page.jsp?month="+month+"&year="+year;
    	    window.open(url, '_self');
    	}
	</script>
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
          <a class="navbar-brand" href="#">RAT Reservations - Revenue</a>
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
            <li><a href="manager_revenue_page.jsp">Sales Reports</a></li>
            <li><a href="manager_revenue_page.jsp?filter=MostCust">Most Customer Generated Revenue</a></li>
            <li><a href="manager_revenue_page.jsp?filter=MostCustRep">Most Customer Rep. Generated Revenue</a></li>
            <li><a href="manager_revenue_page.jsp?filter=FlightNum">Flight Revenue</a></li>
            <li><a href="manager_revenue_page.jsp?filter=Customer">Customer Revenue</a></li>
            <li><a href="manager_revenue_page.jsp?filter=City">City Revenue</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
	<%	
    	String filter = request.getParameter("filter");
		String value = request.getParameter("value");
		String airlineId = request.getParameter("airline");		
    	String month = request.getParameter("month");
       	String year = request.getParameter("year");
       	if(month == null){
       		month = "";
       		year = "";
       	}
       	if(filter == null){
       		filter = "";
       	}
       	if(value == null){
       		value="";
       	}
       	if(airlineId == null){
       		airlineId="";
       	}
       	
       	request.setAttribute("ManagerMonth", month);
       	request.setAttribute("ManagerYear", year);
	
       	request.setAttribute("ManagerRevenue", value);
       	request.setAttribute("ManagerRevAirline", airlineId);
		
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
        	java.sql.ResultSet rs1;
        	
            if(filter.equals("FlightNum")){
            	rs1 = stmt1.executeQuery("SELECT airlineId, airlineName FROM airlines;");
           		%>
           			<span>Airline Id: </span>
           			<select name="AirlineId" id="value2">
           			<option value="">Please select airline!</option>
           				<%
           					while(rs1.next()){
           						if(airlineId.equals(rs1.getString(1))){
               						%> 
           								<option selected="selected" value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>  
           							<% 	
           						}
           						else{
               						%> 
           								<option value="<%=rs1.getString(1)%>"><%=rs1.getString(2)%></option>  
           							<% 
           						}
           					}
           				%>
           			</select>
           			<span>Flight Number: </span>
           			<input type="text" name="FlightNum" id="value" value="${ManagerRevenue}" />
           			<input id="GoButton" name="GoButton" type="button" value="Go" onclick="getInput()" /> 
           		<% 
           	}
           	else if(filter.equals("City")){
           		rs1 = stmt1.executeQuery("SELECT DISTINCT city FROM airport;");
           		%>
    	   			<span>Destination City: </span>
    	   			<select id="value">
    	   			    <%
           					while(rs1.next()){
           						if(value.equals(rs1.getString(1))){
               						%> 
           								<option selected="selected" value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>  
           							<% 	
           						}
           						else{
               						%> 
           								<option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>  
           							<% 
           						}
           					}
           				%>
    	   			</select>
    	   			<input id="GoButton" name="GoButton" type="button" value="Go" onclick="getInput()" />
       			<% 
           	}
           	else if(filter.equals("Customer")){
           		%>
    	   			<span>Customer Account Number: </span>
    	   			<input type="text" name="AccountNum" id="value" value="${value}" />
    	   			<input id="GoButton" name="GoButton" type="button" value="Go" onclick="getInput()" /> 
       			<% 
           	}
           	else if(filter.equals("")){
           		%>
           			<span class="monthSpan">Month: </span>
					<select id="MonthDropdown" name="MonthDropdown">
						<option value="">Select a Month</option>
						<option ${ManagerMonth=="01"?"selected='selected'":""} value="01">January</option>
						<option ${ManagerMonth=="02"?"selected='selected'":""} value="02">February</option>
						<option ${ManagerMonth=="03"?"selected='selected'":""} value="03">March</option>
						<option ${ManagerMonth=="04"?"selected='selected'":""} value="04">April</option>
						<option ${ManagerMonth=="05"?"selected='selected'":""} value="05">May</option>
						<option ${ManagerMonth=="06"?"selected='selected'":""} value="06">June</option>
						<option ${ManagerMonth=="07"?"selected='selected'":""} value="07">July</option>
						<option ${ManagerMonth=="08"?"selected='selected'":""} value="08">August</option>
						<option ${ManagerMonth=="09"?"selected='selected'":""} value="09">September</option>
						<option ${ManagerMonth=="10"?"selected='selected'":""} value="10">October</option>
						<option ${ManagerMonth=="11"?"selected='selected'":""} value="11">November</option>
						<option ${ManagerMonth=="12"?"selected='selected'":""} value="12">December</option>		
					</select>
					<span class="yearSpan">Year: </span>
					<select id="YearDropdown" name="YearDropdown">
						<option value="">Select a Year</option>
						<option ${ManagerYear=="2010"?"selected='selected'":""} value="2010">2010</option>
						<option ${ManagerYear=="2011"?"selected='selected'":""} value="2011">2011</option>
						<option ${ManagerYear=="2012"?"selected='selected'":""} value="2012">2012</option>
						<option ${ManagerYear=="2013"?"selected='selected'":""} value="2013">2013</option>
						<option ${ManagerYear=="2014"?"selected='selected'":""} value="2014">2014</option>	
					</select>
					<input id="GoButton" name="GoButton" type="button" value="Go" onclick="getMonth()" />
           		<% 
           	}
        
	  	} catch(Exception e)
		{
			e.printStackTrace();
			out.print(e.toString());
		}
   		%>
		  <%
		  if(request.getParameter("filter")!=null && request.getParameter("filter").equals("MostCust")){
			  %> <h2 class="sub-header">Most Customer Generated Revenue</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("MostCustRep")){
			  %> <h2 class="sub-header">Most Customer Rep. Generated Revenue</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("City")){
			  %> <h2 class="sub-header">${ManagerRevenue} Revenue</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("FlightNum")){
			  %> <h2 class="sub-header">Flight ${ManagerRevenue} Revenue</h2> <% 
		  }
		  else if(request.getParameter("filter")!=null && request.getParameter("filter").equals("Customer")){
			  %> <h2 class="sub-header">Account ${ManagerRevenue} Revenue</h2> <% 
		  }
		  else{
			  %> <h2 class="sub-header">Monthly Sales Reports</h2> <% 
		  }
		  %>
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                <%
                if(request.getParameter("filter") != null && request.getParameter("filter").equals("MostCust")){
                %>
                  <th>Customer Account</th>
                  <th>Customer</th>
                  <th>Revenue</th>
                	<%
                }
                else if(request.getParameter("filter") != null && request.getParameter("filter").equals("MostCustRep")){
                    %>
                    <th>Customer Rep</th>
                    <th>Revenue</th>
                  	<%
                }
                else if(request.getParameter("filter") != null && (request.getParameter("filter").equals("FlightNum") || request.getParameter("filter").equals("City") || request.getParameter("filter").equals("Customer"))){
                    %>
                    <th>Reservation Number</th>
                    <th>Revenue</th>
                  	<%
                }
                else {
                %>
                  <th>Reservation Number</th>
                  <th>Date</th>
                  <th>Total Fare</th>
                  <th>Booking Fee</th>
                  <th>Representative SSN</th>
                  <th>Passenger Name</th>
                <%
                }
                %>
                </tr>
              </thead>
              <tbody>
<%        
		try 
		{            
            java.sql.Statement stmt1=conn.createStatement();
        
            if(request.getParameter("filter") != null && request.getParameter("filter").equals("MostCust")){
            	stmt1.execute("CREATE VIEW CustomerRevenue(AccountNo, TotalRevenue) AS SELECT accountNum, SUM(bookingFee) FROM Reservation GROUP BY accountNum");
            	java.sql.ResultSet rs = stmt1.executeQuery(" SELECT CR.AccountNo, P.firstName, P.lastName, CR.TotalRevenue FROM CustomerRevenue CR, Customer C, Person P WHERE CR.AccountNo = C.accountNum AND C.id = P.id  AND CR.TotalRevenue >= (SELECT MAX(TotalRevenue) FROM CustomerRevenue) ");
				while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2) + " " + rs.getString(3)%></td>
                          <td><%= "$" + rs.getString(4)%></td>          		
                        </tr>
    <%      		
            	}
          	    stmt1.execute("DROP VIEW CustomerRevenue;");
            }
            else if(request.getParameter("filter") != null && request.getParameter("filter").equals("MostCustRep")){
            	stmt1.execute("CREATE VIEW CRRevenue(SSN, TotalRevenue) AS SELECT represSSN, SUM(bookingFee) FROM Reservation GROUP BY represSSN ");
	            java.sql.ResultSet rs = stmt1.executeQuery(" SELECT SSN, TotalRevenue FROM CRRevenue WHERE TotalRevenue >= (SELECT MAX(TotalRevenue) FROM CRRevenue)");
			   while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%= "$" + rs.getString(2)%></td>     		
                        </tr>
    <%      		
            	}
          	    stmt1.execute("DROP VIEW CRRevenue;");
            }
            else if(request.getParameter("filter") != null && request.getParameter("filter").equals("FlightNum")){
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT DISTINCT R.resrNum, R.bookingFee FROM Reservation R, Includes I WHERE I.resrNum = R.resrNum AND I.airlineId='" + airlineId + "' AND I.flightNum = '" + value + "'");
	            while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%= "$" + rs.getString(2)%></td>        		
                        </tr>
    <%      		
            	}
            }
            else if(request.getParameter("filter") != null && request.getParameter("filter").equals("City")){
            	stmt1.execute("CREATE VIEW ResrFlightLastLeg(resrNum, airlineId, flightNum, legNum) AS SELECT I.resrNum, I.airlineId, I.flightNum, MAX(I.legNum) FROM Includes I GROUP BY I.resrNum, I.airlineId, I.flightNum;"); 
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT DISTINCT R.resrNum, R.bookingFee FROM Reservation R, Leg L, ResrFlightLastLeg LL, Airport A WHERE R.resrNum = LL.resrNum AND L.airlineId = LL.airlineId AND L.flightNum = LL.flightNum AND L.legNum = LL.legNum AND L.arrAirportId = A.airportId AND A.city = '" + value + "';");
                while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%= "$" + rs.getString(2)%></td>       		
                        </tr>
    <%      		
            	}
                stmt1.execute("DROP VIEW ResrFlightLastLeg;");
            }
            else if(request.getParameter("filter") != null && request.getParameter("filter").equals("Customer") && value!=""){
            	int acctNum = Integer.parseInt(value);
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT DISTINCT R.resrNum, R.bookingFee FROM Reservation R WHERE R.accountNum = " + acctNum);
                while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%= "$" + rs.getString(2)%></td>        		
                        </tr>
    <%      		
            	}
            }
            else if(month!="" || year!=""){
            	int month1 = Integer.parseInt(month)-1;
        		int year1 = Integer.parseInt(year);
        		if(month1 == 12) year1--;
        		
        		int month2 = Integer.parseInt(month)+1;
        		int year2 = Integer.parseInt(year);
        		
        		java.util.Calendar cal = new java.util.GregorianCalendar(year1, month1, 0);
        		
        		java.util.Date date2 = new java.util.Date((year2 - 1900), (month2-1), 1);
        		java.util.Date date1 = cal.getTime();
        		
        		java.text.DateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT R.resrNum, R.resrDate, R.totalFare, R.bookingFee, R.represSSN, P.firstName, P.lastName FROM Reservation R, Customer C, Person P WHERE R.resrDate > '" + sdf.format(date1) + "' AND R.resrDate < '" + sdf.format(date2) + "'  AND R.accountNum = C.accountNum AND C.id = P.id");   	       	  
      	 		while(rs.next())
                {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2)%></td>
                          <td><%="$"+rs.getString(3)%></td>
                          <td><%="$"+rs.getString(4)%></td>  
                          <td><% if(rs.getString(5)==null) out.println("N/A"); else out.println(rs.getString(5));%></td>
                          <td><%=rs.getString(6)%></td>          		
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
    <script src="../../dist/js/bootstrap.min.js"></script>
    <script src="../../assets/js/docs.min.js"></script>
  </body>
</html>
