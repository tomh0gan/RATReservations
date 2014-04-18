<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Manager - View Flights</title> 
    <script>
    	function getFilter(filter){
    		var url = "ManagerRevenueSummary.jsp?filter="+filter;
    	    window.open(url, '_self');
    	}
    	function getInput(){   
    		var url = "";
    		var filter = "<%= request.getParameter("filter") %>";
    		if(filter==="flightNum"){
    			url = "ManagerRevenueSummary.jsp?filter="+filter+"&value="+document.getElementById("value").value+"&airline="+document.getElementById("value2").value;
    		}
    		else{
    			url = "ManagerRevenueSummary.jsp?filter="+filter+"&value="+document.getElementById("value").value;	
    		}
    	    window.open(url, '_self');
    	}
    </script>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Revenue Summary Listing</h1>
	<input id="Button1" name="FlightNum" type="button" value="View By Flight Number" onclick="getFilter('flightNum');" />
	<input id="Button2" name="DestCity" type="button" value="View By Destination City" onclick="getFilter('destCity');" />
	<input id="Button3" name="Customer" type="button" value="View By Customer" onclick="getFilter('customer');" />
	<br />
	<br />
	<br />
	<%	
    	String filter = request.getParameter("filter");
		String value = request.getParameter("value");
		String airlineId = request.getParameter("airline");
	
       	if(filter == null){
       		filter = "";
       	}
       	if(value == null){
       		value="";
       	}
       	if(airlineId == null){
       		airlineId="";
       	}
       	
		request.setAttribute("value", value);
		request.setAttribute("filter", filter);
		request.setAttribute("airline", airlineId);
		
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
	 	String mysUserID = "tester"; 
		String mysPassword = "test";
	    
		String stuId = ""+session.getValue("login");
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
        	
            if(filter.equals("flightNum")){
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
           			<input type="text" name="FlightNum" id="value" value="${value}" /> 
           		<% 
           	}
           	else if(filter.equals("destCity")){
           		rs1 = stmt1.executeQuery("SELECT DISTINCT city FROM airport;");
           		%>
    	   			<span>Destination City: </span>
    	   			<select id="value">
    	   				<option value="">Please select city!</option>
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
    	   			<!-- <input type="text" name="DestCity" id="value" value="${value}" />  -->
       			<% 
           	}
           	else if(filter.equals("customer")){
           		%>
    	   			<span>Customer Account Number: </span>
    	   			<input type="text" name="AccountNum" id="value" value="${value}" /> 
       			<% 
           	}
        
	  	} catch(Exception e)
		{
			e.printStackTrace();
			out.print(e.toString());
		}
   		%>
	<input ${filter==""?"type='hidden'":""} id="GoButton" name="GoButton" type="button" value="Go" onclick="getInput()" />
	<table border="0" cellpadding="0" cellspacing="0" style="margin:0px auto; width:500px; height: 100%;">
    	<tr>
    		<td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
            	<table style="margin: auto;" border="1" id="TABLE1">
            		<tr>
		            	<td style="width: 75px">
		                	<span style="font-size: 10pt">Reservation Number</span>
		           	 	</td>
		                <td style="width: 75px">
		                    <span style="font-size: 10pt">Revenue</span>
		                </td>
		            </tr>  
				<%
				try 
				{     
		            java.sql.Statement stmt2=conn.createStatement();
		            java.sql.ResultSet rs2 = null;
		            if(filter.equals("flightNum")){
		               	rs2 = stmt2.executeQuery("SELECT DISTINCT R.resrNum, R.bookingFee FROM Reservation R, Includes I WHERE I.resrNum = R.resrNum AND I.airlineId='" + airlineId + "' AND I.flightNum = '" + value + "'");
		            }
		            else if(filter.equals("destCity")){
			            java.sql.Statement stmt3=conn.createStatement();
		               	stmt3.execute("CREATE VIEW ResrFlightLastLeg(resrNum, airlineId, flightNum, legNum) AS SELECT I.resrNum, I.airlineId, I.flightNum, MAX(I.legNum) FROM Includes I GROUP BY I.resrNum, I.airlineId, I.flightNum;"); 
		               	rs2 = stmt2.executeQuery("SELECT DISTINCT R.resrNum, R.bookingFee FROM Reservation R, Leg L, ResrFlightLastLeg LL, Airport A WHERE R.resrNum = LL.resrNum AND L.airlineId = LL.airlineId AND L.flightNum = LL.flightNum AND L.legNum = LL.legNum AND L.arrAirportId = A.airportId AND A.city = '" + value + "';");
		            }
		            else if(filter.equals("customer")){
		                try { 
		                    int acctNum = Integer.parseInt(value);
		                    rs2 = stmt2.executeQuery("SELECT DISTINCT R.resrNum, R.bookingFee FROM Reservation R WHERE R.accountNum = " + acctNum);
		                } catch(NumberFormatException e) { 

		                }
		            }
		            if(rs2 != null){
				      	while(rs2.next()){
							%>
				            	<tr>
				                	<td style="width: 84px">
				                    	<span style="font-size: 10pt"><%=rs2.getString(1)%></span></td>
				                    <td style="width: 187px">
				                    	<span style="font-size: 10pt"><%= "$" + rs2.getString(2)%></span></td>           		
				                </tr>
							<%      		
			        	}	
		            }
			      	if(filter.equals("destCity")) stmt2.execute("DROP VIEW ResrFlightLastLeg");
				 } catch(Exception e)
				 {
				   e.printStackTrace();
				   out.print(e.toString());
			     }
				 finally{
				   try{conn.close();}catch(Exception ee){};
				 }
  %>
  				    </table>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
            	</tr>
        </table>
        <input id="Button1" type="button" value="Back" onclick="window.open('ManagerRevenueHomePage.jsp','_self');" />
        <input id="Button2" type="button" value="Logout" onclick="window.open('main.jsp','_self');" />
        <br />
        <span style="font-size: 8pt">
        <br />
        RAT Reservations<br />
        Department of Computer Science<br />
		</span>      
    </strong></span>
</body>
</html>