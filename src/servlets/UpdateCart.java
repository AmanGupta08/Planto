package servlets;

import java.io.IOException;
import java.io.InputStream;
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
@WebServlet("/UpdateCart")
public class UpdateCart extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=(String)session.getAttribute("name");
		if(name!=null){
			int quantity=Integer.parseInt(request.getParameter("quantity"));
			int cart_id=Integer.parseInt(request.getParameter("cart_id"));
			try {
				dao.DbConnect db=new dao.DbConnect();
				boolean result=db.updateCart(quantity,cart_id);
				if(result) {
					session.setAttribute("msg","Cart updated Successfully !");
					response.sendRedirect("cart.jsp");
				}else {
					session.setAttribute("msg","Unable to Update Cart!");
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