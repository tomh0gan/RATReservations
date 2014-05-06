<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>RAT Reservations - Employee - Flight Suggestions</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/table.css" rel="stylesheet">
<body>
	<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">RAT Reservations - Flight Suggestions</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <button type="button" class="form-control" onclick="window.open('Employee.jsp','_self');">Home</button>
          </form>
        </div>
      </div>
    </div>
    
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          
        </div>
    <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
    
    <div class="table-responsive">
		
	<table class="table table-striped">
		<thead>
            <tr>
                <td>Airline ID</td>
                <td>Flight Number</td>
            </tr>   
        </thead>
        
        <tbody>
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
		                    	<td><%=rs.getString(1)%></td>
		                      	<td><%=rs.getString(2)%></td>
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
		  	</tbody>
		  </table>
		  </div>

        <br />
        <span style="font-size: 8pt">
        <br />
        RAT Reservations<br />
        Department of Computer Science<br />
		</span>      
    </strong></span>
</body>

</html>