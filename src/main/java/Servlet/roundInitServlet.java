package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class roundInitServlet
 */
@WebServlet("/roundInitServlet")
public class roundInitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public roundInitServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        String requestURI = request.getParameter("round");
        String round	 = requestURI.replaceAll("[^0-9]","");
		System.out.println("roundInitServlet round : " + round);
		
		
		
				
	
        request.setAttribute("resultMessage", round);

        //request.getRequestDispatcher("worldcup.jsp").forward(request, response);
        
        HttpSession session = request.getSession();
        session.setAttribute("round", round);
        
        
        
        
        response.sendRedirect("worldcup.jsp");
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		
	}

}
