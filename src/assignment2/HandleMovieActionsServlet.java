package assignment2;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HandleMovieActionsServlet
 */
@WebServlet("/HandleMovieActionsServlet")
public class HandleMovieActionsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleMovieActionsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String action = request.getParameter("action");
		 
		HttpSession session = request.getSession(true);
		String ip = (String) session.getAttribute("ip");
		String db = (String) session.getAttribute("db");
		String sqluser = (String) session.getAttribute("sqluser");
		String sqlpswd = (String) session.getAttribute("sqlpswd");
		String loggedUser = (String) session.getAttribute("loggedUsername");
		String imdbID = (String) session.getAttribute("imdbID");
		String movieTitle = (String) session.getAttribute("movieTitle");
		
		final DatabaseManager dm = new DatabaseManager(ip,db,sqluser,sqlpswd);
	 	 
        session.setAttribute("ip", ip); 
        session.setAttribute("db", db);
        session.setAttribute("sqluser", sqluser);
        session.setAttribute("sqlpswd", sqlpswd);
        session.setAttribute("loggedUsername", loggedUser);        
        request.setAttribute("movieTitle", movieTitle);
	 	
	 	String timeStamp = new SimpleDateFormat("MM.dd HH:mm").format(new Date());
	 	System.out.println("time: "+timeStamp);
	 	
	 	dm.handleMovieAction(loggedUser, action, movieTitle,imdbID,timeStamp);
	 	
	 	RequestDispatcher rd = request.getRequestDispatcher("MoviePage.jsp");
		rd.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
