package servlets;

import com.google.appengine.api.datastore.DatastoreService;

import com.google.appengine.api.datastore.DatastoreServiceFactory;

import com.google.appengine.api.datastore.Entity;

import com.google.appengine.api.datastore.Key;

import com.google.appengine.api.datastore.KeyFactory;

import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import java.util.Date;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
//Dylan Driving Cachow

public class AddSubscriber extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {
    	
    	UserService userService = UserServiceFactory.getUserService();

        User user = userService.getCurrentUser();
    	
    	if(user == null) {	
//    		String subscriberName = "cron";
//    	    Key subscriberKey = KeyFactory.createKey("SubscriberList", subscriberName);
//    	    Entity subscriber = new Entity("Subscriber", subscriberKey);
//    	    subscriber.setProperty("email", "cron"); 
//    	    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
//    	    datastore.put(subscriber);
    	    	return;
    	 
    	}
    	

    

    String subscriberName = user.getEmail();

    Key subscriberKey = KeyFactory.createKey("SubscriberList", subscriberName);


    Entity subscriber = new Entity("Subscriber", subscriberKey);
    
 

    subscriber.setProperty("email", user.getEmail());
    
    
    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    datastore.put(subscriber);


    resp.sendRedirect("/");

}

	
	
}
