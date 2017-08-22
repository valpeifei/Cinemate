package assignment2;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HandleFollowServlet
 */
@WebServlet("/HandleFollowServlet")
public class HandleFollowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleFollowServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String ip = request.getParameter("ip");
		String db = request.getParameter("db");
		String sqluser = request.getParameter("sqluser");
		String sqlpswd = request.getParameter("sqlpswd");
		String loggedUser = request.getParameter("loggedUser");
		String currUser = request.getParameter("currUser");
		 
		HttpSession session = request.getSession(true);
		
		final DatabaseManager dm = new DatabaseManager(ip, db, sqluser, sqlpswd);
	 	
	 	dm.handleFollow(loggedUser, currUser);
	 	
	 	String followingsList = dm.getFollowingsList(currUser);
  	 	String followersList = dm.getFollowersList(currUser);
  	 	
		session.setAttribute("followingsList", followingsList);
		session.setAttribute("followersList", followersList);
		
		String jsonObject = "{\"followingsList\": \"" + followingsList + "\", \"followersList\": \"" + followersList + "\"}";
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
