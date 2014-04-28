<%@ page import="java.sql.*, java.util.Properties" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
	<%

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
				
				String id = request.getParameter("id");
				String firstName = "";
				String lastName = "";
				String address = "";
				String city = "";
				String state = "";
				String zipcode = "";
				
				
				Statement stmt1 = conn.createStatement();
				String retrieve = "SELECT * FROM Person WHERE id='"+ id +"'";
				java.sql.ResultSet rs = stmt1.executeQuery(retrieve);
				if(rs.next()){
					firstName = rs.getString(2);
					lastName = rs.getString(3);
					address = rs.getString(4);
					city = rs.getString(5);
					state = rs.getString(6);
					zipcode = rs.getString(7);
				}
				
				String ssn = "";
				String isManager = "";
				String startDate = "";
				String hourlyRate = "";
				
				retrieve = "SELECT * FROM Employee WHERE id='"+ id +"'";
				java.sql.ResultSet rs2 = stmt1.executeQuery(retrieve);
				if(rs2.next()){
					ssn = rs2.getString(2);
					isManager = rs2.getString(3);
					startDate = rs2.getString(4);
					hourlyRate = rs2.getString(5);
				}
				String emplType = "employee";
				if(isManager.equals("1")) emplType = "manager";
				
				session.setAttribute("EmployeeId", id);
				session.setAttribute("EmployeeFName", firstName);
				session.setAttribute("EmployeeLName", lastName);
				session.setAttribute("EmployeeSSN", ssn);
				session.setAttribute("OldEmployeeSSN", ssn);
				session.setAttribute("EmployeeAddress", address);
				session.setAttribute("EmployeeCity", city);
				session.setAttribute("EmployeeState", state);
				session.setAttribute("EmployeeZip", zipcode);
				session.setAttribute("EmployeeEmplType", emplType);
				session.setAttribute("EmployeeHourlyRate", hourlyRate);
				
				RequestDispatcher fd = request.getRequestDispatcher("employee_info.jsp?type=edit");
				fd.forward(request, response);
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