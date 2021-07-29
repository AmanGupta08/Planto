<%
String admin_name=(String)session.getAttribute("admin_name");
	if(admin_name==null){
%>
<%
response.setHeader("Pragma","no-cache");
response.setHeader("Cache-Control","no-store");
response.setHeader("Expires","0");
response.setDateHeader("Expires",-1);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Planto</title>
</head>
<body>
	<h1>Admin Login Page</h1>
	<hr/>
	<%
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
			<p style="color:red"> <%=msg %> </p>
	<%		
			session.setAttribute("msg",null);
		}
	%>
	<form action="AdminLogin" method="post">
		<label>Admin Id: </label>
		<input type="text" name="aid" required /><br/><br/>
		<label>Admin Password: </label>
		<input type="password" name="password" required /><br/><br/>
		<button type="submit">Login</button>
	</form>
</body>
</html>
<% 
}else{
	response.sendRedirect("adminHome.jsp");
}
%>