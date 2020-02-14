package servlets;

import java.io.IOException;
import java.util.Properties;

import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.mail.MailService.*;
import com.google.appengine.api.mail.MailServiceFactory;
import com.google.appengine.api.mail.MailService;

public class EmailServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {
		
		//David driving
		String to = "david.wolf.tx@gmail.com";
		String sender = "david.wolf.tx@gmail.com";
		String subject = "Testing :)))))";
		String textBody = "To my sendee";
		
		Message message = new Message(sender,to,subject,textBody);
		MailServiceFactory.getMailService().send(message);
		//((MailService) message).send(message);
		
		resp.sendRedirect("/");
		
	}
}
