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
	<div class="input">
		&emsp;<a href="./home.jsp">LibraMate</a>&nbsp;
		<form name="form" method="GET" action="./searchOut.jsp">
			<b><input type="text" placeholder="Search" name="search" style="width: 40%; height: 25px">
			<button type="submit" onclick="search()" style="position: relative; width: 31px; height: 31px; top: -2px; left: -4px;"><i class="fa fa-search"></i></button>
			<table>
				<tr>
					<td>
						<input type="radio" name="subject" value="intitle" checked="checked"> Title<br /> 
						<input type="radio" name="subject" value="inauthor"> Author</td>
					<td>&emsp;&emsp;&emsp;</td>
					<td>
						<input type="radio" name="subject" value="isbn">ISBN<br /> 
						<input type="radio" name="subject" value="subject">Genre
					</td>
				</tr>
			</table></b>
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
			if (search == null || terms == "")
				return;
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
					a.href = "./informationOut.jsp?search=" + terms + "&subject=" + search + "&choice=" + i;
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
		search();
		</script>
</body>
</html>