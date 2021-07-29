
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Planto</title>
</head>
<body>
	<h1>Planto App</h1>
	<hr/>
	<a href="index.jsp">Home</a>
	<h2>Forget Password:</h2>
	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
			<p style="color:red"> <%=msg %> </p>
	<%		
			session.setAttribute("msg",null);
		}
	%>
	<p> Enter Your registered email id, then we will mail your password.</p>
	<form action="ForgetPassword" method="post">
		<label>Email: </label>
		<input type="email" name="email" required /><br/><br/>
		<button type="submit">Submit</button>
	</form>
	<hr/>
</body>
</html>