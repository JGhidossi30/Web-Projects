<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="./user.css">
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Libramate</title>
</head>
<body>
	<div class="input" id="input">
		&emsp;<a href="./home.jsp" onclick="logout();">LibraMate</a>&nbsp;
		<form name="form" method="GET" action="./searchIn.jsp">
			<b><input type="text" placeholder="Search" name="search" style="width: 40%; height: 25px">
			<img id="sbutton" src="https://png.icons8.com/metro/1600/book.png" onclick="buttonSwitch();" style="position: relative; width: 31px; height: 31px; top: 10.9px; left: -4px; background-color: white;"></img>
			<table id="bubbles">
				<tr style="vertical-align: text-top;">
					<td>
						<input type="radio" id="subject" name="subject" value="intitle" checked="checked"> Title<br /> 
						<input type="radio" id="subject" name="subject" value="inauthor"> Author</td>
					<td>&emsp;&emsp;&emsp;</td>
					<td>
						<input type="radio" id="subject" name="subject" value="isbn">ISBN<br /> 
						<input type="radio" id="subject" name="subject" value="subject">Genre
					</td>
				</tr>
			</table></b>
		</form>
		<form method="POST" action="./youser.jsp">
			<input type="image" id="user" width="75px" height="75px" alt="submit" style="border-radius: 50%; position: fixed; left: 87%;  border: 2px solid #000000;"></button>
		</form>
	</div>
	<br />
	<img id="propic" width="220px" height="220px" style="border-radius:50%; border: 2px solid #000000; position: relative; left: 2%; top: 20px;"></img>
	<table id="uname" bgcolor="#2781C0" width="220px" style="position: absolute; top: 400px; left: 2%; text-align: center; color: white; font-family:'Arial Black', Gadget, sans-serif; font-size: 19px; -webkit-text-stroke: 1px #000000; padding: 15px;"></table>
	<div id="followersOrFollowing" class="fof" style="position: absolute; left: 2%; top: 460px;"></div>
	<table id="utable" bgcolor="#2781C0" width="220px" style="position: absolute; top: 512px; left: 2%; text-align: center; color: white; font-family:'Arial Black', Gadget, sans-serif; font-size: 19px; -webkit-text-stroke: 1px #000000; padding: 15px;"></table>
	<div id="yourLibrary" style="position: absolute; left: 23%; top: 130px; color: white; font-family:'Arial Black', Gadget, sans-serif; font-size: 50px; -webkit-text-stroke: 2px #000000;">Your Library</div>
	<div id="readOrFavorites" class="rof" style="position: absolute; left: 23%; top: 220px;"></div>
	<table id="ltable" bgcolor="#2781C0" width="75%" style="position: absolute; top: 272px; left: 23%; text-align: center; color: white; font-family:'Arial Black', Gadget, sans-serif; font-size: 19px; -webkit-text-stroke: 1px #000000;"></table>
	<form action="./home.jsp" style="position: absolute; top: 30%; left: 90%; "><button id="logout" onclick="logout();" style="display: inline-block; border: none; color: white; padding: 10px 20px; background-color: #555555; font-size: 16px;">Logout</button></form>
	<script>
		function showPage()
		{
			var propic = document.getElementById("propic");
			propic.setAttribute("src", sessionStorage.getItem("imageURL"));
			
			var utable = document.getElementById("uname");
			var uname = utable.insertRow(0);
			var name = document.createTextNode("@" + sessionStorage.getItem("username"));
			uname.appendChild(name);
			utable.appendChild(uname);
			document.body.appendChild(utable);
			
			var ffTabs = document.getElementById("followersOrFollowing");
			var following = document.createElement("button");
			following.appendChild(document.createTextNode("Following"));
			following.onclick = function()
			{
				var uList = document.getElementById("utable");
				uList.removeChild(uList.childNodes[1]);
				var ufList = uList.insertRow(0);
				if (sessionStorage.getItem("following") != null && sessionStorage.getItem("following") != "")
				{
					var list = sessionStorage.getItem("following").split(",");
					for (var i = 0; i < list.length; i++)
					{
						ufList.appendChild(document.createTextNode("@" + list[i]));
						ufList.appendChild(document.createElement("br"));
					}
				}
				uList.appendChild(ufList);
				document.body.appendChild(uList);
				following.setAttribute("style", "background-color: #2781C0;");
				followers.setAttribute("style", "background-color: #165785;");
			};
			ffTabs.appendChild(following);
			var followers = document.createElement("button");
			followers.appendChild(document.createTextNode("Followers"));
			followers.onclick = function()
			{
				var uList = document.getElementById("utable");
				uList.removeChild(uList.childNodes[1]);
				var ufList = uList.insertRow(0);
				if (sessionStorage.getItem("followers") != null && sessionStorage.getItem("followers") != "")
				{
					var list = sessionStorage.getItem("followers").split(",");
					for (var i = 0; i < list.length; i++)
					{
						ufList.appendChild(document.createTextNode("@" + list[i]));
						ufList.appendChild(document.createElement("br"));
					}
				}
				uList.appendChild(ufList);
				document.body.appendChild(uList);
				followers.setAttribute("style", "background-color: #2781C0;");
				following.setAttribute("style", "background-color: #165785");
			};
			ffTabs.appendChild(followers);
			document.body.appendChild(ffTabs);
			
			var uList = document.getElementById("utable");
			var ufList = uList.insertRow(0);
			if (sessionStorage.getItem("followers") != null && sessionStorage.getItem("followers") != "")
			{
				var list = sessionStorage.getItem("followers").split(",");
				for (var i = 0; i < list.length; i++)
				{
					ufList.appendChild(document.createTextNode("@" + list[i]));
					ufList.appendChild(document.createElement("br"));
				}
			}
			followers.setAttribute("style", "background-color: #2781C0;");
			uList.appendChild(ufList);
			document.body.appendChild(uList);
			
			var rfTabs = document.getElementById("readOrFavorites");
			var read = document.createElement("button");
			read.appendChild(document.createTextNode("Read"));
			read.onclick = function()
			{
				if (sessionStorage.getItem("read") == "[]")
				{
					read.setAttribute("style", "background-color: #2781C0;");
					favorites.setAttribute("style", "background-color: #165785;");
					return;
				}
				var table = document.getElementById("ltable");
				table.removeChild(table.childNodes[0]);
				for (var i = 0; i < JSON.parse(sessionStorage.getItem("read")).length; i++)
				{
					var xhttp = new XMLHttpRequest();
					var search = JSON.parse(sessionStorage.getItem("read"))[i];
					xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=intitle:"+search+"&maxResults=1", false);
					xhttp.send();
					var row;
					if (xhttp.status != 404) 
					{
						var books = JSON.parse(xhttp.responseText);
						if (i % 4 == 0)
							row = table.insertRow(i / 4);
						var cell = row.insertCell(i % 4);
						var img = document.createElement("IMG");
					  	try
					  	{
					   		img.setAttribute("src", books.items[0].volumeInfo.imageLinks.thumbnail);
					  	}
					  	catch (error)
					   	{
						   	img.setAttribute("src", "https://www.hachette.co.nz/graphics/CoverNotAvailable.jpg");
					   	}
					   	img.setAttribute("width", "100");
						img.setAttribute("height", "150");
						row.style = "text-align: center;";
						cell.style = "padding: 50px;";
						var cellTitle = document.createTextNode(books.items[0].volumeInfo.title);
						var cellAuthor = document.createTextNode("by " + books.items[0].volumeInfo.authors);
						var a = document.createElement("a");
						a.style = "font-size: 14px; color: black; text-decoration: none;";
						a.appendChild(img);
						a.appendChild(document.createElement("br"));
						a.appendChild(cellTitle);
						a.appendChild(document.createElement("br"));
						a.href = "./informationIn.jsp?search=" + search + "&subject=intitle&choice=0";
						var b = document.createElement("a");
						b.style = "font-size: 12px; color: black; text-decoration: none;";
						b.appendChild(cellAuthor);
						cell.appendChild(a);
						cell.appendChild(b);
					}
				}
				read.setAttribute("style", "background-color: #2781C0;");
				favorites.setAttribute("style", "background-color: #165785;");
			};
			rfTabs.appendChild(read);
			var favorites = document.createElement("button");
			favorites.appendChild(document.createTextNode("Favorites"));
			favorites.onclick = function()
			{
				if (sessionStorage.getItem("favorites") == "[]")
				{
					favorites.setAttribute("style", "background-color: #2781C0;");
					read.setAttribute("style", "background-color: #165785;");
					return;
				}
				var table = document.getElementById("ltable");
				table.removeChild(table.childNodes[0]);
				for (var i = 0; i < JSON.parse(sessionStorage.getItem("favorites")).length; i++)
				{
					var xhttp = new XMLHttpRequest();
					var search = JSON.parse(sessionStorage.getItem("favorites"))[i];
					xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=intitle:"+search+"&maxResults=1", false);
					xhttp.send();
					var row;
					if (xhttp.status != 404) 
					{
						var books = JSON.parse(xhttp.responseText);
						if (i % 4 == 0)
							row = table.insertRow(i / 4);
						var cell = row.insertCell(i % 4);
						var img = document.createElement("IMG");
					  	try
					  	{
					   		img.setAttribute("src", books.items[0].volumeInfo.imageLinks.thumbnail);
					  	}
					  	catch (error)
					   	{
						   	img.setAttribute("src", "https://www.hachette.co.nz/graphics/CoverNotAvailable.jpg");
					   	}
					   	img.setAttribute("width", "100");
						img.setAttribute("height", "150");
						row.style = "text-align: center;";
						cell.style = "padding: 50px;";
						var cellTitle = document.createTextNode(books.items[0].volumeInfo.title);
						var cellAuthor = document.createTextNode("by " + books.items[0].volumeInfo.authors);
						var a = document.createElement("a");
						a.style = "font-size: 14px; color: black; text-decoration: none;";
						a.appendChild(img);
						a.appendChild(document.createElement("br"));
						a.appendChild(cellTitle);
						a.appendChild(document.createElement("br"));
						a.href = "./informationIn.jsp?search=" + search + "&subject=intitle&choice=0";
						var b = document.createElement("a");
						b.style = "font-size: 12px; color: black; text-decoration: none;";
						b.appendChild(cellAuthor);
						cell.appendChild(a);
						cell.appendChild(b);
					}
				}
				favorites.setAttribute("style", "background-color: #2781C0;");
				read.setAttribute("style", "background-color: #165785;");
			};
			for (var i = 0; i < JSON.parse(sessionStorage.getItem("favorites")).length; i++)
			{
				var xhttp = new XMLHttpRequest();
				var search = JSON.parse(sessionStorage.getItem("favorites"))[i];
				xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q=intitle:"+search+"&maxResults=1", false);
				xhttp.send();
				var row;
				if (xhttp.status != 404) 
				{
					var books = JSON.parse(xhttp.responseText);
					var table = document.getElementById("ltable");
					if (i % 4 == 0)
						row = table.insertRow(i / 4);
					var cell = row.insertCell(i % 4);
					var img = document.createElement("IMG");
				  	try
				  	{
				   		img.setAttribute("src", books.items[0].volumeInfo.imageLinks.thumbnail);
				  	}
				  	catch (error)
				   	{
					   	img.setAttribute("src", "https://www.hachette.co.nz/graphics/CoverNotAvailable.jpg");
				   	}
				   	img.setAttribute("width", "100");
					img.setAttribute("height", "150");
					row.style = "text-align: center;";
					cell.style = "padding: 50px;";
					var cellTitle = document.createTextNode(books.items[0].volumeInfo.title);
					var cellAuthor = document.createTextNode("by " + books.items[0].volumeInfo.authors);
					var a = document.createElement("a");
					a.style = "font-size: 14px; color: black; text-decoration: none;";
					a.appendChild(img);
					a.appendChild(document.createElement("br"));
					a.appendChild(cellTitle);
					a.appendChild(document.createElement("br"));
					a.href = "./informationIn.jsp?search=" + search + "&subject=intitle&choice=0";
					var b = document.createElement("a");
					b.style = "font-size: 12px; color: black; text-decoration: none;";
					b.appendChild(cellAuthor);
					cell.appendChild(a);
					cell.appendChild(b);
				}
			}
			favorites.setAttribute("style", "background-color: #2781C0;");
			read.setAttribute("style", "background-color: #165785;");
			rfTabs.appendChild(favorites);
			document.body.appendChild(rfTabs);
		}
		function login()
		{
			var url = sessionStorage.getItem("imageURL");
			if (url == null)
				url = "http://www.mop-zafon.org.il/sites/default/files/default_images/place-holder.png";
			var img = document.getElementById("user");
			img.setAttribute("src", url);
		}
		function logout()
		{
			sessionStorage.removeItem("username");
			sessionStorage.removeItem("imageurl");
			sessionStorage.removeItem("followers");
			sessionStorage.removeItem("following");
		}
		var img_array = ["https://png.icons8.com/metro/1600/book.png", "https://cdn2.iconfinder.com/data/icons/ui-1/60/05-512.png"];
		var i = 0;
		function buttonSwitch()
		{
			i++;
			document.getElementById("sbutton").setAttribute("src", img_array[i]);
			if (i == 1)
			{
				document.getElementById("bubbles").style.display = "none";
				document.getElementById("input").setAttribute("style", "padding-bottom: 34px;");
				document.getElementById("subject").value = "user";
				i = -1;
			}
			else
			{
				document.getElementById("bubbles").style.display = "initial";
				document.getElementById("input").setAttribute("style", "padding-bottom: 15px;");
				document.getElementById("subject").value = "intitle";
			}
		}
		showPage();
		login();
		</script>
</body>
</html>