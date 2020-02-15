<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>

<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>

<%@ page import="com.google.appengine.api.datastore.Query" %>

<%@ page import="com.google.appengine.api.datastore.Entity" %>

<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>

<%@ page import="com.google.appengine.api.datastore.Key" %>

<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
  <head>
    <link rel="stylesheet" href="home.css">
    <title>Hello App Engine</title>
    
 
  </head>

  <body>
  
  
<%

	
	Boolean isSubscribed = false;
	UserService userService = UserServiceFactory.getUserService();
	User user = userService.getCurrentUser();
	if (user != null) {

  		pageContext.setAttribute("user", user);
  		
  		
  		DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
  		Query subQuery = new Query("Subscriber").addSort("email", Query.SortDirection.DESCENDING);
  		List<Entity> subscribers = datastore.prepare(subQuery).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
  		
  		
  		for(Entity subscriber : subscribers){
  			if(subscriber.getProperty("email").equals(user.getEmail())){
  				isSubscribed = true;
  			}
  			
  		}
	}

%>
  
  <!-- NavBar -->
  <!-- Dylan driving -->
  <ul>
  <li><a class="active" href="#">Home</a></li>
  <li><a href="/post.jsp">Make A Post</a></li>
  <li><a href="/all.jsp">All Posts</a></li>
  
  <%
	if(user != null){  
		if(isSubscribed){
  %>
    <li><a href="/rem">Unsubscribe</a></li>
  <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>"> Hello ${fn:escapeXml(user.nickname)}! Sign out</a></li>
  <%
		}else{
  
  %>
	  <li><a href="/add">Subscribe</a></li>
  <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>"> Hello ${fn:escapeXml(user.nickname)}! Sign out</a></li>
  <%
		}
	}else {
  %>
	
  <li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a></li>
  <%
	}
  %>
</ul>
    <h1 align="center" >Hat Blog!</h1>
    <img class = "center" src="black-suede-fedora.jpeg" alt="A black suede fedora" style="width:200px;height:200px;">
    
    <!-- End of Dylan Driving -->
    
      <%
  
    String guestbookName = "hats";

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

    Query query = new Query("BlogPost", guestbookKey).addSort("user", Query.SortDirection.DESCENDING).addSort("date", Query.SortDirection.DESCENDING);

    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
    
    if (greetings.isEmpty()) {

        %>

        <p>Hat blog has no posts. Maybe you should add one!</p>
        
        <%

    } else {

        %>

        <p>Posts in Hat Blog.</p>

        <%

        for (Entity greeting : greetings) {
        	
        	//David Driving

            pageContext.setAttribute("greeting_content",

                                     greeting.getProperty("content"));
            pageContext.setAttribute("greeting_date",
            						 greeting.getProperty("date"));
            							
            
            pageContext.setAttribute("greeting_title",
            							greeting.getProperty("title")); 


            %>
            <h5>${fn:escapeXml(greeting_date)}</h5>
            <h4>${fn:escapeXml(greeting_title)}</h4>

            <blockquote>${fn:escapeXml(greeting_content)}</blockquote>

            <%
            
            if (greeting.getProperty("user") == null) {

                %>

                <p>- Anonymous</p>

                <%

            } else {

                pageContext.setAttribute("greeting_user",

                                         greeting.getProperty("user"));

                %>

                <p align = right>- <b>${fn:escapeXml(greeting_user.nickname)}</b></p>
                <br>
                <hr>
                <%
                
                //End of David Driving

            }

        }

    }

%>
  </body>
</html>