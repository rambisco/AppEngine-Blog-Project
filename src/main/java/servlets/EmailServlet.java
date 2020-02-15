package servlets;

import java.io.IOException;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;
import javax.mail.*;
import javax.mail.Message;
import javax.mail.internet.*;
import javax.activation.*;

public class EmailServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {
		
		//David driving
		String to = "david.wolf.tx@gmail.com";
		String subject = "Testing :)))))";
		String textBody = "To my sendee";
	      // Sender's email ID needs to be mentioned
	      String from = "david.wolf.tx@gmail.com";
	      // Assuming you are sending email from localhost
	      String host = "localhost";
	      // Get system properties
	      Properties properties = System.getProperties();

	      // Setup mail server
	      properties.setProperty("mail.smtp.host", host);

	      // Get the default Session object.
	      Session session = Session.getDefaultInstance(properties);

	      try {
	         // Create a default MimeMessage object.
	         MimeMessage message = new MimeMessage(session);

	         // Set From: header field of the header.
	         message.setFrom(new InternetAddress(from));

	         // Set To: header field of the header.
	         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));

	         // Set Subject: header field
	         message.setSubject("This is the Subject Line!");

	         // Now set the actual message
	         message.setText("This is actual message");

	         // Send message
	         Transport.send(message);
	         System.out.println("Sent message successfully....");
	      } catch (MessagingException mex) {
	         mex.printStackTrace();
	      }
		//((MailService) message).send(message);
		
		resp.sendRedirect("/");
		
	}
}
