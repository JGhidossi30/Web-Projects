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
	<div class="input">
		&emsp;<a href="./home.jsp">LibraMate</a>&nbsp;
		<form name="form" method="GET" action="./searchOut.jsp">
			<b><input type="text" placeholder="Search" name="search" style="width: 40%; height: 25px">
			<button type="submit" onclick="search()" style="position: relative; width: 31px; height: 31px; top: -2px; left: -4px;"><i class="fa fa-search"></i></button>
			<table>
				<tr style="vertical-align: text-top;">
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
	<table id="table"></table>
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
		search();
		login();
		</script>
</body>
</html>