<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
            .textbox{
                color: #222222;
                font-family: Arial, Helvetica, sans-serif;
                text-decoration: none;
                font-size: 12px;
                border-right: 1px solid #000000; 
                border-left: 1px solid #000000; 
                border-top: 1px solid #000000; 
                border-bottom: 1px solid #000000;
                width: 150px;
            }
            
            .leftAlign{
                text-align: left;
            }
            
            .spn1{
                font-family: Verdana, Arial, Helvetica, sans-serif;
                size:2;
            }
            
            .redText{
				color:red;
			}
</style>
<script>
		function clearErrorMsg(errorMsgTagId){
    		document.getElementById(errorMsgTagId).innerHTML = "";
		}

		function checkField(id, errorId){
			if(document.getElementById(id, errorId).value == ""){
				document.getElementById(errorId).innerHTML = "Please Enter A Correct Value.";
				return false;
			}
			else{
				document.getElementById(errorId).innerHTML = "";
				return true;
			}
		}
		
		function checkFields(){
			if(checkField("firstName", "fNameError") == false){
				return false;
			}
			else if(checkField("lastName", "lNameError") == false){
				return false;
			}
			else if(checkField("address", "addressError") == false){
				return false;
			}
			else if(checkField("city", "cityError") == false){
				return false;
			}
			else if(checkField("state", "stateError") == false){
				return false;
			}
			else if(checkField("zip", "zipError") == false){
				return false;
			}
			else if(checkField("emplType", "emplTypeError") == false){
				return false;
			}
			else if(checkField("hourlyRate", "hourlyRateError") == false){
				return false;
			}
			else{
				return true;
			}
		}
</script>
</head>
<body bgcolor="#E8E8E8">
	<h1  style="text-align: center; font-family: Verdana, Arial, Helvetica, sans-serif;">Add Employee</h1>
	<br />
	<br />
	<form id="Form1" name="CreateEmpForm" action="CreateEmployee.jsp" method="post" onsubmit="return checkFields()">
		<table id="Table1" style="margin:0px auto; width:500px; height: 100%;">
			<tr>
				<td class="leftAlign">
					<span class="spn1">First name:</span>
					<input id="firstName" name="firstName" class="textbox" size="35" type="text" oninput="return clearErrorMsg('fNameError')">&nbsp;&nbsp;<span class="redText" id="fNameError"></span>
				</td>
			</tr>
			<tr>
				<td class="leftAlign">
					<span class="spn1">Last name:</span>
					<input id="lastName" name="lastName" class="textbox" size="35" type="text" oninput="clearErrorMsg('lNameError')">&nbsp;&nbsp;<span class="redText" id="lNameError"></span>
				</td>
			</tr>
			<tr>
				<td class="leftAlign">
					<span class="spn1">Address:</span>
					<input id="address" name="address" class="textbox" size="35" type="text" oninput="clearErrorMsg('addressError')">&nbsp;&nbsp;<span class="redText" id="addressError"></span>
				</td>
			</tr>
			<tr>
				<td class="leftAlign">
					<span class="spn1">City:</span>
					<input id="city" name="city" class="textbox" size="35" type="text" oninput="clearErrorMsg('cityError')">&nbsp;&nbsp;<span class="redText" id="cityError"></span>
				</td>
			</tr>
			<tr>
				<td class="leftAlign">
					<span class="spn1">State:</span>
					<select id="state" name="state" class="textbox" oninput="clearErrorMsg('stateError')">
						<option value="">Please Select:</option>
						<option value="AL">Alabama</option>
						<option value="AK">Alaska</option>
						<option value="AZ">Arizona</option>
						<option value="AR">Arkansas</option>
						<option value="CA">California</option>
						<option value="CO">Colorado</option>
						<option value="CT">Connecticut</option>
						<option value="DE">Delaware</option>
						<option value="DC">District Of Columbia</option>
						<option value="FL">Florida</option>
						<option value="GA">Georgia</option>
						<option value="HI">Hawaii</option>
						<option value="ID">Idaho</option>
						<option value="IL">Illinois</option>
						<option value="IN">Indiana</option>
						<option value="IA">Iowa</option>
						<option value="KS">Kansas</option>
						<option value="KY">Kentucky</option>
						<option value="LA">Louisiana</option>
						<option value="ME">Maine</option>
						<option value="MD">Maryland</option>
						<option value="MA">Massachusetts</option>
						<option value="MI">Michigan</option>
						<option value="MN">Minnesota</option>
						<option value="MS">Mississippi</option>
						<option value="MO">Missouri</option>
						<option value="MT">Montana</option>
						<option value="NE">Nebraska</option>
						<option value="NV">Nevada</option>
						<option value="NH">New Hampshire</option>
						<option value="NJ">New Jersey</option>
						<option value="NM">New Mexico</option>
						<option value="NY">New York</option>
						<option value="NC">North Carolina</option>
						<option value="ND">North Dakota</option>
						<option value="OH">Ohio</option>
						<option value="OK">Oklahoma</option>
						<option value="OR">Oregon</option>
						<option value="PA">Pennsylvania</option>
						<option value="RI">Rhode Island</option>
						<option value="SC">South Carolina</option>
						<option value="SD">South Dakota</option>
						<option value="TN">Tennessee</option>
						<option value="TX">Texas</option>
						<option value="UT">Utah</option>
						<option value="VT">Vermont</option>
						<option value="VA">Virginia</option>
						<option value="WA">Washington</option>
						<option value="WV">West Virginia</option>
						<option value="WI">Wisconsin</option>
						<option value="WY">Wyoming</option>
					</select>&nbsp;&nbsp;<span class="redText" id="stateError"></span>
				</td>
			</tr>
			<tr>
				<td class="leftAlign">
					<span class="spn1">Zip:</span>
					<input id="zip" name="zip" class="textbox" size="35" type="text" oninput="clearErrorMsg('zipError')">&nbsp;&nbsp;<span class="redText" id="zipError"></span>
				</td>
			</tr>
			<tr>
				<td class="leftAlign">
					<span class="spn1">Position:</span>
					<select id="emplType" name="emplType" class="textbox" oninput="clearErrorMsg('emplTypeError')">
						<option selected="selected" value="Employee">Employee</option>
						<option value="Manager">Manager</option>	
					</select>&nbsp;&nbsp;<span class="redText" id="emplTypeError"></span>
				</td>
			</tr>
			<tr>
				<td class="leftAlign">
					<span class="spn1">Hourly rate:</span>
					<input id="hourlyRate" name="hourlyRate" class="textbox" size="35" type="text" oninput="clearErrorMsg('hourlyRateError')">&nbsp;&nbsp;<span class="redText" id="hourlyRateError"></span>
				</td>
			</tr>
			<tr style="text-align: center">
            	<td>
            		<input id= "submitButton" type="submit" width="96" height="37" name="Submit" value="Create Employee" /> 
            		<br />
                	<br />
                	<br />
                </td>
            </tr>
		</table>
	</form>
</body>
</html>