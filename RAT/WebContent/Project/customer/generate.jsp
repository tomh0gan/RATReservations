<%@ page import="Flights.*, java.sql.*, java.text.SimpleDateFormat, java.util.ArrayList, java.util.Calendar" %>
<!DOCTYPE html>
<html>
<head>
</head>
<body>
<%!
	// finds paths
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

	// generates reservations
	public ArrayList<Res> generateReservations(ArrayList<ArrayList<Leg>> paths, String flightType, String classType, int numOfPassengers){
		ArrayList<Res> results = new ArrayList<Res>();
		
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
			
			boolean correctClass;
			int id = 0;
			for(ArrayList<Leg> path : paths){
				correctClass = true;
				Res r = new Res(id);
				for(int i = 1; i <= numOfPassengers; i++){
					Res_Passenger rp = new Res_Passenger(i);
					for(Leg l : path){
						ResultSet rs = stmt.executeQuery("SELECT mult FROM fare_classtype WHERE airlineId='"+l.getAirlineId()+"' AND type='"+classType+"';");
						if(rs.next()){
							Res_Leg rl = new Res_Leg(l, classType, flightType, -1);
						
							double class_mult = rs.getDouble("mult");
							double res_mult = 100.00;
							double adv_mult = 0.00;
							rs = stmt.executeQuery("SELECT mult FROM fare_restype WHERE airlineId='"+l.getAirlineId()+"' AND type='"+flightType+"';");
							if(rs.next()){
								res_mult = rs.getDouble("mult");
							}
							rs = stmt.executeQuery("SELECT MAX(mult) FROM fare_advpurchase WHERE airlineId='"+l.getAirlineId()+"' AND days <= (DATEDIFF(STR_TO_DATE('"+l.getDepDate()+"', '%Y-%m-%d'),CURDATE()));");
							if(rs.next()){
								adv_mult = rs.getDouble("MAX(mult)");
							}
						
							double cost = (l.getBaseFare()*(class_mult/100.00))*(res_mult/100.00);
							cost = cost - (cost*(adv_mult/100.00));
						
							rl.setCost(cost);
							rp.getLegs().add(rl);
						}else{
							correctClass = false;
						}
					}
					r.getPassengers().add(rp);
				}
				if(correctClass){
					results.add(r);
					id++;
				}
			}
		}catch(Exception e){ System.out.println(e);} 
		finally {try {conn.close();} catch(Exception ee){}}
		return results;
	}
%>
<%
	// get general information about search
	String flightType = request.getParameter("flightType");									// 'oneway', 'roundtrip', 'multdest'
	
	// IS IT A PREDETERMINED SEARCH?
	if(flightType.equals("bestSelling")){
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
		String mysUserID = "tester"; 
		String mysPassword = "test";
		
		String depAirportId = "";
		String arrAirportId = "";
		String depDate = "";
		String newFlightType = "oneway";
		String newClassType = "economy";
		int numOfPassengers = 1;
		
		Connection conn = null;
		try{
			Class.forName(mysJDBCDriver).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", mysUserID);
			sysprops.put("password", mysPassword);
			conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery("SELECT RL.airLineId, RL.flightNum, COUNT(*) AS M, L.depDate, L.depAirportId, L.arrAirportId" +
												" FROM reservation_legs RL, Leg L" +
												" WHERE RL.depDate > NOW() AND L.airlineId=RL.airlineId AND L.flightNum=RL.flightNum AND L.legNum=RL.legNum AND L.depDate=RL.depDate" +
												" GROUP BY RL.airLineId" +
												" ORDER BY M DESC" +
												" LIMIT 1;");
			if(rs.next()){
				depAirportId = rs.getString("L.depAirportId");
				arrAirportId = rs.getString("L.arrAirportId");
				depDate = rs.getString("L.depDate");
			}else{
				/* ERROR COMPLETELY HANDLED;  there is no path path */
				request.setAttribute("ReturnedFlightType", "oneway");
				request.setAttribute("SearchError", "No flights found.");
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.forward(request, response);
				return;
			}
		}catch(Exception e){ System.out.println(e);} 
		finally {try {conn.close();} catch(Exception ee){}}
		// handle it just like a one-way
		// find the one way paths
				ArrayList<ArrayList<Leg>> paths = findPaths(depAirportId, arrAirportId, depDate);
				
				if(paths.isEmpty()){
					/* ERROR COMPLETELY HANDLED;  there is no path path */
					request.setAttribute("ReturnedFlightType", "oneway");
					request.setAttribute("SearchError", "No flights found.");
					RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
					rd.forward(request, response);
					return;
				}else{
					ArrayList<Res> results = generateReservations(paths, newFlightType, newClassType, numOfPassengers);
					if(results.isEmpty()){
						/* ERROR COMPLETELY HANDLED;  there is no path path */
						request.setAttribute("ReturnedFlightType", "oneway");
						request.setAttribute("SearchError", "No flights found.");
						RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
						rd.forward(request, response);
						return;
					}else{
						session.setAttribute("results", results);
						response.sendRedirect("view_oneway.jsp"); 
					}
				}
		
		
		return;
	}
	if(flightType.equals("suggest")){
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
		String mysUserID = "tester"; 
		String mysPassword = "test";
		
		String depAirportId = "";
		String arrAirportId = "";
		String newFlightType = "flex";
		String newClassType = "economy";
		int numOfPassengers = 1;
		
		Connection conn = null;
		try{
			Class.forName(mysJDBCDriver).newInstance();
			java.util.Properties sysprops = System.getProperties();
			sysprops.put("user", mysUserID);
			sysprops.put("password", mysPassword);
			conn = java.sql.DriverManager.getConnection(mysURL, sysprops);
			Statement stmt = conn.createStatement();
			
			ResultSet rs = stmt.executeQuery("SELECT L.depAirportId, L.arrAirportId "
					+ "FROM reservation_legs RL, Leg L "
					+ "WHERE RL.resrNum = ( "
					+ "SELECT MAX(R.resrNum) "
					+ "FROM reservation R "
					+ "WHERE R.accountNum = "+session.getAttribute("accountNum")+") "
					+ "AND L.airlineId=RL.airlineId "
					+ "AND L.flightNum=RL.flightNum "
					+ "AND L.legNum=RL.legNum "
					+ "AND L.depDate=RL.depDate "
					+ "AND L.legNum=1;");
			
			if(rs.next()){
				depAirportId = rs.getString("L.depAirportId");
				arrAirportId = rs.getString("L.arrAirportId");
			}else{
				/* ERROR COMPLETELY HANDLED;  no flights were found */
				request.setAttribute("ReturnedFlightType", "oneway");
				request.setAttribute("SearchError", "No flights found.");
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.forward(request, response);
				return;
			}
		}catch(Exception e){ System.out.println(e);} 
		finally {try {conn.close();} catch(Exception ee){}}
		// handle it like mult des for the next 3 months
		Calendar startCal = Calendar.getInstance();
		Calendar endCal = Calendar.getInstance();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    endCal.add(Calendar.MONTH, 2);
	    
	    System.out.println(sdf.format(startCal.getTime()));
	    System.out.println(sdf.format(endCal.getTime()));
	    
		ArrayList<ArrayList<Res>> flexResults = new ArrayList<ArrayList<Res>>();
		
		while(startCal.before(endCal)){
			ArrayList<ArrayList<Leg>> paths = findPaths(depAirportId, arrAirportId, sdf.format(startCal.getTime()));
			
			if(!paths.isEmpty()){
				ArrayList<Res> results = generateReservations(paths, newFlightType, newClassType, numOfPassengers);
				if(!results.isEmpty()){
					flexResults.add(results);
				}
			}
			startCal.add(Calendar.DATE, 1);
		}
		
		if(flexResults.isEmpty()){
			/* ERROR COMPLETELY HANDLED;  no flights were found */
			request.setAttribute("ReturnedFlightType", "oneway");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			request.setAttribute("SearchError", "No flights found.");
			rd.forward(request, response);
			return;
		}
		else {
			// otherwise, send it to the mult flight page
			session.setAttribute("flexResults", flexResults);
			response.sendRedirect("view_flex.jsp");
		}
		return;
	}
	else{
	// OTHERWISE, IT'S A NORMAL SEARCH
	
	String classType = request.getParameter("class");										// 'first','business','economy'
	int numOfPassengers = Integer.parseInt(request.getParameter("numOfPassengers"));		
	
	// one way flights
	if(flightType.equals("oneway")){
		// get information about oneway search
		String depAirportId = request.getParameter("depAirportId");		// depature airport
		String arrAirportId = request.getParameter("arrAirportId");		// arrival airport
		String depDate = request.getParameter("depDate");				// departure date
		
		if(depDate.isEmpty()){
			/* ERROR COMPLETELY HANDLED; depature date is empty */
			request.setAttribute("ReturnedFlightType", "oneway");
			request.setAttribute("SearchError", "Depature date must be selected.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		
		if(depAirportId.equals(arrAirportId)){
			/* ERROR COMPLETELY HANDLED; departure airport and arrival airport are the same */
			request.setAttribute("ReturnedFlightType", "oneway");
			request.setAttribute("SearchError", "Departure airport and arrival airport must be different.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		
		// find the one way paths
		ArrayList<ArrayList<Leg>> paths = findPaths(depAirportId, arrAirportId, depDate);
		
		if(paths.isEmpty()){
			/* ERROR COMPETELY HANDLED;  there is no path path */
			request.setAttribute("ReturnedFlightType", "oneway");
			request.setAttribute("SearchError", "No flights found.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}else{
			ArrayList<Res> results = generateReservations(paths, flightType, classType, numOfPassengers);
			if(results.isEmpty()){
				/* ERROR COMPLETELY HANDLED;  flights were found, but not in the requested class */
				request.setAttribute("ReturnedFlightType", "oneway");
				request.setAttribute("SearchError", "Flights found, but not in requested class.");
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.forward(request, response);
				return;
			}else{
				session.setAttribute("results", results);
				response.sendRedirect("view_oneway.jsp"); 
			}
		}
	}
	// round trip flights
	else if(flightType.equals("roundtrip")){
		// get information about roundtrip Search
		String depAirportId = request.getParameter("depAirportId");
		String arrAirportId = request.getParameter("arrAirportId");
		String depDate = request.getParameter("depDate");
		String retDate = request.getParameter("retDate");
		
		if(depAirportId.equals(arrAirportId)){
			/* ERROR COMPLETELY HANDLED; departure airport and arrival airport are the same */
			request.setAttribute("ReturnedFlightType", "roundtrip");
			request.setAttribute("SearchError", "Departure airport and arrival airport must be different.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		if(depDate.isEmpty() || retDate.isEmpty()){
			/* ERROR COMPLETELY HANDLED; depart date or return date is empty */
			request.setAttribute("ReturnedFlightType", "roundtrip");
			request.setAttribute("SearchError", "Departure date and return date must be selected.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		java.util.Date depDateCompare = new SimpleDateFormat("yyyy-MM-dd").parse(depDate);
		java.util.Date retDateCompare = new SimpleDateFormat("yyyy-MM-dd").parse(retDate);
		if(retDateCompare.before(depDateCompare)){
			/* ERROR COMPLETELY HANDLED; return date is before the departure date */
			request.setAttribute("ReturnedFlightType", "roundtrip");
			request.setAttribute("SearchError", "Departure date must be before return date.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		
		// find the one way path for the departure
		ArrayList<ArrayList<Leg>> dep_paths = findPaths(depAirportId, arrAirportId, depDate);
				
		// find the one way path for the return
		ArrayList<ArrayList<Leg>> ret_paths = findPaths(arrAirportId, depAirportId, retDate);
		
		if(dep_paths.isEmpty() || ret_paths.isEmpty()){
			/* ERROR COMPLETELY HANDLED;  there is no depature path or there is no return path */
			request.setAttribute("ReturnedFlightType", "roundtrip");
			request.setAttribute("SearchError", "No flights found.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}else{
			ArrayList<Res> dep_results = generateReservations(dep_paths, flightType, classType, numOfPassengers);
			ArrayList<Res> ret_results = generateReservations(ret_paths, flightType, classType, numOfPassengers);
			
			if(dep_results.isEmpty() || ret_results.isEmpty()){
				/* ERROR COMPLETELY HANDLED;  flights were found, but not in the requested class */
				request.setAttribute("ReturnedFlightType", "roundtrip");
				request.setAttribute("SearchError", "Flights found, but not in requested class.");
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.forward(request, response);
				return;
			}else{
				session.setAttribute("dep_results", dep_results);
				session.setAttribute("ret_results", ret_results);
				response.sendRedirect("view_roundtrip.jsp"); 
			}
		}
		
	}
	// multi destination flights (returns what we can; if at least one flight is valid it will show results)
	else if(flightType.equals("multdest")){
		String[] depAirportIds = new String[4];
		String[] arrAirportIds = new String[4];
		String[] depDates = new String[4];
		
		depAirportIds[0] = request.getParameter("depAirportId");
		arrAirportIds[0] = request.getParameter("arrAirportId");	
		depDates[0] = request.getParameter("depDate");
		
		for(int i = 1; i < 4; i++){
			depAirportIds[i] = request.getParameter("depAirportId"+i);
			arrAirportIds[i] = request.getParameter("arrAirportId"+i);	
			depDates[i] = request.getParameter("depDate"+i);
		}
		
		boolean[] invalidInput = new boolean[4];
		for(int i = 0; i < 4; i++){
			if(depAirportIds[i].isEmpty()){
				invalidInput[i] = true;
			}
			if(arrAirportIds[i].isEmpty()){
				invalidInput[i] = true;
			}
			if(depDates[i].isEmpty()){
				invalidInput[i] = true;
			}
			if(depAirportIds[i].equals(arrAirportIds[i])){
				invalidInput[i] = true;
			}
		}
		
		int count = 0;
		for(int i = 0; i < 4; i++){
			if(invalidInput[i]){
				count++;
			}
		}
		
		if(count == 4){
			/* ERROR COMPLETELY HANDLED;  all inputs were invalid, meaning either empty or the arr/dep were the same */
			request.setAttribute("ReturnedFlightType", "multdest");
			request.setAttribute("SearchError", "All inputs invalid.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		
		ArrayList<ArrayList<Res>> multResults = new ArrayList<ArrayList<Res>>();
		for(int i = 0; i < 4; i++){
			ArrayList<ArrayList<Leg>> paths = findPaths(depAirportIds[i], arrAirportIds[i], depDates[i]);
			
			if(!paths.isEmpty()){
				ArrayList<Res> results = generateReservations(paths, flightType, classType, numOfPassengers);
				if(!results.isEmpty()){
					multResults.add(results);
				}
			}
		}
		
		if(multResults.isEmpty()){
			/* ERROR COMPLETELY HANDLED;  no flights were found */
			request.setAttribute("ReturnedFlightType", "multdest");
			request.setAttribute("SearchError", "No flights found.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		if(multResults.size() == 1){
			// if the results of a mult flight search is just one flight, send to view_oneway.jsp page
			session.setAttribute("results", multResults.get(0));
			response.sendRedirect("view_oneway.jsp"); 
		} else {
			// otherwise, send it to the mult flight page
			session.setAttribute("multResults", multResults);
			response.sendRedirect("view_multdest.jsp");
		}
	}
	else if(flightType.equals("flex")){
		String depAirportId = request.getParameter("depAirportId");
		String arrAirportId = request.getParameter("arrAirportId");
		String flexDateStart = request.getParameter("flexDateStart");
		String flexDateEnd = request.getParameter("flexDateEnd");

		if(flexDateStart.isEmpty() || flexDateEnd.isEmpty()){
			/* ERROR COMPLETELY HANDLED; flex start or flex end date is empty */
			request.setAttribute("ReturnedFlightType", "flex");
			request.setAttribute("SearchError", "Start date and end date must be selected.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		
		Calendar startCal = Calendar.getInstance();
		Calendar endCal = Calendar.getInstance();
	    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	    startCal.setTime(sdf.parse(flexDateStart));
	    endCal.setTime(sdf.parse(flexDateEnd));

		if(endCal.before(startCal)){
			/* ERROR COMPLETELY HANDLED; flex end date is before flex start date */
			request.setAttribute("ReturnedFlightType", "flex");
			request.setAttribute("SearchError", "Start date must be before end date.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		
		ArrayList<ArrayList<Res>> flexResults = new ArrayList<ArrayList<Res>>();
		
		while(startCal.before(endCal)){
			ArrayList<ArrayList<Leg>> paths = findPaths(depAirportId, arrAirportId, sdf.format(startCal.getTime()));
			
			if(!paths.isEmpty()){
				ArrayList<Res> results = generateReservations(paths, flightType, classType, numOfPassengers);
				if(!results.isEmpty()){
					flexResults.add(results);
				}
			}
			startCal.add(Calendar.DATE, 1);
		}
		
		if(flexResults.isEmpty()){
			/* ERROR COMPLETELY HANDLED;  no flights were found */
			request.setAttribute("ReturnedFlightType", "flex");
			request.setAttribute("SearchError", "No flights found.");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.forward(request, response);
			return;
		}
		else {
			// otherwise, send it to the mult flight page
			session.setAttribute("flexResults", flexResults);
			response.sendRedirect("view_flex.jsp");
		}
		}
	}
%>
</body>
</html>