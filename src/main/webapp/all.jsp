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
   <link type="text/css" rel="stylesheet" href="home.css" />
  </head>

 

  <body>
  
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
        
        for(Entity subscriber: subscribers) {
        	pageContext.setAttribute("sub_email",

                    subscriber.getProperty("email"));
        	
        	%>
        	<h6>Subscriber: ${fn:escapeXml(sub_email)}</h6>
        	<%
        }
        

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
    
    