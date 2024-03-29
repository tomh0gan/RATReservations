<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee Home Page</title>
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
          <li><a href="employee_help.jsp?help=navEmpHomScr">Help</a></li>
          <li><a href="../logout.jsp">Logout</a></li>
        </ul>
        <h3>RAT Reservations - Employee</h3>
      </div>
	<button type="button" class="btn btn-lg btn-primary" onclick="window.open('EmployeeViewCustomers.jsp','_self');" />View Customers</button>
	<br />
	<br />
	<button type="button" class="btn btn-lg btn-primary" onclick="window.open('RecordReservation.jsp','_self');" />Record A Reservation</button>
	<br />
	<br />
	<button type="button" class="btn btn-lg btn-primary" onclick="window.open('EmployeeMailingList.jsp','_self');" />Produce Mailing List</button>
	<br />
	<br />
	<button type="button" class="btn btn-lg btn-primary" onclick="window.open('ReviewAuctions.jsp','_self');" />Review Auctions</button>
	<br />
	<br />
	<button type="button" class="btn btn-lg btn-primary" onclick="window.open('EmployeeReceipts.jsp','_self');" />My Receipts</button>
	<br />
	<br />
	<button type="button" class="btn btn-lg btn-primary" onclick="window.open('ViewEmployeePage.jsp','_self');" />View Employees</button>
	<br />
	<br />

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