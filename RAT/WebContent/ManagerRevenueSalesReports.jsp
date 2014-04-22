<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
    <title>Manager - View Flights</title>  
    <script>
    	function getDropdown(){
    		var month=document.getElementById("MonthDropdown").value;
    		var year=document.getElementById("YearDropdown").value;
    		var url = "ManagerRevenueSalesReports.jsp?month="+month+"&year="+year;
    	    window.open(url, '_self');
    	}
    </script>
    <%	
    	String month = request.getParameter("month");
       	String year = request.getParameter("year");
       	if(month == null){
       		month = "";
       		year = "";
       	}
       	
       	request.setAttribute("month", month);
       	request.setAttribute("year", year);
       	
     %>
</head>
<body style="text-align: center" bgcolor="#E8E8E8">
	<h1>Sales Reports</h1>
	<br />
	<br />
	<span class="monthSpan">Month: </span>
	<select id="MonthDropdown" name="MonthDropdown">
		<option value="">Select a Month</option>
		<option ${month=="01"?"selected='selected'":""} value="01">January</option>
		<option ${month=="02"?"selected='selected'":""} value="02">February</option>
		<option ${month=="03"?"selected='selected'":""} value="03">March</option>
		<option ${month=="04"?"selected='selected'":""} value="04">April</option>
		<option ${month=="05"?"selected='selected'":""} value="05">May</option>
		<option ${month=="06"?"selected='selected'":""} value="06">June</option>
		<option ${month=="07"?"selected='selected'":""} value="07">July</option>
		<option ${month=="08"?"selected='selected'":""} value="08">August</option>
		<option ${month=="09"?"selected='selected'":""} value="09">September</option>
		<option ${month=="10"?"selected='selected'":""} value="10">October</option>
		<option ${month=="11"?"selected='selected'":""} value="11">November</option>
		<option ${month=="12"?"selected='selected'":""} value="12">December</option>		
	</select>
	<span class="yearSpan">Year: </span>
	<select id="YearDropdown" name="YearDropdown">
		<option value="">Select a Year</option>
		<option ${year=="2010"?"selected='selected'":""} value="2010">2010</option>
		<option ${year=="2011"?"selected='selected'":""} value="2011">2011</option>
		<option ${year=="2012"?"selected='selected'":""} value="2012">2012</option>
		<option ${year=="2013"?"selected='selected'":""} value="2013">2013</option>
		<option ${year=="2014"?"selected='selected'":""} value="2014">2014</option>	
	</select>
	<input id="GoButton" name="GoButton" type="button" value="Go" onclick="getDropdown()" />
	<table border="0" cellpadding="0" cellspacing="0" style="margin:0px auto; width:500px; height: 100%;">
            <tr>
                <td style="vertical-align: Center; width: 11237px; text-align: left; height: 454px;">
                    <table border="1" id="TABLE1">
                    <tr>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Reservation Number</span>
                      </td>
                      <td style="width: 75px">
                          <span style="font-size: 10pt">Date</span>
                      </td>
                      <td style="width: 75px">
                      	<span style="font-size: 10pt">Total Fare</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Booking Fee</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Representative SSN</span>
                      </td>
                      <td style="width: 75px">
                        <span style="font-size: 10pt">Passenger Name</span>
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
            	
            	if(month!="" || year!=""){         		
            	
	        		int month1 = Integer.parseInt(month)-1;
	        		int year1 = Integer.parseInt(year);
	        		if(month1 == 12) year1--;
	        		
	        		int month2 = Integer.parseInt(month)+1;
	        		int year2 = Integer.parseInt(year);
	        		
	        		java.util.Calendar cal = new java.util.GregorianCalendar(year1, month1, 0);
	        		
	        		java.util.Date date2 = new java.util.Date((year2 - 1900), (month2-1), 1);
	        		java.util.Date date1 = cal.getTime();
	        		
	        		java.text.DateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
	        
					java.sql.ResultSet rs = stmt1.executeQuery("SELECT R.resrNum, R.resrDate, R.totalFare, R.bookingFee, R.represSSN, P.firstName, P.lastName FROM Reservation R, Customer C, Person P WHERE R.resrDate > '" + sdf.format(date1) + "' AND R.resrDate < '" + sdf.format(date2) + "'  AND R.accountNum = C.accountNum AND C.id = P.id");   	       	  
	      	 		while(rs.next()){
%>
                    <tr>
                      <td style="width: 84px">
                          <span style="font-size: 10pt"><%=rs.getString(1)%></span></td>
                      <td style="width: 187px">
                          <span style="font-size: 10pt"><%=rs.getString(2)%></span></td>
                      <td style="width: 74px">
                      	<span style="font-size: 10pt"><%=rs.getString(3)%></span></td>
                      <td>
                      	<span style="font-size: 10pt"><%=rs.getString(4)%></span></td>
                      <td style="width: 7px">
                      	<span style="font-size: 10pt"><% if(rs.getString(5)==null) out.println("N/A"); else out.println(rs.getString(5));%></span></td>
                      <td style="width: 7px">
                      	<span style="font-size: 10pt"><%=rs.getString(6)%></span></td>              		
                    </tr>
<%      		
		        	}
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
        <input id="Button1" type="button" value="Back" onclick="window.open('ManagerRevenueHomePage.jsp','_self');" />
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