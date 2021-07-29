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
		String msg=(String)session.getAttribute("msg");
		if(msg!=null){
	%>
			<p style="background-color:yellow;width:max-content;" > <%=msg %> </p>
	<%		
			session.setAttribute("msg",null);
		}
	%>
	<%
	dao.DbConnect db=new dao.DbConnect();
	String order_status=request.getParameter("status");
	ArrayList<HashMap> allOrders=db.getOrders(order_status);
	for(HashMap order : allOrders){
		int order_id=(int)order.get("order_id");
		String status=(String)order.get("status");
		
	%>
		<div style="background-color:lightgray;">
			<p> 
				Order ID: <b> <%=order_id%> </b>
				User Email: <b> <%=order.get("email")%> </b>
				DateTime: <b> <%=order.get("order_datetime")%> </b>
				Status: <b> <%=status%> </b>
				<%
					if(status.equalsIgnoreCase("pending")){
				%>
					<form action="OrderStatusUpdate" method="post">
						<input type="hidden" name="order_id" value="<%=order_id%>" />
						<input type="hidden" name="status" value="canceled" />
						<input type="hidden" name="pagename" value="pending" />
						<button type="submit">Cancel Order</button>
					</form>
					<br/>
					<form action="OrderStatusUpdate" method="post">
						<input type="hidden" name="order_id" value="<%=order_id%>" />
						<input type="hidden" name="status" value="shipped" />
						<input type="hidden" name="pagename" value="pending" />
						<button type="submit">Shipped Order</button>
					</form>
				<%		
					}
					if(status.equalsIgnoreCase("shipped")){
					%>
						<form action="OrderStatusUpdate" method="post">
							<input type="hidden" name="order_id" value="<%=order_id%>" />
							<input type="hidden" name="status" value="delivered" />
						<input type="hidden" name="pagename" value="shipped" />
							<button type="submit">Delivered Order</button>
						</form>
					<%		
						}
				%>
			</p>
			<hr/>
	<%
	int total=0;
	ArrayList<HashMap> allItems=db.getOrderItems(order_id);
	for(HashMap item : allItems){
		int q=(int)item.get("quantity");
		int p=(int)item.get("price");
		total += p*q;
	%>
		<p>
			<img src='GetOrderItemPhoto?order_id=<%=order_id%>&name=<%=item.get("name")%>' height="40px" />
			Name: <%=item.get("name")%>
			Price: <%=p%>
			Quantity: <%=q%>
			Category: <%=item.get("category")%>
		</p>
	<%	
	}
	%>
			<hr/>
			<p> 
				Total Amount: <b><%=total%></b>
				Address: <b> <%=order.get("address")%> </b>
			</p>
		</div>
		<hr/>
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