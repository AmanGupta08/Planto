package servlets;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


@WebServlet("/ForgetPassword")
public class ForgetPassword extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String email=request.getParameter("email");
		try {
			HttpSession session=request.getSession();
			dao.DbConnect db=new dao.DbConnect();
			String password=db.getPassword(email);
			if(password!=null) {
				//mail code
				try {
					final String SEmail="amanobccc@gmail.com";
	                final String SPass="naijie@6610";
	                final String REmail=email;
	                final String Sub="PlantO: Your Password is Here.";
	                final String Body="Your User ID:"+email+"and Password: "+password;
	                
	                Properties prop = new Properties();  
					prop.put("mail.smtp.host", "smtp.gmail.com");
					prop.put("mail.smtp.port", "587");
					prop.put("mail.smtp.auth", "true");
					prop.put("mail.smtp.starttls.enable", "true");
					
					Session ses = Session.getInstance(prop,  
				    new javax.mail.Authenticator() {  
				      protected PasswordAuthentication getPasswordAuthentication() {  
				    return new PasswordAuthentication(SEmail,SPass);  
				      }  
				    });
					
					Message message=new MimeMessage(ses);
		            message.setFrom(new InternetAddress(SEmail));
		            message.setRecipients(Message.RecipientType.TO, 
		            		InternetAddress.parse(REmail));
		            message.setSubject(Sub);
		            message.setContent(Body,"text/html" );
		            
		            Transport.send(message);
		            
		            session.setAttribute("msg","Mail sent successfully!");
					response.sendRedirect("forgetPassword.jsp");
					}catch(Exception e) {
						e.printStackTrace();
						session.setAttribute("message","Something went with mail sending!");
						response.sendRedirect("forgetPassword.jsp");
					}
				//mail code end
				
			}else {
				session.setAttribute("msg","Email id is not registered with Us yet!");
				response.sendRedirect("forgetPassword.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
