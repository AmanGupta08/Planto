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
<script src='https://code.jquery.com/jquery-3.5.1.js'></script>
<script>
    $(document).ready(function(){
        $("#msg").text("");
        $("#confirmpassword").blur(function(){
            var p1=$("#newpassword").val();
            var p2=$("#confirmpassword").val();
            if(p1!=p2){
                $("#msg").text("password does not match");
                $("#msg").css("color","red");
            }else{
                $("#msg").text("password matched");
                $("#msg").css("color","green");
            }
        });
    });
</script>
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
			<a href="profile.jsp">PROFILE</a>
	<a href="order.jsp">View Orders</a>
	
	<a href="index.jsp">Home</a> 
	<hr/>
	<h3>Update Your Name and Phone.</h3>
	<form action="UpdateProfile" method="post">
		<label>Name: </label>
		<input type="text" name="name" value="<%=name %>" placeholder="<%=name %>" required /><br/><br/>
		<%
			String phone=db.getPhone(email);
		%>
		<label>Phone: </label>
		<input type="tel" name="phone" value="<%=phone %>" placeholder="<%=phone %>" required /><br/><br/>
		<button type="submit">Update</button>
	</form>
	<hr/>
	<h3>Change Your Password.</h3>
	<form action="ChangePassword" method="post">
		<label>Old Password: </label>
		<input type="password" name="oldpassword" required /><br/><br/>
		<label>New Password: </label>
		<input type="password" id="newpassword" name="newpassword" required /><br/><br/>
		<label>Confirm new Password: </label>
		<input type="password" id="confirmpassword" name="confirmpassword" required /> <label id="msg"></label><br/><br/>
		<button type="submit">Update</button>
	</form>
</body>
</html>
<% 
	}else{
		session.setAttribute("msg","Plz login!");
		response.sendRedirect("signIn.jsp");
	}
%>