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

<!-- David Driving -->
<html>
<head>
<!-- navbar will go here -->
<link rel="stylesheet" href="home.css">
</head>

<body>

<h1>Here to make a post?</h1>
<h2>Show off your favorite hats! :)</h2>

<%     
	UserService userService = UserServiceFactory.getUserService();

	User user = userService.getCurrentUser();

	if (user != null) {

  		pageContext.setAttribute("user", user);

%>

	<p>Hello, ${fn:escapeXml(user.nickname)}! (You can

	<a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">sign out</a>.)</p>
	
	<form action="/submit" method="post">
	<!-- Dylan Driving -->
	  <div><textarea id = "titlebox" placeholder = "Title" name = "title" rows = 1, cols = 20></textarea></div>	
		
      <div><textarea name="content" rows="3" cols="60"></textarea></div>

      <div><input type="submit" value="Submit" /></div>

      <input type="hidden" name="guestbookName" value="${fn:escapeXml(guestbookName)}"/>

    </form>
    
    <!-- End of Dylan Driving -->

<%

	} else {

%>

	<p>Hello!

	<a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a>

	to be able to make a post :)</p>

<%

}

%>

<!-- End of David driving -->

</body>





</html>