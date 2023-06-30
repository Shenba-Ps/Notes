<!DOCTYPE HTML><%@page language="java"
	contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<html>
<head>
<title>Login</title>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="Style.css">
</head>
<body>

	<div class="container">
		<h1 class="label">User Login</h1>

		<form class="login_form"
			action="<%=request.getContextPath()%>/login" method="post">
			<div class="font">user Id</div>
			<input autocomplete="off" type="text" name="username">
<%-- 		<div id="email_error">Please fill up your user id</div>      --%>	
			<div class="font font2">Password</div>
			<input type="password" name="password">
<%--			<div id="pass_error">Please fill up your Password</div>    --%>
			<button type="submit">Login</button>
		</form>
	</div>

</body>
</html>
