<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link rel="stylesheet" type="text/css" href="./home.css">
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>Libramate</title>
	</head>
	<body>
		<div class="input" align="center">
			<a href="./home.jsp">LibraMate</a><br />
			<form name="form" method="GET" action="./searchOut.jsp"><b>
			<input type="text" placeholder="Search" name="search" style="width: 40%; height: 25px">
			<button type="submit" style="position: relative; width: 31px; height: 31px; top: -2px; left: -4px;"><i class="fa fa-search"></i></button><br />
			<table>
				<tr>
					<td>
						<input type="radio" name="subject" value="intitle" checked="checked"> Title<br /><br />
						<input type="radio" name="subject" value="inauthor"> Author
					</td>
					<td>
						<input type="radio" name="subject" value="isbn"> ISBN<br /><br />
						<input type="radio" name="subject" value="subject"> Genre
					</td>
				</tr>
			</table>
			</b></form>
			<div class="Sign">
			<br /><br />
			<form action="./signup.jsp"><button style="display: inline-block; border: none; color: white; padding: 10px 20px; background-color: #555555; font-size: 16px;">SIGN UP</button></form><br />
			<form action="./login.jsp"><button onclick="./login.jsp" style="display: inline-block; border: none; color: white; padding: 10px 27px; background-color: #555555; font-size: 16px;">LOGIN</button></form>
			</div>
		</div>
	</body>
</html>