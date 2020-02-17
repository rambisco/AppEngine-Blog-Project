<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.*" %>

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
   <link id = "myStyleSheet" type="text/css" rel="stylesheet" href="home.css" />
  </head>

 

  <body>
    <script>
        if(localStorage.getItem("nightMode") == null){
            localStorage.setItem("nightMode", "true");
        }
           var nightMode = localStorage.getItem("nightMode");
           
           if(nightMode.localeCompare("true") == 0){
               document.getElementById('myStyleSheet').href = "home.css";
           }else{
               document.getElementById('myStyleSheet').href = "darkmode.css";
           }
                 
        
        </script>
        
        <script>
      function
      switchMode(){
          var nightMode = localStorage.getItem("nightMode");
          if(nightMode.localeCompare("true") == 0){
              localStorage.setItem("nightMode", "false");
          }else{
              localStorage.setItem("nightMode", "true");
          }
          window.location.reload(false); 
      
      }
      </script>
        
        
      <%
       //Dylan Driving
       
           
           
          
          Boolean isSubscribed = false;
          UserService userService = UserServiceFactory.getUserService();
          User user = userService.getCurrentUser();
          if (user != null) {
      
                pageContext.setAttribute("user", user);
                
                
                DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
                Query subQuery = new Query("Subscriber").addSort("email", Query.SortDirection.DESCENDING);
                List<Entity> subscribers = datastore.prepare(subQuery).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
                
                 if(!subscribers.isEmpty()){
                    
                
                
                for(Entity subscriber : subscribers){
                    if(subscriber.getProperty("email").equals(user.getEmail())){
                        isSubscribed = true;
                    }
                    
                    }
                 }
                 
          }
          //End of Dylan Driving
          
          
      
      %>
        
        <!-- NavBar -->
        <!-- Dylan driving this whole navbar-->
        <ul>
        <li><a class="active" href="/">Home</a></li>
        <li><a href="/post.jsp">Make A Post</a></li>
        <li><a href="/all.jsp">All Posts</a></li>
        <li><a href="javascript:switchMode();">Toggle Light/Dark Mode</a></li>
        
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
  
  <%
  
    String guestbookName = "hats";

    DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();

    Key guestbookKey = KeyFactory.createKey("Guestbook", guestbookName);

    // Run an ancestor query to ensure we see the most up-to-date

    // view of the Greetings belonging to the selected Guestbook.

    Query query = new Query("BlogPost", guestbookKey).addSort("user", Query.SortDirection.DESCENDING).addSort("date", Query.SortDirection.DESCENDING);

    List<Entity> greetings = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
    
    Query subQuery = new Query("Subscriber").addSort("email", Query.SortDirection.DESCENDING);

    List<Entity> subscribers = datastore.prepare(subQuery).asList(FetchOptions.Builder.withLimit(Integer.MAX_VALUE));
    
    Collections.sort(greetings, new Comparator<Entity>() {
        @Override
        public int compare(Entity o1, Entity o2) {
        	return (((Date)(o1.getProperty("date"))).compareTo((Date)(o2.getProperty("date"))))*-1;
        }
    });
    
    
    if(subscribers.isEmpty()){
    	%>
    	<p> No subscribers.<p>
    	
    	<%
    }
    
    if (greetings.isEmpty()) {

        %>

        <p>Hat blog has no posts. Maybe you should add one!</p>
        
        <%

    } else {

        %>

        <p>Posts in Hat Blog.</p>

        <%
        

        for (Entity greeting : greetings) {

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

                <p align = right >- <b>${fn:escapeXml(greeting_user.nickname)}</b></p>
                <br>
                <hr>

                <%

            }

        }

    }

%>

        
   
   
   
   
   </body>
   </html>
    
    