<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  	String ip = (String) session.getAttribute("ip");
	String db = (String) session.getAttribute("db");
	String sqluser = (String) session.getAttribute("sqluser");
	String sqlpswd = (String) session.getAttribute("sqlpswd");
     
  	session.setAttribute("ip", ip);
  	session.setAttribute("db", db);
  	session.setAttribute("sqluser", sqluser);
  	session.setAttribute("sqlpswd", sqlpswd);
  %>
            
  <body>
    <div class="title">
      <div id="top">
        <h1>Cinemate</h1>
        <p>File parsed! Please log in. </p>
      </div>
      <div id ="main">
      	<div id ="innerMain" style ="margin-top: 80px; height:60%">
      	  <div class = "form">
      	    
      	    <form name="signupform" id ="signupform"  >
      	      <table> 
      	        <tr>
          		  <td><input type="hidden" id="ip" name="ip" value=<%=ip%>></input></td>
          		</tr>
          		<tr>
     			  <td><input type="hidden" id="db" name="db" value=<%=db%>></input></td>
     			</tr>
     			<tr>
                  <td><input type="hidden" id="sqluser" name="sqluser" value=<%=sqluser%>></input></td>
                </tr>
                <tr>
                  <td><input type="hidden" id="sqlpswd" name="sqlpswd" value=<%=sqlpswd%>></input></td>
        		</tr>
          		<tr>
          		  <td><input type="fullname" id="fullname" name="fullname" placeholder="Full Name" style= "width:200px"/></td>
        		</tr>
        		<tr>
          		 <td><input type="username" id="username" name="username" placeholder="Username" style= "width:200px"/></td>
          		</tr>
          		<tr>
                  <td><input type="password" id="password" name="password" placeholder="Password"style= "width:200px"/></td>
        		</tr>
        		<tr>
                  <td><input type="imageurl" id="imageurl" name="imageurl" placeholder="Image URL" style= "margin-bottom: 20px; width:200px"/></td>
        		</tr>
                <tr>
	              <td><input type ="button" name="submit" value="Sign Up" onclick="signUpValidate()" style="width: 200px"/></td>
	            </tr>
	          </table>
            </form> 
            <%
            String errorMessage = (String) session.getAttribute( "errorMessage" );
      	 	if ( errorMessage !=null){
      		%>
      	 		<p style="color:red"><%= errorMessage %> </p>
      	 	<% 
      	 		session.removeAttribute("errorMessage");
      	 	} 
      	 	%> 
             <div id="error" style="color: red;">
             </div>
            
      	  </div> 
      	</div>
      </div>
      <div id="bottom">
      </div>
    </div>
  </body>
</html>