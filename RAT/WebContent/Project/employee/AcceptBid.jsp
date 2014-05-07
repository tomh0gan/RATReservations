<%
		String resrNum = request.getParameter("resrNum");
		String accountNum = request.getParameter("accountNum");
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
				stmt1.executeUpdate("UPDATE reverse_bid SET status = 'accepted' WHERE resrNum = '"+resrNum+"' AND accountNum = '"+accountNum+"'");
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
