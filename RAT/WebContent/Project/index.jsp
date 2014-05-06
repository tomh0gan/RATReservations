<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>RAT Reservations - Login</title>

    <!-- Bootstrap core CSS -->
    <link href="resources/css/bootstrap.min.css" rel="stylesheet">

    <link href="resources/css/login.css" rel="stylesheet">
  </head>

  <body>

    <div class="container">
    
    	<h1 class="form-signin" >RAT Reservations</h1><br /><br />

      <form class="form-signin" action="account_authenticate.jsp" method=post>
        <h2 class="form-signin-heading">Login</h2>
        <input name="username" type="text" class="form-control" placeholder="Username" required autofocus>
        <input name="password" type="password" class="form-control" placeholder="Password" required>
        <span style="color: red;" id="loginError">${loginError}</span>
        <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
        <br> Don't have an account? <a href="register.jsp">Register</a>
      </form>
    </div> 
    
    <!-- Debug login info -->
    
    <BR><BR>debug login info
	<TABLE BORDER="1">
	<TR>
	<TD>cooljane1</TD>
	<TD>pw1</TD>
	</TR>
	<TR>
	<TD>cooljohn2</TD>
	<TD>pw2</TD>
	</TR>
	<TR>
	<TD>coolrick3</TD>
	<TD>pw3</TD>
	</TR>
	<TR>
	<TD>annatheemployee</TD>
	<TD>pw4</TD>
	</TR>
	<TR>
	<TD>pattrickmanager</TD>
	<TD>pw5</TD>
	</TR>
	</TABLE>
	

    <br /><br /><img class="img" src="images/important.gif">
  </body>
</html>