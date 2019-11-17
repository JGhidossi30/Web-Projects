package libramate;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Output")
public class Output extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		String obj = request.getParameter("obj");
		BufferedWriter writer = new BufferedWriter(new FileWriter("/Users/JGhidossi/Library/Mobile Documents/com~apple~CloudDocs/Workspace/Libramate/WebContent/users.json")); 
		writer.write(obj);
		writer.flush();
		writer.close();
		RequestDispatcher dispatch = getServletContext().getRequestDispatcher("/searchIn.jsp");
		dispatch.forward(request, response);
	}
}