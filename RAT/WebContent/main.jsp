<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
	function Button1_onclick() {
		if(document.loginForm.userName.value == "") 
    		alert("UserName Can Not Be Null!")
		javascript:myForm.submit()
		}

		function Button2_onclick() {
    		window.open("RegisterPage.htm","_self");
		}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1>Login</h1>
	<form id="loginForm" name="loginForm" action="login.jsp" method="post">
		<span style="font-size: 10pt">User ID :</span>
        <input id="userName" name="userName" type="text" />
        &nbsp; 
        <span style="font-size: 10pt">Password:</span>
        <input id="userPassword" name="userPassword" type="password" />
        &nbsp;
        <input id="Button1" style="width: 70px" type="button" value="Log In" onclick="return Button1_onclick()" />
        &nbsp;
        <input id="Button2" style="width: 70px" type="button" value="Register" onclick="return Button2_onclick()" /><br />
        <br />
	</form>
</body>
</html>