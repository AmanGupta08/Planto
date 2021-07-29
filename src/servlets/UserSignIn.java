package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/UserSignIn")
public class UserSignIn extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		try {
			HttpSession session=request.getSession();
			dao.DbConnect db=new dao.DbConnect();
			String name=db.getUserLogin(email, password);
			if(name!=null) {
				session.setAttribute("email",email);
				session.setAttribute("name",name);
				response.sendRedirect("index.jsp");
			}else {
				session.setAttribute("msg","Wrong Entries!");
				response.sendRedirect("signIn.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}