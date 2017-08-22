 
<%@ page import ="assignment2.DatabaseManager" %>
<%@ page import ="assignment2.DatabaseManager.Feed" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <meta charset="UTF-8">
    <title>CSCI 201 Cinemate</title>
    <link rel="stylesheet" type="text/css" href="MoviePage.css" />
    <script src="js/HandleRating.js" type="text/javascript"></script>
    
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
            
    String imdbID = request.getParameter("imdbID");
    session.setAttribute("imdbID", imdbID);
    
    String movieTitle = request.getParameter("movieTitle");
    session.setAttribute("movieTitle",movieTitle);
    
    System.out.println("movie: "+movieTitle);
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
      	  
    String profileImage = dm.getImage(loggedUser);
    String movieImage = dm.getMovieImage(imdbID);
    String genre = dm.getGenre(imdbID);
    String year = dm.getYear(imdbID);
    String director = dm.getDirector(imdbID);
    String actors = dm.getActors(imdbID);
    String writers = dm.getWriters(imdbID);
    String description = dm.getDescription(imdbID);
    String avgRating = dm.getAvgRating(imdbID);
    //String avgRating = "8";
    String imdbRating = dm.getImdbRating(imdbID);
    String[] actorsArray = actors.split(",");
    
    String follow = "";	 	 
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
      <input id="ip" type="hidden" name="ip" value=<%=ip%>></input>
      <input id="db" type="hidden" name="db" value=<%=db%>></input>
      <input id="sqluser" type="hidden" name="sqluser" value=<%=sqluser%>></input>
      <input id="sqlpswd" type="hidden" name="sqlpswd" value=<%=sqlpswd%>></input>
      <input id ="loggedUser" type="hidden" name="loggedUser" value="<%=loggedUser%>"></input>
      <input id= "movieTitle" type="hidden" name="movieTitle" value="<%=movieTitle%>"></input>
      <input id= "imdbID" type="hidden" name="imdbID" value="<%=imdbID%>"></input>
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
        <input type="submit" title ="search" id="searchButton" name="submit" value="" style="width: 20px; height: 20px; margin-top:3px;"></input>
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
    <div id="main" style="text-align: left;">
      <div id="poster" style="float: left; margin: 20px;width: 100px; height: 170px;"> 
      <img id="moviePoster" title ="<%=movieTitle %>" src="<%=movieImage %>" alt="movie" style="width: 100px; height: 170px;"/>
      <form name="watchForm"  method="GET" action ="HandleMovieActionsServlet" style="display: inline;" >
        <input type="hidden" name="action" value="watch"></input>
        <input type="hidden" name="movieTitle" value="<%=movieTitle %>"></input>
        <input type="hidden" name="imdbID" value="<%=imdbID %>"></input>
        <input id="watchButton" title ="watch" type="image" name="watch" src="a3-pngs/watched.png" style="position:relative; width:20px; height: 20px; padding: 3px;"></input>
      </form>
      <form name="likeForm" method="GET" action ="HandleMovieActionsServlet" style="display: inline;"  >
        <input type="hidden" name="action" value="like"></input>
        <input type="hidden" name="movieTitle" value="<%=movieTitle %>"></input>
         <input type="hidden" name="imdbID" value="<%=imdbID %>"></input>
        <input id="likeButton" title ="like" type="image" name="like" src="a3-pngs/liked.png"  style="position:relative; width:20px; height: 20px; padding: 3px;" ></input>
      </form>
      <form name="dislikeForm" method="GET" action ="HandleMovieActionsServlet"  style="display: inline;">
        <input type="hidden" name="action" value="dislike"></input>
        <input type="hidden" name="movieTitle" value="<%=movieTitle %>"></input>
        <input type="hidden" name="imdbID" value="<%=imdbID %>"></input>
        <input id="dislikeButton" title ="dislike" type="image" name="dislike" src="a3-pngs/disliked.png" style="position:relative; width:20px; height: 20px; padding:3px;"></input>
      </form>
      </div> 
      <h1><%=movieTitle %> (<%=year %>)</h1>
      <ul style="list-style: none;">
        <li style="color: #DCDCDC;">Genre: <%=genre %></li>
        <li style="color: #DCDCDC;">Director: <%=director %></li>
        <li style="color: #DCDCDC;">Actors: <%=actors %></li>
        <li style="color: #DCDCDC;">Writers: <%=writers %></li>
        <li> 
        <span class="rating">
        <% 
        int rating = Math.round(Integer.parseInt(avgRating));
        if (rating==10){%>
        <input type="radio" class="rating-input" id="rating-input-1-10" name="rating-input-1" onclick="handleRating('10')" checked/>
        <label for="rating-input-1-10" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-10" name="rating-input-1" onclick="handleRating('10')"/>
        <label for="rating-input-1-10" class="rating-star"></label>
        <%
        }
        if (rating==9){%>
        <input type="radio" class="rating-input" id="rating-input-1-9" name="rating-input-1" onclick="handleRating('9')"checked/>
        <label for="rating-input-1-9" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-9" name="rating-input-1" onclick="handleRating('9')"/>
        <label for="rating-input-1-9" class="rating-star"></label>
        <%
        }
        if (rating==8){%>
        <input type="radio" class="rating-input" id="rating-input-1-8" name="rating-input-1" onclick="handleRating('8')" checked/>
        <label for="rating-input-1-8" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-8" name="rating-input-1" onclick="handleRating('8')"/>
        <label for="rating-input-1-8" class="rating-star"></label>
        <%
        }
        if (rating==7){%>
        <input type="radio" class="rating-input" id="rating-input-1-7" name="rating-input-1" onclick="handleRating('7')" checked/>
        <label for="rating-input-1-7" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-7" name="rating-input-1" onclick="handleRating(7)"/>
        <label for="rating-input-1-7" class="rating-star"></label>
        <%
        }
        if (rating==6){%>
        <input type="radio" class="rating-input" id="rating-input-1-6" name="rating-input-1" onclick="handleRating('6')" checked/>
        <label for="rating-input-1-6" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-6" name="rating-input-1" onclick="handleRating('6')"/>
        <label for="rating-input-1-6" class="rating-star"></label>
        <%
        }
        if (rating==5){%>
        <input type="radio" class="rating-input" id="rating-input-1-5" name="rating-input-1" onclick="handleRating('5')" checked/>
        <label for="rating-input-1-5" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-5" name="rating-input-1" onclick="handleRating('5')"/>
        <label for="rating-input-1-5" class="rating-star"></label>
        <%
        }
        if (rating==4){%>
        <input type="radio" class="rating-input" id="rating-input-1-4" name="rating-input-1" onclick="handleRating('4')" checked/>
        <label for="rating-input-1-4" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-4" name="rating-input-1" onclick="handleRating('4')"/>
        <label for="rating-input-1-4" class="rating-star"></label>
        <%
        }
        if (rating==3){%>
        <input type="radio" class="rating-input" id="rating-input-1-3" name="rating-input-1" onclick="handleRating('3')" checked/>
        <label for="rating-input-1-3" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-3" name="rating-input-1" onclick="handleRating('3')"/>
        <label for="rating-input-1-3" class="rating-star"></label>
        <%
        }
        if (rating==2){%>
        <input type="radio" class="rating-input" id="rating-input-1-2" name="rating-input-1" onclick="handleRating('2')" checked/>
        <label for="rating-input-1-2" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-2" name="rating-input-1" onclick="handleRating('2')"/>
        <label for="rating-input-1-2" class="rating-star"></label>
        <%
        }
        if (rating==1){%>
        <input type="radio" class="rating-input" id="rating-input-1-1" name="rating-input-1" onclick="handleRating('1')" checked/>
        <label for="rating-input-1-1" class="rating-star"></label>
        <%
        }
        else {%>
        <input type="radio" class="rating-input" id="rating-input-1-1" name="rating-input-1" onclick="handleRating('1')"/>
        <label for="rating-input-1-1" class="rating-star"></label>
        <%
        }%>
        </span>
        </li>
        <%
        int imdbRatingNum = Math.round(Integer.parseInt(imdbRating));
        if (imdbRatingNum==10){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span></li>
        <% }   
         else if (imdbRatingNum==9){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==8){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==7){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span><span>☆</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==6){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==5){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==4){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>★</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==3){
        %>
        <li><span>★</span><span>★</span><span>★</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==2){
        %>
        <li><span>★</span><span>★</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span></li>
        <% }   
         else if (imdbRatingNum==1){
        %>
        <li><span>★</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span><span>☆</span></li>
        <% } %>
        <li> <%=description %></li>
      </ul>
    </div>
    <div id="bottom" style="text-align: center"> 
      <h2  style="padding: 0; margin: 0;"><u>Cast</u></h2>
      <table style="margin-left: 40%; border-spacing: 10px;">
  
      <%
        for (int i =0; i<actorsArray.length; i++){
        	if (actorsArray[i]==null){
        	    break;
        	}
            String actorImage = dm.getActorImage(actorsArray[i]);%>
          <tr style="float: center; text-align: center;">
        	<td>
          	  <img title="<%=actorsArray[i]%>" src="<%=actorImage %>" alt="actor" style="width: 70px; height: 100px;"></img>
          	</td>
          	<td>
          	  <h3 style="float: left; color: white;"><%=actorsArray[i] %></h3>
          	</td>
         </tr>
        <%
        }%>
        
      </table>
    </div>
  </div>
</body>
</html>
    