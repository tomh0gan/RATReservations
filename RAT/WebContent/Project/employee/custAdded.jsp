<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%
		/*String firstName = request.getParameter("firstName");
		String lastName = request.getParameter("lastName");
		String address = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zip = request.getParameter("zip");
		String cardNo = request.getParameter("cardNo");
		String email = request.getParameter("email");
		*/
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

			
			DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	   		Date date = new Date();

	   		
	   		String fullDate = dateFormat.format(date);
			
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
									+"','"+request.getParameter("address")+"','"+request.getParameter("city")+"','"+request.getParameter("state")+"','"+request.getParameter("zip")+"')");
							
							java.sql.ResultSet rs = stmt1.executeQuery("SELECT id FROM Person WHERE firstName = '" + request.getParameter("firstName") + "' AND lastName = '"
									+ request.getParameter("lastName")+"'");
							
							rs.next();
							
							stmt1.executeUpdate("INSERT INTO Customer (id, creditCardNum, email, creationDate) VALUES('"+rs.getString(1)+"','"+request.getParameter("cardNo")+"','"+request.getParameter("email")
									+"','"+fullDate+"')");
//							out.print("insert into Student values('"+Id+"','"+Password1+"','"+Name+"','"+request.getParameter("status")+"')");
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

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>RAT Reservations - Customer Added</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <link href="../resources/css/register.css" rel="stylesheet">
    
    <style>
    	.redText{
    		color: red;
    	}
    </style>
</head>
<body">
	<div class="container">
	<h2 class="col-sm-offset-3 form-register-heading">Customer Added!</h2>
	<div class="form-group">
	      <div class="col-sm-offset-3 col-sm-10">
 			<button class="btn btn-default btn-lg" type="button" onclick="window.open('Employee.jsp','_self');">Home</button>
	      </div>
	   
	</div>
	</div>
</body>
</html>