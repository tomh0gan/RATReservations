<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee - Flight Suggestions</title>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Flight Suggestions</h1>
		
	<table border="0" cellpadding="0" cellspacing="0" align="center" style="margin:0px auto; width:500px; height: 100%;">
            <tr>
                <td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
                    <table border="1" id="TABLE1">
                    <tr>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Airline ID</span>
                      </td>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Flight Number</span>
                      </td>
                      
                    </tr>   
<%
		String accNum = request.getParameter("custid");
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
            	
            	stmt1.executeUpdate("CREATE VIEW FlightReservation(AirlineID, FlightNum, ResrCount) AS SELECT" +
            						" airlineID, flightNum, COUNT(DISTINCT resrNum) FROM Includes GROUP BY AirlineID, FlightNum");
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM FlightReservation FR WHERE NOT EXISTS (SELECT * FROM Reservation R, Includes I WHERE " +
														"R.ResrNum = I.ResrNum AND FR.AirlineID = I.AirlineID AND FR.FlightNum = I.FlightNum AND R.AccountNum = "+accNum+" ) ORDER BY FR.ResrCount DESC");
	
				 while(rs.next())
		          {			
		%>
		                    <tr>
		                    	<td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(1)%></span></td>
		                      <td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(2)%></span></td>
		                      
		                    </tr>
		<%      		
		        	
		          
		          }
				 stmt1.executeUpdate("DROP VIEW FlightReservation");
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
		  <input id="Button1" type="button" value="Back" onclick="window.open('Employee.jsp','_self');" />
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