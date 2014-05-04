<%@ page import="java.sql.*, java.util.Properties, java.util.*, Flights.*" %>
<!DOCTYPE html>
<html>
<body>
	<%
	String from = request.getParameter("flyingfrom");
	String to = request.getParameter("flyingto");
	String flightType = request.getParameter("flightType");
	String departDate = request.getParameter("departing");
	String returnDate = request.getParameter("returning");
	String numOfPassengersStr = request.getParameter("passengers");
	int numOfPassengers = Integer.parseInt(numOfPassengersStr);
	
	request.setAttribute("flightType", flightType);
	request.setAttribute("departing", departDate);
	request.setAttribute("returning", returnDate);
	request.setAttribute("numOfPassengers", numOfPassengersStr);
	
	//Values needed to checkout
	HashMap<String, Integer> passengers = new HashMap<String, Integer>();
	
	
	String mysJDBCDriver = "com.mysql.jdbc.Driver";
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema";
	String mysUserID = "tester";
	String mysPassword = "test";	
	
	Connection conn = null;
	try{
		Class.forName(mysJDBCDriver).newInstance();
		Properties sysprops = System.getProperties();
		sysprops.put("user",mysUserID);
		sysprops.put("password",mysPassword);
		
		conn = DriverManager.getConnection(mysURL,sysprops);
		
		//Handle Airports
		ArrayList<Flights.FlightVertex> airports = new ArrayList<Flights.FlightVertex>();
		HashMap<String, Airport> map = new HashMap<String, Airport>();
		HashMap<String, String> nameToId = new HashMap<String, String>();
		Statement airportsStmt = conn.createStatement();
		String airportsQuery = "SELECT airportId, airportName, city FROM Airport;";
		ResultSet airportResults = airportsStmt.executeQuery(airportsQuery);
		int index = 0;
		while(airportResults.next()){
			Airport airport = new Airport(airportResults.getString(2), airportResults.getString(3));
			map.put(airportResults.getString(1), airport);
			nameToId.put(airportResults.getString(2), airportResults.getString(1));
			airports.add(new FlightVertex(index, airport, null));	
			index++;
		}
		
		int loopMax = 1;
		if(request.getParameter("flightType").equals("MULTDEST")){
			for(int k = 2; k < 5; k++){
				if(request.getParameter("flyingfrom"+k).equals("") || request.getParameter("flyingto"+k).equals("") || request.getParameter("departing"+k).equals("")){
					break;
				}
				else{
					loopMax++;
				}
			}
		}
		
		request.setAttribute("numOfFlights", loopMax);
		//Does flight exist?
		for(int i = 0; i < loopMax; i++){
			if(!(i==0)){
				from = request.getParameter("flyingfrom"+(i+1));
				to = request.getParameter("flyingto"+(i+1));
				departDate = request.getParameter("departing"+(i+1));
			}
			
			request.setAttribute(("flyingfrom"+i), from);
			request.setAttribute(("flyingto"+i), to);
			
			//Graph for flights
			FlightGraph fg = new FlightGraph(airports, map);
			
			Statement possStmt = conn.createStatement();
			String poss = "SELECT l1.airlineId, l1.flightNum, l1.legNum FROM Leg l1 WHERE EXISTS(SELECT DISTINCT flightNum FROM Leg l2 WHERE l2.depAirportId='"+nameToId.get(from)+"' AND l1.flightNum=l2.flightNum) AND depTime>'"+departDate+" 00:00:00' AND depTime<'"+departDate+" 23:59:59';";
			ResultSet possRs = possStmt.executeQuery(poss);
			while(possRs.next()){
			
				//Add all possible edges
				Statement stmt = conn.createStatement(); 
				String query = "SELECT airlineId, flightNum, legNum, depAirportId, arrAirportId, min(depTime), min(arrTime) FROM Leg WHERE airlineId='"+possRs.getString(1)+"' AND flightNum="+possRs.getString(2)+" AND legNum="+possRs.getString(3)+" AND depTime>'"+departDate+" 00:00:00';";
				ResultSet rs = stmt.executeQuery(query);
				while(rs.next()){
					FlightInfo info = new FlightInfo(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(6), rs.getString(7));
					fg.addEdge(rs.getString(4), rs.getString(5), info);
				}
				
			}
			
			LinkedList<FlightVertex> path = fg.getFlightPath(from, to);
			
			if(path == null || path.isEmpty()){
				request.setAttribute("flightErrorMsg", "No flight to destination available!");
				RequestDispatcher rd = request.getRequestDispatcher("../customer/home.jsp");
				rd.forward(request, response);	
				return;
			}
			
			//Check how many different flights exist
			ArrayList<String> diffFlights = new ArrayList<String>();
			ArrayList<String> diffFlightsAirlines = new ArrayList<String>();
			for(int j = 0; j < path.size(); j++){
				String tempFlightNum = path.get(j).getFlightInfo().getFlightNum();
				String tempAirlineId = path.get(j).getFlightInfo().getAirlineId();
				if(!diffFlights.contains(tempFlightNum) || !diffFlightsAirlines.contains(tempAirlineId)){
					diffFlights.add(tempFlightNum);
					diffFlightsAirlines.add(tempAirlineId);
				}
			}
			
			//Are there enough seats on all flights?
			for(int j = 0; j < diffFlights.size(); j++){
				Statement stmt1 = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				String seatsRemainStr = "SELECT COUNT(DISTINCT seatNum) FROM ReservationPassenger R, Includes I WHERE I.resrNum=R.resrNum AND I.airlineId='"+diffFlightsAirlines.get(j)+"' AND I.flightNum="+diffFlights.get(j)+" AND date='"+departDate+"';";
				String flightSeatsStr = "SELECT numOfSeats FROM Flight WHERE airlineId='"+diffFlightsAirlines.get(j)+"' AND flightNum="+diffFlights.get(j)+";";
				ResultSet rs1 = stmt1.executeQuery(seatsRemainStr);
				ResultSet rs2 = stmt2.executeQuery(flightSeatsStr);
				int seatsRemain = 0;
				int flightSeats = 0;
				if(rs1.next()) 
					seatsRemain = Integer.parseInt(rs1.getString(1));
				if(rs2.next())
					flightSeats = Integer.parseInt(rs2.getString(1));
				if((seatsRemain+numOfPassengers) > flightSeats){
					request.setAttribute("flightErrorMsg", "Not enough seats available! Only " + (flightSeats-seatsRemain) + " seats remain!");
					RequestDispatcher rd = request.getRequestDispatcher("../customer/home.jsp");
					rd.forward(request, response);	
					return;
				}
				else{
					passengers.put(("pass"+i), seatsRemain);
				}
			}
			
			//Don't know how else to pass all the values
			session.setAttribute("passengers"+i, passengers);			
			
			request.setAttribute(("path"+i), path);
			request.setAttribute("flightType", flightType);
		}
		
		if(request.getParameter("flightType").equals("ROUNDTRIP")){
			//FIND RETURN FLIGHT
			//Graph for return flight
			FlightGraph fgFrom = new FlightGraph(airports, map);
					
			//Add all possible edges
			Statement stmt = conn.createStatement();
			String legsQuery2 = "SELECT airlineId, flightNum, legNum, depAirportId, arrAirportId, depTime, arrTime FROM Leg WHERE depTime>'"+returnDate+" 00:00:00' AND depTime<'"+returnDate+" 23:59:59';";			
			ResultSet rs = stmt.executeQuery(legsQuery2);
			while(rs.next()){
				FlightInfo info = new FlightInfo(rs.getString(1), rs.getString(2), rs.getString(3), rs.getString(6), rs.getString(7));
				fgFrom.addEdge(rs.getString(4), rs.getString(5), info);
			}
			
			//Get the flight path
			LinkedList<FlightVertex> path2 = fgFrom.getFlightPath(to, from);
			if(path2 == null || path2.isEmpty()){
				request.setAttribute("flightErrorMsg", "No return flight available!");
				RequestDispatcher rd2 = request.getRequestDispatcher("../customer/home.jsp");
				rd2.forward(request, response);	
				return;
			}
			
			
			//Check how many different flights exist
			ArrayList<String> diffFlights = new ArrayList<String>();
			ArrayList<String> diffFlightsAirlines = new ArrayList<String>();
			for(int j = 0; j < path2.size(); j++){
				String tempFlightNum = path2.get(j).getFlightInfo().getFlightNum();
				String tempAirlineId = path2.get(j).getFlightInfo().getAirlineId();
				if(!diffFlights.contains(tempFlightNum) || !diffFlightsAirlines.contains(tempAirlineId)){
					diffFlights.add(tempFlightNum);
					diffFlightsAirlines.add(tempAirlineId);
				}
			}
			
			//Is the max or min length out of range?
			for(int j = 0; j < diffFlights.size(); j++){
				Statement stayStmt = conn.createStatement();
				String stayQuery = "SELECT minLengthOfStay, maxLengthOfStay FROM Flight WHERE airlineId='"+diffFlightsAirlines.get(j)+"' AND flightNum="+diffFlights.get(j)+";";
				ResultSet stayRs = stayStmt.executeQuery(stayQuery);
				
				//Handle dates
				java.text.DateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date date1 = null;
				java.util.Date date2 = null;
				try {
					date1 = sdf.parse(returnDate);
					date2 = sdf.parse(departDate);
				} catch (java.text.ParseException e) {}
				
				int lengthOfStay = (int)((date1.getTime() - date2.getTime()) / (1000 * 60 * 60 * 24) );
				
				//Compare dates
				if(stayRs.next()){
					int minStay = Integer.parseInt(stayRs.getString(1));
					int maxStay = Integer.parseInt(stayRs.getString(2));
					RequestDispatcher rd = request.getRequestDispatcher("../customer/home.jsp");
					if(lengthOfStay < minStay){
						request.setAttribute("flightErrorMsg", "Your stay must be greater than the minimum length of stay! The minimum length of stay is " + minStay);
						rd.forward(request, response);	
						return;
					}
					if(lengthOfStay > maxStay){
						request.setAttribute("flightErrorMsg", "Your stay must be less than the maximum length of stay! The maximum length of stay is " + maxStay);
						rd.forward(request, response);	
						return;
					}
				}
			}
			
			//Are there enough seats on all flights?
			for(int j = 0; j < diffFlights.size(); j++){
				Statement stmt1 = conn.createStatement();
				Statement stmt2 = conn.createStatement();
				String seatsRemainStr = "SELECT COUNT(DISTINCT seatNum) FROM ReservationPassenger R, Includes I WHERE I.resrNum=R.resrNum AND I.airlineId='"+diffFlightsAirlines.get(j)+"' AND I.flightNum="+diffFlights.get(j)+" AND date='"+departDate+"';";
				String flightSeatsStr = "SELECT numOfSeats FROM Flight WHERE airlineId='"+diffFlightsAirlines.get(j)+"' AND flightNum="+diffFlights.get(j)+";";
				ResultSet rs1 = stmt1.executeQuery(seatsRemainStr);
				ResultSet rs2 = stmt2.executeQuery(flightSeatsStr);
				int seatsRemain = 0;
				int flightSeats = 0;
				if(rs1.next()) 
					seatsRemain = Integer.parseInt(rs1.getString(1));
				if(rs2.next())
					flightSeats = Integer.parseInt(rs2.getString(1));
				if((seatsRemain+numOfPassengers) > flightSeats){
					request.setAttribute("flightErrorMsg", "Not enough seats available! Only " + (flightSeats-seatsRemain) + " seats remain!");
					RequestDispatcher rd = request.getRequestDispatcher("../customer/home.jsp");
					rd.forward(request, response);	
					return;
				}
				//Assuming seats on the way back are the same on the way there
				//else{
				//	passengers.put(("pass"+j), seatsRemain+1);
				//}
			}
			
			request.setAttribute("pathFrom", path2);
			
		}
	
		RequestDispatcher rd2 = request.getRequestDispatcher("display_available_flights.jsp");
		rd2.forward(request, response);	
		return;
		
	} catch(Exception e){
		System.out.println(e);
	}
	
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	%>
</body>
</html>