<%@ page import="assignment2.DatabaseManager" %>
<%@ page import="assignment2.DatabaseManager.Feed" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <title>CSCI 201 Cinemate</title>
    <link rel="stylesheet" type="text/css" href="ViewProfile.css" />
    <script src="js/FollowUser.js" type="text/javascript"></script>
  </head>
  <%
  	String ip = (String) session.getAttribute("ip");
  	String db = (String) session.getAttribute("db");
  	String sqluser = (String) session.getAttribute("sqluser");
  	String sqlpswd = (String) session.getAttribute("sqlpswd");
          
  	session.setAttribute("ip", ip);
  	session.setAttribute("db", db);
  	session.setAttribute("sqluser", sqluser);
  	session.setAttribute("sqlpswd", sqlpswd);
  
  	String loggedUser = (String) session.getAttribute("loggedUsername");
  	session.setAttribute("loggedUsername", loggedUser);
         
  	String username = request.getParameter("username");            
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
  System.out.println("!username: "+username);
    String fname = dm.getFname(username);
    
    fname = fname.substring(0, 1).toUpperCase() + fname.substring(1);
    String lname = dm.getLname(username);
    lname = lname.substring(0, 1).toUpperCase() + lname.substring(1);
      	 	
    String followingsList = dm.getFollowingsList(username);
    
    String [] followingsListParsed = followingsList.split("%");
      	 	
    String followersList = dm.getFollowersList(username);
    
    String [] followersListParsed = followersList.split("%");
      	 	     	 	
    String profileImage = dm.getImage(loggedUser);
    String image = dm.getImage(username);
      	 	
    Feed[] myFeeds = dm.getMyFeed(username); 	
      
    String follow = "";
    String currUser = username;
    boolean checkFollow = dm.checkFollow(loggedUser, currUser);
    if (!checkFollow){
    	follow = "Follow";
    }
    else {
    	follow = "Unfollow";
    }
  %>
  <style type ="text/css">
    a {
      color : white;
    }
    a: hover {
      color : blue;
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
    <div class="title">
      <div id="top" >
      <input type="hidden" id="ip" name="ip" value=<%=ip%>></input>
      <input type="hidden" id="db" name="db" value=<%=db%>></input>
      <input type="hidden" id="sqluser" name="sqluser" value=<%=sqluser%>></input>
      <input type="hidden" id="sqlpswd" name="sqlpswd" value=<%=sqlpswd%>></input>
      <input id ="loggedUser" type="hidden" name="loggedUser" value=<%=loggedUser%>></input>
      <input id= "currUser" type="hidden" name="currUser" value=<%=currUser%>></input>
      
      <form name="feedForm" method="GET" action ="LoginPage.jsp" style="display:inline;">
        <input type="hidden" name="username" value=<%=loggedUser %>></input>
        <input type="image" title ="view feed" id="feedButton" src="a3-pngs/feed_icon.png" alt="feed" style="width: 35px; height:35px"/>
      </form>
      <form name="profileForm" method="GET" action ="ProfilePage.jsp" style="display:inline;"> 
        <input type="hidden" name="username" value=<%=loggedUser %>></input>
        <input type="image" title ="view profile" id="profileButton" src=<%=profileImage%> alt="profile" style="border-radius: 50%; width: 35px; height:35px"/>
      </form>
      
      <form name="searchForm" method="GET" action="SearchResultServlet" style="display: inline; margin-top:5px; padding:0; position: absolute;">
        <div class="wrapper">
          <input id = "searchBox" type="text" name = "searchMaterial" value = "Search Movies" style="border-style: none; padding:0;margin:0;"/>
          <input id="searchType" type="hidden" name="searchType" value="movie"></input>
          <img id="searchToggle_clapperboard" title ="toggle search type" src="a3-pngs/clapperboard_icon.png" alt="search" style="width: 20px; height:20px; margin-top: 2px;" onclick="changeSearchToggleImage()"/>   
        </div>
        <input type="submit" id="searchButton" title ="search" name="submit" value="" style="width: 20px; height: 20px; margin-top:3px;"></input>
       </form>
      
      <img id="cinemate" src="a3-pngs/cinemate_1.png" alt="cinemate" style="margin-left: 40%; width: 140px; height:40px"/>
      <div id="top-right">
        <form name="logoutForm" method="GET" action ="peifeili_login.jsp" style="display:inline;"> 
          <input type="image" title ="log out" id="logoutButton" src="a3-pngs/logout_icon.png" alt="logout" style="width: 35px; height:35px"/>
        </form>
        <form name="exitForm" method="GET" action ="peifeili_login.jsp" style="display:inline;"> 
          <input type ="image" title ="exit" id="exitButton" src="a3-pngs/exit_icon.jpg" alt="exit" style="width: 35px; height:35px"/>
        </form>
      </div>
    </div>
      <div id ="main">
      	 	<img title ="<%=fname+ " "+ lname %>" src="<%=image %>" alt="userImage" style="width:100px;height:100px;border-radius: 50%;padding:10px;">
      	 	<h1 style="padding: 0; margin: 0;"> <%=fname%> <%=lname %></h1>
      	 	<h3 style="padding: 0; margin: 0;">@<%=username %></h3>
      	 	<input id="followButton" style="margin-left: 90%; background-color: #306ccc;" type="button" name="follow" value="<%=follow%>" onclick="handleFollowButton()"></input>
      	</div>
      </div>
      <div id="bottom-left">
        <div id="bottom-left-top">
          <h3 style="text-align:center;margin:0;margin-top:10px;">Followers</h3>
        </div>
        <div id="bottom-left-bottom">
          <ul id="followersPart" style="color:white; text-align:center; font-weight:bold; font-size: 20px;list-style-type:none; margin: 0; padding: 0;">
          <% for (int i = 0; i < followersListParsed.length; i++){ %>
          <li>
          <form name="profileForm" method="GET" action ="ProfilePage.jsp" style="display:inline;">          	        
            <input type="hidden" name="username" value="<%=followersListParsed[i] %>"></input>
          	<input type="submit" style=" background: none; border: none; color: white;" value= "<%=followersListParsed[i] %>"></input>         	         
          </form>
            </li>
          <%}%>
          </ul>
        </div>
      </div>
      <div id="bottom-middle">
      <table align="center" style="margin-top: 80px;" cellspacing=10px;>
      <%
        for (int i = 0; i < myFeeds.length; i++) {
        	if (myFeeds[i]==null){
        	    break;
        	} 
        String action = myFeeds[i].action;
        String movie = myFeeds[i].movie;
        String imdbID = myFeeds[i].imdbID;
        String feedTime = myFeeds[i].feedTime;
        Double rating = myFeeds[i].rating;
        System.out.println(movie+"'s rating: "+rating);
      %>
        <tr> 
          <% 
            if (action.equals("liked")||action.equals("Liked")) {
            %>
            <td><img title ="liked" src="a3-pngs/liked.png" alt="actionImage" style="width: 20px; height:20px;">liked</td>
            <%
            }
            else if (action.equals("disliked")||action.equals("Disliked")){ %>
            <td><img title ="disliked" src="a3-pngs/disliked.png" alt="actionImage" style="width: 20px; height:20px;">disliked</td>
            <%
            }
            else if (action.equals("watched")||action.equals("Watched")){%>
            <td><img title ="watched" src="a3-pngs/watched.png" alt="actionImage" style="width: 20px; height:20px;">watched</td>
            <%
            }
            else if (action.equals("rated")||(action.equals("Rated"))){
            	long roundedRating = Math.round((myFeeds[i].rating)/(double) 2);
                if (roundedRating==(long) 0 || roundedRating==(long)1){
                %>
                <td><img title ="rated" src="a3-pngs/rating1.png" alt="actionImage">rated</td>
                <%
                }
                else if (roundedRating==(long)2){
                %>
                <td><img title ="rated" src="a3-pngs/rating2.png" alt="actionImage" >rated</td>
                <%
                }
                else if (roundedRating==(long)3){
                %>
                <td><img title ="rated" src="a3-pngs/rating3.png" alt="actionImage">rated</td>
                <%
                }
                else if (roundedRating==(long)4){
                %>
                <td><img title ="rated" src="a3-pngs/rating4.png" alt="actionImage">rated</td>
                <%
                }
                else if (roundedRating==(long)5){
                %>
                <td><img title ="rated" src="a3-pngs/rating5.png" alt="actionImage">rated</td>
                <%
                }
              }%>
              <td >
              	<form name="movieForm" method="GET" action ="MoviePage.jsp" style="display:inline;">          	        
          	  		<input type="hidden" name="movieTitle" value="<%=movie%>"></input>
          	  		<input type="hidden" name="imdbID" value="<%=imdbID%>"></input>
          	    	<input type="submit" style=" background: none; border: none; color: #306ccc;" value= "<%=movie%>"></input>       	         
          	  	</form>
              </td>
              <td style="color:#09478E; size:15px"><%=feedTime %></td>
            </tr>
          <%
          } 
          %>
        </table>
      </div>
      <div id="bottom-right">
        <div id="bottom-right-top">
          <h3 style="text-align:center;margin:0;margin-top:10px;">Following</h3>
        </div>
        <div id="bottom-right-bottom">
          <ul id= "followingsPart" style="color:white; text-align:center; font-weight:bold; font-size: 20px;list-style-type: none;margin: 0; padding: 0;">
          <% for (int i = 0; i < followingsListParsed.length; i++){ %>
            <li>
          <form name="profileForm" method="GET" action ="ProfilePage.jsp" style="display:inline;">        	        
            <input type="hidden" name="username" value="<%=followingsListParsed[i] %>"></input>
          	<input type="submit" style=" background: none; border: none; color: white;" value= "<%=followingsListParsed[i] %>"></input>          	         
          </form>
            </li>
          <%
          }%>
          </ul>
        </div>
      </div>
     
    </div>
  </body>
</html>