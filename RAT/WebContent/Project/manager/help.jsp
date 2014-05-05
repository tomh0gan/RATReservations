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
			display: block;
		    margin-left: auto;
		    margin-right: auto; 
		}
		.img, .helpSel{
			display: block;
		    margin-left: auto;
		    margin-right: auto; 
		}
		
    </style>
    
    <script>
    	function showMenu(){
    		var helpType = document.getElementById("helpMenu").value;
    		var url = "help.jsp?help=" + helpType;
    		window.open(url, '_self');
    	}
    </script>
    
  </head>
  <body>
  	<% if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	   }
  	   request.setAttribute("helpMenuSelect", request.getParameter("help"));
  	 %>
    <div class="container">
    
      <div class="header">
        <ul class="nav nav-pills pull-right">
        	<li><a href="home.jsp">Home</a></li>
          <li><a href="../logout.jsp">Logout</a></li>
        </ul>
        <h3>RAT Reservations - Manager Help Menu</h3>
      </div>
      
      <br/>
      <br/>
      
      <select id="helpMenu" class="form-control helpSel" style="width: 400px;" onchange="showMenu();" >
      	<option ${helpMenuSelect=='navManHomScr'?"selected":""} value="navManHomScr" >Navigating Manager Home Screen</option>
      	<option ${helpMenuSelect=='manEmp'?"selected":""} value="manEmp" >Managing Employees</option>
      	<option ${helpMenuSelect=='manCus'?"selected":""} value="manCus" >Managing Customers</option>
      	<option ${helpMenuSelect=='manRev'?"selected":""} value="manRev" >Managing Revenue</option>
      	<option ${helpMenuSelect=='manFli'?"selected":""} value="manFli" >Managing Flights</option>
      	<option ${helpMenuSelect=='backup'?"selected":""} value="backup" >Backup Database</option>
      </select>
      
      <br />
      <br />
      
      <%
      if(request.getParameter("help").equals("navManHomScr")){
    	  %>
    	  	<button class="btn btn-lg btn-primary" onclick="window.open('home.jsp','_self');">Go to Home Page</button>
    	  	<br />
    	  	<br />
    	  	<h1>Navigating the Manager Home Screen</h1>
    	  	<br />
    	  	<p>
	    	  	The manager home screen was designed to be simple for easy navigation. It contains five buttons to handle each of the five 
	    	  	different functions a manager can do.
    	  	</p>
    	    <br />
     	    <br />
    	  	<img class="img" src="Images/home_page_empl_button.png" />
    	  	<p>
    	  		The first button, "Manage Employees", will take you to the Manager Employee page. There, 
	    	  	you can create, edit, and delete employees.
    	  	</p>
    	  	<br />
     	    <br />
    	  	<img class="img" src="Images/home_page_rev_button.png" />
    	  	<p>
    	  		The second button, "View Revenue", will take you to the Manager Revenue page. There, 
	    	  	you can view monthly sales reports, view revenue from flights and customers, and other revenue reports.
    	  	</p>
    	  	<br />
     	    <br />
    	  	<img class="img" src="Images/home_page_flights_button.png" />
    	  	<p>
    	  		The third button, "View Flights", will take you to the Manager Flights page. There, 
	    	  	you can view information for flights such as a listing of all flights, view the most active flights, and
	    	  	receive the on-time and delayed flights.
    	  	</p>
    	    <br />
     	    <br />
    	  	<img class="img" src="Images/home_page_cust_button.png" />
    	  	<p>
    	  		The fourth button, "View Customers", will take you to the Manager Customers page. There, 
	    	  	you can create, and delete customers, as well as view their reservations and revenue.
    	  	</p>
    	  	<br />
     	    <br />
    	  	<img class="img" src="Images/home_page_backup_button.png" />
    	  	<p>
    	  		The last button, "Backup Database", will backup the database. A message of success will appear if the 
    	  		backup was successful and a message of failure will appear if the backup fails.
    	  	</p>
    	  <%
      }else if(request.getParameter("help").equals("manEmp")){
    	%>
    	<button class="btn btn-lg btn-primary" onclick="window.open('manager_employee_page.jsp','_self');">Go to Employee Page</button>
    	<br />
    	<br />
  	  	<h1>Navigating the Manager Employee Page</h1>
  	  	<br />
  	  	<p>
	    	  	The Manager Employee Page contains three parts. The top right contains the Home and Logout buttons. The left hand side contains the creation
	    	  	of employees. And lastly, the table contains the employee's information and the edit and delete options. 
  	  	</p>
  	    <br />
   	    <br />
  	  	<img class="img" src="Images/empl_add_button.png" />
  	  	<p>
  	  		The add employee button will take you to a form page where you can enter the information for employees. Make sure you enter the correct information or
  	  		else an error message will appear next to the form. After you hit submit and all the information is validated, you will be brought back to the employee
  	  		page and will see the new employee in the table.
  	  	</p>
  	  	<br />
   	    <br />
  	  	<img class="img" src="Images/empl_table.png" />
  	  	<p>
  	  		On the right hand side of the table, you will see the edit and delete buttons. Clicking the edit button will bring you to a form where you will see that
  	  		employee's personal information. You can edit any of the values, as long as they are valid, and update the employee. Upon update, you will be brought back
  	  		to the employee page. Clicking delete will prompt you, asking if you are sure you want to delete that employee. If you confirm, the employee will be deleted.
  	  	</p>
  	  <%
      }else if(request.getParameter("help").equals("manCus")){
      	%>
      	<button class="btn btn-lg btn-primary" onclick="window.open('manager_customers.jsp','_self');">Go to Customers Page</button>
    	<br />
    	<br />
  	  	<h1>Navigating the Manager Customers Page</h1>
  	  	<br />
  	  	<p>
	    	  	The Manager Customer Page contains three parts. The top right contains the Home and Logout buttons. The left hand side contains the creation
	    	  	of customers. And lastly, the table contains the employee's information and the view reservation, revenue, and delete options. 
  	  	</p>
  	    <br />
   	    <br />
  	  	<img class="img" src="Images/cust_add_button.png" />
  	  	<p>
  	  		The add customer button will take you to a form page where you can enter the information for customers. Make sure you enter the correct information or
  	  		else an error message will appear next to the form. After you hit submit and all the information is validated, you will be brought back to the customer
  	  		page and will see the new customer in the table.
  	  	</p>
  	  	<br />
   	    <br />
  	  	<img class="img" src="Images/cust_table.png" />
  	  	<p>
  	  		On the right hand side of the table, you will see the Reservations, Revenue, and Delete buttons. CLicking the Reservations button will bring you to a page that displays
  	  		all reservations of that customer. Clicking the Revenue button will bring you to a page that displays all the revenue generated from that customer. 
  	  		Clicking delete will prompt you, asking if you are sure you want to delete that customer. If you confirm, the customer will be deleted.
  	  	</p>
  	  <%  
      }else if(request.getParameter("help").equals("manRev")){
       %>
       <button class="btn btn-lg btn-primary" onclick="window.open('manager_revenue_page.jsp','_self');">Go to Revenue Page</button>
    	<br />
    	<br />
      	  <h1>Navigating the Manager Revenue Reports Page</h1>
      	  <br />
      	  <p>
    	    The Manager Revenue Page contains three parts. The top right contains the Home and Logout buttons. The left hand side contains all the reports
    	    for managers to view revenue. And lastly, the table contains all the information depending for the report selected. 
      	  </p>
      	  <br />
       	  <br />
      	  <img class="img" src="Images/rev_reports.png" />
      	  <p>
      	    The menu contains all of the reports a manager can view for revenue. The names are self-explanatory. Some of the buttons require input to retrieve, which
      	    will be explained below.
      	  </p>
      	  <br />
       	  <br />
      	  <img class="img" src="Images/rev_monthy.png" />
      	  <p>
      	  	The monthly sales reports require a selection for month and year to work. Once each selection is chosen, click Go and then the sales report will be produced in the table.
      	  </p>
      	  <br />
       	  <br />
      	  <img class="img" src="Images/rev_flights.png" />
      	  <p>
      	  	The flights report require a selection for flight and airline id to work. Once each selection is chosen, click Go and then the sales report will be produced in the table.
      	  	You can also reach this report by viewing the flights and clicking the revenue button on that page.
      	  </p>
      	  <br />
       	  <br />
      	  <img class="img" src="Images/rev_cust.png" />
      	  <p>
      	  	The customer report require a selection for customer account number to work. Once the selection is chosen, click Go and then the sales report will be produced in the table. 
      	  	You can also reach this page from the manager customers page and clicking on the revenue button.
      	  </p>
      	  <br />
       	  <br />
      	  <img class="img" src="Images/rev_city.png" />
      	  <p>
      	  	The city report require a selection for city to work. Once the selection is chosen, click Go and then the sales report will be produced in the table. 
      	  </p>
      	  <% 	  
      }else if(request.getParameter("help").equals("manFli")){
    	  %>
    	  <button class="btn btn-lg btn-primary" onclick="window.open('manager_flights.jsp','_self');">Go to Flights Page</button>
    	  <br />
    	  <br />
      	  <h1>Navigating the Manager Flights Reports Page</h1>
      	  <br />
      	  <p>
    	    The Manager Flights Page contains three parts. The top right contains the Home and Logout buttons. The left hand side contains all the reports
    	    for managers to view flights. And lastly, the table contains all the information depending for the report selected. 
      	  </p>
      	  <br />
       	  <br />
      	  <img class="img" src="Images/flights_reports.png" />
      	  <p>
      	    The menu contains all of the reports a manager can view for flights. The names are self-explanatory. Some of the buttons require input to retrieve, which
      	    will be explained below.
      	  </p>
      	  <br />
       	  <br />
      	  <img class="img" src="Images/flights_airport.png" />
      	  <p>
      	  	The flights by airport report require a selection for airport to work. Once the selection is chosen, click Go and then the sales report will be produced in the table.
      	  </p>
      	  <%
      }else if(request.getParameter("help").equals("backup")){
    	  %>
    	  <button class="btn btn-lg btn-primary" onclick="window.open('home.jsp','_self');">Go to Home Page</button>
    	  <br />
    	  <br />
    	  <h1>How to backup the database</h1>
      	  <br />
      	  <p>
    	    Simply clicking the backup button will backup the database and produce a .sql file in the location C:/backupdata/ratreservations. 
      	  </p>
    	  <%
      }
      %>      
      
      <br/>
      <br/>
      <br/>
      <footer class="footer">
        <p>RAT Reservations</p>
      </footer>
         
     </div>
    
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
	<script src="../resources/js/bootstrap.min.js"></script>
    
    
  </body>
</html>