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
@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session=request.getSession();
		String name=(String)session.getAttribute("name");
		if(name!=null){
			try {
				String email=(String)session.getAttribute("email");
				String op=request.getParameter("oldpassword");
				String np=request.getParameter("newpassword");
				String cp=request.getParameter("confirmpassword");
				if(np.equals(cp)) {
					dao.DbConnect db=new dao.DbConnect();
					String m=db.updatePassword(email, op, np);
					session.setAttribute("msg",m);
				}else {
					session.setAttribute("msg","new and confirm password does not match!");
				}
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