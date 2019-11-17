<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="./login.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Login</title>
		<script>
			function login()
			{
				var username = document.form.username.value;
				var password = document.form.password.value;
				var rawFile = new XMLHttpRequest();
			    rawFile.open("GET", "./users.json", false);
			    rawFile.onreadystatechange = function()
			    {
			        if (rawFile.readyState === 4)
			        {
			        		var u, p = false;
			            var users = JSON.parse(rawFile.responseText);
			            for (var i = 0; i < users.users.length; i++)
			            	{
			            		if (users.users[i].username == username)
			            		{
			            			if (users.users[i].password == password)
			            			{
			            				var obj = users.users[i];
			            				var favorites = JSON.stringify(obj.library.favorite);
			            				var read = JSON.stringify(obj.library.read);
			            				sessionStorage.setItem("username", obj.username);
			            				sessionStorage.setItem("imageURL", obj.imageURL);
			            				sessionStorage.setItem("followers", obj.followers);
			            				sessionStorage.setItem("following", obj.following);
			            				sessionStorage.setItem("favorites", favorites);
			            				sessionStorage.setItem("read", read);
			            				document.form.submit();
			            				return true;
			            			}
			            			u = true;
			            			break;
			            		}
			            	}
			            if (u && !p && document.getElementById("err_username").childNodes.length > 0)
			            	{
			            		document.getElementById("err_username").removeChild(document.getElementById("err_username").childNodes[0]);
			            		document.getElementById("err_username").style.backgroundColor = "transparent";
			            	}
			            if (!u && document.getElementById("err_username").childNodes.length < 1)
			            	{
			            		document.getElementById("err_username").appendChild(document.createTextNode("Invalid Username"));
			           	 	document.getElementById("err_username").style.backgroundColor = "#69B8E5";
			            	}
			            if (!p && document.getElementById("err_password").childNodes.length < 1)
			            {
			            		document.getElementById("err_password").appendChild(document.createTextNode("Invalid Password"));
			            		document.getElementById("err_password").style.backgroundColor = "#69B8E5";
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
			<a href="./login.jsp">Login</a><br />
			<form name="form" method="POST" action="./searchIn.jsp" onsubmit="event.preventDefault(); login();">
			<b style="position: relative; left: -215px;">Username</b><br />
			<input type="text" name="username" style="width: 40%; height: 25px"><div id="err_username" style="position: absolute; left: 73%; display: inline; color: red; width: 200px; padding: 5px;"></div><br /><br /><br />
			<b style="position: relative; left: -215px;">Password</b><br />
			<input type="password" name="password" style="width: 40%; height: 25px"><div id="err_password" style="position: absolute; left: 73%; display: inline; color: red; width: 200px; padding: 5px;"></div> <br /><br />
			<button style="display: inline-block; border: none; color: white; padding: 10px 20px; background-color: #555555; font-size: 16px;">Submit</button>
			</form>
		</div>
	</body>
</html>