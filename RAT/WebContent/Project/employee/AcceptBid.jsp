<%
		String accNum = request.getParameter("accNum");
		String airlineId = request.getParameter("airId");
		String flightNum = request.getParameter("flightNum");
		String classType = request.getParameter("classType");
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
		String mysUserID = "tester"; 
		String mysPassword = "test";

/*    	
	if ((username!=null) &&(userpasswd!=null))
	{
		if (username.trim().equals("") || userpasswd.trim().equals(""))
		{
			response.sendRedirect("index.htm");
		}
		else
		{
*/
			// code start here
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
				stmt1.executeUpdate("UPDATE Auctions SET accepted = '1' WHERE accountNum = '"+accNum+"' AND airlineId = '"+airlineId+"' AND flightNum = '"+flightNum+"' AND class = '"+classType+"'");
			} catch(Exception e)
			{
				e.printStackTrace();
				out.print(e.toString());
			}
			finally{
				try{conn.close();
				}
				catch(Exception ee){
					
				};
				
				
			}
			
/*
	}
*/
%>


<html>
<head>
<script language="javascript" type="text/javascript">
function load(){
	window.open("ReviewAuctions.jsp","_self")	
}
</script>
</head>

<body onload="load()">

Customer Deleted!
</body>
</html>
