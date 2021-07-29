package servlets;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

@MultipartConfig
@WebServlet("/OrderStatusUpdate")
public class OrderStatusUpdate extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String admin_name=(String)session.getAttribute("admin_name");
		if(admin_name!=null){
			try {
				int order_id=Integer.parseInt(request.getParameter("order_id"));
				String status=request.getParameter("status");
				String pagename=request.getParameter("pagename");
				dao.DbConnect db=new dao.DbConnect();
				db.updateOrderStatus(order_id,status);
				session.setAttribute("msg","Order updated Successfully!");
				response.sendRedirect("allOrders.jsp?status="+pagename);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			session.setAttribute("msg","Plz login!");
			response.sendRedirect("adminLogin.jsp");
		}
	}

}