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
	<big> Cart: <b> <%=count %> </b> </big> <a href="cart.jsp">View Cart</a>
	
	<a href="index.jsp">Home</a> 
	<hr/>
	<%
	int total=0;
	ArrayList<HashMap> allPlants=db.getCartPlantbyEmail(email);
	for(HashMap cartPlant : allPlants){
		int plant_id=(int)cartPlant.get("plant_id");
		HashMap<String,Object> plantData=db.getPlantByID(plant_id);
		
		total += (int)plantData.get("price") * (int)cartPlant.get("quantity") ;
	%>
		<p>
			<img src='GetPhoto?plant_id=<%=plant_id%>&photo_no=1' height="60px" />
			<b><%=plantData.get("name")%></b>
			<b>&#x20B9; <%=plantData.get("price")%>/-</b>
			Quantity: <b><%=cartPlant.get("quantity")%></b>
		</p>
		<hr/>
	<%
	}
	%>
	<h3>Total Amount: &#x20B9; <big><%= total %></big></h3>
	<hr/>
	<p> Your Address to place order. </p>
	<form action="ConfirmOrder" method="post">
		<%
		ArrayList<String> addresses=db.getAddress(email);
		for(String address:addresses){
		%>
			<input type="radio" name="address" value="<%=address %>" required/>
			<%=address %>
			<br/><br/>
		<%
		}
		%>
		<input type="radio" name="address" value="new" required/>
		<textarea rows="3" name="new_address" placeholder="enter your new address"></textarea>
		<br/><br/>
		<button type="submit">Confirm Order</button>
	</form>
</body>
</html>
<% 
	}else{
		session.setAttribute("msg","Plz login!");
		response.sendRedirect("signIn.jsp");
	}
%>