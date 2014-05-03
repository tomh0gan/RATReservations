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
	String numOfPassengers = request.getParameter("passengers");
	
	request.setAttribute("flyingfrom", from);
	request.setAttribute("flyingto", to);
	request.setAttribute("flightType", flightType);
	request.setAttribute("departing", departDate);
	request.setAttribute("returning", returnDate);
	request.setAttribute("numOfPassengers", numOfPassengers);
	
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
		
			ArrayList<Flights.FlightVertex> airports = new ArrayList();
			HashMap<String, Airport> map = new HashMap();
			
			Statement stmt1 = conn.createStatement();
			String airportQuery = "SELECT airportId, airportName, city FROM Airport;";
			
			ResultSet rs = stmt1.executeQuery(airportQuery);
			
			int index = 0;
			while(rs.next()){
				Airport airport = new Airport(rs.getString(2), rs.getString(3));
				map.put(rs.getString(1), airport);
				airports.add(new FlightVertex(index, airport, null));	
				index++;
			}
		
	  		if(flightType.equals("ONEWAY")){
			
				FlightGraph fg = new FlightGraph(airports, map);
				
				Statement stmt2 = conn.createStatement();
				String legsQuery = "SELECT airlineId, flightNum, legNum, depAirportId, arrAirportId, depTime, arrTime FROM Leg WHERE depTime>'"+departDate+" 00:00:00' AND depTime<'"+departDate+" 23:59:59';";
				
				ResultSet rs1 = stmt2.executeQuery(legsQuery);
		
				while(rs1.next()){
					FlightInfo info = new FlightInfo(rs1.getString(1), rs1.getString(2), rs1.getString(3), rs1.getString(6), rs1.getString(7));
					fg.addEdge(rs1.getString(4), rs1.getString(5), info);
				}
				
				//Find flight path
				LinkedList<FlightVertex> path = fg.getFlightPath(from, to);
				if(path == null || path.isEmpty()){
					request.setAttribute("flightErrorMsg", "No flight to destination available!");
					RequestDispatcher rd = request.getRequestDispatcher("../customer/home.jsp");
					rd.forward(request, response);	
					return;
				}
				
				//DO ENOUGH SEATS REMAIN?
				//Statement seats = conn.createStatement();
				//String seatsQuery = "SELECT COUNT(DISTINCT seatNum) FROM ReservationPassenger R, Includes I WHERE I.resrNum=R.resrNum AND I.airlineId='"++"' AND I.flightNum='111' AND date='"+departDate+"';";
				
				request.setAttribute("path", path);
				request.setAttribute("flightType", flightType);
				
				RequestDispatcher rd = request.getRequestDispatcher("display_flights.jsp");
				rd.forward(request, response);
				return;
			}
	  		else if(flightType.equals("ROUNDTRIP")){
				FlightGraph fgTo = new FlightGraph(airports, map);
				
				Statement stmt2 = conn.createStatement();
				String legsQuery = "SELECT airlineId, flightNum, legNum, depAirportId, arrAirportId, depTime, arrTime FROM Leg WHERE depTime>'"+departDate+" 00:00:00' AND depTime<'"+departDate+" 23:59:59';";
				
				ResultSet rs1 = stmt2.executeQuery(legsQuery);
		
				while(rs1.next()){
					FlightInfo info = new FlightInfo(rs1.getString(1), rs1.getString(2), rs1.getString(3), rs1.getString(6), rs1.getString(7));
					fgTo.addEdge(rs1.getString(4), rs1.getString(5), info);
				}
				
				//Find flight path
				LinkedList<FlightVertex> path = fgTo.getFlightPath(from, to);
				if(path == null || path.isEmpty()){
					request.setAttribute("flightErrorMsg", "No flight to destination available!");
					RequestDispatcher rd = request.getRequestDispatcher("../customer/home.jsp");
					rd.forward(request, response);
					return;
				}
				
				request.setAttribute("toPath", path);
				request.setAttribute("flightType", flightType);
				
				/////////////////////////////////////////////////////////////////////////////////////////
				
				FlightGraph fgFrom = new FlightGraph(airports, map);
				
				Statement stmt3 = conn.createStatement();
				String legsQuery2 = "SELECT airlineId, flightNum, legNum, depAirportId, arrAirportId, depTime, arrTime FROM Leg WHERE depTime>'"+returnDate+" 00:00:00' AND depTime<'"+returnDate+" 23:59:59';";
				
				ResultSet rs2 = stmt3.executeQuery(legsQuery2);
		
				while(rs2.next()){
					FlightInfo info = new FlightInfo(rs2.getString(1), rs2.getString(2), rs2.getString(3), rs2.getString(6), rs2.getString(7));
					fgFrom.addEdge(rs2.getString(4), rs2.getString(5), info);
				}
				
				//Find flight path
				LinkedList<FlightVertex> pathFrom = fgFrom.getFlightPath(to, from);
				if(pathFrom == null || pathFrom.isEmpty()){
					request.setAttribute("flightErrorMsg", "No return flight available!");
					RequestDispatcher rd2 = request.getRequestDispatcher("../customer/home.jsp");
					rd2.forward(request, response);	
					return;
				}
				
				request.setAttribute("pathFrom", pathFrom);
				
				RequestDispatcher rd2 = request.getRequestDispatcher("display_flights.jsp");
				rd2.forward(request, response);	
				return;
	  		}
		
	} catch(Exception e){
		System.out.println(e);
	}
	finally{
		try{conn.close();} catch(Exception ee){};
	}
	
	%>
</body>
</html>