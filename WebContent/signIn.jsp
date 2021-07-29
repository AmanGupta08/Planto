
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Planto</title>
</head>
<body>
	<h1>Planto App</h1>
	<hr/>
	<a href="signUp.jsp">SignUp</a> | <a href="index.jsp">Home</a>
	Cart: <b>0</b>
	<h2>Sign In:</h2>
	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
			<p style="color:red"> <%=msg %> </p>
	<%		
			session.setAttribute("msg",null);
		}
	%>
	<form action="UserSignIn" method="post">
		<label>Email: </label>
		<input type="email" name="email" required /><br/><br/>
		<label>Password: </label>
		<input type="password" name="password" required /><br/><br/>
		<button type="submit">Login</button>
		<a href='forgetPassword.jsp'>Forget Password</a>
	</form>
	<hr/>
	<p> If you are not already registered go to - <a href='signUp.jsp'>Sign Up</a></p>
</body>
</html>