package assignment2;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class HandleRatingServlet
 */
@WebServlet("/HandleRatingServlet")
public class HandleRatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HandleRatingServlet() {
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
		String rating = request.getParameter("rating");
		String imdbID = request.getParameter("imdbID");
		String loggedUser = request.getParameter("loggedUser");
		String movieTitle = request.getParameter("movieTitle");
		double rating1 = Double.parseDouble(rating);
		HttpSession session = request.getSession(true);
			 
	 	final DatabaseManager dm = new DatabaseManager(ip, db, sqluser, sqlpswd);
	 
	 	String timeStamp = new SimpleDateFormat("MM.dd HH:mm").format(new Date());
	 	System.out.println("time: "+timeStamp);
	 	
		dm.addRating(loggedUser, imdbID, movieTitle, rating1,timeStamp);
		
	 	String avgRating = dm.getAvgRating(imdbID);
  	 	 
		session.setAttribute("avgRating", avgRating);
		System.out.println("avg: "+avgRating);
		String jsonObject = "{\"avgRating\": \"" + avgRating + "\"}";
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
