package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/AdminLogin")
public class AdminLogin extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String aid=request.getParameter("aid");
		String password=request.getParameter("password");
		try {
			HttpSession session=request.getSession();
			dao.DbConnect db=new dao.DbConnect();
			String admin_name=db.getAdminLogin(aid, password);
			if(admin_name!=null) {
				session.setAttribute("admin_name",admin_name);
				response.sendRedirect("adminHome.jsp");
			}else {
				session.setAttribute("msg","Wrong entries!");
				response.sendRedirect("adminLogin.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}