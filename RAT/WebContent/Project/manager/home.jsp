<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Rat Reservations - Manager</title>

    <!-- Bootstrap -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
		body, html {
		  padding-top: 20px;
		  padding-bottom: 20px;
		  text-align: center;
		  background-color: #CFCFCF;
		}
		/* Custom page header */
		.header {
		  border-bottom: 1px solid #e5e5e5;
		}
		/* Make the masthead heading the same height as the navigation */
		.header h3 {
		  padding-bottom: 19px;
		  margin-top: 0;
		  margin-bottom: 0;
		  line-height: 40px;
		}
		.footer {
		  padding-top: 19px;
		  border-top: 1px solid #e5e5e5;
		}
		button{
			width: 350px;
		}
		
    </style>
  </head>
  <body>
    <div class="container">
    
      <div class="header">
        <ul class="nav nav-pills pull-right">
          <li><a href="../logout.jsp">Logout</a></li>
        </ul>
        <h3>RAT Reservations - Manager</h3>
      </div>
      
      <br/>
      <br/>
      
	  <p>
	    <button type="button" class="btn btn-lg btn-primary" onclick="window.open('manager_employee_page.jsp','_self');">Manage Employees</button>
	  </p>
	  <p>
	    <button type="button" class="btn btn-lg btn-primary" onclick="window.open('manager_revenue_page.jsp','_self');">View Revenue</button>
	  </p>	  
	  <p>
	    <button type="button" class="btn btn-lg btn-primary" onclick="window.open('manager_flights.jsp','_self');">View Flights</button>
	  </p>     
	  <p>
	    <button type="button" class="btn btn-lg btn-primary" onclick="window.open('manager_customers.jsp','_self');">View Customers</button>
	  </p>    
      
      <br/>
      <br/>
      <br/>
      <footer class="footer">
        <p>RAT Reservations</p>
      </footer>
         
     </div>
    
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="js/bootstrap.min.js"></script>
    
    
  </body>
</html>