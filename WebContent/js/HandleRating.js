function handleRating(mRating){
	var url = "HandleRatingServlet";
	var params = "?";

	// setup the params
	 
	var entries = [];
	
	var rating = mRating;
	var key2 = encodeURIComponent("rating");
	var value2 = encodeURIComponent(rating);
	entries.push(key2 + "=" + value2);
	
	var ip = document.getElementById("ip").value;
	var key = encodeURIComponent("ip");
	var value = encodeURIComponent(ip);
	entries.push(key + "=" + value);
	 
	var db = document.getElementById("db").value;
	var key3 = encodeURIComponent("db");
	var value3 = encodeURIComponent(db);
	entries.push(key3 + "=" + value3);
	
	var sqluser = document.getElementById("sqluser").value;
	var key4 = encodeURIComponent("sqluser");
	var value4 = encodeURIComponent(sqluser);
	entries.push(key4 + "=" + value4);
	
	var sqlpswd = document.getElementById("sqlpswd").value;
	var key5 = encodeURIComponent("sqlpswd");
	var value5 = encodeURIComponent(sqlpswd);
	entries.push(key5 + "=" + value5);
	
	var loggedUser = document.getElementById("loggedUser").value;
	var key0 = encodeURIComponent("loggedUser");
	var value0 = encodeURIComponent(loggedUser);
	entries.push(key0 + "=" + value0);
	
	var movieTitle = document.getElementById("movieTitle").value;
	var key1 = encodeURIComponent("movieTitle");
	var value1 = encodeURIComponent(movieTitle);
	entries.push(key1 + "=" + value1);
	
	var imdbID = document.getElementById("imdbID").value;
	var key6 = encodeURIComponent("imdbID");
	var value6 = encodeURIComponent(imdbID);
	entries.push(key6 + "=" + value6);
	
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
function processForm(obj) {

	var newRating = obj.avgRating;
	var str = "rating-input-1-";
	var newRatingId = str+newRating;
	
	var newRatingButton = document.getElementById(newRatingId);
	 
	newRatingButton.checked = true;
	 
	for (var num = 1; num < 10; num++){
		if (num != parseInt(newRating)){
			var currRatingId = str+ num.toString();
			var currRatingButton = document.getElementById(currRatingId);
			currRatingButton.checked = false;
		}
	}
}