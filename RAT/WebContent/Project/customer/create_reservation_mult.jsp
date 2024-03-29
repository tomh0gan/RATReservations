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

	ArrayList<Res> resrs = (ArrayList<Res>) session.getAttribute("selectedFlight");
	
	ArrayList<Res_Passenger> allPassengers = resrs.get(0).getPassengers();
	ArrayList<Res_Leg> resLegs = allPassengers.get(0).getLegs();
	
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
		resrStmt.execute("START TRANSACTION;");
		//Reservation
		
		String resr = "INSERT INTO Reservation (accountNum, totalFare, bookingFee) VALUES ("+session.getAttribute("accountNum")+", "+request.getParameter("totalFare")+", "+request.getParameter("bookingFee")+");";
		System.out.println(resr);
		resrStmt.addBatch(resr);
		
		if(request.getParameter("bid") != null && request.getParameter("bid").equals("true")){
			resrStmt.addBatch(bidQuery);
		}
		
		for(int i = 0; i < allPassengers.size(); i++){
			
			double costForPass = 0;
			for(int k = 0; k < resrs.size(); k++){
				costForPass += resrs.get(k).getPassengers().get(i).getCost();
			}
			
			//Passenger
			String pass = new String("INSERT INTO reservation_passengers VALUES((SELECT MAX(resrNum) from Reservation), "+(i+1)+", '"+allPassengers.get(i).getPassName()+"', "+costForPass+")");
			System.out.println(pass);
			resrStmt.addBatch(pass);
			for(int k = 0; k < resrs.size(); k++){
				//Get resr
				Res current = resrs.get(k);
				ArrayList<Res_Leg> temp = current.getPassengers().get(i).getLegs();
				for(int j = 0; j < temp.size(); j++){
					ArrayList<Res_Passenger> passengers = current.getPassengers();
					//Reservation Leg
					String resrLeg = new String("INSERT INTO reservation_legs VALUES((SELECT MAX(resrNum) from Reservation), "+(i+1)+", '"+passengers.get(i).getLegs().get(j).getL().getAirlineId()
							+"', "+passengers.get(i).getLegs().get(j).getL().getFlightNum()+", "+passengers.get(i).getLegs().get(j).getL().getLegNum()+", '"+passengers.get(i).getLegs().get(j).getL().getDepDate()
							+"', '"+passengers.get(i).getLegs().get(j).getL().getDepTime()+"', '"+passengers.get(i).getLegs().get(j).getLClass()+"', '"+passengers.get(i).getLegs().get(j).getLType()
							+"', "+passengers.get(i).getLegs().get(j).getSeatNum()+", '"+passengers.get(i).getLegs().get(j).getMeal()+"', "+passengers.get(i).getLegs().get(j).getCost()+")");
					System.out.println(resrLeg);
					resrStmt.addBatch(resrLeg);
				}	
			}
		}
		resrStmt.executeBatch();
		resrStmt.execute("COMMIT;");
		
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