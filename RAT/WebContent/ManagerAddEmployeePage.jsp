<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<style type="text/css">
            
            .leftAlign{
                text-align: left;
            }
            
            body {
				background: #E8E8E8;
				color: #111111;
				font-family: Georgia, "Times New Roman", Times, serif;
				padding: 20px;
			}
			
            .redText{
				color:red;
			}
			
			h1 {
				background: #E8E8E8;
				border-radius: 5px;
				-moz-border-radius: 5px;
				-webkit-border-radius: 5px;
				padding: 20px;
				width: 500px;
				width: 500px;
				margin:0px auto;
			}
			
			form#Form1{
				color: #384313;
				font-size: 16px;
				font-weight: bold;
				padding-bottom: 10px;
				text-shadow: 0 1px 1px #c0d576;
			    background: #A3A3A3;
				-moz-border-radius: 5px;
				-webkit-border-radius: 5px;
				border-radius: 5px;
				padding: 20px;
				width: 650px;
				margin:0px auto;
			}
			
			form#Form1 ol li {
				background: #b9cf6a;
				background: rgba(255,255,255,.3);
				border-color: #e3ebc3;
				border-color: rgba(255,255,255,.6);
				border-style: solid;
				border-width: 2px;
				-moz-border-radius: 5px;
				-webkit-border-radius: 5px;
				border-radius: 5px;
				line-height: 30px;
				list-style: none;
				padding: 5px 10px;
				margin-bottom: 2px;
			}
			form#Form1 ol ol li {
				background: none;
				border: none;
				float: left;
			}
			form#Form1 label {
				float: left;
				font-size: 13px;
				width: 110px;
			}
			
			form#Form1 input:not([type=submit]):focus {
				background: #eaeaea;
				width: 110px;
			}
			
			form#Form1 button {
				background: #5A6570;
				border: none;
				-moz-border-radius: 20px;
				-webkit-border-radius: 20px;
				-khtml-border-radius: 20px;
				border-radius: 20px;
				color: #ffffff;
				display: block;
				font: 18px Georgia, "Times New Roman", Times, serif;
				letter-spacing: 1px;
				margin: auto;
				padding: 7px 25px;
				text-shadow: 0 1px 1px #000000;
				text-transform: uppercase;
			}
			form#Form1 button:hover {
				background: #4B5259;
				cursor: pointer;
			}

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
<body>
	<h1  style="text-align: center; font-family: Verdana, Arial, Helvetica, sans-serif;">Add Employee</h1>
	<br />
	<br />
	<form id="Form1" name="CreateEmpForm" action="CreateEmployee.jsp" method="post">
		<fieldset>
		<legend>Personal Information</legend>
			<ol>
				<li>
					<label for=firstName >First name </label>
					<input id=firstName name=firstName type=text placeholder="First name" value="${EmployeeFName}" oninput="return clearErrorMsg('fNameError')" required /><span class="redText" id="fNameError">${EmployeeFNameError}</span>
				</li>		
				<li>
					<label for=lastName >Last name </label>
					<input id=lastName name=lastName type=text placeholder="Last name" value="${EmployeeLName}" oninput="return clearErrorMsg('lNameError')" required /><span class="redText" id="lNameError">${EmployeeLNameError}</span>
				</li>
				<li>
					<label for=ssn >SSN</label>
					<input id=ssn name=ssn type=text value="${EmployeeSSN}" oninput="return clearErrorMsg('ssnError')" required /><span class="redText" id="ssnError">${EmployeeSSNError}</span>
				</li>				
			</ol>		
		</fieldset>
		<fieldset>
		<legend>Address</legend>
			<ol>
				<li>
					<label for=address >Address </label>
					<input id=address name=address type=text placeholder="Address" value="${EmployeeAddress}" oninput="return clearErrorMsg('addressError')" required />&nbsp;&nbsp;<span class="redText" id="addressError">${EmployeeAddressError}</span>
				</li>		
				<li>
					<label for=city >City </label>
					<input id=city name=city type=text oninput="clearErrorMsg('cityError')" value="${EmployeeCity}" required />&nbsp;&nbsp;<span class="redText" id="cityError">${EmployeeCityError}</span>
				</li>
				<li>
					<label for=state >State </label>
					<select id="state" name="state" class="textbox" oninput="clearErrorMsg('stateError')">
						<option ${EmployeeState==""?"Selected=selected":""} value="">Please Select:</option>
						<option ${EmployeeState=="AL"?"Selected=selected":""} value="AL">Alabama</option>
						<option ${EmployeeState=="AK"?"Selected=selected":""} value="AK">Alaska</option>
						<option ${EmployeeState=="AZ"?"Selected=selected":""} value="AZ">Arizona</option>
						<option ${EmployeeState=="AR"?"Selected=selected":""} value="AR">Arkansas</option>
						<option ${EmployeeState=="CA"?"Selected=selected":""} value="CA">California</option>
						<option ${EmployeeState=="CO"?"Selected=selected":""} value="CO">Colorado</option>
						<option ${EmployeeState=="CT"?"Selected=selected":""} value="CT">Connecticut</option>
						<option ${EmployeeState=="DE"?"Selected=selected":""} value="DE">Delaware</option>
						<option ${EmployeeState=="DC"?"Selected=selected":""} value="DC">District Of Columbia</option>
						<option ${EmployeeState=="FL"?"Selected=selected":""} value="FL">Florida</option>
						<option ${EmployeeState=="GA"?"Selected=selected":""} value="GA">Georgia</option>
						<option ${EmployeeState=="HI"?"Selected=selected":""} value="HI">Hawaii</option>
						<option ${EmployeeState=="ID"?"Selected=selected":""} value="ID">Idaho</option>
						<option ${EmployeeState=="IL"?"Selected=selected":""} value="IL">Illinois</option>
						<option ${EmployeeState=="IN"?"Selected=selected":""} value="IN">Indiana</option>
						<option ${EmployeeState=="IA"?"Selected=selected":""} value="IA">Iowa</option>
						<option ${EmployeeState=="KS"?"Selected=selected":""} value="KS">Kansas</option>
						<option ${EmployeeState=="KY"?"Selected=selected":""} value="KY">Kentucky</option>
						<option ${EmployeeState=="LA"?"Selected=selected":""} value="LA">Louisiana</option>
						<option ${EmployeeState=="ME"?"Selected=selected":""} value="ME">Maine</option>
						<option ${EmployeeState=="MD"?"Selected=selected":""} value="MD">Maryland</option>
						<option ${EmployeeState=="MA"?"Selected=selected":""} value="MA">Massachusetts</option>
						<option ${EmployeeState=="MI"?"Selected=selected":""} value="MI">Michigan</option>
						<option ${EmployeeState=="MN"?"Selected=selected":""} value="MN">Minnesota</option>
						<option ${EmployeeState=="MS"?"Selected=selected":""} value="MS">Mississippi</option>
						<option ${EmployeeState=="MO"?"Selected=selected":""} value="MO">Missouri</option>
						<option ${EmployeeState=="MT"?"Selected=selected":""} value="MT">Montana</option>
						<option ${EmployeeState=="NE"?"Selected=selected":""} value="NE">Nebraska</option>
						<option ${EmployeeState=="NV"?"Selected=selected":""} value="NV">Nevada</option>
						<option ${EmployeeState=="NH"?"Selected=selected":""} value="NH">New Hampshire</option>
						<option ${EmployeeState=="NJ"?"Selected=selected":""} value="NJ">New Jersey</option>
						<option ${EmployeeState=="NM"?"Selected=selected":""} value="NM">New Mexico</option>
						<option ${EmployeeState=="NY"?"Selected=selected":""} value="NY">New York</option>
						<option ${EmployeeState=="NC"?"Selected=selected":""} value="NC">North Carolina</option>
						<option ${EmployeeState=="ND"?"Selected=selected":""} value="ND">North Dakota</option>
						<option ${EmployeeState=="OH"?"Selected=selected":""} value="OH">Ohio</option>
						<option ${EmployeeState=="OK"?"Selected=selected":""} value="OK">Oklahoma</option>
						<option ${EmployeeState=="OR"?"Selected=selected":""} value="OR">Oregon</option>
						<option ${EmployeeState=="PA"?"Selected=selected":""} value="PA">Pennsylvania</option>
						<option ${EmployeeState=="RI"?"Selected=selected":""} value="RI">Rhode Island</option>
						<option ${EmployeeState=="SC"?"Selected=selected":""} value="SC">South Carolina</option>
						<option ${EmployeeState=="SD"?"Selected=selected":""} value="SD">South Dakota</option>
						<option ${EmployeeState=="TN"?"Selected=selected":""} value="TN">Tennessee</option>
						<option ${EmployeeState=="TX"?"Selected=selected":""} value="TX">Texas</option>
						<option ${EmployeeState=="UT"?"Selected=selected":""} value="UT">Utah</option>
						<option ${EmployeeState=="VT"?"Selected=selected":""} value="VT">Vermont</option>
						<option ${EmployeeState=="VT"?"Selected=selected":""} value="VA">Virginia</option>
						<option ${EmployeeState=="WA"?"Selected=selected":""} value="WA">Washington</option>
						<option ${EmployeeState=="WV"?"Selected=selected":""} value="WV">West Virginia</option>
						<option ${EmployeeState=="WI"?"Selected=selected":""} value="WI">Wisconsin</option>
						<option ${EmployeeState=="WY"?"Selected=selected":""} value="WY">Wyoming</option>
					</select>&nbsp;&nbsp;<span class=redText id=stateError>${EmployeeStateError}</span>	
				</li>
				<li>
					<label for=zip >Zip code </label>
					<input id=zip name=zip type=text oninput="clearErrorMsg('zipError')" value="${EmployeeZip}" required />&nbsp;&nbsp;<span class="redText" id="zipError">${EmployeeZipError}</span>
				</li>			
			</ol>		
		</fieldset>
		<fieldset>
		<legend>Employee Information</legend>
			<ol>
				<li>
					<label for=emplType >Position </label>
					<select id=emplType name=emplType oninput="clearErrorMsg('emplTypeError')">
						<option ${EmployeeEmplType=="Employee"?"Selected=selected":""} value=Employee>Employee</option>
						<option ${EmployeeEmplType=="Manager"?"Selected=selected":""} value=Manager>Manager</option>	
					</select>&nbsp;&nbsp;<span class=redText id=emplTypeError>${EmployeeEmplTypeError}</span>
				</li>		
				<li>
					<label for=hourlyRate >Hourly Rate </label>
					<input id=hourlyRate name=hourlyRate type=text oninput="clearErrorMsg('hourlyRateError')" value="${EmployeeHourlyRate}" required />&nbsp;&nbsp;<span class="redText" id="hourlyRateError">${EmployeeHourlyRateError}</span>
				</li>		
			</ol>		
		</fieldset>
		<button type=submit>Submit</button>
	</form>
</body>
</html>