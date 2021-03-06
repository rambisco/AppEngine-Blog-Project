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


public class SubmitServlet extends HttpServlet {

    public void doPost(HttpServletRequest req, HttpServletResponse resp)

            throws IOException {
    	
    	//David Driving

    UserService userService = UserServiceFactory.getUserService();

    User user = userService.getCurrentUser();

    String guestbookName = "hats";

    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    String content = req.getParameter("content");
    
    String title = req.getParameter("title");

    Date date = new Date();

    Entity blogPost = new Entity("BlogPost", guestbookKey);

    blogPost.setProperty("user", user);

    blogPost.setProperty("date", date);

    blogPost.setProperty("content", content);
    
    blogPost.setProperty("title", title);
    
    	//End of David driving
    
    


    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    datastore.put(blogPost);



    resp.sendRedirect("/");

}

	
	
}
