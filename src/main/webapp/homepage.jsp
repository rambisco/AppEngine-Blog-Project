<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@ page import="java.util.List" %>

<%@ page import="com.google.appengine.api.users.User" %>

<%@ page import="com.google.appengine.api.users.UserService" %>

<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>

<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
  <head>
    <link rel="stylesheet" href="home.css">
    <title>Hello App Engine</title>
    
 
  </head>

  <body>
  
  
<%     
	UserService userService = UserServiceFactory.getUserService();

	User user = userService.getCurrentUser();

	if (user != null) {

  		pageContext.setAttribute("user", user);
	}

%>
  
  <!-- Header -->
  <ul>
  <li><a class="active" href="#">Home</a></li>
  <li><a href="/post.jsp">Post</a></li>
  <%
	if(user != null){  
  %>

  <li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>"> Hello ${fn:escapeXml(user.nickname)}! Sign out</a></li>
  <%
	} else {
  %>
  <li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign in</a></li>
  <%
	}
  %>
</ul>
    <h1>Hat Blog!</h1>
    <img src="black-suede-fedora.jpeg" alt="A black suede fedora" style="width:200px;height:200px;">
    
    
    

    <table>
      <tr>
        <td colspan="2" style="font-weight:bold;">Available Servlets:</td>        
      </tr>
      <tr>
        <td><a href='/hello'>The servlet</a></td>
      </tr>
    </table>
  </body>
</html>