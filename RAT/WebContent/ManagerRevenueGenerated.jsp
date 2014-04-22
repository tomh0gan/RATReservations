<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Manager - View Revenue Generated</title> 
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Most Customer Representative Generated Revenue</h1>
	<br />
	<br />
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
        	
	  	} catch(Exception e)
		{
			e.printStackTrace();
			out.print(e.toString());
		}
   		%>
	<table border="0" cellpadding="0" cellspacing="0" style="margin:0px auto; width:500px; height: 100%;">
    	<tr>
    		<td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
            	<table style="margin: auto;" border="1" id="TABLE1">
            		<tr>
		            	<td style="width: 75px">
		                	<span style="font-size: 10pt">Customer Representative</span>
		           	 	</td>
		                <td style="width: 75px">
		                    <span style="font-size: 10pt">Revenue</span>
		                </td>
		            </tr>  
				<%
				try 
				{     
		            java.sql.Statement stmt=conn.createStatement();
		            stmt.execute("CREATE VIEW CRRevenue(SSN, TotalRevenue) AS SELECT represSSN, SUM(bookingFee) FROM Reservation GROUP BY represSSN ");
		            java.sql.ResultSet rsCustRep = stmt.executeQuery(" SELECT SSN, TotalRevenue FROM CRRevenue WHERE TotalRevenue >= (SELECT MAX(TotalRevenue) FROM CRRevenue)");
				    while(rsCustRep.next()){
						%>
				            <tr>
				                <td style="width: 84px">
				                    <span style="font-size: 10pt"><%=rsCustRep.getString(1)%></span></td>
				                <td style="width: 187px">
				                    <span style="font-size: 10pt"><%= "$" + rsCustRep.getString(2)%></span></td>           		
				            </tr>
						<%      		
				    }
				    stmt.execute("DROP VIEW CRRevenue");
				 } catch(Exception e)
				 {
				   e.printStackTrace();
				   out.print(e.toString());
			     }
				 %>
				 </table>
				 	<br />
				 	<br />
				 	<h1>Most Customer Generated Revenue</h1>
					<br />
					<br />
				 <table style="margin: auto;" border="1" id="TABLE2">
            		<tr>
		            	<td style="width: 75px">
		                	<span style="font-size: 10pt">Customer Account</span>
		           	 	</td>
		                <td style="width: 75px">
		                    <span style="font-size: 10pt">Customer</span>
		                </td>
		                <td style="width: 75px">
		                    <span style="font-size: 10pt">Revenue</span>
		                </td>
		            </tr> 
				 <%
				 try 
				 {
					java.sql.Statement stmt=conn.createStatement();
			     	stmt.execute("CREATE VIEW CustomerRevenue(AccountNo, TotalRevenue) AS SELECT accountNum, SUM(bookingFee) FROM Reservation GROUP BY accountNum");
			     	java.sql.ResultSet rsCust = stmt.executeQuery(" SELECT CR.AccountNo, P.firstName, P.lastName, CR.TotalRevenue FROM CustomerRevenue CR, Customer C, Person P WHERE CR.AccountNo = C.accountNum AND C.id = P.id  AND CR.TotalRevenue >= (SELECT MAX(TotalRevenue) FROM CustomerRevenue) ");
					while(rsCust.next()){
					%>
						<tr>
					    	<td style="width: 84px">
					        	<span style="font-size: 10pt"><%=rsCust.getString(1)%></span></td>
					        <td style="width: 187px">
					        	<span style="font-size: 10pt"><%= rsCust.getString(2) + " " + rsCust.getString(3) %></span></td>
					        <td style="width: 187px">
					        	<span style="font-size: 10pt"><%= "$" + rsCust.getString(4) %></span></td>           		
					    </tr>
					<%      		
					}
				    stmt.execute("DROP VIEW CustomerRevenue");
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