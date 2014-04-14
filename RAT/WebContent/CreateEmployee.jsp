<%
		String Id = request.getParameter("Id");
		String Name = request.getParameter("Name");
		String Password1 = request.getParameter("Password1");
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://sbcstldb.cs.stonybrook.edu:3306/cse305ta"; 
     	String mysUserID = "lopes"; 
    	String mysPassword = "111";
    	
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
				stmt1.executeUpdate("INSERT INTO Person (firstName, lastName, address, city, state, zipCode) VALUES('"+request.getParameter("firstName")+"','"+request.getParameter("lastName")
								+"','"+request.getParameter("address")+"','"+request.getParameter("city")+"','"+request.getParameter("state")+"','"+request.getParameter("zipCode")"')");
				stmt1.close();
			} catch(Exception e)
			{
				e.printStackTrace();
				out.print(e.toString());
			}
			finally{
			
				try{conn.close();}catch(Exception ee){};
			}
/*
	}
*/
%>

User Added!
<a href="index.htm"><font color="Blue">Home</font></a>