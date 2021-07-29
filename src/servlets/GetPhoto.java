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
@WebServlet("/GetPhoto")
public class GetPhoto extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int plant_id=Integer.parseInt(request.getParameter("plant_id"));
		int photo_no=Integer.parseInt(request.getParameter("photo_no"));
		try {
			dao.DbConnect db=new dao.DbConnect();
			byte[] photo=db.getPhoto(plant_id, photo_no);
			response.getOutputStream().write(photo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}