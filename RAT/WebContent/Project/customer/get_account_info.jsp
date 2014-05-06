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
				
				int id = (Integer) session.getAttribute("id");				
				
				Statement stmt1 = conn.createStatement();
				String retrieve = "SELECT * FROM Person WHERE id='"+ id +"'";
				java.sql.ResultSet rs = stmt1.executeQuery(retrieve);
				if(rs.next()){
					request.setAttribute("firstName", rs.getString(2));
					request.setAttribute("lastName", rs.getString(3));
					request.setAttribute("address", rs.getString(4));
					request.setAttribute("city", rs.getString(5));
					request.setAttribute("state", rs.getString(6));
					request.setAttribute("zipcode", rs.getString(7));
				}
				
				retrieve = "SELECT creditCardNum, email FROM Customer WHERE id='"+ id +"'";
				java.sql.ResultSet rs2 = stmt1.executeQuery(retrieve);
				if(rs2.next()){
					request.setAttribute("creditcard", rs2.getString(1));
					request.setAttribute("email", rs2.getString(2));
				}
				
				RequestDispatcher fd = request.getRequestDispatcher("account.jsp?");
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