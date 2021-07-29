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
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
			<p style="background-color:yellow;width:max-content;" > <%=msg %> </p>
	<%		
			session.setAttribute("msg",null);
		}
	%>
	<h2>Add Plant</h2>
	<form action="AddPlant" method="post" enctype="multipart/form-data">
		<label>Plant Name: </label>
		<input type="text" name="name" required /><br/><br/>
		<label>Plant Price: </label>
		<input type="number" name="price" required /><br/><br/>
		<label>Plant Description: </label>
		<textarea rows='3' name="description" required ></textarea><br/><br/>
		<label>Plant Category: </label>
		<select name='category'>
			<option>Indoor</option>
			<option>Outdoor</option>
			<option>Indoor-Outdoor</option>
		</select><br/><br/>
		<label>Plant Height: </label>
		<input type="text" name="height" required /><br/><br/>
		<label>Plant Quantity: </label>
		<input type="number" name="quantity" required /><br/><br/>
		<label>Plant Photo: </label>
		<input type="file" name="photo" required /><br/><br/>
		<label>Plant Photo: </label>
		<input type="file" name="photo1" required /><br/><br/>
		<label>Plant Photo: </label>
		<input type="file" name="photo2" required /><br/><br/>
		<button type="submit">Add</button>
	</form>
</body>
</html>
<% 
}else{
	session.setAttribute("msg","Plz login!");
	response.sendRedirect("adminLogin.jsp");
}
%>