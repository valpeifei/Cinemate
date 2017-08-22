<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <title>CSCI 201 Cinemate</title>
     <link rel="stylesheet" type="text/css" href="SearchResults.css" />
  </head>
  
  <style type ="text/css">
    tr{
        background-color: #9BC3F0; 
        color: white;
        margin-left:20px;
    }
    tr:hover{
        background-color: white;
        color: #9BC3F0;
    }
     
  </style>
  <script language="javascript" type="text/javascript">
  function changeSearchToggleImage(){
	  if (document.getElementById("searchToggle_clapperboard").getAttribute('src') == "a3-pngs/user_icon.png"){
		  document.getElementById("searchToggle_clapperboard").src = "a3-pngs/clapperboard_icon.png";
		  document.getElementById("searchBox").value = "Search Movies";
		  document.getElementById("searchType").value = "movie";
	  }
	  else if (document.getElementById("searchToggle_clapperboard").getAttribute('src') == "a3-pngs/clapperboard_icon.png"){
		  document.getElementById("searchToggle_clapperboard").src = "a3-pngs/user_icon.png";
		  document.getElementById("searchBox").value = "Search Users";
		  document.getElementById("searchType").value = "user";
	  }
  }
  </script>
  <body>
  <%
  	String ip = (String) session.getAttribute("ip");
	String db = (String) session.getAttribute("db");
	String sqluser = (String) session.getAttribute("sqluser");
	String sqlpswd = (String) session.getAttribute("sqlpswd");
        
	session.setAttribute("ip", ip);
	session.setAttribute("db", db);
	session.setAttribute("sqluser", sqluser);
	session.setAttribute("sqlpswd", sqlpswd);
	
   	String profileImage = (String) session.getAttribute("profileImage");
   	session.setAttribute("profileImage", profileImage);
  
   	String loggedUser = (String) session.getAttribute("loggedUsername");
   	session.setAttribute("loggedUsername", loggedUser);
   
    String[] results = (String[]) session.getAttribute("results");
    String[] imdbIDs = (String[]) session.getAttribute("imdbIDs");
    
    String searchType = (String)session.getAttribute("searchType");
 %>
  <%
     String errorMessage = (String) session.getAttribute( "errorMessage" );
  %>
    <div id="top" >
      <input type="hidden" id="ip" name="ip" value=<%=ip%>></input>
      <input type="hidden" id="db" name="db" value=<%=db%>></input>
      <input type="hidden" id="sqluser" name="sqluser" value=<%=sqluser%>></input>
      <input type="hidden" id="sqlpswd" name="sqlpswd" value=<%=sqlpswd%>></input>
      <form name="feedForm" method="GET" action ="LoginPage.jsp" style="display:inline;">
        <input type="hidden" name="username" value=<%=loggedUser %>></input>
        <input title="view feed" type="image" id="feedButton" src="a3-pngs/feed_icon.png" alt="feed" style="width: 35px; height:35px"/>
      </form>
      <form name="profileForm" method="GET" action ="ProfilePage.jsp" style="display:inline;"> 
        <input type="hidden" name="username" value=<%=loggedUser %>></input>
        <input title="view profile" type="image" id="profileButton" src=<%=profileImage%> alt="profile" style="border-radius: 50%; width: 35px; height:35px"/>
      </form>
      <form name="searchForm" method="GET" action="SearchResultServlet" style="display: inline; margin-top:5px; padding:0; position: absolute;">
        <div class="wrapper">
          <input id = "searchBox" type="text" name = "searchMaterial" value = "Search Movies" style="border-style: none; padding:0;margin:0;"/>
          <input  id="searchType" type="hidden" name="searchType" value="movie"></input>
          <img title="toggle search type" id="searchToggle_clapperboard" src="a3-pngs/clapperboard_icon.png" alt="search" style="width: 20px; height:20px; margin-top: 2px;" onclick="changeSearchToggleImage()"/>   
       </div>
       <input title="search" type="submit" id="searchButton" name="submit" value="" style="width: 20px; height: 20px; margin-top:3px;"></input>
     </form>
      
      <img id="cinemate" src="a3-pngs/cinemate_1.png" alt="cinemate" style="margin-left: 40%; width: 140px; height:40px"/>
      <div id="top-right">
        <form name="logoutForm" method="GET" action ="peifeili_login.jsp" style="display:inline;"> 
          <input title="log out" type="image" id="logoutButton" src="a3-pngs/logout_icon.png" alt="logout" style="width: 35px; height:35px"/>
        </form>
        <form name="exitForm" method="GET" action ="peifeili_login.jsp" style="display:inline;">        
          <input title="exit" type ="image" id="exitButton" src="a3-pngs/exit_icon.jpg" alt="exit" style="width: 35px; height:35px"></input>    
        </form>
      </div>
    </div>
      <div id ="main" >
      	<div id ="innerMain" style ="margin-top:10px; height:95%; width: 50%;">
      	  <div class="resultForm" style="margin-left: 150px; margin-top: 100px; height:200px; width:350px;text-aligned: center; overflow:auto;">
      	    <table cellspacing="0" style="text-aligned: center;overflow:auto; height: 10px;">
      	      <tr>
          	      <td style="width: 320px;color:#09478E; background-color:white; display: inline-block; float:left;">Search Results</td>
              </tr>
              <% if (results!=null){
                     for(int i = 0; i < results.length; i++) { 
                         if (results[i]==null){
                             break;
                         }
              %>
        		<tr>
        		  <% if (searchType.equals("user")){%>
        		  <form name="profileForm" method="GET" action ="ProfilePage.jsp" style="display:inline;"> 
          	        <td style="padding:3px;display: inline-block; float:left;margin-left:20px;">
          	        	<input type="hidden" name="username" value="<%=results[i] %>"></input>
          	        	<input type="submit" style=" background: none; border: none; color: white;" value= "<%=results[i] %>"></input>
          	        </td>
          	      </form>
          	      <% }
          	      else { %>
          	      <form name="movieForm" method="GET" action ="MoviePage.jsp" style="display:inline;"> 
          	        <td style="padding:3px;display: inline-block; float:left;margin-left:20px;">
          	        	<input type="hidden" name="movieTitle" value="<%=results[i]%>"></input>
          	        	<input type="hidden" name="imdbID" value="<%=imdbIDs[i]%>"></input>
          	        	<input type="submit" style=" background: none; border: none; color: white;" value= "<%=results[i] %>"></input>
          	        </td>
          	      </form>
          	      
          	      <% } %>
                </tr>
                <% 
                     }
                } //remove result movies attribute
                session.removeAttribute("results");
                session.removeAttribute("imdbIDs");
                %>
            </table>
      	  </div> 
      	</div>
      </div>
      <div id="bottom">
      </div>
    </div>
  </body>
</html>