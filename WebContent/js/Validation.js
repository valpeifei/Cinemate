function signUpValidate(){
	 
	var fullname = document.getElementById("fullname").value;
	var username = document.getElementById("username").value;
	var password =document.getElementById("password").value;
	var imageurl = document.getElementById("imageurl").value;
	
	var ip = document.getElementById("ip").value;
	var db =document.getElementById("db").value;
	var sqluser = document.getElementById("sqluser").value;
	var sqlpswd =document.getElementById("sqlpswd").value;
	
	var url = "HandleSignUpServlet";
	var params = "?";

	// setup the params
	 
	var entries = [];
	 
	var key2 = encodeURIComponent("fullname");
	var value2 = encodeURIComponent(fullname);
	entries.push(key2 + "=" + value2);
	 
	var key0 = encodeURIComponent("username");
	var value0 = encodeURIComponent(username);
	entries.push(key0 + "=" + value0);
	
	var key1 = encodeURIComponent("password");
	var value1 = encodeURIComponent(password);
	entries.push(key1 + "=" + value1);
	
	var key3 = encodeURIComponent("imageurl");
	var value3 = encodeURIComponent(imageurl);
	entries.push(key3 + "=" + value3);
	
	var key6 = encodeURIComponent("ip");
	var value6 = encodeURIComponent(ip);
	entries.push(key6 + "=" + value6);
	 
	var key7 = encodeURIComponent("db");
	var value7 = encodeURIComponent(db);
	entries.push(key7 + "=" + value7);
	
	var key4 = encodeURIComponent("sqluser");
	var value4 = encodeURIComponent(sqluser);
	entries.push(key4 + "=" + value4);
	 
	var key5 = encodeURIComponent("sqlpswd");
	var value5 = encodeURIComponent(sqlpswd);
	entries.push(key5 + "=" + value5);
	
	params += entries.join("&");

	// create AJAX request
	var req = new XMLHttpRequest();
	req.open("GET", url + params, true);
	req.onreadystatechange = function () {
		if(req.readyState == 4 && req.status == 200){	  
			var obj = JSON.parse(req.responseText);
			processForm(obj);
		}
	}
	req.send(null);
}
function processForm(obj){
	var noErr = "none";
	if (obj.errorMessage != noErr){
		var error = document.getElementById("error");
		error.innerHTML = obj.errorMessage;
	}
	else {
		var username = document.getElementById("username").value;
		 
		 
		var ip = document.getElementById("ip").value;
		var db = document.getElementById("db").value;
		var sqluser = document.getElementById("sqluser").value;
		var sqlpswd = document.getElementById("sqlpswd").value;
		var entries = [];
		var params = "?";
		var key = encodeURIComponent("ip");
		var value = encodeURIComponent(ip);
		entries.push(key + "=" + value);
		
		var key1 = encodeURIComponent("db");
		var value1 = encodeURIComponent(db);
		entries.push(key1 + "=" + value1);
		
		var key2 = encodeURIComponent("sqluser");
		var value2 = encodeURIComponent(sqluser);
		entries.push(key2 + "=" + value2);
		
		var key3 = encodeURIComponent("sqlpswd");
		var value3 = encodeURIComponent(sqlpswd);
		entries.push(key3 + "=" + value3);
		var key0 = encodeURIComponent("username");
		var value0 = encodeURIComponent(username);
		entries.push(key0 + "=" + value0);
		
		params += entries.join("&");
		var url = "SignUpSuccessServlet";
		var loc = url+ params;
		window.location= loc;
	}
}
 
function loginValidate(){
	var username = document.getElementById("username").value;
	var password =document.getElementById("password").value;
	var ip = document.getElementById("ip").value;
	var db =document.getElementById("db").value;
	var sqluser = document.getElementById("sqluser").value;
	var sqlpswd =document.getElementById("sqlpswd").value;
	
	var url = "HandleLoginServlet";
	var params = "?";

	// setup the params
	 
	var entries = [];
	 
	var key0 = encodeURIComponent("username");
	var value0 = encodeURIComponent(username);
	entries.push(key0 + "=" + value0);
	 
	var key1 = encodeURIComponent("password");
	var value1 = encodeURIComponent(password);
	entries.push(key1 + "=" + value1);
	
	var key2 = encodeURIComponent("ip");
	var value2 = encodeURIComponent(ip);
	entries.push(key2 + "=" + value2);
	 
	var key3 = encodeURIComponent("db");
	var value3 = encodeURIComponent(db);
	entries.push(key3 + "=" + value3);
	
	var key4 = encodeURIComponent("sqluser");
	var value4 = encodeURIComponent(sqluser);
	entries.push(key4 + "=" + value4);
	 
	var key5 = encodeURIComponent("sqlpswd");
	var value5 = encodeURIComponent(sqlpswd);
	entries.push(key5 + "=" + value5);
	
	params += entries.join("&");

	// create AJAX request
	var req = new XMLHttpRequest();
	req.open("GET", url + params, true);
	req.onreadystatechange = function () {
		if(req.readyState == 4 && req.status == 200){	  
			var obj = JSON.parse(req.responseText);
			processFormLogin(obj);
		}
	}
	req.send(null);
}
function processFormLogin(obj){
	var noErr = "none";
	if (obj.errorMessage != noErr){
		var error = document.getElementById("error");
		error.innerHTML = obj.errorMessage;
	}
	else {
		var username = document.getElementById("username").value;
		var ip = document.getElementById("ip").value;
		var db = document.getElementById("db").value;
		var sqluser = document.getElementById("sqluser").value;
		var sqlpswd = document.getElementById("sqlpswd").value;
		var entries = [];
		var params = "?";
		var key = encodeURIComponent("ip");
		var value = encodeURIComponent(ip);
		entries.push(key + "=" + value);
		
		var key1 = encodeURIComponent("db");
		var value1 = encodeURIComponent(db);
		entries.push(key1 + "=" + value1);
		
		var key2 = encodeURIComponent("sqluser");
		var value2 = encodeURIComponent(sqluser);
		entries.push(key2 + "=" + value2);
		
		var key3 = encodeURIComponent("sqlpswd");
		var value3 = encodeURIComponent(sqlpswd);
		entries.push(key3 + "=" + value3);
		
		var key0 = encodeURIComponent("username");
		var value0 = encodeURIComponent(username);
		entries.push(key0 + "=" + value0);
		
		params += entries.join("&");
		var url = "LoginSuccessServlet";
		var loc = url+ params;
		window.location= loc;
	}
}