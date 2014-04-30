<%@ page import="java.sql.*, java.util.Properties, java.util.*, Flights.*" %>
<!DOCTYPE html>
<html>
<body>
	<%
	String from = request.getParameter("from");
	String to = request.getParameter("to");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
	String numOfPassengers = request.getParameter("numOfPassengers");
	
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
		
		FlightGraph fg = new FlightGraph(airports, map);
		
		Statement stmt2 = conn.createStatement();
		String legsQuery = "SELECT airlineId, flightNum, legNum, depAirportId, arrAirportId FROM Leg";
		
		ResultSet rs1 = stmt2.executeQuery(legsQuery);
		while(rs1.next()){
			fg.addEdge(rs1.getString(4), rs1.getString(5), new FlightInfo(rs1.getString(1), rs1.getString(2), rs1.getString(3)));
		}
		
		//out.println(fg.printVertices());
		//out.println(fg.printEdges());
		
		from = "Los Angeles International";
		to = "Tokyo International";
		
		LinkedList<FlightVertex> path = fg.getFlightPath(from, to);
		for(int i = 0; i < path.size(); i++){
			out.println(path.get(i).getAirport().getAirportName());
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