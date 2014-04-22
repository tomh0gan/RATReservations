<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Employee - View Customers</title>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Customers</h1>
		<input id="AddButton" type="button" value="Add Customer" onclick="window.open('AddCustomer.jsp','_self');" />
	<table border="0" cellpadding="0" cellspacing="0" style="margin:0px auto; width:500px; height: 100%;">
            <tr>
                <td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
                    <table border="1" id="TABLE1">
                    <tr>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">First Name</span>
                      </td>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Last Name</span>
                      </td>
                      <td style="width: 75px">
                      	<span style="font-size: 10pt">Address</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">City</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">State</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Zip</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Account Number</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Credit Card Number</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Email</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Creation Date</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Rating</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Edit</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Delete</span>
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
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM Customer C, Person P " +
															"WHERE C.id = P.id");
	
				 while(rs.next())
		          {			
		%>
		                    <tr>
		                    	<td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(8)%></span></td>
		                      <td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(9)%></span></td>
		                      <td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(10)%></span></td>
		                      <td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(11)%></span></td>
		                      <td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(12)%></span></td>
		                      <td style="width: 84px">
		                          <span style="font-size: 10pt"><%=rs.getString(13)%></span></td>
		                      <td style="width: 187px">
		                          <span style="font-size: 10pt"><%=rs.getString(2)%></span></td>
		                      <td style="width: 74px">
		                      	<span style="font-size: 10pt"><%=rs.getString(3)%></span></td>
		                      <td>
		                      	<span style="font-size: 10pt"><%=rs.getString(4)%></span></td>
		                      <td style="width: 7px">
		                      	<span style="font-size: 10pt"><%=rs.getString(5)%></span></td>
		                      <td style="width: 7px">
		                      	<span style="font-size: 10pt"><%=rs.getString(6)%></span></td>
		                      <td style="width: 7px">
		                      	<span style="font-size: 10pt"><input type="button" value="Edit"></span></td>
		                      <td style="width: 7px">
		                      	<span style="font-size: 10pt"><input type="button" value="Delete" onclick="javascript:if (confirm('Are you sure that you want to delete the customer?')==true){window.open('DeleteCustomer.jsp?custid=<%=rs.getString(2)%>','_self');return;}"></span></td>              		
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
		  <input id="Button1" type="button" value="Back" onclick="window.open('Employee.jsp','_self');" />
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