<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="./signup.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Sign Up</title>
		<script>
		function signup()
			{
				var username = document.form.username.value;
				var password = document.form.password.value;
				var imageURL = document.form.imageURL.value;
				var rawFile = new XMLHttpRequest();
			    rawFile.open("GET", "./users.json", false);
			    rawFile.onreadystatechange = function()
			    {
			        if (rawFile.readyState === 4)
			        {
			            var users = JSON.parse(rawFile.responseText);
			            var bool = 0;
			            for (var i = 0; i < users.users.length; i++)
			            	{
			            		if ((users.users[i].username == username || username == "") && document.getElementById("err_username").childNodes.length < 1)
			            		{ 
			            			bool = 1;
			            			document.getElementById("err_username").appendChild(document.createTextNode("Invalid Username"));
					           	document.getElementById("err_username").style.backgroundColor = "#69B8E5";
			            		}
			            		else if (users.users[i].username == username || username == "")
			            		{
			            			bool = 1;
			            		}
			            	}
			            if (bool == 0 && document.getElementById("err_username").childNodes.length > 0)
			            	{
			            		document.getElementById("err_username").removeChild(document.getElementById("err_username").childNodes[0]);
			            		document.getElementById("err_username").style.backgroundColor = "transparent";
			            	}
			            if (password == "" && document.getElementById("err_password").childNodes.length < 1)
			            	{
			            		bool = 1;
				            	document.getElementById("err_password").appendChild(document.createTextNode("Password Cannot Be Null"));
			            		document.getElementById("err_password").style.backgroundColor = "#69B8E5";
			            	}
			            else if (password == "")
			            	{
			            		bool = 1;
			            	}
			            if (imageURL == "" && document.getElementById("err_imageURL").childNodes.length < 1)
			            	{
			            		bool = 1;
				            	document.getElementById("err_imageURL").appendChild(document.createTextNode("Image URL Cannot Be Null"));
			            		document.getElementById("err_imageURL").style.backgroundColor = "#69B8E5";
			            	}
			            else if (imageURL == "")
			            	{
			           	 	bool = 1;
			            	}
			            if (bool == 0)
			            {
				            var obj = {"username": username, "password": password, "imageURL": imageURL, "followers": [], "following": [], "library": {"read" : [], "favorite" : []}};
				            users.users.push(obj);
						    document.output.method = "POST"; 
						    document.getElementById("obj").value = JSON.stringify(users);
						    document.output.submit();
				            sessionStorage.setItem("username", username);
				            sessionStorage.setItem("imageURL", imageURL);
				            document.form.action();
				            return true;
			            }
			            return false;
			        }
			    }
			    rawFile.send(null);
			}
		</script>
	</head>
	<body>
	<div class="home">&emsp;<a href="./home.jsp">LibraMate</a></div>
		<div class="input" align="center">
			<a href="./signup.jsp">Sign Up</a><br />
			<form name="form" method="POST" action="./searchIn.jsp" onsubmit="event.preventDefault(); signup();">
			<b style="position: relative; left: -215px;">Username</b><br />
			<input type="text" name="username" style="width: 40%; height: 25px"><div id="err_username" style="position: absolute; left: 73%; display: inline; color: red; width: 200px; padding: 5px;"></div><br /><br />
			<b style="position: relative; left: -215px;">Password</b><br />
			<input type="text" name="password" style="width: 40%; height: 25px"><div id="err_password" style="position: absolute; left: 73%; display: inline; color: red; width: 250px; padding: 5px;"></div><br /><br />
			<b style="position: relative; left: -210px;">Image URL</b><br />
			<input type="text" name="imageURL" style="width: 40%; height: 25px"><div id="err_imageURL" style="position: absolute; left: 73%; display: inline; color: red; width: 250px; padding: 5px;"></div><br /><br />
			<button style="display: inline-block; border: none; color: white; padding: 10px 20px; background-color: #555555; font-size: 16px;">SIGN UP</button>
			</form>
		</div>
		<form name="output" action="./Output"><input type="hidden" id="obj" name="obj"></form>
	</body>
</html>