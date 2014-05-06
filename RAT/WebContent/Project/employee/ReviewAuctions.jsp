<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
                <th>Account Number</th>
                <th>Airline Id</th>
                <th>Flight Number</th>
                <th>Class</th>
                <th>Date</th>
                <th>NYOP</th>
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
        
				java.sql.ResultSet rs = stmt1.executeQuery("SELECT * FROM auctions A " +
															"WHERE A.accepted IS NULL");
	
				 while(rs.next())
		          {			
		%>
		                    <tr>
		                      <td><%=rs.getString(1)%></td>
		                      <td><%=rs.getString(2)%></td>
		                      <td><%=rs.getString(3)%></td>
		                      <td><%=rs.getString(4)%></td>
		                      <td><%=rs.getString(5)%></td>
		                      <td><%=rs.getString(6)%></td>
		                      <td><button type="button" class="btn btn-sm btn-info"  onclick="return acceptBid()">Accept</button></td>
		                      <td><button type="button" class="btn btn-sm btn-danger"  onclick="return rejectBid()">Reject</button></td> 
		                                               		
		                    </tr>
		                   
<script language="javascript" type="text/javascript">
function acceptBid(){
	if (confirm('Are you sure that you want to accept the bid?') == true){
		window.open('AcceptBid.jsp?accNum=<%=rs.getString(1)%>&airId=<%=rs.getString(2)%>&flightNum=<%=rs.getString(3)%>&classType=<%=rs.getString(4)%>','_self')
	}
}
</script>

<script language="javascript" type="text/javascript">
function rejectBid(){
	if (confirm('Are you sure that you want to reject the bid?') == true){
		window.open('RejectBid.jsp?accNum=<%=rs.getString(1)%>&airId=<%=rs.getString(2)%>&flightNum=<%=rs.getString(3)%>&classType=<%=rs.getString(4)%>','_self')
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