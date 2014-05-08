<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Rat Reservations - Customer Help Menu</title>

    <!-- Bootstrap -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">
    
    <style>
		body, html {
		  padding-top: 20px;
		  padding-bottom: 20px;
		  text-align: center;
		  background-color: #FFFFFF;
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
	<!-- START NAV -->
	<div class="container">
		<div class="navbar navbar-default" style="margin-top: 20px;">
			<div class="container-fluid">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse"
						data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span> <span
							class="icon-bar"></span> <span class="icon-bar"></span> <span
							class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="#">RAT Reservations</a>
				</div>
				<div class="navbar-collapse collapse">
					<ul class="nav navbar-nav">
						<li class="active"><a href="home.jsp">Find Flights</a></li>
						<li><a href="view_reservations.jsp">View Reservations</a></li>
						<li><a href="view_bids.jsp">View Bids</a></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
						<li><a href="help.jsp">Help</a></li>
						<li><a href="get_account_info.jsp">My Account (<%=session.getAttribute("username")%>)
						</a></li>
						<li><div>
						<a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a>
						</div></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<!-- END NAV -->
	<div class="container">
	<br/>
    <br/>
      
    <select id="helpMenu" class="form-control helpSel" style="width: 400px;" onchange="showMenu();" >
      <option ${helpMenuSelect=='navCusHomScr'?"selected":""} value="navCusHomScr" >Navigating the Customer Pages</option>
      <option ${helpMenuSelect=='searchFli'?"selected":""} value="searchFli" >How to Search For Flights</option>
      <option ${helpMenuSelect=='createRes'?"selected":""} value="createRes" >How to Create a Reservation</option>
      <option ${helpMenuSelect=='viewRes'?"selected":""} value="viewRes" >Viewing Active/Past Reservations</option>
      <option ${helpMenuSelect=='viewBid'?"selected":""} value="viewBid" >How to View the Status of My Bids</option>
      <option ${helpMenuSelect=='"bidRes"'?"selected":""} value="bidRes" >How to Bid for a Reservation</option>
    </select>
      
    <br />
    <br />
    
    <%
      if(request.getParameter("help").equals("navCusHomScr")){
    	  %>
    	  	<!--<button class="btn btn-lg btn-primary" onclick="window.open('','_self');"></button>-->
    	  	<br />
    	  	<br />
    	  	<h1>Navigating the Customer Pages</h1>
    	  	<br />
    	  	<p>
    	  		The navigation for customers can be found on the top of the page. Customers can find flights for their reservation, view their current and past
    	  		reservations, view their bid history, and more. All of these functionalities can be found on the navigation menu on the top of the page. 
    	  	</p>
    	  	<p>
    	  		Customers may also edit their account info, which they can by clicking on their account button on the right hand side of the navigation menu. This
    	  		brings you to a page where you can view your current information and are given the option to edit anything, besides username. 
    	  	</p>
    	  	<p>
    	  		Please read through the other help pages to learn get more specific information about the several capabilities customers have. 
    	  	</p>
    	    <br />
     	    <br />
    	  <%
      }else if(request.getParameter("help").equals("searchFli")){
    	%>
    	<!--<button class="btn btn-lg btn-primary" onclick="window.open('','_self');"></button>-->
    	<br />
    	<br />
  	  	<h1>How to Search For Flights</h1>
  	  	<br />
  	  	<p>
  	  		The home page for Customers is the Find Flights page. If you navigate away from it, you can get back to it by clicking the Find Flights button
  	  		in the navigation menu.
  	  	</p>
  	  	<p>
  	  		1) The first step to find a flight is to choose whether you want to search a One-way, Round-trip, Multi-Destination, or Flexible-Date Trip. A
  	  		multi-destination trip allows you to go several places over a period of time. A flexible-date allows you to choose a range of dates and select the flight
  	  		from the available flights.
  	  	</p>
  	  	<p>
  	  		2) After choosing your type of flight, you now enter in your departing airport/city and choose the airport/city you would like to fly to. Then you choose the
  	  		date you would like to travel. If you chose roundtrip or flexible-date, there will be two date inputs, specifying when you would like to return and the range 
  	  		you would like to search for, respectively. You will also need to select the number of passengers for the trip as well as the class you desire. If you chose multiple
  	  		 destination, you will have more options of departure and arrival. Click search after you are done. If the flight is available, you will be brought to a page where you 
  	  		 choose the flight you want, otherwise an error message will appear indicating what went wrong.
  	  	</p>
  	    <br />
   	    <br />
  	  <%
      }else if(request.getParameter("help").equals("createRes")){
      	%>
      	<!--<button class="btn btn-lg btn-primary" onclick="window.open('','_self');"></button>-->
    	<br />
    	<br />
  	  	<h1>How to Create a Reservation</h1>
  	  	<br />
  	  	<p>
  	  		To create a reservation, you will first need to search for a flight, so please see that help guide if you want to learn more about it.
  	  	</p>
  	  	<p>
  	  		After you select your flight, you will be asked to enter the passenger names and meals for the flight. You will also be given the seat number
  	  		and price for the flight. After you enter all the information required, you can choose to buy or bid the flight. Buying the flight will bring
  	  		you to a confirmation page where you can confirm or cancel. Clicking bid will bring you to the bid page where you can bid a price for the whole
  	  		reservation. Please see that help guide for more information. If you clicked buy, clicking confirm on the confirmation page will purchase the flight. 
  	  		If you want to cancel it, go to the view reservations page (assuming the trip hasn't occurred yet) and click the cancel button. 
  	  	</p>
  	    <br />
   	    <br />
  	  <%  
      }else if(request.getParameter("help").equals("viewRes")){
       %>
       <!--<button class="btn btn-lg btn-primary" onclick="window.open('','_self');"></button>-->
    	<br />
    	<br />
      	  <h1>Viewing Active/Past Reservations</h1>
      	  <br />
      	  <br />
       	  <br />
      	  <p>
      	  	To view your current reservations and past reservations, click the view reservations button at the top of the page located in the navigation menu. 
      	  	This will bring you to a page that shows you your active reservations and past reservations. You can click each of the reservations to view more
      	  	information about them (i.e. price, departure date, etc.). You are also given the option to cancel any of the current reservations. 
      	  </p>
      	  <br />
       	  <br />

      	  <% 	  
      }else if(request.getParameter("help").equals("viewBid")){
    	  %>
    	  <!--<button class="btn btn-lg btn-primary" onclick="window.open('','_self');"></button>-->
    	  <br />
    	  <br />
      	  <h1>How to View the Status of My Bids</h1>
      	  <br />
      	  <p>
			To view the status of your bids, click the view bids button at the top of the page located in the navigation menu. This will bring you to a page that displays
			your bids. Next to each bid, a status of accepted, denied, and pending will appear. If your status is pending, that means a customer representative is currently
			looking over it and waiting to approve or decline it. If your status is accepted, that means your bid for that reservation was accepted! If the status is denied, 
			you were not granted that reservation and will have to make another bid or buy the reservation.  
      	  </p>
      	  <br />
       	  <br />
      	  <%
      }else if(request.getParameter("help").equals("bidRes")){
    	  %>
    	 <!--<button class="btn btn-lg btn-primary" onclick="window.open('','_self');"></button>-->
    	  <br />
    	  <br />
    	  <h1>How to Bid for a Reservation</h1>
      	  <br />
      	  <p> 
      	  	To bid for a reservation, you must click the bid button on the passenger information page (see how to make a reservation for more information). Once there, you will be asked
      	  	to enter your bid for that reservation. Clicking confirm bid will process your bid and you will be able to monitor the status in the view bids page (see How to View the Status of My 
      	  	Bids for more information).  	    
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