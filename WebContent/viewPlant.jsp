<!DOCTYPE html>
<%@page import="java.util.HashMap"%>
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
		<input type="search" name="name" required />
		<button type="submit">Search</button>
	</form>
	<hr/>
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
			<a href="order.jsp">View Orders</a>
	<%		
		}
	%>
	<a href="index.jsp">Home</a> 
	<hr/>
	<%
		int plant_id=Integer.parseInt(request.getParameter("plant_id"));
		dao.DbConnect db=new dao.DbConnect();
		HashMap<String,Object> plant=db.getPlantByID(plant_id);
		if(plant !=null){
	%>
			<img src="GetPhoto?plant_id=<%=plant_id%>&photo_no=1" height="200px" alt="" />
			<img src="GetPhoto?plant_id=<%=plant_id%>&photo_no=2" height="200px" alt="" />
			<img src="GetPhoto?plant_id=<%=plant_id%>&photo_no=3" height="200px" alt="" />
			<p>
			Plant ID: <b><%= plant.get("plant_id") %> </b>
			Name: <b><%= plant.get("name") %> </b>
			Price: <b><%= plant.get("price") %> </b> 
			Category: <b><%= plant.get("category") %> </b>
			Height: <b><%= plant.get("height") %> </b> <hr/>
			Description: <b><%= plant.get("description") %> </b>
			</p>
			<%
				int quantity=(Integer)plant.get("quantity");
				if(quantity>0){
			%>
					<p style="color:blue;"><b>&#x20B9; <%=plant.get("price")%>/-</b></p>
					<form action="AddCart" method="post">
						<input type="hidden" name="plant_id" value="<%=plant.get("plant_id")%>" />
						<button type="submit">Add To Cart</button>
					</form>
			<%		
				}else{
					%>
					<p style="color:red;"><b>OUT OF STOCK!</b></p>
			<%		
				}
			%>
	<%		
		}
	%>
</body>
</html>