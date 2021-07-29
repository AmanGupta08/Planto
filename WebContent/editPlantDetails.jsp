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
	<a href='allPlants.jsp'>View All Plants</a>
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
	
	
	<%
	    int plant_id=Integer.parseInt(request.getParameter("plant_id"));
		dao.DbConnect db=new dao.DbConnect();
		HashMap<String,Object> plant=db.getPlantByID(plant_id);
		if(plant!=null){
	%>
			<form action="UpdatePlant" method="post" enctype="multipart/form-data">
				<label>Plant Name: </label>
				<input type="hidden" name="plant_id" value="<%=plant.get("plant_id")%>" />
				<input type="text" name="name" value="<%= plant.get("name") %>" placeholder="<%= plant.get("name") %>" required /><br/><br/>
				<label>Plant Price: </label>
				<input type="number" name="price" value="<%= plant.get("price") %>" placeholder="<%= plant.get("price") %>"  required /><br/><br/>
				<label>Plant Description: </label>
				<textarea rows='3' name="description" placeholder="<%= plant.get("description") %>"  required > <%= plant.get("description") %> </textarea><br/><br/>
				<label>Plant Category: </label>
				<select name='category'>
					<option><%= plant.get("category") %></option>
					<option>Indoor</option>
					<option>Outdoor</option>
					<option>Indoor-Outdoor</option>
				</select><br/><br/>
				<label>Plant Height: </label>
				<input type="text" name="height" value="<%= plant.get("height") %>" placeholder="<%= plant.get("height") %>" required /><br/><br/>
				<label>Plant Quantity: </label>
				<input type="number" name="quantity" value="<%= plant.get("quantity") %>" placeholder="<%= plant.get("quantity") %>" required /><br/><br/>
				<img src="GetPhoto?plant_id=<%=plant_id%>&photo_no=1" height="200px" alt="" />
				<label>Plant Photo: </label>
				<input type="file" name="photo"  /><br/><br/>
				<img src="GetPhoto?plant_id=<%=plant_id%>&photo_no=2" height="200px" alt="" />
				<label>Plant Photo: </label>
				<input type="file" name="photo1"  /><br/><br/>
				<img src="GetPhoto?plant_id=<%=plant_id%>&photo_no=3" height="200px" alt="" />
				<label>Plant Photo: </label>
				<input type="file" name="photo2"  /><br/><br/>
				
				<button type="submit">Update Plant</button>
			</form>
			<br/>
			<form action="DeletePlant" method="post">
				<input type="hidden" name="plant_id" value="<%=plant_id%>" />
				<button type="submit">Delete Plant</button>
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