package assignment2;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HandleSignUpServlet
 */
@WebServlet("/HandleLoginServlet")
public class HandleLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String username = request.getParameter("username");
		String password = request.getParameter("password");
 	 
		String ip = request.getParameter("ip");
		String db = request.getParameter("db");
		String sqluser = request.getParameter("sqluser");
		String sqlpswd = request.getParameter("sqlpswd");
		
		HttpSession session = request.getSession(false);
		 
		final DatabaseManager dm = new DatabaseManager(ip, db, sqluser, sqlpswd); 
		
		String errorMessage = "";
		 
		  String validUsername = dm.validateUsername(username);
		  if (!validUsername.equals("success")){
			  errorMessage = validUsername;
		  }
		  else {
			  String validPassword = dm.validatePassword(username, password);
			    if (!validPassword.equals("success")){
			    	errorMessage = validPassword;
			    }
			    else {
			    	errorMessage = "none";
			    }
		  }
		session.setAttribute("username", username);
	 
		String jsonObject = "{ \"errorMessage\": \"" + errorMessage + "\"}";
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		out.print(jsonObject);
		out.flush();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
