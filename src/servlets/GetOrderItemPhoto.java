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
@WebServlet("/GetOrderItemPhoto")
public class GetOrderItemPhoto extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int order_id=Integer.parseInt(request.getParameter("order_id"));
		String name=request.getParameter("name");
		try {
			dao.DbConnect db=new dao.DbConnect();
			byte[] photo=db.getOrderItemPhoto(name, order_id);
			response.getOutputStream().write(photo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}