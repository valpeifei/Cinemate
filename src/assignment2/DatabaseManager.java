package assignment2;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URI;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.nio.charset.Charset;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

public class DatabaseManager {
	String url;
	Connection conn = null;
    Statement st = null;
    Statement st1 = null;
    ResultSet rs = null;
    ResultSet rs1 = null;
    public class Actor {
		public String fname;
		public String lname;
		public String image;
		public String fullname;
		public Actor(String mFname, String mLname,String mImage,String mFullname){
			fname = mFname;
			lname = mLname;
			image = mImage;
			fullname = mFullname;
		}
	}
	public class Feed {
		public String action;
		public String movie;
		public String imdbID;
		public Double rating;
		public String username;
		public String feedTime;
		
		public Feed (String mUsername, String mAction, String mMovie, String mID, Double mRating, String mfeedTime){
			username = mUsername;
			action = mAction;
			movie = mMovie;
			rating  = mRating;
			imdbID = mID;
			feedTime = mfeedTime;
		}
	}
	public DatabaseManager(String ip, String db, String username, String password){
	    url = "jdbc:mysql://"+ip;
	    url +="/"+db + "?user=";
	    url +=username + "&password=";
	    url +=password;
	    try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(url+"&useSSL=false");
	        st = conn.createStatement();
	        st1 = conn.createStatement();
	        
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void handleMovieAction(String loggedUser, String action, String movieTitle,String imdbID, String time){
		if (action.equals("watch")){
			addFeed(loggedUser, "Watched", movieTitle, imdbID, 0,time);
		}
		else if (action.equals("like")){
			addFeed(loggedUser, "Liked", movieTitle, imdbID, 0,time);
		}
		else if (action.equals("dislike")){
			addFeed(loggedUser, "Disliked", movieTitle, imdbID, 0,time);
		}
	}
	public String getGenre(String imdbID){
		String genres = "";
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		    
			genres = (String) json.get("Genre");
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return genres;
	}
	public String getYear(String imdbID){
		String year = "";
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		   
			 
			year = (String) json.get("Year");
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return year;
	}
	public String getDirector(String imdbID){
		String director = "";
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		   
			 
			director = (String) json.get("Director");
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return director;
	}
	public String getDescription(String imdbID){
		String plot = "";
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		   
			 
			plot = (String) json.get("Plot");
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return plot;
	}
	public String getAvgRating(String imdbID){
		int count = 0;
		double total = 0;
		try {
			//ResultSet rs;
	        rs = st.executeQuery("SELECT rating FROM Feed WHERE imdbID='"+imdbID+"'");	
	        
	        if (rs.next()){
	        	do {
	        		double rating = rs.getDouble("rating");
	        		if (rating != 0){
	        			total += rating;
	        			count++;
	        		}
	            }while (rs.next());
	        }
	        else {
	        	return "0";
	        }
			//conn.close();
		 } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		 }
		double avg = total/(double)count;
		 
		int avg_int = (int) Math.round(avg);
		 
		return Integer.toString(avg_int);
	}
	public String getImdbRating(String imdbID){
		String rating = "";
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		   
			double temp = json.getDouble("imdbRating");
			int avg_int = (int) Math.round(temp);
			rating = Integer.toString(avg_int);
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		
		
		return rating;
	}
	public String getActors(String imdbID){
		String actors="";
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		   
			actors = (String) json.get("Actors");
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
		return actors;
	}
	public String getWriters(String imdbID){
		String writers = "";
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		   
			writers = (String) json.get("Writer");
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return writers;
	}
	public String[] searchByActor (String actor){
		 
		String[] splited = actor.split("\\s+");
		String fname = splited[0];
		fname+="%20";
		String lname = splited[1];
		String name = fname+lname;
		 
		String[] results = new String[100];
		try {
			URLConnection connection = new URL("https://api.themoviedb.org/3/search/person?api_key=bd745389f8db8af86d48363dcea46dd8&language=en-US&query=" + URLEncoder.encode(name, "UTF-8")+"&page=1&include_adult=true").openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		     
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		     
		    JSONArray jsonArray = json.getJSONArray("results");
		    if (jsonArray.length()==0){
		    	return results;
		    }
		    JSONObject json1 = (JSONObject) jsonArray.getJSONObject(0);
		     
		    JSONArray jsonArray1 = json1.getJSONArray("known_for");
		     
		    for (int i = 0; i < jsonArray1.length(); i++) {
		       results[i]= (String) jsonArray1.getJSONObject(i).get("title");
		       
		    }
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return results;
		 
	}
	public String getImdbID(String tmdbID){
		String result = "";
		try {
			URLConnection connection = new URL("https://api.themoviedb.org/3/movie/" + URLEncoder.encode(tmdbID, "UTF-8")+"?api_key=bd745389f8db8af86d48363dcea46dd8&language=en-US").openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		     
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
			 
			result = (json.get("imdb_id")).toString();
		 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return result;
	}
	public String[] searchByActorID(String actor){
		String[] splited = actor.split("\\s+");
		String fname = splited[0];
		fname+="%20";
		String lname = splited[1];
		String name = fname+lname;
	 
		String[] results = new String[100];
		try {
			URLConnection connection = new URL("https://api.themoviedb.org/3/search/person?api_key=bd745389f8db8af86d48363dcea46dd8&language=en-US&query=" + URLEncoder.encode(name, "UTF-8")+"&page=1&include_adult=true").openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		     
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		     
		    JSONArray jsonArray = json.getJSONArray("results");
		    if (jsonArray.length()==0){
		    	return results;
		    }
		    JSONObject json1 = (JSONObject) jsonArray.getJSONObject(0);
		     
		    JSONArray jsonArray1 = json1.getJSONArray("known_for");
		     
		    for (int i = 0; i < jsonArray1.length(); i++) {
		       String id = (jsonArray1.getJSONObject(i).get("id")).toString();
		       results[i] = getImdbID(id);
		       System.out.println("json imdbID: "+results[i]);
		    }
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return results;
		 
	}
	public String[] searchByTitle (String title){
		String[] results = new String[100];
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?s=" + URLEncoder.encode(title, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		  
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		    if (json.has("Response")){
		    	 
		    	return results;
		    }
		    else {
		    	 
		    JSONArray jsonArray = json.getJSONArray("Search");
		    
		    for (int i = 0; i < jsonArray.length(); i++) {
		       results[i]= (String) jsonArray.getJSONObject(i).get("Title");
		       
		    }
		    }
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return results;
	}
	public String[] searchByTitleID(String title){
		String[] results = new String[100];
		try {
			URLConnection connection = new URL("http://www.omdbapi.com/?s=" + URLEncoder.encode(title, "UTF-8")).openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		  
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		    if (json.has("Response")){
		    	 
		    	return results;
		    }
		    JSONArray jsonArray = json.getJSONArray("Search");
		    for (int i = 0; i < jsonArray.length(); i++) {
		       results[i]= (String) jsonArray.getJSONObject(i).get("imdbID");
		       
		    }
			 
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return results;
	}
	public void handleFollow(String loggedUser, String currUser){
		boolean check = checkFollow(loggedUser, currUser);
		if (check){ //do unfollow
			System.out.println(loggedUser+"unfollow "+currUser);
			removeFollowing(loggedUser, currUser);
		}
		else { //do follow
			System.out.println(loggedUser+"follow "+currUser);
			addFollowing(loggedUser, currUser);
		}
	}
	public String[] searchUser (String user){
		String [] resultUsers = new String[1000];
		try {
			//ResultSet rs;
	        rs = st.executeQuery("SELECT username,fname,lname FROM Users");	
	        int index = 0;
	        if (rs.next()){
	        	do {
	        		String username = rs.getString("username");
	            	String fname = rs.getString("fname");
	            	String lname = rs.getString("lname");
	            	if (username.equalsIgnoreCase(user)||fname.equalsIgnoreCase(user)||lname.equalsIgnoreCase(user)){
	            		resultUsers[index] = username;
	            		index++;
	            	}
	            }while (rs.next());
	        }
			//conn.close();
		 } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		 }
		 return resultUsers;
	}
	public String getFollowingsList(String mUsername){
		String followingsList = "";
		try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT following FROM Following WHERE username='" + mUsername+"'");			 
            if (rs.next()){
            	do {
            		String following = rs.getString("following");
            		followingsList += following;
            		followingsList += '%';
            	}while (rs.next());
            }
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return followingsList;
	}
	public String getFollowersList(String mUsername){
		String followersList = "";
		try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT username FROM Following WHERE following='" + mUsername+"'");			 
            if(rs.next()){
            	do {
            		String follower = rs.getString("username");
            		followersList += follower;
            		followersList += '%';
            	}while (rs.next());
            }
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return followersList;
	}
	public Feed[] getFeed(String mUsername){
		Feed[] feeds = new Feed[1000];
		int i = 0;
		try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT following FROM Following WHERE username='" + mUsername+"'");
            while (rs.next()) {
	        	String following = rs.getString("following");
	        	System.out.println("following: "+following);
	        	//ResultSet rs1;
	        	rs1 = st1.executeQuery("SELECT userAction,movie,imdbID,rating,feedTime FROM Feed WHERE username='" + following+"'");
	        	if (rs1.next()){
	        		System.out.println(following+" has feed");
	        		do{
	        			System.out.println(following+" feed reading");
	        			String userAction = rs1.getString("userAction");
	        			String movie1 = rs1.getString("movie");
	        			String imdbID = rs1.getString("imdbID");
	        			double rating1 = rs1.getInt("rating");
	        			String feedTime = rs1.getString("feedTime");
	        			Feed feed = new Feed(following, userAction,movie1,imdbID,rating1,feedTime);
	        			feeds[i] = feed;
	        			i++;
	        		}while (rs1.next());
	        	}
	        	else {
	        		System.out.println(following+" has no feed");
	        	}
	        }			
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		int[] array = new int[i];
		Map<Integer, Feed> map = new HashMap<Integer, Feed>();
		for (int j =0;j<i;j++){
			String str = feeds[j].feedTime;
			 
			str = str.replaceAll("\\s+","");
			 
			str = str.replace(".", "");
			 
			str = str.replaceAll(":", "");
			str += "0";
			int time = Integer.parseInt(str);
			if (map.containsKey(time)){
				time +=1;
			}
			map.put(time, feeds[j]);
			array[j] = time;
		}
		Arrays.sort(array);
		Feed[] feedSorted = new Feed[i];
		int index = 0;
		for (int n = array.length-1; n >=0; n--){
			feedSorted[index] = map.get(array[n]);
			index++;
		}
		return feedSorted;
	}
	public boolean checkFollow(String loggedUser, String currUser){
		boolean follow = false;
        try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT following FROM Following WHERE username='"+loggedUser+"'");			 
            if (rs.next()){
            	do {
            		String following = rs.getString("following");
            		if (following.equals(currUser)){
            			follow = true;
            		}
            	}while (rs.next());
            }
			//conn.close();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return follow;
	}
	public Feed[] getMyFeed(String mUsername){
		Feed[] feeds = new Feed[1000];
		int i = 0;
        try {
        	//ResultSet rs;
			rs = st.executeQuery("SELECT userAction,movie,imdbID,rating,feedTime FROM Feed WHERE username='" + mUsername+"'");
			
			if (rs.next()){
				do {
					String userAction = rs.getString("userAction");
					String movie1 = rs.getString("movie");
					String imdbID = rs.getString("imdbID");
					double rating1 = rs.getInt("rating");
					String feedTime = rs.getString("feedTime");
					Feed feed = new Feed(mUsername, userAction,movie1,imdbID,rating1,feedTime);
					feeds[i] = feed;
					i++;
				}while (rs.next());
			}
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        int[] array = new int[i];
		Map<Integer, Feed> map = new HashMap<Integer, Feed>();
		for (int j =0;j<i;j++){
			String str = feeds[j].feedTime;
			str = str.replaceAll("\\s+","");
			str = str.replace(".", "");
			str = str.replaceAll(":", "");
			str += "0";
			int time = Integer.parseInt(str);
			if (map.containsKey(time)){
				time +=1;
			}
			map.put(time, feeds[j]);
			array[j] = time;
		}
		Arrays.sort(array);
		Feed[] feedSorted = new Feed[i];
		int index = 0;
		for (int n = array.length-1; n >=0 ; n--){
			feedSorted[index] = map.get(array[n]);
			index++;
		}
		return feedSorted;
        
	}
	public String getImage(String username){
		String image = "";
		try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT image FROM Users WHERE username='"+username+"'");			 
			if (rs.next()){
				image = rs.getString("image");	
			}
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return image;
	}
	public String getActorImage(String actor){
		String[] splited = actor.split("\\s+");
		String fname = splited[0];
		fname+="%20";
		String lname = splited[1];
		String name = fname+lname;
		 
		String result = "";
		try {
			URLConnection connection = new URL("https://api.themoviedb.org/3/search/person?api_key=bd745389f8db8af86d48363dcea46dd8&language=en-US&query=" + URLEncoder.encode(name, "UTF-8")+"&page=1&include_adult=true").openConnection();
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		     
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
		     
		    JSONArray jsonArray = json.getJSONArray("results");
		    
		    String prefix = "http://image.tmdb.org/t/p/w130";
		    result += prefix;
		    result += (String) jsonArray.getJSONObject(0).get("profile_path");
		   
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}		 
		return result;
	}
	public String getMovieImage(String imdbID){ //omdb
		String image = "";
		try {			 
			System.out.println("imdbID: "+imdbID);
			URLConnection connection = new URL("http://www.omdbapi.com/?i=" + URLEncoder.encode(imdbID, "UTF-8")).openConnection();
			 
			connection.setRequestProperty("Accept-Charset", "UTF-8");
			InputStream response = connection.getInputStream();
		 
			BufferedReader streamReader = new BufferedReader(new InputStreamReader(response, "UTF-8"));
			StringBuilder responseStrBuilder = new StringBuilder();

		    String inputStr;
		    while ((inputStr = streamReader.readLine()) != null){
		        responseStrBuilder.append(inputStr);
		    }
		    
		    JSONObject json = new JSONObject(responseStrBuilder.toString());
	 	 
			image = (String) json.get("Poster");
	 	 
		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return image;
	}
	public String getFname(String username){
		String fname = "";
		try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT fname FROM Users WHERE username='"+username+"'");			 
			if (rs.next()){
				fname = rs.getString("fname");	
			}
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return fname;
	}
	public String getLname(String username){
		String lname = "";
		try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT lname FROM Users WHERE username='"+username+"'");			 
			if (rs.next()){
				lname = rs.getString("lname");		
			}
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return lname;
	}
	public String validatePassword(String mUsername, String mPassword){
		boolean valid = false;
        try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT pswd FROM Users WHERE username='"+mUsername+"'");
			if (rs.next()){
				String pswd = rs.getString("pswd");
				System.out.println("pswd of user: "+pswd);
			
				if (mPassword.equals(pswd)){
			    	valid = true;
				}
			}
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (!valid) {
        	return("Incorrect password!");
        }
        else {
        	return("success");
        }
	}
	public String validateUsername(String mUsername){
		boolean exist = false;
        try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT username,pswd FROM Users");
			while ( rs.next() ) {
				
			    String currUsername = rs.getString("username");
			    System.out.println("username: "+currUsername);
			    System.out.println("pswd: "+rs.getString("pswd"));
			    if (currUsername.equals(mUsername)){
			    	exist = true;
			    }
			}
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (!exist) {
        	return("Username does not exist");
        }
        else {
        	return("success");
        }
	}
	public String validateSignUpUsername (String mUsername){
		boolean exist = false;
        try {
        	//ResultSet rs;
            rs = st.executeQuery("SELECT username FROM Users");
			while ( rs.next() ) {
			    String currUsername = rs.getString("username");
			    if (currUsername.equals(mUsername)){
			    	exist = true;
			    }
			}
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        if (exist) {
        	return("Username already existed");
        }
        else {
        	return("success");
        }
	}
	public void addUser(String username, String pswd, String fname, String lname, String image){
		try {
			st.executeUpdate("INSERT INTO Users (username, pswd, fname, lname, image) "
			          +"VALUES ('"+username+"', '"+pswd+"','"+fname+"','"+lname+"','"+image+ "')");
			//conn.close();
			 
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}      
	}
	public void addRating(String username, String imdbID, String movie, double rating, String time){
		try {
			st.executeUpdate("INSERT INTO Feed (username, userAction, movie, imdbID, rating, feedTime) "
			          +"VALUES ('"+username+"', '"+ "Rated" +"','"+movie+"','"+imdbID+"','"+rating+ "','"+time+"')");
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void addFeed(String username, String userAction, String movie, String imdbID, double rating,String time){
		try {
			st.executeUpdate("INSERT INTO Feed (username, userAction, movie, imdbID, rating, feedTime) "
			          +"VALUES ('"+username+"', '"+ userAction+"','"+movie+"','"+imdbID+"','"+rating+ "','"+time+"')");
			//conn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
	}
	public void addFollowing(String username, String following){
		try {
			st.executeUpdate("INSERT INTO Following (username, following) "
			          +"VALUES ('"+username+"','"+ following + "')");
			//conn.close();
			rs = st.executeQuery("SELECT following FROM Following Where username='"+username+"'");
			while ( rs.next() ) {
			    String currUsername = rs.getString("following");
			    System.out.println(username+" is following "+currUsername);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void removeFollowing(String username, String following){
		try {
			st.executeUpdate("DELETE FROM Following WHERE username='"+username +"' and following = '"+following+"'");
		    //conn.close();
			rs = st.executeQuery("SELECT following FROM Following Where username='"+username+"'");
			while ( rs.next() ) {
			    String currUsername = rs.getString("following");
			    System.out.println(username+" is following "+currUsername);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	      
	}
}
