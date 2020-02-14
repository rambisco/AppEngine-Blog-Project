package servlets;

import com.google.appengine.api.datastore.DatastoreService;

import com.google.appengine.api.datastore.DatastoreServiceFactory;

import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.FetchOptions;
import com.google.appengine.api.datastore.Key;

import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.users.User;

import com.google.appengine.api.users.UserService;

import com.google.appengine.api.users.UserServiceFactory;

import java.io.IOException;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServlet;

import javax.servlet.http.HttpServletRequest;

import javax.servlet.http.HttpServletResponse;
//Dylan Driving Cachow

public class RemoveSubscriberServlet extends HttpServlet {

    public void doGet(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {
    	
    	

	    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
	    UserService userService = UserServiceFactory.getUserService();
	
	    User user = userService.getCurrentUser();
	    
	    if(user == null) {
	    	resp.sendError(400, "user not enable");
	    }
	
	  
	    Query subQuery = new Query("Subscriber").addSort("email", Query.SortDirection.DESCENDING);

	    List<Entity> subscribers = datastore.prepare(subQuery).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
	    
	    
	  

        for (Entity subscriber : subscribers) {
        	
        	if(subscriber.getProperty("email").equals(user.getEmail())){
        		datastore.delete(subscriber.getKey());
        		break;
        	}
        	
        	

        }
           

    resp.sendRedirect("/");

}

	
	
}