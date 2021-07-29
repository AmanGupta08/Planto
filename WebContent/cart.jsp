<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%
String name=(String)session.getAttribute("name");
if(name!=null){
	String email=(String)session.getAttribute("email");
	dao.DbConnect db=new dao.DbConnect();
	int count=db.getCartCount(email);
%>
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
	
	Welcome: <b><%=name %></b> <a href="Logout">Logout</a>  
	<big> Cart: <b> <%=count %> </b> </big> 
	<a href="cart.jsp">View Cart</a>
	<a href="order.jsp">View Orders</a>
	
	<a href="index.jsp">Home</a> 
	<br/><br/>
	<form action="placeOrder.jsp" method="post">
			<button type="submit">Place Order</button>
	</form>
	<hr/>
	<%
	ArrayList<HashMap> allPlants=db.getCartPlantbyEmail(email);
	for(HashMap cartPlant : allPlants){
		int plant_id=(int)cartPlant.get("plant_id");
		HashMap<String,Object> plantData=db.getPlantByID(plant_id);
	%>
		<p>
			<a href='viewPlant.jsp?plant_id=<%=plant_id%>' style="color:black; text-decoration:none;">
				<img src='GetPhoto?plant_id=<%=plant_id%>&photo_no=1' height="130px" />
				<h3><b><%=plantData.get("name")%></b></h3>
			</a>
			<p style="color:blue;"><b>&#x20B9; <%=plantData.get("price")%>/-</b></p>
			<p><b><%=plantData.get("category")%></b></p>
			 
			<form action="UpdateCart" method="post">
					Quantity: <input type="number" min='1' max='10' name="quantity" value='<%= cartPlant.get("quantity") %>' required/>
					<input type="hidden" name="cart_id" value="<%=cartPlant.get("cart_id")%>" />
					<button type="submit">Update</button>
			</form>
			<a href='DeleteFromCart?cart_id=<%= cartPlant.get("cart_id") %>'>Remove from Cart</a>
		</p>
		<hr/>
	<%
	}
	%>
</body>
</html>
<% 
	}else{
		session.setAttribute("msg","Plz login!");
		response.sendRedirect("signIn.jsp");
	}
%>