<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%
	String pname=request.getParameter("pname");
	if(pname==null){
		pname=(String)session.getAttribute("pname");
	}
	dao.DbConnect db=new dao.DbConnect();
	ArrayList<HashMap> allPlants=db.getPlantLikeName(pname);
%>
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
	if(allPlants.isEmpty()){
	%>
		<p> No plant found! </p>
	<%	
	}
	for(HashMap plant : allPlants){
	%>
	<div style="width:max-content;border:1px solid gray;padding:20px; float:left;margin:10px;">
		<a href='viewPlant.jsp?plant_id=<%=plant.get("plant_id")%>' style="color:black; text-decoration:none;">
			<img src='GetPhoto?plant_id=<%=plant.get("plant_id")%>&photo_no=1' height="130px" />
			<h3><b><%=plant.get("name")%></b></h3>
			<p><b><%=plant.get("category")%></b></p>
		</a>
		<%
			int quantity=(Integer)plant.get("quantity");
			if(quantity>0){
				session.setAttribute("pname", pname);
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
	</div>
	<%
	}
	%>
</body>
</html>