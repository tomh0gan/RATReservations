<!DOCTYPE html>
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
          <a class="navbar-brand" href="#">RAT Reservations - Receipts</a>
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
            	<td>Reservation Number</td>
            	<td>Customer</td>
            	<td>Customer Account</td>
                <td>Date Created</td>
                <td>Total Fare</td>
                <td>Booking Fee</td>
            </tr>   
        </thead>
        
        <tbody>
<%
		String accNum = request.getParameter("custid");
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
     	String mysUserID = "tester"; 
    	String mysPassword = "test";
        
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
            	
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT R.resrNum, P.firstName, P.lastName, C.accountNum, R.resrCreated, R.totalFare, R.bookingFee FROM Reservation R, Customer C, Person P WHERE R.represSSN='"+session.getAttribute("employeeSSN")+"' AND R.accountNum=C.accountNum AND C.id=P.id;");
				
				int i = 1;
				 while(rs.next())
		          {			
		%>
		                    <tr>
		                    	<td><%=rs.getString(1)%></td>
		                      	<td><%=rs.getString(2) + " " + rs.getString(3)%></td>
		                      	<td><%=rs.getString(4)%></td>
		                      	<td><%=rs.getString(5)%></td>
		                      	<td><%= "$" + rs.getString(6)%></td>
		                      	<td><%= "$" + rs.getString(7)%></td>
		                    </tr>
		<%      		
		        	
		          
		          i++;
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