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
	<%
	ArrayList<HashMap> allOrders=db.getOrdersbyEmail(email);
	for(HashMap order : allOrders){
		int order_id=(int)order.get("order_id");
		String status=(String)order.get("status");
		
	%>
		<div style="background-color:lightgray;">
			<p> 
				Order ID: <b> <%=order_id%> </b>
				DateTime: <b> <%=order.get("order_datetime")%> </b>
				Status: <b> <%=status%> </b>
				<%
					if(status.equalsIgnoreCase("pending") || status.equalsIgnoreCase("shipped")){
				%>
					<form action="CancelOrder" method="post">
						<input type="hidden" name="order_id" value="<%=order_id%>" />
						<button type="submit">Cancel Order</button>
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
			<img src='GetOrderItemPhoto?order_id=<%=order_id%>&name=<%=item.get("name")%>' height="100px" />
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
		response.sendRedirect("signIn.jsp");
	}
%>