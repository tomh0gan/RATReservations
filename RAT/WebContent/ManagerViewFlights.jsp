 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Manager - View Flights</title>

</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Flights</h1>
	<input id="Button1" name="ViewAllFlights" type="button" value="View All Flights" onclick="window.open('ManagerViewFlights.jsp','_self');" />
	<input id="Button2" name="ViewMostActiveFlights" type="button" value="View Most Active Flights" onclick="window.open('Jsp file here','_self');" />
	<input id="Button3" name="ViewFlightsByAirport" type="button" value="View Flights By Airport" onclick="window.open('ManagerViewFlightsByAirport.jsp','_self');" />
	<input id="Button4" name="ViewOnTimeDelayed" type="button" value="View On-time/Delayed" onclick="window.open('Jsp file here','_self');" />
	<br />
	<br />
        <table border="0" cellpadding="0" cellspacing="0" style="margin:0px auto; width:500px; height: 100%;">
            <tr>
                <td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
                    <table border="1" id="TABLE1">
                    <tr>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Airline</span>
                      </td>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Flight Number</span>
                      </td>
                      <td style="width: 75px">
                      	<span style="font-size: 10pt">Number of Seats</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Operating Days</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Min Length of Stay</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Max Length of Stay</span>
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
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Flight");
      	       	  
      	  while(rs.next())
          {
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
                      	<span style="font-size: 10pt"><%=rs.getString(5)%></span></td>
                      <td style="width: 7px">
                      	<span style="font-size: 10pt"><%=rs.getString(6)%></span></td>              		
                    </tr>
<%      		
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
        <input id="Button1" type="button" value="Back" onclick="window.open('Manager.jsp','_self');" />
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
