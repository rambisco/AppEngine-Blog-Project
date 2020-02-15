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


	<script>
		if(localStorage.getItem("nightMode") == null){
			localStorage.setItem("nightMode", "true");
			document.getElementById("test").innerHTML = "working";
			
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

<ul>
	<li><a class="active" href="#">Home</a></li>
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

      <div><textarea name="content" placeholder = "Content" rows="6" cols="120"></textarea></div>
		<br>
      <div><input id= "button" type="submit" value="Submit" /></div>

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