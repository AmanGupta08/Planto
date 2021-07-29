<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Planto</title>
</head>
<body>
	<h1>Planto App</h1>
	<hr/>
	<form action="plantSearch.jsp" method="post">
		<label>Search Plant: </label>
		<input type="search" name="pname" required />
		<button type="submit">Search</button>
	</form>
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
	
	<%
		String name=(String)session.getAttribute("name");
		if(name==null){
	%>
			<a href="signIn.jsp">SignIn</a> | <a href="adminLogin.jsp">admin login</a>
	<%		
		}else{
			String email=(String)session.getAttribute("email");
			dao.DbConnect db=new dao.DbConnect();
			int count=db.getCartCount(email);
	%>
			Welcome: <b><%=name %></b> <a href="Logout">Logout</a>  
			<big> Cart: <b> <%=count %> </b> </big> 
			<a href="cart.jsp">View Cart</a>
			<a href="profile.jsp">PROFILE</a>
			<a href="cart.jsp">View Cart</a>
	<%		
		}
	%>
	<a href="index.jsp">Home</a> 
	<hr/>
	<div>
		<img src="images/banner.jpg" width="800px" height="300px">
		
	</div>
</body>
</html>