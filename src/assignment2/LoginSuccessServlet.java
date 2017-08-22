package assignment2;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SignUpSuccessServlet
 */
@WebServlet("/LoginSuccessServlet")
public class LoginSuccessServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginSuccessServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 
		String username = request.getParameter("username");
		String ip = request.getParameter("ip");
		String db = request.getParameter("db");
		String sqluser = request.getParameter("sqluser");
		String sqlpswd = request.getParameter("sqlpswd");
	 
		HttpSession session = request.getSession(true);
		session.setAttribute("username", username);
		session.setAttribute("ip", ip);
		session.setAttribute("db", db);
		session.setAttribute("sqluser", sqluser);
		session.setAttribute("sqlpswd", sqlpswd);
		response.sendRedirect("LoginPage.jsp");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
