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
@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=(String)session.getAttribute("name");
		if(name!=null){
			try {
				String email=(String)session.getAttribute("email");
				String n=request.getParameter("name");
				String ph=request.getParameter("phone");
				dao.DbConnect db=new dao.DbConnect();
				String m=db.updateProfile(email, n, ph);
				session.setAttribute("msg",m);
				session.setAttribute("name",n);
				response.sendRedirect("profile.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			session.setAttribute("msg","Plz login!");
			response.sendRedirect("index.jsp");
		}
	}

}