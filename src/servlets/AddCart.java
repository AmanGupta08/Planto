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
@WebServlet("/AddCart")
public class AddCart extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=(String)session.getAttribute("name");
		if(name!=null){
			int plant_id=Integer.parseInt(request.getParameter("plant_id"));
			String email=(String)session.getAttribute("email");
			try {
				dao.DbConnect db=new dao.DbConnect();
				boolean result=db.addCart(plant_id,email);
				if(result) {
					session.setAttribute("msg","Plant Added to Cart Successfully !");
					response.sendRedirect("plantSearch.jsp");
				}else {
					session.setAttribute("msg","Unable to Add to Cart!");
					response.sendRedirect("plantSearch.jsp");
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