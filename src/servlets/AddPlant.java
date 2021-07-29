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
@WebServlet("/AddPlant")
public class AddPlant extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String admin_name=(String)session.getAttribute("admin_name");
		if(admin_name!=null){
			String name=request.getParameter("name");
			int price=Integer.parseInt(request.getParameter("price"));
			String description=request.getParameter("description");
			String category=request.getParameter("category");
			double height=Double.parseDouble(request.getParameter("height"));
			int quantity=Integer.parseInt(request.getParameter("quantity"));
			Part p=request.getPart("photo");
			InputStream photo=p.getInputStream();
			Part p1=request.getPart("photo1");
			InputStream photo1=p1.getInputStream();
			Part p2=request.getPart("photo2");
			InputStream photo2=p2.getInputStream();
			HashMap<String, Object> plant=new HashMap();
			plant.put("name", name);
			plant.put("price", price);
			plant.put("description", description);
			plant.put("category", category);
			plant.put("height", height);
			plant.put("photo", photo);
			plant.put("photo1", photo1);
			plant.put("photo2", photo2);
			plant.put("quantity", quantity);
			
			try {
				dao.DbConnect db=new dao.DbConnect();
				boolean result=db.addPlant(plant);
				if(result) {
					session.setAttribute("msg","Plant Added Successfully !");
					response.sendRedirect("adminHome.jsp");
				}else {
					session.setAttribute("msg","Plant Already Exist !");
					response.sendRedirect("adminHome.jsp");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			session.setAttribute("msg","Plz login!");
			response.sendRedirect("adminLogin.jsp");
		}
	}

}