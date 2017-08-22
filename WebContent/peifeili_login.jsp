<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="assignment2.ParseConfig" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <title>CSCI 201 Cinemate</title>
    <link rel="stylesheet" type="text/css" href="assignment2.css" />
    <script src="js/Validation.js" type="text/javascript"></script>
  </head>
  <style type ="text/css">
	.colorable {
		color: white;
	}
	.button {
	     
	}
  </style>
  <%
  	ParseConfig pc = new ParseConfig();
  	String[] mConfig = pc.parse();
  	String ip = mConfig[0];
  	String db = mConfig[1];
  	String sqluser = mConfig[2];
  	String sqlpswd = mConfig[3];
  	/*System.out.println("ip: "+ip);
  	System.out.println("db: "+db);
  	System.out.println("sqluser: "+sqluser);
  	System.out.println("sqlpswd: "+sqlpswd);*/
  	session.setAttribute("ip", ip);
  	session.setAttribute("db", db);
  	session.setAttribute("sqluser", sqluser);
  	session.setAttribute("sqlpswd", sqlpswd);
           
  %>
  <body>
    <div class="title">
      <div id="top">
        <h1>Cinemate</h1>
        <p>Welcome to Cinemate! Please log in. </p>
      </div>
      <div id ="main">
      	<div id ="innerMain" style ="margin-top: 80px; height:60%">
      	  <div class = "form">
      	    <form name="classform">
      	      <table>
        		<tr>
          		  <td class="colorable" style="text-align: left">Username</td>
          		</tr>
          		<tr>
          		  <td><input type="hidden" id="ip" name="ip" value="<%=ip %>" style= "width:200px"/></td>
        		</tr>
        		<tr>
          		  <td><input type="hidden" id="db" name="db" value="<%=db%>" style= "width:200px"/></td>
        		</tr>
        		<tr>
          		  <td><input type="hidden" id="sqluser" name="sqluser" value="<%=sqluser %>" style= "width:200px"/></td>
        		</tr>
        		<tr>
          		  <td><input type="hidden" id="sqlpswd" name="sqlpswd" value="<%=sqlpswd%>" style= "width:200px"/></td>
        		</tr>
          		<tr>
          		  <td><input type="username" id="username" name="username" style= "width:200px"/></td>
        		</tr>
        		<tr>
          		  <td class="colorable" style="text-align: left">Password</td>
          		</tr>
          		<tr>
                  <td><input type="password" id="password" name="password" style= "margin-bottom: 20px; width:200px"/></td>
        		</tr>
                <tr>
	              <td><input type ="button" name="submit" value="Log In" onclick="loginValidate()" style="width: 200px" /></td>
	            </tr>
	          </table>
            </form>  
            <form name="signup" method = "GET" action = "SignUp.jsp" >
	          <input type ="submit" name="signup" value="Sign Up" style="width: 200px" /> 
            </form>
            <div id="error" style="color: red;">
             </div>
            
            <%
            String errorMessage = (String) session.getAttribute( "errorMessage" );
      	 	if ( errorMessage !=null){
      		%>
      	 		<p style="color:red"><%= errorMessage %> </p>
      	 	<% 
      	 		session.removeAttribute("errorMessage");
      	 	} 
      	 	%>
      	  </div> 
      	</div>
      </div>
      <div id="bottom">
      </div>
    </div>
  </body>
</html>