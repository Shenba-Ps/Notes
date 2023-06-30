<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>StaffRegistration</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<style>
input {
	width: 30%;
	padding: 6px 6px;
	margin: 8px 0;
	box-sizing: border-box;
}

.row:after {
	content: "";
	display: table;
	clear: both;
}

.col-25 {
	float: left;
	width: 25%;
	margin-top: 6px;
}

.col-75 {
	float: left;
	width: 75%;
	margin-top: 6px;
}

label {
	padding: 12px 12px 12px 0;
	display: inline-block;
}
</style>
</head>
<body>
<form action="<%=request.getContextPath() %>/newStaff" method="post">
		<div class="row">
			<div class="col-25">
				<label for="">User Id</label>
			</div>
			<div class="col-75">
				<input type="text" name="userId">
			</div>
		</div>
		<div class="row">
			<div class="col-25">
				<label for="">Password</label>
			</div>
			<div class="col-75">
				<input type="password" name="password">
			</div>
		</div>


		<div class="row">
			<div class="col-25">
				<label for="roles">Role:</label>
			</div>
			<div class="col-75">
				<select name="roles" id="roles">
					<option value="SA">System Administrator</option>
					<option value="CO">Contract Officer</option>
					<option value="RO">Recommending Officer</option>
					<option value="AO">Approving Officer</option>
					<option value="AUO">Audit Officer</option>

				</select>
			</div>
		</div>

		<div class="row">
			<div class="col-25"></div>
			<div class="col-75">
				<input type="submit" name="Add">
			</div>
			<a href="Admin.jsp">Back</a>
		</div>
	</form>

</body>
</html>
