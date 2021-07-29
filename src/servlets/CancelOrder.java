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
@WebServlet("/CancelOrder")
public class CancelOrder extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=(String)session.getAttribute("name");
		if(name!=null){
			try {
				int order_id=Integer.parseInt(request.getParameter("order_id"));
				dao.DbConnect db=new dao.DbConnect();
				String msg="";
				ArrayList<HashMap> allItems=db.getOrderItems(order_id);
				for(HashMap item : allItems){
					String pname=(String)item.get("name");
					int quantity=(int)item.get("quantity");
					db.updatePlantQtyOrderCancel(pname, quantity);
				}
				db.updateOrderStatus(order_id,"canceled");
				session.setAttribute("msg","Order Canceled Successfully!");
				response.sendRedirect("order.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			session.setAttribute("msg","Plz login!");
			response.sendRedirect("index.jsp");
		}
	}

}