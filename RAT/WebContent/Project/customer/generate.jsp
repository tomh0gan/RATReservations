<%@ page import="Flights.*, java.sql.*, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%!
	public ArrayList<ArrayList<Leg>> findPaths(String depAirportId, String arrAirportId, String depDate){
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
			
			String q = "SELECT * FROM leg WHERE depAirportId = '" + depAirportId + "' AND depDate = '" + depDate + "';";
			ResultSet rs = stmt.executeQuery(q);
			while(rs.next()){
				Leg start = new Leg(rs.getString("airlineId"),rs.getString("flightNum"),
									rs.getString("legNum"),rs.getString("depAirportId"),
									rs.getString("arrAirportId"),rs.getString("depDate"),
									rs.getString("depTime"),rs.getString("arrDate"),
									rs.getString("arrTime"),rs.getDouble("baseFare"));
				if(start.getArrAirportId().equals(arrAirportId)){	// if we've found a path to the arrival airport
					ArrayList<Leg> path = new ArrayList<Leg>();		// create a new path
					path.add(start);								// add the start to a path
					paths.add(path);								// add the path of 1 leg to the list of valid paths
				}else{												// otherwise, we need to continue searching this path
					pathStarts.add(start);							// add it to the list of valid starts to paths
				}
			}
			if(!pathStarts.isEmpty()){										// there are no starts to a path														// there are starts to a path
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
						if(next.getArrAirportId().equals(arrAirportId)){		// if we've found a path to the arrival airport
							ArrayList<Leg> path = new ArrayList<Leg>();			// create a new path
							path.add(start);									// add the start to a path
							path.add(next);										// add the next to a path
							paths.add(path);									// add the path of 2 legs to the list of valid paths
						}else{													// otherwise, we need to continue searching this path
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
								if(fleg.getArrAirportId().equals(arrAirportId)){				// if we've found a path to the arrival airport
									ArrayList<Leg> path = new ArrayList<Leg>();					// create a new path
									path.add(start);											// add the start to a path
									path.add(next);												// add the next to a path
									path.add(fleg);												// add the final leg to a path
									paths.add(path);											// add the path of 3 legs to the list of valid paths
								}
							}
						}
					}
				}
			}
		} catch(Exception e){
			System.out.println(e);
		} finally {try {conn.close();} catch(Exception ee){}}
		return paths;
	}
%>
<%
	String flightType = request.getParameter("flightType");
	int numOfPassengers = Integer.parseInt(request.getParameter("numOfPassengers"));
	System.out.println(request.getParameter("class"));
	
	if(flightType.equals("oneway")){
		String depAirportId = request.getParameter("depAirportId");
		String arrAirportId = request.getParameter("arrAirportId");
		String depDate = request.getParameter("depDate");
		ArrayList<ArrayList<Leg>> paths = findPaths(depAirportId, arrAirportId, depDate);
		if(paths.isEmpty()){
			response.sendRedirect("home.jsp");
		}else{ 
			ArrayList<Res> results = new ArrayList<Res>();
			
			int pathNum = 0;
			for(ArrayList<Leg> path : paths){
				Res r = new Res(pathNum);
				double cost = 0;
				boolean correctClass = true;
				
				for(int i = 1; i <= numOfPassengers; i++){
					Res_Passenger rp = new Res_Passenger(i);
					for(Leg l : path){

					}
				}
			}
			
			/*
			ArrayList<Res> results = new ArrayList<Res>();
			
			for(ArrayList<Leg> path : paths){
				Res r = new Res(paths.indexOf(path));
				double cost = 0;
				for(int i = 1; i <= numOfPassengers; i++){
					Res_Passenger rp = new Res_Passenger(i);
					for(Leg l : path){
						Res_Leg rl = new Res_Leg(l, "economy", "oneway", -1);
						cost += l.getBaseFare();
						rp.getLegs().add(rl);
					}
					r.getPassengers().add(rp);
				}
				cost = cost + (cost*0.10);	// add booking fee
				r.setCost(cost);			// set default cost for reservation
				results.add(r);
			}
			
			session.setAttribute("results", results);
			response.sendRedirect("view_oneway.jsp"); */
			
			
		}
	}
	else if(flightType.equals("roundtrip")){
		response.sendRedirect("home.jsp");
		/*
		String depAirportId = request.getParameter("depAirportId");
		String arrAirportId = request.getParameter("arrAirportId");
		String depDate = request.getParameter("depDate");
		String retDate = request.getParameter("retDate"); // check if this is null!
		ArrayList<ArrayList<Leg>> dep_paths = findPaths(depAirportId, arrAirportId, depDate);
		ArrayList<ArrayList<Leg>> ret_paths = findPaths(arrAirportId, depAirportId, retDate);
		if(dep_paths.isEmpty() || ret_paths.isEmpty()){
			response.sendRedirect("home.jsp");
		}else{
			
		}*/
	}
	else if(flightType.equals("multdest")){
		response.sendRedirect("home.jsp");
		/*
		String depAirportId1 = request.getParameter("depAirportId1");
		String arrAirportId1 = request.getParameter("arrAirportId1");
		String depDate1 = request.getParameter("depDate1");
		ArrayList<ArrayList<Leg>> paths1 = findPaths(depAirportId1, arrAirportId1, depDate1);
		
		String depAirportId2 = request.getParameter("depAirportId2");
		String arrAirportId2 = request.getParameter("arrAirportId2");
		String depDate2 = request.getParameter("depDate2");
		ArrayList<ArrayList<Leg>> paths2 = findPaths(depAirportId2, arrAirportId2, depDate2);
		
		String depAirportId3 = request.getParameter("depAirportId3");
		String arrAirportId3 = request.getParameter("arrAirportId3");
		String depDate3 = request.getParameter("depDate3");
		ArrayList<ArrayList<Leg>> paths3 = findPaths(depAirportId3, arrAirportId3, depDate3);
		
		String depAirportId4 = request.getParameter("depAirportId4");
		String arrAirportId4 = request.getParameter("arrAirportId4");
		String depDate4 = request.getParameter("depDate4");
		ArrayList<ArrayList<Leg>> paths4 = findPaths(depAirportId4, arrAirportId4, depDate4);
		*/
	}
	
%>
</body>
</html>