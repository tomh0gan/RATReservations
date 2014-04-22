 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Manager - View Employees</title>

</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Employees</h1>
	<br />
	<br />
        <table border="0" cellpadding="0" cellspacing="0" style="margin:0px auto; width:500px; height: 100%;">
            <tr>
                <td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
                    <table border="1" id="TABLE1">
                    <tr>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Name</span>
                      </td>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Last name</span>
                      </td>
                      <td style="width: 75px">
                      	<span style="font-size: 10pt">SSN</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Position</span>
                      </td>
                      <td style="width: 175px">
                        <span style="font-size: 10pt">Start Date</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Hourly Rate</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Edit</span>
                      </td>
                    </tr>   
<%
		String mysJDBCDriver = "com.mysql.jdbc.Driver"; 
		String mysURL = "jdbc:mysql://localhost:3306/rat_schema"; 
     	String mysUserID = "tester"; 
    	String mysPassword = "test";
        
        String stuId = ""+session.getValue("login");
  			java.sql.Connection conn=null;
			try 
			{
            	Class.forName(mysJDBCDriver).newInstance();
    			java.util.Properties sysprops=System.getProperties();
    			sysprops.put("user",mysUserID);
    			sysprops.put("password",mysPassword);
        
				//connect to the database
            	conn=java.sql.DriverManager.getConnection(mysURL,sysprops);
            	System.out.println("Connected successfully to database using JConnect");
            
            	java.sql.Statement stmt1=conn.createStatement();
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT P.firstName, P.lastName, E.ssn, E.isManager, E.startDate, E.hourlyRate FROM Person P, Employee E WHERE P.id=E.id;");
      	       	
      	  while(rs.next())
          {
      		  String position = "";
      		  if(Integer.parseInt(rs.getString(4)) == 0){
      			  position = "Employee";
      		  }
      		  else if(Integer.parseInt(rs.getString(4)) == 1){
      			  position = "Manager";
      		  }
%>
                    <tr>
                      <td style="width: 75px">
                          <span style="font-size: 10pt"><%=rs.getString(1)%></span></td>
                      <td style="width: 75px">
                          <span style="font-size: 10pt"><%=rs.getString(2)%></span></td>
                      <td style="width: 75px">
                      	<span style="font-size: 10pt"><%=rs.getString(3)%></span></td>
                      <td>
                      	<span style="font-size: 10pt"><%= position %></span></td>
                      <td style="width: 175px">
                      	<span style="font-size: 10pt"><%=rs.getString(5)%></span></td>
                      <td style="width: 75px">
                      	<span style="font-size: 10pt"><%=rs.getString(6)%></span></td>     
                      <td style=  "width: 50px">
                      	<button type=submit>Edit</button>    		
                    </tr>
<%      		
        	}
  			} catch(Exception e)
			{
				e.printStackTrace();
				out.print(e.toString());
			}
			finally{
			
				try{conn.close();}catch(Exception ee){};
			}

  %>
  					</table>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
            	</tr>
        </table>
        <input id="Button1" type="button" value="Back" onclick="window.open('ManagerEmployeePage.jsp','_self');" />
        <input id="Button2" type="button" value="Logout" onclick="window.open('main.jsp','_self');" />
        <br />
        <span style="font-size: 8pt">
        <br />
        RAT Reservations<br />
        Department of Computer Science<br />
		</span>      
    </strong></span>
</body>
</html>
