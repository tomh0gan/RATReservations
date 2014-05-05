
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>RAT Reservations - Manager - Customers</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/table.css" rel="stylesheet">
    
    <script>
    	function deleteCustomer(name, id, accountNum){
    		var resp=confirm("Are you sure you want to delete " + name + "?");
    		if (resp==true){
    			window.open("delete_customer.jsp?id=" + id + "&accountNum=" + accountNum, '_self'); 
    		}
    	}
    </script>
    
  </head>

  <body>
  	<% if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	   }
  	 %>
    <div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">RAT Reservations - Active Customers</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
          	<li><a href="help.jsp?help=manCus">Help</a></li>
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <button type="button" class="form-control" onclick="window.open('home.jsp','_self');">Home</button>
          </form>
        </div>
      </div>
    </div>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          <ul class="nav nav-sidebar">
            <li><a href="create_customer.jsp?type=managerCreate">Add a Customer</a></li>
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
	    <h2 class="sub-header">Customers</h2> 
	      
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Account</th>
                  <th>First Name</th>
                  <th>Last Name</th>
                  <th>Address</th>
                  <th>City</th>
                  <th>State</th>
                  <th>Email</th>
                  <th>Rating</th>
                  <th>Reservations</th>
                  <th>Revenue</th>
                  <th>Delete</th>
                </tr>
              </thead>
              <tbody>
<%
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
        
            java.sql.ResultSet rs = stmt1.executeQuery("SELECT C.accountNum, P.firstName, P.lastName, P.address, P.city, P.state, C.email, C.rating, P.id FROM Person P, Customer C WHERE P.id=C.id");
  	       	 	            	
          	while(rs.next())
            {
    %>
                        <tr>
                          <td><%=rs.getString(1)%></td>
                          <td><%=rs.getString(2)%></td>
                          <td><%=rs.getString(3)%></td>
                          <td><%=rs.getString(4)%></td>
                          <td><%=rs.getString(5)%></td>
                          <td><%=rs.getString(6)%></td>
                          <td><%=rs.getString(7)%></td>
                          <td><% if(rs.getString(8) == null) out.println("N/A"); else out.println(rs.getString(8)); %></td>
                          <td><button type="button" class="btn btn-sm btn-primary" onclick="window.open('reservations.jsp?view=customers&fname=<%=rs.getString(2)%>&lname=<%=rs.getString(3)%>', '_self')" >Reservations</button></td>
                          <td><button type="button" class="btn btn-sm btn-success" onclick="window.open('manager_revenue_page.jsp?filter=Customer&value=<%=rs.getString(1)%>','_self')">Revenue</button></td>
                          <td><button type="button" class="btn btn-sm btn-danger" onclick="deleteCustomer('<%=rs.getString(2)%> <%=rs.getString(3)%>', '<%=rs.getString(9)%>', '<%=rs.getString(1)%>');" >Delete</button></td>             		
                          <td>   
                          <td></td>
                          <td></td>             		
                        </tr>
    <%      		
            }
  		} catch(Exception e)
		{
			e.printStackTrace();
			out.print(e.toString());
		}
		finally
		{
			try{conn.close();}catch(Exception ee){};
		}

  %>
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </div>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
  </body>
</html>
