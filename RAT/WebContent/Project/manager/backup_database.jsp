<!DOCTYPE html>
<html>
<head>

	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
	
	<title>Rat Reservations - Backup Database</title>
	
	<!-- Bootstrap -->
	<link href="../resources/css/bootstrap.min.css" rel="stylesheet">
	
	<style>
		body, html {
		  padding-top: 20px;
		  padding-bottom: 20px;
		  text-align: center;
		  background-color: #CFCFCF;
		}
		/* Custom page header */
		.header {
		  border-bottom: 1px solid #e5e5e5;
		}
		/* Make the masthead heading the same height as the navigation */
		.header h3 {
		  padding-bottom: 19px;
		  margin-top: 0;
		  margin-bottom: 0;
		  line-height: 40px;
		}
		.footer {
		  padding-top: 19px;
		  border-top: 1px solid #e5e5e5;
		}
		button{
			width: 350px;
		}
		
    </style>
	
</head>
<body>
<% 
  	if(session.getAttribute("manager") == null || !(session.getAttribute("manager").equals("valid"))){
  		  throw new SkipPageException();
  	}

	String mysUserID = "tester"; 
	String mysPassword = "test";
	String databaseName = "rat_schema";
	String resultMsg = "";
	
	String command = "mysqldump -u " + mysUserID + " -p" + mysPassword + " " + databaseName + " > c:\\backupdata\\ratreservations\\backup_rat_schema.sql";
	
	String cmd2 = "C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\mysqldump -u " + mysUserID + " -p" + mysPassword + " " + databaseName + " -r C:\\backupdata\\ratreservations\\backupratschema.sql";
	
	java.io.File file = new java.io.File("C:\\Program Files\\MySQL\\MySQL Server 5.6\\bin\\");
	Process runtimeProcess = Runtime.getRuntime().exec(cmd2);
	int processComplete = runtimeProcess.waitFor();
	if(processComplete == 0){ 
		resultMsg = "Database backup successful!";  
	}
	else {
		resultMsg = "Databse backup failed!";
	}
  	
%>

      <div class="header">
        <h2>RAT Reservations - Backup Database</h2>
      </div>


      <br/>
      <br/>
      
      <h3><%=resultMsg%></h3>
      
      <br/>
      <br/>
      
	  <p>
	    <button type="button" class="btn btn-lg btn-primary" onclick="window.open('home.jsp','_self');">Home</button>
	  </p>
	  
	  <br/>
      <br/>
      <br/>
      <footer class="footer">
        <p>RAT Reservations</p>
      </footer>
	  
</body>
</html>