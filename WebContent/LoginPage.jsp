<%@ page import="assignment2.DatabaseManager" %>
<%@ page import="assignment2.DatabaseManager.Feed" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <title>CSCI 201 Cinemate</title>
    <link rel="stylesheet" type="text/css" href="assignment3.css" />
    
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
  </head>
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
    
    String username = (String) session.getAttribute("username");
    session.setAttribute("loggedUsername", username);
    //System.out.println("logged user: "+username);
  %>
  <%
 	String errorMessage = (String) session.getAttribute( "errorMessage" );
    if ( errorMessage !=null){
  %>
    	<p style="color:red"><%= errorMessage %> </p>
  <% 
    	session.removeAttribute("errorMessage");
    } 
  %>
  <%
	final DatabaseManager dm = new DatabaseManager(ip,db,sqluser,sqlpswd);
    Feed[] myFeeds = dm.getFeed(username); 	 
    String profileImage = dm.getImage(username);
    session.setAttribute("profileImage", profileImage);
  %>
    <div id="top">
      <input type="hidden" name="ip" value=<%=ip%>></input>
      <input type="hidden" name="db" value=<%=db%>></input>
      <input type="hidden" name="sqluser" value=<%=sqluser%>></input>
      <input type="hidden" name="sqlpswd" value=<%=sqlpswd%>></input>
      <form name="feedForm" method="GET" action ="LoginPage.jsp" style="display:inline;">
        <input type="hidden" name="username" value=<%=username %>></input>
        <input type="image" id="feedButton" title="view feed" src="a3-pngs/feed_icon.png" alt="feed" style="width: 35px; height:35px"/>
      </form>
      <form name="profileForm" method="GET" action ="ProfilePage.jsp" style="display:inline;"> 
        <input type="hidden" name="username" value=<%=username %>></input>
        <input type="image" title="view profile" id="profileButton" src=<%=profileImage%> alt="profile" style="border-radius: 50%; width: 35px; height:35px"/>
      </form>
      <form name="searchForm" method="GET" action="SearchResultServlet" style="display: inline; margin-top:5px; padding:0; position: absolute;">
        <div class="wrapper">
          <input id = "searchBox" type="text" name = "searchMaterial" value = "Search Movies" style="border-style: none; padding:0;margin:0;"/>
          <input id="searchType" type="hidden" name="searchType" value="movie"></input>
          <img id="searchToggle_clapperboard" title="toggle search type" src="a3-pngs/clapperboard_icon.png" alt="search" style="width: 20px; height:20px; margin-top: 2px;" onclick="changeSearchToggleImage()"/>   
       </div>
       <input type="submit" id="searchButton" title="search" name="submit" value="" style="width: 20px; height: 20px; margin-top:3px;"></input>
      </form>
      <input type ="image" id="cinemate" src="a3-pngs/cinemate_1.png" alt="cinemate" style="margin-left: 40%; width: 140px; height:40px"/>
      
      <div id="top-right">
        <form name="logoutForm" method="GET" action ="peifeili_login.jsp" style="display:inline;"> 
          <input type="image" title="log out" id="logoutButton" src="a3-pngs/logout_icon.png" alt="logout" style="width: 35px; height:35px"/>
        </form>
        <form name="exitForm" method="GET" action ="peifeili_login.jsp" style="display:inline;"> 
          <input type ="image" title="exit" id="exitButton" src="a3-pngs/exit_icon.jpg" alt="exit" style="width: 35px; height:35px"/>
        </form>
      </div>
    </div>
    <div id="main">
      <div id="innerMain">
        <table align="center" style="margin-top: 80px;" cellspacing=30px;>
        <%for (int i = 0; i < myFeeds.length; i++) {
        	if (myFeeds[i]==null){
        	    break;
        	}%>
          <tr>
            <%
            System.out.println("feeder: "+myFeeds[i].username);
            String image = dm.getImage(myFeeds[i].username); 
            String action = myFeeds[i].action;
            String feedTime = myFeeds[i].feedTime;
            String movie = dm.getMovieImage(myFeeds[i].imdbID);
            %>
            <td>
            <form name="profileForm" method="GET" action ="ProfilePage.jsp" style="display:inline;"> 
            	<input type="hidden" name="username" value=<%=myFeeds[i].username %>></input>
            	<input type="image" src="<%=image %>" title="<%= dm.getFname(myFeeds[i].username)+ " "+dm.getLname(myFeeds[i].username)%>"alt="userImage" style="border-radius: 50%; width: 100px; height:100px;"></input>
            </form>
            </td>
            <%
            if (action.equals("liked")||action.equals("Liked")) {
            %>
            <td><img src="a3-pngs/liked.png" alt="actionImage" title="liked" style="width: 100px; height:100px;"></td>
            <%
            }
            else if (action.equals("disliked")||action.equals("Disliked")){%>
            <td><img src="a3-pngs/disliked.png" alt="actionImage" title ="disliked" style="width: 100px; height:100px;"></td>
            <%
            }
            else if (action.equals("watched")||action.equals("Watched")){%>
            <td><img src="a3-pngs/watched.png" alt="actionImage" title ="watched" style="width: 100px; height:100px;"></td>
            <%
            }
            else if (action.equals("rated")||action.equals("Rated")){
            	long roundedRating = Math.round((myFeeds[i].rating)/(double) 2);
                if (roundedRating==(long) 0 || roundedRating==(long)1){
                %>
                <td><img src="a3-pngs/rating1.png" alt="actionImage" title="rated"></td>
                <%
                }
                else if (roundedRating==(long)2){
                %>
                <td><img src="a3-pngs/rating2.png" alt="actionImage" title="rated"></td>
                <%
                }
                else if (roundedRating==(long)3){
                %>
                <td><img src="a3-pngs/rating3.png" alt="actionImage" title="rated"></td>
                <%
                }
                else if (roundedRating==(long)4){
                %>
                <td><img src="a3-pngs/rating4.png" alt="actionImage" title="rated"></td>
                <%
                }
                else if (roundedRating==(long)5){
                %>
                <td><img src="a3-pngs/rating5.png" alt="actionImage" title="rated"></td>
                <%
                }
              }%>
               
              <td>
             	<form name="movieForm" method="GET" action ="MoviePage.jsp" style="display:inline;"> 
              		<input type="hidden" id="imdbID" name="imdbID" value="<%=myFeeds[i].imdbID %>"></input>
              		<input type="hidden" id="movieTitle" name="movieTitle" value="<%=myFeeds[i].movie %>"></input>
              		<input type="image" src="<%=movie %>" title="<%=myFeeds[i].movie%>" alt="movieImage"  style="width: 90px; height:140px"></input>
              	</form>
              </td>
              <td style="color:#09478E; size:15px"><%=feedTime %></td>
          </tr>
          <%
            } 
            %>
        </table>
      </div>
    </div>
  </body>
</html>