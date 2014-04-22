<%
	if((request.getParameter("action")!=null)&&	(request.getParameter("action").trim().equals("logout")))
	{
		session.putValue("login","");
		response.sendRedirect("/");
		return;
	}
		String username = request.getParameter("userName");
		String userpasswd = request.getParameter("userPassword");
     	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
     	String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
     	String mysUserID = "tester"; 
    	String mysPassword = "test";
    	
	session.putValue("login","");
	if ((username!=null) &&(userpasswd!=null))
	{
		if (username.trim().equals("") || userpasswd.trim().equals(""))
		{
			response.sendRedirect("main.jsp");
		}
		else
		{
			// code start here
			java.sql.Connection conn=null;
			try {
		        Class.forName(mysJDBCDriver).newInstance();
            	java.util.Properties sysprops=System.getProperties();
            	sysprops.put("user",mysUserID);
            	sysprops.put("password",mysPassword);
        
				//connect to the database
            	conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            	System.out.println("Connected successfully to database using JConnect");
            
            	conn.setAutoCommit(false);
            	java.sql.Statement stmt1=conn.createStatement();
				
            	java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Customer WHERE accountNum='"+username+"'");
				if (rs.next())
				{
					// login success
					session.putValue("login",username);
					response.sendRedirect("Customer.jsp");
				}
				else
				{
					rs = stmt1.executeQuery("SELECT * FROM Employee WHERE id='"+username+"' AND isManager="+false);
					if(rs.next())
					{
						session.putValue("login", username);
						response.sendRedirect("Employee.jsp");
					}
						
					else
					{
						rs = stmt1.executeQuery("SELECT * FROM Employee WHERE id='"+username+"' AND isManager="+true);
						if(rs.next())
						{
							session.putValue("login", username);
							response.sendRedirect("Manager.jsp");
						}
							
						else
						{
							// username or password mistake
							response.sendRedirect("passMistake.jsp");
						}
					}
				}
			} catch(Exception e)
			{
				e.printStackTrace();
			}
			finally{
				try{conn.close();}catch(Exception ee){};
			}
		}
	}
%>