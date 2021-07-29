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
@WebServlet("/DeletePlant")
public class DeletePlant extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String admin_name=(String)session.getAttribute("admin_name");
		if(admin_name!=null){
			int plant_id=Integer.parseInt(request.getParameter("plant_id"));
			try {
				dao.DbConnect db=new dao.DbConnect();
				boolean result=db.deletePlant(plant_id);
				if(result) {
					session.setAttribute("msg","Plant Deleted Successfully !");
					response.sendRedirect("adminHome.jsp");
				}else {
					session.setAttribute("msg","Plant does not Exist !");
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