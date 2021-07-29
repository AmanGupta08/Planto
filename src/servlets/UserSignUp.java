package servlets;

import java.io.IOException;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/UserSignUp")
public class UserSignUp extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		String name=request.getParameter("name");
		String phone=request.getParameter("phone");
		HashMap<String,String> user=new HashMap<String, String>();
		user.put("email", email);
		user.put("password", password);
		user.put("name", name);
		user.put("phone", phone);
		try {
			HttpSession session=request.getSession();
			dao.DbConnect db=new dao.DbConnect();
			boolean result=db.setUser(user);
			if(result) {
				session.setAttribute("email",email);
				session.setAttribute("name",name);
				response.sendRedirect("index.jsp");
			}else {
				session.setAttribute("msg","User email already exist!");
				response.sendRedirect("signUp.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}