
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Planto</title>
</head>
<body>
	<h1>Planto App</h1>
	<hr/>
	<a href="signIn.jsp">SignIn</a> | <a href="index.jsp">Home</a>
	Cart: <b>0</b>
	<h2>Sign UP:</h2>
	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
			<p style="color:red"> <%=msg %> </p>
	<%		
			session.setAttribute("msg",null);
		}
	%>
	<form action="UserSignUp" method="post">
		<label>Name: </label>
		<input type="text" name="name" required /><br/><br/>
		<label>Email: </label>
		<input type="email" name="email" required /><br/><br/>
		<label>Password: </label>
		<input type="password" name="password" required /><br/><br/>
		<label>Phone: </label>
		<input type="text" maxlength="10" name="phone" required /><br/><br/>
		<button type="submit">Sign Up</button>
	</form>
</body>
</html>