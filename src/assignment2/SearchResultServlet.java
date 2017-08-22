package assignment2;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SearchResultServlet
 */
@WebServlet("/SearchResultServlet")
public class SearchResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchResultServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession(true);
		String ip = (String) session.getAttribute("ip");
		String db = (String) session.getAttribute("db");
		String sqluser = (String) session.getAttribute("sqluser");
		String sqlpswd = (String) session.getAttribute("sqlpswd");
		String profileImage = (String) session.getAttribute("profileImage");
		  
	    final DatabaseManager dm = new DatabaseManager(ip,db,sqluser,sqlpswd);
	 	 
	    String[] results = null;
	    String[] imdbIDs = null;
		String toSearch = request.getParameter("searchType");
		if (toSearch.equals("movie")){ //search for movies
			String movie = request.getParameter("searchMaterial");
			session.setAttribute("searchType", "movie");
			if (movie.contains(":")){
				String[] parts = movie.split(":");
				String type = parts[0];  
				type = type.trim();
				String movieName = parts[1]; 
				movieName = movieName.trim();
				if (type.equals("actor")){
					results = dm.searchByActor(movieName);
					imdbIDs = dm.searchByActorID(movieName);
				}
				else if (type.equals("title")){
					results = dm.searchByTitle(movieName);
					imdbIDs = dm.searchByTitleID(movieName);
				}
			}
			
		}
		else { //search for user
			session.setAttribute("searchType", "user");
			String user = request.getParameter("searchMaterial");
			results = dm.searchUser(user);
		}
		 
		session.setAttribute("profileImage", profileImage);
		session.setAttribute("ip", ip);
		session.setAttribute("db", db);
		session.setAttribute("sqluser", sqluser);
		session.setAttribute("sqlpswd", sqlpswd);
		session.setAttribute("results", results);
		session.setAttribute("imdbIDs", imdbIDs);
		response.sendRedirect("SearchResults.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
