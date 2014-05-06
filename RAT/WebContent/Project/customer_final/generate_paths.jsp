<%@ page import="Flights.*, java.sql.*, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<title>Generate Paths JSP</title>
</head>
<body>
<%
	/* START PATH GENERATING ALGORITHM */
	String depAirport = "SFI";			// Departure Airport
	String arrAirport = "LGA";			// Arrival Airport
	String depDate = "2014-05-05";		// Depature Date
	
	// all valid paths, comprised of legs, between DepAirport & ArrAirport, departing on depDate
	ArrayList<ArrayList<Leg>> paths = new ArrayList<ArrayList<Leg>>();		
	
	// connect to database
	String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
	String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
	String mysUserID = "tester"; 
	String mysPassword = "test";
	
	Connection conn = null;
	try{
		Class.forName(mysJDBCDriver).newInstance();
		java.util.Properties sysprops = System.getProperties();
		sysprops.put("user", mysUserID);
		sysprops.put("password", mysPassword);
		conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
		Statement stmt = conn.createStatement();
		Statement fstmt = conn.createStatement();
		// all valid starts to paths
		ArrayList<Leg> pathStarts = new ArrayList<Leg>();
		
		String q = "SELECT * FROM leg WHERE depAirportId = '" + depAirport + "' AND depDate = '" + depDate + "';";
		ResultSet rs = stmt.executeQuery(q);
		while(rs.next()){
			Leg start = new Leg(rs.getString("airlineId"),rs.getString("flightNum"),
								rs.getString("legNum"),rs.getString("depAirportId"),
								rs.getString("arrAirportId"),rs.getString("depDate"),
								rs.getString("depTime"),rs.getString("arrDate"),
								rs.getString("arrTime"),rs.getDouble("baseFare"));
			if(start.getArrAirportId().equals(arrAirport)){		// if we've found a path to the arrival airport
				ArrayList<Leg> path = new ArrayList<Leg>();		// create a new path
				path.add(start);								// add the start to a path
				paths.add(path);								// add the path of 1 leg to the list of valid paths
			}else{												// otherwise, we need to continue searching this path
				pathStarts.add(start);							// add it to the list of valid starts to paths
			}
		}
		if(pathStarts.isEmpty()){										// there are no starts to a path
			/* NOT HANDLED */
		}else{															// there are starts to a path
			for(Leg start : pathStarts){								// for each start to a path
				q = "SELECT * FROM leg" +
					" WHERE depAirportId='"+ start.getArrAirportId()+"'"+
					" AND" +
					" ((TIMEDIFF(ADDTIME(CONCAT(leg.depDate,' 00:00:00'),leg.depTime)," +
					" ADDTIME(CONCAT('"+start.getArrDate()+"',' 00:00:00'),'"+start.getArrTime()+"')) <= '02:00:00')" +
					" AND" +
					" (TIMEDIFF(ADDTIME(CONCAT(leg.depDate,' 00:00:00'),leg.depTime)," + 
					" ADDTIME(CONCAT('"+start.getArrDate()+"',' 00:00:00'),'"+start.getArrTime()+"')) >= '00:15:00'));";
				rs = stmt.executeQuery(q);
				while(rs.next()){
					Leg next = new Leg(rs.getString("airlineId"),rs.getString("flightNum"),
								rs.getString("legNum"),rs.getString("depAirportId"),
								rs.getString("arrAirportId"),rs.getString("depDate"),
								rs.getString("depTime"),rs.getString("arrDate"),
								rs.getString("arrTime"),rs.getDouble("baseFare"));
					if(next.getArrAirportId().equals(arrAirport)){		// if we've found a path to the arrival airport
						ArrayList<Leg> path = new ArrayList<Leg>();		// create a new path
						path.add(start);								// add the start to a path
						path.add(next);									// add the next to a path
						paths.add(path);								// add the path of 2 legs to the list of valid paths
					}else{												// otherwise, we need to continue searching this path
						String fq = "SELECT * FROM leg" +
								" WHERE depAirportId='"+ next.getArrAirportId()+"'"+
								" AND" +
								" ((TIMEDIFF(ADDTIME(CONCAT(leg.depDate,' 00:00:00'),leg.depTime)," +
								" ADDTIME(CONCAT('"+next.getArrDate()+"',' 00:00:00'),'"+next.getArrTime()+"')) <= '02:00:00')" +
								" AND" +
								" (TIMEDIFF(ADDTIME(CONCAT(leg.depDate,' 00:00:00'),leg.depTime)," + 
								" ADDTIME(CONCAT('"+next.getArrDate()+"',' 00:00:00'),'"+next.getArrTime()+"')) >= '00:15:00'));";
						ResultSet frs = fstmt.executeQuery(fq);
						while(frs.next()){
							Leg fleg = new Leg(frs.getString("airlineId"),frs.getString("flightNum"),
									frs.getString("legNum"),frs.getString("depAirportId"),
									frs.getString("arrAirportId"),frs.getString("depDate"),
									frs.getString("depTime"),frs.getString("arrDate"),
									frs.getString("arrTime"),frs.getDouble("baseFare"));
							if(fleg.getArrAirportId().equals(arrAirport)){				// if we've found a path to the arrival airport
								ArrayList<Leg> path = new ArrayList<Leg>();				// create a new path
								path.add(start);										// add the start to a path
								path.add(next);											// add the next to a path
								path.add(fleg);											// add the final leg to a path
								paths.add(path);										// add the path of 3 legs to the list of valid paths
							}
						}
					}
				}
			}
		}

	} catch(Exception e){
		System.out.println(e);
	} finally {
		try {
			conn.close();
			} catch(Exception ee){ }
	}
	/* END PATH GENERATING ALGORITHM */
	
	System.out.println(paths);
%>
</body>
</html>