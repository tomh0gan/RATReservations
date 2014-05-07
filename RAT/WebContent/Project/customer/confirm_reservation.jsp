<%@ page import="java.util.*, java.text.DecimalFormat, java.text.SimpleDateFormat, java.sql.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>RAT - Passenger Info</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<!-- START SCRIPT --> 
<script>
	function updateName(nameId, size, index){
		var val = document.getElementById(nameId).value;
		for(var i = 0; i < size; i++){
			document.getElementById("passName"+i+""+index).value = val;
		}
	}
</script>
<!-- END SCRIPT --> 
</head>
<body>
<!-- START NAV -->
<div class="container">
	<div class="navbar navbar-default" style="margin-top:20px;">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="#">RAT Reservations</a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav">
					<li class="active"><a href="home.jsp">Find Flights</a></li>
					<li><a href="view_reservations.jsp">View Reservations</a></li>
					<li><a href="#">View Bids</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="get_account_info.jsp">My Account (<%=session.getAttribute("username")%>)</a></li>
					<li><div><a class="btn btn-default navbar-btn" href="../logout.jsp">Log out</a></div></li>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- END NAV --><br><br>
<!-- START PAGE -->
<%
	DecimalFormat df = new DecimalFormat("#.00");

	Res res = (Res) session.getAttribute("selectedFlight");
	
	ArrayList<Res_Passenger> passengers = res.getPassengers();
	ArrayList<Res_Leg> resLegs = passengers.get(0).getLegs();
			
	//Enter in the meals
	for(int i = 0; i < resLegs.size(); i++){
		for(int j = 0; j < passengers.size(); j++){
			passengers.get(j).getLegs().get(i).setMeal(request.getParameter("passMeal"+i+""+j));
		}
	}
	
	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
	String mysUserID = "tester"; 
	String mysPassword = "test";
	
	Connection conn=null;
	try{	
		Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops=System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
		
		conn = java.sql.DriverManager.getConnection(mysURL,sysprops);
	%>
	<div class="container">

	</div>
	
<%		
	} catch(Exception e){
		System.out.println(e);
	} finally {
		try {
			conn.close();
			} catch(Exception ee){ }
	}
%>
<!-- END PAGE -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="../resources/js/bootstrap.min.js"></script>
</body>
</html>