<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<link rel="stylesheet" type="text/css" href="./information.css">
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
	<table id="table"></table>
	<button onclick="dropdown()" style="width:250px; position: absolute; top: 550px; left: 2%; display: block; border: none; color: white; padding: 10px 27px; background-color: #000; font-size: 20px;">Add to Library</button>
	<img src="https://www.thrivingparish.org/wp-content/uploads/2018/01/white-down-arrow-png-2.png" onclick="dropdown()" width="28px" height="33px" style="position: absolute; top: 550px; left: 21.75%; display: block; border: none; color: white; padding: 5px 10px; background-color: #000; font-size: 20px;"></img>
	<button id="readDropDown" style="display: none;">Read</button>
	<button id="favDropDown" style="display: none;">Favorites</button>
	<script>
		function search()
		{	
			var url = new URL(window.location.href);
			var search = url.searchParams.get("subject");
			var terms = url.searchParams.get("search");
			var choice = url.searchParams.get("choice");
			var xhttp = new XMLHttpRequest();
			xhttp.open("GET", "https://www.googleapis.com/books/v1/volumes?q="+search+":"+terms+"&maxResults=12", false);
			xhttp.send();
			if (xhttp.status != 404) 
			{
				var books = JSON.parse(xhttp.responseText);
				if (books.totalItems == 0)
				{
					alert("No Book Found Under: " + terms);
					window.history.back();
					return;
				}
				var img = document.createElement("IMG");
			  	try
			  	{
			   		img.setAttribute("src", books.items[choice].volumeInfo.imageLinks.thumbnail);
			  	}
			  	catch (error)
			   	{
				   	img.setAttribute("src", "https://www.hachette.co.nz/graphics/CoverNotAvailable.jpg");
			   	}
			  	img.setAttribute("width", "300px");
			  	img.setAttribute("height", "400px");
			  	img.style = "position: absolute; left: 2%; top: 18%;";
			  	document.body.appendChild(img);
			  	var title = document.createTextNode(books.items[choice].volumeInfo.title);
			  	var author = document.createTextNode("by " + books.items[choice].volumeInfo.authors);
			  	var publish = document.createTextNode("Publisher:");
			  	var publisher = document.createTextNode(books.items[choice].volumeInfo.publisher);
			  	var descript = document.createTextNode("Description:");
			  	var description = document.createTextNode(books.items[choice].volumeInfo.description);
			  	var rate = document.createTextNode("Rating:");
			  	var rating = books.items[choice].volumeInfo.averageRating;
			  	var table = document.createElement("table");
			  	table.style = "position: absolute; top: 140px; left: 380px; width: 70%;";
			  	var tbody = document.createElement("tbody");
			  	var row1 = document.createElement("tr");
			  	var row2 = document.createElement("tr");
			  	var row3 = document.createElement("tr");
			  	var row4 = document.createElement("tr");
			  	var row5 = document.createElement("tr");
			  	var row6 = document.createElement("tr");
			  	var row7 = document.createElement("tr");
			  	var titleCell = document.createElement("td");
			  	var authorCell = document.createElement("td");
			  	var publishColon = document.createElement("td");
			  	var publisherCell = document.createElement("td");
			  	var descriptionColon = document.createElement("td");
			  	var descriptionCell = document.createElement("td");
			  	var ratingColon = document.createElement("td");
			  	titleCell.appendChild(title);
			  	authorCell.appendChild(author);
			  	publishColon.appendChild(publish);
			  	publisherCell.appendChild(publisher);
			  	descriptionColon.appendChild(descript);
			  	descriptionCell.appendChild(description);
			  	ratingColon.appendChild(rate);
			  	
			  	titleCell.style = "color: white; font: 'Arial Black', Gadget, sans-serif; font-size: 45px; -webkit-text-stroke: 2px #000000;";
			  	authorCell.style = "color: white; font: 'Arial Black', Gadget, sans-serif; font-size: 30px; -webkit-text-stroke: 2px #000000;";
			  	publishColon.style = "color: white; font: 'Arial Black', Gadget, sans-serif; font-size: 25px; -webkit-text-stroke: 2px #000000;";
			  	publisherCell.style = "color: black; font: 'Arial Black', Gadget, sans-serif; font-size: 25px; position: relative; left: -350px; width: 500px;";
			  	descriptionColon.style = "color: white; font: 'Arial Black', Gadget, sans-serif; font-size: 25px; -webkit-text-stroke: 2px #000000;";
			  	descriptionCell.style = "color: black; font: 'Arial Black', Gadget, sans-serif; ";
			  	ratingColon.style = "color: white; font: 'Arial Black', Gadget, sans-serif; font-size: 25px; -webkit-text-stroke: 2px #000000;";
			  	
			  	row1.appendChild(titleCell);
			  	row2.appendChild(authorCell);
			  	row3.appendChild(publishColon);
			  	row3.appendChild(publisherCell);
			  	row4.appendChild(descriptionColon);
			  	row5.appendChild(descriptionCell);
			  	row6.appendChild(ratingColon);
			  	
			  	var stars = document.createElement("IMG");
			  	switch(parseInt(rating))
			  	{
			  	case 1:
			  		stars.setAttribute("src", "http://audneal.typepad.com/.a/6a010534aaa6ea970c0168ebedc81d970c-pi");
			  		break;
			  	case 2:
			  		stars.setAttribute("src", "https://scilogreen.files.wordpress.com/2014/11/2-star.png");
			  		break;
			  	case 3:
			  		stars.setAttribute("src", "https://emdoesbookreviews.files.wordpress.com/2014/12/three-stars.png");
			  		break;
			  	case 4:
			  		stars.setAttribute("src", "https://www.grantmemorial.com/images/4stars.png");
			  		break;
			  	case 5:
			  		stars.setAttribute("src", "http://www.stickpng.com/assets/images/587515f319ef112e47c6964a.png");
			  		break;
			  	default:
			  		stars.setAttribute("src", "https://openclipart.org/download/26456/Anonymous-zero-star-rating.svg");
			  		break;
			  	}
			  	stars.setAttribute("width", "500px");
			  	stars.setAttribute("height", "100px");
			  	row7.appendChild(stars);
			  	
			  	tbody.appendChild(row1);
			  	tbody.appendChild(row2);
			  	tbody.appendChild(row3);
			  	tbody.appendChild(row4);
			  	tbody.appendChild(row5);
			  	tbody.appendChild(row6);
			  	tbody.appendChild(row7);
			  	table.appendChild(tbody);
			  	document.body.appendChild(table);
			}
			else
				window.location.replace("./home.jsp");
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
		var dd = 0;
		function dropdown()
		{ 
			dd++;
			var read = document.getElementById("readDropDown");
			var favorites = document.getElementById("favDropDown");
			if (dd == 1)
			{
				read.style = "width:250px; position: absolute; top: 595px; left: 2%; display: block; border: none; color: black; padding: 10px 27px; background-color: #C4C4C4; font-size: 20px;";
				read.onclick = function()
				{
					var rawFile = new XMLHttpRequest();
				    rawFile.open("GET", "./users.json", false);
				    rawFile.onreadystatechange = function()
				    {
				        if (rawFile.readyState === 4)
				        {
		        				var url = new URL(window.location.href);
							var search = url.searchParams.get("search");
				            var users = JSON.parse(rawFile.responseText);
				            var read = users.users[i].library.read;
				            var bool = 0;
	            				for (var j = 0; j < read.length; j++)
	            				{
	            					if (read[j] == search)
	            						bool = 1;
	            				}
				            if (bool == 0)
				            	{
					            	read.push(search);
		            				sessionStorage.setItem("read", read);
		            				users.users[i].library.read = read;
		    					    document.output.method = "POST"; 
		    					    document.getElementById("obj").value = JSON.stringify(users);
		    					    document.output.submit();
				            	}
				        }
				    }
				    rawFile.send(null);
				};
				favorites.style = "width:250px; position: absolute; top: 640px; left: 2%; display: block; border: none; color: black; padding: 10px 27px; background-color: #C4C4C4; font-size: 20px;";
				favorites.onclick = function()
				{
					var rawFile = new XMLHttpRequest();
				    rawFile.open("GET", "./users.json", false);
				    rawFile.onreadystatechange = function()
				    {
				        if (rawFile.readyState === 4)
				        {
		        				var url = new URL(window.location.href);
							var search = url.searchParams.get("search");
				            var users = JSON.parse(rawFile.responseText);
				            var favorites = users.users[i].library.favorite;
				            var bool = 0;
	            				for (var j = 0; j < favorites.length; j++)
	            				{
	            					if (favorites[j] == search)
	            						bool = 1;
	            				}
				            if (bool == 0)
				            	{
					            	read.push(search);
		            				sessionStorage.setItem("favorites", favorites);
		            				users.users[i].library.favorite = favorites;
		    					    document.output.method = "POST"; 
		    					    document.getElementById("obj").value = JSON.stringify(users);
		    					    document.output.submit();
				            	}
				        }
				    }
				    rawFile.send(null);
				};
				document.body.append(read);
				document.body.append(favorites);
				dd = -1;
			}
			else
			{
				read.style = "display: none;";
				favorites.style = "display: none;";
			}	
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
		<form name="output" onsubmit="./OutputUp"><input type="hidden" id="obj" name="obj"></form>
	</body>
</html>