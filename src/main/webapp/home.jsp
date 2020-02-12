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
  
  <!-- Header -->
  <ul>
  <li><a class="active" href="#">Home</a></li>
  <li><a href="/post.jsp">Post</a></li>

  <li><a href="#about">About</a></li>
</ul>
    <h1>Hat Blog!</h1>
    
    

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