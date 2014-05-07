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
    		var url = "employee_help.jsp?help=" + helpType;
    		window.open(url, '_self');
    	}
    </script>
    
  </head>
  <body>
  	
    <div class="container">
    
      <div class="header">
        <ul class="nav nav-pills pull-right">
        	<li><a href="Employee.jsp">Home</a></li>
          <li><a href="../logout.jsp">Logout</a></li>
        </ul>
        <h3>RAT Reservations - Employee Help Menu</h3>
      </div>
      
      <br/>
      <br/>
      
      <select id="helpMenu" class="form-control helpSel" style="width: 400px;" onchange="showMenu();" >
      	<option ${helpMenuSelect=='navEmpHomScr'?"selected":""} value="navEmpHomScr" >Navigating Employee Home Screen</option>
      	<option ${helpMenuSelect=='manCus'?"selected":""} value="manCus" >Managing Cutomers</option>
      	<option ${helpMenuSelect=='recRev'?"selected":""} value="recRev" >Recording Reservations</option>
      	<option ${helpMenuSelect=='prodMail'?"selected":""} value="prodMail" >Producing Customer Mailing List</option>
      	<option ${helpMenuSelect=='revAuc'?"selected":""} value="revAuc" >Reviewing Auctions</option>
      </select>
      
      <br />
      <br />
      
      <%
      if(request.getParameter("help").equals("navEmpHomScr")){
    	  %>
    	  	<button class="btn btn-lg btn-primary" onclick="window.open('Employee.jsp','_self');">Go to Home Page</button>
    	  	<br />
    	  	<br />
    	  	<h1>Navigating the Employee Home Screen</h1>
    	  	<br />
    	  	<p>
	    	  	The employee home screen was designed to be simple for easy navigation. It contains four buttons to handle each of the four 
	    	  	different functions an employee can do.
    	  	</p>
    	    <br />
     	    <br />
    	  	<h3>View Customer Button</h3>
    	  	<p>
    	  		The first button, "View Customers", will take you to the View Customers page. There, 
	    	  	you can create, edit, and delete customers and also produce a flight suggestion list for a given cutomer.
    	  	</p>
    	  	<br />
     	    <br />
    	  	<h3>Record A Reservation Button</h3>
    	  	<p>
    	  		The second button, "Record A Reservation", will take you to the Record Reservation page. There, 
	    	  	you can browse for available flights and make a reservation for a customer using their account number.
    	  	</p>
    	  	<br />
     	    <br />
    	  	<h3>Produce Mailing List Button</h3>
    	  	<p>
    	  		The third button, "Produce Mailing List", will take you to the Customer Mailing List page. There, 
	    	  	you can view all of the relevant mailing information for every customer.
    	  	</p>
    	    <br />
     	    <br />
    	  	<h3>Review Auctions Button</h3>
    	  	<p>
    	  		The fourth button, "Review Auctions", will take you to the Review Auctions page. There, 
	    	  	you can view all pending reverse auctions and accept or decline them.
    	  	</p>
    	  	<br />
     	    <br />
    	  	
    	  <%
      }else if(request.getParameter("help").equals("manCus")){
    	%>
    	<button class="btn btn-lg btn-primary" onclick="window.open('EmployeeViewCustomers.jsp','_self');">Go to View Customers Page</button>
    	<br />
    	<br />
  	  	<h1>Navigating the Customers Page</h1>
  	  	<br />
  	  	<p>
	    	  	The Manager Customers Page contains three parts. The top right contains the Home and Logout buttons. The left hand side contains the creation
	    	  	of customers. And lastly, the table contains the customer's information and the edit, delete, and flight suggestion options. 
  	  	</p>
  	    <br />
   	    <br />
  	  	<h3>Add Customer Button</h3>
  	  	<p>
  	  		The add customer button will take you to a form page where you can enter the information for customers. Make sure you enter the correct information or
  	  		else an error message will appear in an alert box informing you of your mistake. After you hit submit and all the information is validated, you will be brought back to the customers
  	  		page and will see the new customer in the table.
  	  	</p>
  	  	<br />
   	    <br />
  	  	<h3>Edit, Delete, and Flight Suggestion Buttons</h3>
  	  	<p>
  	  		On the right hand side of the table, you will see the edit, delete, and flight suggestion buttons. Clicking the edit button will bring you to a form where you will see that
  	  		customer's personal information. You can edit any of the values, as long as they are valid, and update the customer. Upon update, you will be brought back
  	  		to the customers page. Clicking delete will prompt you, asking if you are sure you want to delete that customer. If you confirm, the customer will be deleted. The 'Go' button
  	  		in each customer's row in the table will bring you to the flight suggestions page and will contain a personalized list of suggested flights for the customer.
  	  	</p>
  	  <%
      }else if(request.getParameter("help").equals("recRev")){
      	%>
      	<button class="btn btn-lg btn-primary" onclick="window.open('.jsp','_self');">Go to Record Reservation Page</button>
    	<br />
    	<br />
  	  	<h1>Navigating the Record Reservation Page</h1>
  	  	<br />
  	  	<p>
	    	  	TBD
  	  	</p>
  	    <br />
   	    <br />
  	  	
  	  	<p>
  	  		TBD
  	  	</p>
  	  	<br />
   	    <br />
  	  	
  	  	<p>
  	  		TBD
  	  	</p>
  	  <%  
      }else if(request.getParameter("help").equals("prodMail")){
       %>
       <button class="btn btn-lg btn-primary" onclick="window.open('EmployeeMailingList.jsp','_self');">Go to Mailing List Page</button>
    	<br />
    	<br />
      	  <h1>Navigating the Mailing List Page</h1>
      	  <br />
      	  <p>
    	    The Mailing List Page contains two parts. The top right contains the Home and Logout buttons. The table contains all of the relevant
    	    mailing information for all customers.
      	  </p>
      	  <br />
       	  <br />
      	  
      	  
      	  <% 	  
      }else if(request.getParameter("help").equals("revAuc")){
    	  %>
    	  <button class="btn btn-lg btn-primary" onclick="window.open('ReviewAuctions.jsp','_self');">Go to Review Auctions Page</button>
    	  <br />
    	  <br />
      	  <h1>Navigating the Review Auctions Page</h1>
      	  <br />
      	  <p>
    	    The Review Auctions Page contains two parts. The top right contains the Home and Logout buttons. The table contains all pending
    	    reverse auction bids that need to be reviewed. Each bid contains the account number of the account that made the bid, the airline id,
    	    the flight number, the date the bid was placed, and the bid amount. 
      	  </p>
      	  <br />
       	  <br />
      	  <h3>The Accept and Reject Buttons</h3>
      	  <p>
      	    In each row for every bid there is an 'Accept' and a 'Reject' button. The 'Accept' button will ask you if you are sure you want to accept the bid
      	    and upon confirmation will accept the bid. The 'Reject' button will ask you if you are sure you want to reject the bid
      	    and upon confirmation will reject the bid.
      	  </p>
      	  <br />
       	  <br />
      	 
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