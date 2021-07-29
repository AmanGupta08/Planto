<%@page import="java.util.*"%>
<%
	String admin_name=(String)session.getAttribute("admin_name");
	if(admin_name!=null){
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
	Welcome: <b> <%=admin_name %> </b> <a href='adminHome.jsp'>HOME</a> | <a href='Logout'>Logout</a>
	<hr/>
	<a href='allPlants.jsp'>All Plants</a> &nbsp;&nbsp;&nbsp;&nbsp;
	<a href='allOrders.jsp?status=pending'>Pending Orders</a> &nbsp;&nbsp;&nbsp;&nbsp;
	<a href='allOrders.jsp?status=canceled'>Canceled Orders</a> &nbsp;&nbsp;&nbsp;&nbsp;
	<a href='allOrders.jsp?status=shipped'>Shipped Orders</a> &nbsp;&nbsp;&nbsp;&nbsp;
	<a href='allOrders.jsp?status=delivered'>Delivered Orders</a> &nbsp;&nbsp;&nbsp;&nbsp;
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
			Height: <b><%= plant.get("height") %> </b>
			Quantity: <b><%= plant.get("quantity") %> </b> <br/>
			Description: <b><%= plant.get("description") %> </b>
			</p>
			<form action="DeletePlant" method="post">
				<input type="hidden" name="plant_id" value="<%=plant_id%>" />
				<button type="submit">Delete Plant</button>
			</form>
			<br/>
			<form action="editPlantDetails.jsp" method="post">
				<input type="hidden" name="plant_id" value="<%=plant_id%>" />
				<button type="submit">Edit Plant</button>
			</form>
	<%		
		}
	%>
</body>
</html>
<% 
}else{
	session.setAttribute("msg","Plz login!");
	response.sendRedirect("adminLogin.jsp");
}
%>