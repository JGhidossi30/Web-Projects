<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="./search.css">
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
				<tr>
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
	<table id="myTable"></table>
	<script>
		function search()
		{	
			var url = new URL(window.location.href);
			var search = url.searchParams.get("subject");
			var terms = url.searchParams.get("search");
			if (search == null || (terms == "" && search != "user"))
				return;
			if (search == "user")
			{
				var rawFile = new XMLHttpRequest();
			    rawFile.open("GET", "./users.json", false);
			    rawFile.onreadystatechange = function()
			    {
			        if (rawFile.readyState === 4)
			        	{
			        		var users = JSON.parse(rawFile.responseText);
						var table = document.getElementById("myTable");
				    		var row;
				    		var j = 0;
						for (var i = 0; i < users.users.length; i++)
						{
							if (terms == ""){}
							else if (!users.users[i].username.toLowerCase().includes(terms.toLowerCase()))
								continue;
							if (j % 4 == 0)
								row = table.insertRow(j / 4);
							var cell = row.insertCell(j % 4);
					 		var img = document.createElement("IMG");
					  		try
					  		{
					   			img.setAttribute("src", users.users[i].imageURL);
					  		}
							catch (error)
					  		{
						   		img.setAttribute("src", "http://www.mop-zafon.org.il/sites/default/files/default_images/place-holder.png");
					   		}
					   		img.setAttribute("width", "200");
							img.setAttribute("height", "200");
							img.setAttribute("style", "border-radius: 50%; border: 2px solid #000000;");
							row.style = "text-align: center;";
							cell.style = "padding: 50px;";
							var cellTitle = document.createTextNode("@" + users.users[i].username);
							var a = document.createElement("a");
							a.style = "font-size: 14px; color: black; text-decoration: none;";
							a.appendChild(img);
							a.appendChild(document.createElement("br"));
							a.appendChild(cellTitle);
							if (sessionStorage.getItem("username") == users.users[i].username)
								a.href = "./youser.jsp";
							else
								a.href = "./user.jsp?search=" + users.users[i].username;
							cell.appendChild(a);
							j++;
						}
						if (j == 0)
						{
							var noUsers = document.createTextNode("No Users Found!");
							table.appendChild(noUsers);
							table.setAttribute("style", "color: white; font-family:'Arial Black', Gadget, sans-serif; font-size: 40px; -webkit-text-stroke: 2px #000000; position: absolute; top: 50%; left: 37.5%;"); 
							document.body.appendChild(table);
						}
			        	}
			    }
			    	rawFile.send(null);
			}
			else
			{
				var xhttp = new XMLHttpRequest();
				xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q="+search+":"+terms+"&maxResults=12", false);
				xhttp.send();
				if (xhttp.status != 404) 
				{
					var books = JSON.parse(xhttp.responseText);
					if (books.totalItems == 0)
					{
						alert("No Books Found Under: " + terms);
						window.history.back();
						return;
					}
					var table = document.getElementById("myTable");
			    		var row;
					for (var i = 0; i < books.items.length; i++)
					{
						if (i % 4 == 0)
							row = table.insertRow(i / 4);
						var cell = row.insertCell(i % 4);
				   		var img = document.createElement("IMG");
				  		try
				  		{
				   			img.setAttribute("src", books.items[i].volumeInfo.imageLinks.thumbnail);
				  		}
				  		catch (error)
				   		{
					   		img.setAttribute("src", "https://www.hachette.co.nz/graphics/CoverNotAvailable.jpg");
				   		}
				   		img.setAttribute("width", "200");
						img.setAttribute("height", "300");
						row.style = "text-align: center;";
						cell.style = "padding: 50px;";
						var cellTitle = document.createTextNode(books.items[i].volumeInfo.title);
						var cellAuthor = document.createTextNode("by " + books.items[i].volumeInfo.authors);
						var a = document.createElement("a");
						a.style = "font-size: 14px; color: black; text-decoration: none;";
						a.appendChild(img);
						a.appendChild(document.createElement("br"));
						a.appendChild(cellTitle);
						a.appendChild(document.createElement("br"));
						a.href = "./informationIn.jsp?search=" + terms + "&subject=" + search + "&choice=" + i;
						var b = document.createElement("a");
						b.style = "font-size: 12px; color: black; text-decoration: none;";
						b.appendChild(cellAuthor);
						cell.appendChild(a);
						cell.appendChild(b);
					}
				}
			else
				window.location.replace("./home.jsp");
			}
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
			sessionStorage.removeItem("library");
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
		search();
		login();
		</script>
</body>
</html>