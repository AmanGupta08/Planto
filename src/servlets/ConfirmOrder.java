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
@WebServlet("/ConfirmOrder")
public class ConfirmOrder extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=(String)session.getAttribute("name");
		if(name!=null){
			try {
				String email=(String)session.getAttribute("email");
				dao.DbConnect db=new dao.DbConnect();
				String address=request.getParameter("address");
				if(address.equals("new")) {
					address=request.getParameter("new_address");
					db.setAddress(email, address);
				}
				String msg="";
				ArrayList<HashMap> allPlants=db.getCartPlantbyEmail(email);
				for(HashMap cartPlant : allPlants){
					int plant_id=(int)cartPlant.get("plant_id");
					int quantity=(int)cartPlant.get("quantity");
					ArrayList list=db.getPlantQtyNameByID(plant_id);
					int plant_quantity=(int)list.get(0);
					String plant_name=(String)list.get(1);
					if(plant_quantity==0) {
						String m=plant_name+" is unavailable. <br/>" ;
						msg += m;
					}else if(plant_quantity<quantity) {
						String m=plant_name+" is only "+plant_quantity+" available. <br/>" ;
						msg += m;
					}
				}
				if(msg.equals("")) {
					int order_id=db.setOrder(email,address);
					db.setOrderItems(allPlants, order_id);
					
					db.deleteFromCart(email);
					
					db.updatePlantQtyOrder(allPlants);
					
					session.setAttribute("msg","Order placed successfully!");
					response.sendRedirect("cart.jsp");
				}else {
					session.setAttribute("msg",msg);
					response.sendRedirect("cart.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			session.setAttribute("msg","Plz login!");
			response.sendRedirect("index.jsp");
		}
	}

}