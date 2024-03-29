<%@ page import="java.util.*, java.text.DecimalFormat, java.text.SimpleDateFormat, java.sql.*, Flights.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>jsp file</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
<!-- START SCRIPT --> 
<script>
</script>
<!-- END SCRIPT --> 
</head>
<body>
<%
	DecimalFormat df = new DecimalFormat("#.00");

	Res res = (Res) session.getAttribute("selectedFlight");
	
	ArrayList<Res_Passenger> passengers = res.getPassengers();
	ArrayList<Res_Leg> resLegs = passengers.get(0).getLegs();	
	
	String bidQuery = "";
	if(request.getParameter("bid") != null && request.getParameter("bid").equals("true")){
		String bid = request.getParameter("bidPrice");
		bidQuery = "INSERT INTO reverse_bid (resrNum, accountNum, bid) VALUES ((SELECT MAX(resrNum) from Reservation), "+session.getAttribute("accountNum")+", "+bid+");";
		
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

		Statement resrStmt = conn.createStatement();
		Statement passStmt = conn.createStatement();
		Statement legStmt = conn.createStatement();
		
		//Reservation
		String resr = "INSERT INTO Reservation (accountNum, totalFare, bookingFee) VALUES ("+session.getAttribute("accountNum")+", "+df.format(res.getCost())+", "+df.format(res.getBookingFee())+");";
		System.out.println(resr);
		resrStmt.addBatch(resr);
		
		if(request.getParameter("bid") != null && request.getParameter("bid").equals("true")){
			resrStmt.addBatch(bidQuery);
		}
		
		for(int i = 0; i < passengers.size(); i++){
			
			//Passenger
			String pass = new String("INSERT INTO reservation_passengers VALUES((SELECT MAX(resrNum) from Reservation), "+(i+1)+", '"+passengers.get(i).getPassName()+"', "+passengers.get(i).getCost()+")");
			System.out.println(pass);
			resrStmt.addBatch(pass);
			
			for(int j = 0; j < resLegs.size(); j++){
				
				//Reservation Leg
				String resrLeg = new String("INSERT INTO reservation_legs VALUES((SELECT MAX(resrNum) from Reservation), "+(i+1)+", '"+passengers.get(i).getLegs().get(j).getL().getAirlineId()
						+"', "+passengers.get(i).getLegs().get(j).getL().getFlightNum()+", "+passengers.get(i).getLegs().get(j).getL().getLegNum()+", '"+passengers.get(i).getLegs().get(j).getL().getDepDate()
						+"', '"+passengers.get(i).getLegs().get(j).getL().getDepTime()+"', '"+passengers.get(i).getLegs().get(j).getLClass()+"', '"+passengers.get(i).getLegs().get(j).getLType()
						+"', "+passengers.get(i).getLegs().get(j).getSeatNum()+", '"+passengers.get(i).getLegs().get(j).getMeal()+"', "+passengers.get(i).getLegs().get(j).getCost()+")");
				System.out.println(resrLeg);
				resrStmt.addBatch(resrLeg);
			}
		}
		resrStmt.executeBatch();
		
		if(request.getParameter("bid") != null && request.getParameter("bid").equals("true")){
			response.sendRedirect("view_bids.jsp");
		}
		else{
			response.sendRedirect("view_reservations.jsp");	
		}
		
		
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