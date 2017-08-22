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
@WebServlet("/HandleSignUpServlet")
public class HandleSignUpServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleSignUpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("in sign up servlet");
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String fullname = request.getParameter("fullname");
		String imageurl = request.getParameter("imageurl");
		String ip = request.getParameter("ip");
		String db = request.getParameter("db");
		String sqluser = request.getParameter("sqluser");
		String sqlpswd = request.getParameter("sqlpswd");
		String[] names = fullname.split("\\s+");
		String fname = names[0];
		String lname = names[1];
		
		HttpSession session = request.getSession(false);
		final DatabaseManager dm = new DatabaseManager(ip, db, sqluser, sqlpswd);
		 
		String errorMessage = "";
		if (username.equals("") || password.equals("") || fullname.equals("") || imageurl.equals("")){
			errorMessage = "Please fill in all required fields";
		}
		else {
			String validSignUpUsernameMsg = dm.validateSignUpUsername(username);
		    if (!validSignUpUsernameMsg.equals("success")){
		    	errorMessage = validSignUpUsernameMsg;
		    }
		}
		session.setAttribute("username", username);
		 
		if (errorMessage.equals("")){
			dm.addUser(username, password, fname, lname, imageurl);
			errorMessage = "none";
			System.out.println("no err");
		}
		 
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
