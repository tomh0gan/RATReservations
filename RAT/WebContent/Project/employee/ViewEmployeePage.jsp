<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>RAT Reservations - Employee - Employees</title>

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
          <a class="navbar-brand" href="#">RAT Reservations - Employees</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="employee_help.jsp?help=navEmpHomScr">Help</a></li>
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
          </ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        
	    <h2 class="sub-header">Employees</h2> 
	      
          <div class="table-responsive">
            <table class="table table-striped">
              <thead>
                <tr>
                  <th>Name</a></th>
                  <th>SSN</th>
                  <th>Position</th>
                  <th>Start Date</a></th>
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
            
            java.sql.Statement stmt1=conn.createStatement();
        
            java.sql.ResultSet rs = stmt1.executeQuery("SELECT P.firstName, P.lastName, E.ssn, E.isManager, E.startDate FROM Person P, Employee E WHERE P.id=E.id;");
  	       	 	            	
          	while(rs.next())
            {
        		  String position = "";
          		  if(Integer.parseInt(rs.getString(4)) == 0){
          			  position = "Employee";
          		  }
          		  else if(Integer.parseInt(rs.getString(4)) == 1){
          			  position = "Manager";
          		  }
    %>
                        <tr>
                          <td><%=rs.getString(1) + " " + rs.getString(2)%></td>
                          <td><%="*******"+rs.getString(3).substring(7)%></td>
                          <td><%=position%></td>
                          <td><%=rs.getString(5)%></td>              		
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
