<%@ page import="java.text.DecimalFormat" %>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="shortcut icon" href="../../assets/ico/favicon.ico">

    <title>RAT Reservations - Employee - Review Auctions</title>

    <!-- Bootstrap core CSS -->
    <link href="../resources/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="../resources/css/table.css" rel="stylesheet">
</head>

<body>
<div class="navbar navbar-inverse navbar-fixed-top">
      <div class="container-fluid">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="#">RAT Reservations - Review Auctions</a>
        </div>
        <div class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li><a href="../logout.jsp">Logout</a></li>
          </ul>
          <form class="navbar-form navbar-right">
            <button type="button" class="form-control" onclick="window.open('Employee.jsp','_self');">Home</button>
          </form>
        </div>
      </div>
    </div>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
          
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
	

	
	<div class="table-responsive">
	
	<table class="table table-striped">
		<thead>
            <tr>
                <th>Reservation Number</th>
                <th>Account Number</th>
                <th>Original Cost</th>
				<th>Customer Bid</th>
				<th>Recommended Minimum Cost</th>
                <th>Accept</th>
				<th>Reject</th>
            </tr>
       </thead> 
      <tbody>  
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
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT R.resrNum, R.accountNum, R.totalFare, R.bookingFee, A.bid FROM Reservation R, Reverse_bid A WHERE R.resrNum=A.resrNum AND R.accountNum=A.accountNum AND A.status = 'pending';");
	
				DecimalFormat df = new DecimalFormat("#.00");
				
				while(rs.next())
				{ 
					 String totalFare = rs.getString(3);
					 String bookingFee = rs.getString(4);
					 double total = Double.parseDouble(totalFare) + Double.parseDouble(bookingFee);
		%>
		                    <tr>
		                      <td><%=rs.getString(1)%></td>
		                      <td><%=rs.getString(2)%></td>
		                      <td><%="$" + total %></td>
							  <td><%="$" + rs.getString(5)%></td>
							  <td><%= "$" + (total*.75) %></td>
		                      <td><button type="button" class="btn btn-sm btn-info"  onclick="return acceptBid()">Accept</button></td>
		                      <td><button type="button" class="btn btn-sm btn-danger"  onclick="return rejectBid()">Reject</button></td> 
		                                               		
		                    </tr>
		                   
<script language="javascript" type="text/javascript">
function acceptBid(){
	if (confirm('Are you sure that you want to accept the bid?') == true){
		window.open('AcceptBid.jsp?resrNum=<%=rs.getString(1)%>&accountNum=<%=rs.getString(2)%>','_self')
	}
}
</script>

<script language="javascript" type="text/javascript">
function minBid(x){
	var y = parseInt(x);
	return y*.8
}
</script>

<script language="javascript" type="text/javascript">
function rejectBid(){
	if (confirm('Are you sure that you want to reject the bid?') == true){
		window.open('RejectBid.jsp?resrNum=<%=rs.getString(1)%>&accountNum=<%=rs.getString(2)%>','_self')
	}
}
</script>
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
		  		</tbody>
            </table>
          </div>

        <br />
        <span style="font-size: 8pt">
        <br />
        RAT Reservations<br />
        Department of Computer Science<br />
		</span>      
    </strong></span>
    


    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script src="../../dist/js/bootstrap.min.js"></script>
<script src="../../assets/js/docs.min.js"></script>   

</body>
</html>