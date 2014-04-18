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
    		var url = "ManagerRevenueSummary.jsp?filter="+filter+"&value="+document.getElementById("value");
    	    window.open(url, '_self');
    	}
    </script>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Revenue Summary Listing</h1>
	<input id="Button1" name="ViewAllFlights" type="button" value="View All Flights" onclick="getFilter('flightNum');" />
	<input id="Button2" name="ViewMostActiveFlights" type="button" value="View Most Active Flights" onclick="getFilter('destCity');" />
	<input id="Button3" name="ViewFlightsByAirport" type="button" value="View Flights By Airport" onclick="getFilter('customer');" />
	<br />
	<br />
	<br />
	<%	
    	String filter = request.getParameter("filter");
		String value = request.getParameter("value");
;
       	if(filter == null){
       		filter = "";
       		value="";
       	}
       	
		request.setAttribute("value", value);
		request.setAttribute("filter", filter);
       	
        if(filter.equals("flightNum")){
       		%>
       			<span>Flight Number: </span>
       			<input type="text" name="FlightNum" id="value" value="${value}" } /> 
       		<% 
       	}
       	else if(filter.equals("destCity")){
       		%>
	   			<span>Destination City: </span>
	   			<input type="text" name="DestCity" id="value" value="${value}" /> 
   			<% 
       	}
       	else if(filter.equals("customer")){
       		%>
	   			<span>Customer Account Number: </span>
	   			<input type="text" name="AccountNum" id="value" value="${value}" /> 
   			<% 
       	}
    %>
	<input ${filter==""?"type='hidden'":""} id="GoButton" name="GoButton" type="button" value="Go" onclick="getInput()" />
	<table border="0" cellpadding="0" cellspacing="0" style="margin:0px auto; width:500px; height: 100%;">
            <tr>
                <td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
                    <table border="1" id="TABLE1">
                    <tr>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Reservation Number</span>
                      </td>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Date</span>
                      </td>
                      <td style="width: 75px">
                      	<span style="font-size: 10pt">Total Fare</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Booking Fee</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Representative SSN</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Passenger Name</span>
                      </td>
                    </tr>   
<%
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
            	java.sql.ResultSet rs;
            	if(false){         		
	        
					//java.sql.ResultSet rs = stmt1.executeQuery();   	       	  
	      	 		while(rs.next()){
%>
                    <tr>
                      <td style="width: 84px">
                          <span style="font-size: 10pt"><%=rs.getString(1)%></span></td>
                      <td style="width: 187px">
                          <span style="font-size: 10pt"><%=rs.getString(2)%></span></td>
                      <td style="width: 74px">
                      	<span style="font-size: 10pt"><%=rs.getString(3)%></span></td>
                      <td>
                      	<span style="font-size: 10pt"><%=rs.getString(4)%></span></td>
                      <td style="width: 7px">
                      	<span style="font-size: 10pt"><% if(rs.getString(5)==null) out.println("N/A"); else out.println(rs.getString(5));%></span></td>
                      <td style="width: 7px">
                      	<span style="font-size: 10pt"><%=rs.getString(6)%></span></td>              		
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