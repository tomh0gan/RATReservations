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

    <title>RAT Reservations - Employee - View Customers</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/table.css" rel="stylesheet">
</head>

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
          <a class="navbar-brand" href="#">RAT Reservations - Customers</a>
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
          <ul class="nav nav-sidebar">
            <li><a href="AddCustomer.jsp?type=create">Add A Customer</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	

	
	<div class="table-responsive">
	
	<table class="table table-striped">
		<thead>
            <tr>
                <th>First Name</th>
                <th>Last Name</th>
                <th>Address</th>
                <th>City</th>
                <th>State</th>
                <th>Zip</th>
                <th>Account Number</th>
                <th>Credit Card Number</th>
                <th>Email</th>
                <th>Creation Date</th>
                <th>Rating</th>
                <th>Edit</th>
                <th>Delete</th>
                <th>Flight Sugg.</th>
            </tr>
       </thead> 
      <tbody>  
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
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Customer C, Person P " +
															"WHERE C.id = P.id");
	
				 while(rs.next())
		          {			
		%>
		                    <tr>
		                      <td><%=rs.getString(8)%></td>
		                      <td><%=rs.getString(9)%></td>
		                      <td><%=rs.getString(10)%></td>
		                      <td><%=rs.getString(11)%></td>
		                      <td><%=rs.getString(12)%></td>
		                      <td><%=rs.getString(13)%></td>
		                      <td><%=rs.getString(2)%></td>
		                      <td><%=rs.getString(3)%></td>
		                      <td><%=rs.getString(4)%></td>
		                      <td><%=rs.getString(5)%></td>
		                      <td><%=rs.getString(6)%></td>
		                      <td><button type="button" class="btn btn-sm btn-info"  onclick="window.open('EditCustomer.jsp?custid=<%=rs.getString(1)%>','_self')">Edit</button></td>
		                      <td><button type="button" class="btn btn-sm btn-danger"  onclick="return deleteVerify()">Delete</button></td> 
		                      <td><button type="button" class="btn btn-sm btn-info"  onclick="window.open('FlightSuggestions.jsp?custid=<%=rs.getString(2)%>','_self')">Go</button></td>                         		
		                    </tr>
		                   
<script language="javascript" type="text/javascript">
function deleteVerify(){
	if (confirm('Are you sure that you want to delete the customer?') == true){
		window.open('DeleteCustomer.jsp?custid=<%=rs.getString(2)%>','_self')
	}
}
</script>
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
    


    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="../../dist/js/bootstrap.min.js"></script>
<script src="../../assets/js/docs.min.js"></script>   

</body>
</html>