function handleWatchButton(){
	var url = "HandleMovieActionsServlet";
	var params = "?";

	// setup the params
	 
	var entries = [];
	
	var action = "watch";
	var key2 = encodeURIComponent("action");
	var value2 = encodeURIComponent(action);
	entries.push(key2 + "=" + value2);
	
	var xmlFile = document.getElementById("xmlFile").value;
	var key = encodeURIComponent("xmlFile");
	var value = encodeURIComponent(xmlFile);
	entries.push(key + "=" + value);
	 
	var loggedUser = document.getElementById("loggedUser").value;
	var key0 = encodeURIComponent("loggedUser");
	var value0 = encodeURIComponent(loggedUser);
	entries.push(key0 + "=" + value0);
	
	var movieTitle = document.getElementById("movieTitle").value;
	var key1 = encodeURIComponent("movieTitle");
	var value1 = encodeURIComponent(movieTitle);
	entries.push(key1 + "=" + value1);
	
	
	params += entries.join("&");

	// create AJAX request
	var req = new XMLHttpRequest();
	req.open("GET", url + params, true);
	req.onreadystatechange = function () {
		if(req.readyState == 4 && req.status == 200) {
			var obj = JSON.parse(req.responseText);
			processForm(obj);
		}
	}
	req.send(null);
}
function handleLikeButton(){
	var url = "HandleMovieActionsServlet";
	var params = "?";

	// setup the params
	 
	var entries = [];
	
	var action = "like";
	var key2 = encodeURIComponent("action");
	var value2 = encodeURIComponent(action);
	entries.push(key2 + "=" + value2);
	
	var xmlFile = document.getElementById("xmlFile").value;
	var key = encodeURIComponent("xmlFile");
	var value = encodeURIComponent(xmlFile);
	entries.push(key + "=" + value);
	 
	var loggedUser = document.getElementById("loggedUser").value;
	var key0 = encodeURIComponent("loggedUser");
	var value0 = encodeURIComponent(loggedUser);
	entries.push(key0 + "=" + value0);
	
	var movieTitle = document.getElementById("movieTitle").value;
	var key1 = encodeURIComponent("movieTitle");
	var value1 = encodeURIComponent(movieTitle);
	entries.push(key1 + "=" + value1);
	
	
	params += entries.join("&");

	// create AJAX request
	var req = new XMLHttpRequest();
	req.open("GET", url + params, true);
	req.onreadystatechange = function () {
		if(req.readyState == 4 && req.status == 200) {
			var obj = JSON.parse(req.responseText);
			processForm(obj);
		}
	}
	req.send(null);
}
function handleDislikeButton(){
	var url = "HandleMovieActionsServlet";
	var params = "?";

	// setup the params
	 
	var entries = [];
	
	var action = "dislike";
	var key2 = encodeURIComponent("action");
	var value2 = encodeURIComponent(action);
	entries.push(key2 + "=" + value2);
	
	var xmlFile = document.getElementById("xmlFile").value;
	var key = encodeURIComponent("xmlFile");
	var value = encodeURIComponent(xmlFile);
	entries.push(key + "=" + value);
	 
	var loggedUser = document.getElementById("loggedUser").value;
	var key0 = encodeURIComponent("loggedUser");
	var value0 = encodeURIComponent(loggedUser);
	entries.push(key0 + "=" + value0);
	
	var movieTitle = document.getElementById("movieTitle").value;
	var key1 = encodeURIComponent("movieTitle");
	var value1 = encodeURIComponent(movieTitle);
	entries.push(key1 + "=" + value1);
	
	params += entries.join("&");

	// create AJAX request
	var req = new XMLHttpRequest();
	req.open("GET", url + params, true);
	req.onreadystatechange = function () {
		if(req.readyState == 4 && req.status == 200) {
			var obj = JSON.parse(req.responseText);
			processForm(obj);
		}
	}
	req.send(null);
}
