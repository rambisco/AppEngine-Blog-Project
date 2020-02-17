package servlets;

import java.io.IOException;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.users.User;


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
		String subject = "New hat posts in the last 24 hours";
		String textBody = "To my sendee";
	      // Sender's email ID needs to be mentioned
	      String from = "anything@hatblog-dylan-david.appspotmail.com";
	      // Assuming you are sending email from localhost
	      String host = "localhost";
	      // Get system properties
	      Properties properties = System.getProperties();

	      // Setup mail server
	      properties.setProperty("mail.smtp.host", host);

	      // Get the default Session object.
	      Session session = Session.getDefaultInstance(properties);
	      
	      //get posts from last 24 hours
	      String guestbookName = "hats";

	      DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

	      Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);
	      
	      Query query = new Query("BlogPost", guestbookKey);//.addSort("date", Query.SortDirection.DESCENDING);
	      
	      List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
	      
	      Query subQuery = new Query("Subscriber").addSort("email", Query.SortDirection.DESCENDING);

	      List<Entity> subscribers = datastore.prepare(subQuery).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
	      
	      Collections.sort(posts, new Comparator<Entity>() {
	          @Override
	          public int compare(Entity o1, Entity o2) {
	          	return (((Date)(o1.getProperty("date"))).compareTo((Date)(o2.getProperty("date"))))*-1;
	          }
	      });
	      
	      StringBuilder builder = new StringBuilder();
	      
	      Date now = new Date();
	      Date aDayAgo = new Date(now.getTime() - 86400000);
	    		  // Date(int year, int month, int date, int hrs, int min)
	      
	      int count = 0;
	      
	      for(Entity post : posts) {
	    	  Date postDate = (Date)post.getProperty("date");
	    	  if(postDate.before(aDayAgo)) continue;
	    	  count++;
	    	  builder.append("\n \n User: ");
	    	  builder.append(((User) post.getProperty("user")).getNickname());
	    	  builder.append("\n Title: ");
	    	  String title = (String) post.getProperty("title");
	    	  builder.append(title);
	    	  builder.append("\n");
	    	  String content = (String) post.getProperty("content");
	    	  builder.append(content);
	      }
	         if(count == 0) {
	    	     resp.sendRedirect("/");
	    	     return;
	         }
	         for(Entity subscriber : subscribers) {
		   	      try {
		   	    	 MimeMessage message = new MimeMessage(session);
		   	    	 message.setFrom(new InternetAddress(from));
		        	 to = (String)subscriber.getProperty("email");
		        	 
		        	 if(to.equals("cron")) continue;
		        	// Set To: header field of the header.
			         message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
	
			         // Set Subject: header field
			         message.setSubject("New posts in Hat Blog in the last 24 Hours!");
	
			         // Now set the actual message
			         message.setText(builder.toString());
	
			         // Send message
			         Transport.send(message);
			         System.out.println("Sent message successfully....");
			      }
		   	      catch (MessagingException mex) {
			         mex.printStackTrace();
		   	      }
	         }
	     resp.sendRedirect("/");
	}
}
