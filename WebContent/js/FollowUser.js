function handleFollowButton(){
	if (document.getElementById("followButton").value == "follow"){
		document.getElementById("followButton").value = "unfollow";
	}
	else {
		document.getElementById("followButton").value = "follow";
	}
	var url = "HandleFollowServlet";
	var params = "?";

	// setup the params
	 
	var entries = [];
	
	var ip = document.getElementById("ip").value;
	var key = encodeURIComponent("ip");
	var value = encodeURIComponent(ip);
	entries.push(key + "=" + value);
	 
	var db = document.getElementById("db").value;
	var key2 = encodeURIComponent("db");
	var value2 = encodeURIComponent(db);
	entries.push(key2 + "=" + value2);
	
	var sqluser = document.getElementById("sqluser").value;
	var key3 = encodeURIComponent("sqluser");
	var value3 = encodeURIComponent(sqluser);
	entries.push(key3 + "=" + value3);
	
	var sqlpswd = document.getElementById("sqlpswd").value;
	var key4 = encodeURIComponent("sqlpswd");
	var value4 = encodeURIComponent(sqlpswd);
	entries.push(key4 + "=" + value4);
	
	var loggedUser = document.getElementById("loggedUser").value;
	var key0 = encodeURIComponent("loggedUser");
	var value0 = encodeURIComponent(loggedUser);
	entries.push(key0 + "=" + value0);
	
	var currUser = document.getElementById("currUser").value;
	var key1 = encodeURIComponent("currUser");
	var value1 = encodeURIComponent(currUser);
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

function processForm(obj) {
	
	var followingsPart = document.getElementById('followingsPart');
	followingsPart.innerHTML = "";
	var followingsListParsed = obj.followingsList.split("%");
	for (var i = 0; i < followingsListParsed.length; i++){
		followingsPart.innerHTML +="<li>"+followingsListParsed[i]+"</li>";
	}
	
	var followersPart = document.getElementById('followersPart');
	followersPart.innerHTML ="";
	var followersListParsed = obj.followersList.split("%");
	for (var i = 0; i < followersListParsed.length; i++){
		followersPart.innerHTML +="<li>"+followersListParsed[i]+"</li>";
	}
}
