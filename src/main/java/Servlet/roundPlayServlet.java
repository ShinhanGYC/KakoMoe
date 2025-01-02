package Servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import BeansHome.Actor.ActorDAO;
import BeansHome.Actor.ActorDTO;
import java.util.ArrayList;
import java.util.List;
/**
 * Servlet implementation class roundPlayServlet
 */
@WebServlet("/roundPlayServlet")
public class roundPlayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public roundPlayServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 HttpSession session = request.getSession();
		
		 ArrayList<ActorDTO> currentActorList =  (ArrayList) session.getAttribute("list");
		 int currentRound = 0;
		 int totalRound = 0;
		 if (session.getAttribute("currentRound") == null) {
			 currentRound = 1;
			 session.setAttribute("currentRound", currentRound);
		 }
		 else {
			 currentRound= (Integer) session.getAttribute("currentRound");
		 }
		 
		 if (session.getAttribute("totalRound") == null) {
			 totalRound = 1;
		 }
		 else {

			totalRound = (Integer) session.getAttribute("totalRound");
		 }
		 
		 if (currentActorList == null || currentActorList.isEmpty()) {
			 response.sendRedirect("error.jsp");
		 }
		 if (currentActorList.size() == 1) {
			 session.setAttribute("winnerActor", currentActorList.get(0));
			 response.sendRedirect("winner.jsp");			
		 }
		 else {
			 System.out.println(totalRound);
			 System.out.println(currentRound);
			 List<ActorDTO> pairList = currentActorList.subList(0, 2);
			 session.setAttribute("currentPair", pairList);
			 response.sendRedirect("play.jsp");
		 }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		ArrayList<ActorDTO> currentActorList =  (ArrayList) session.getAttribute("list");
		int currentRound = Integer.parseInt((String) session.getAttribute("currentRound"));
		int totalRound = Integer.parseInt((String) session.getAttribute("totalRound"));
		if(currentActorList == null || currentActorList.size() <= 1) {
			response.sendRedirect("roundPlayServlet");
			
		}
		ActorDTO currnetRoundWinnerActorDTO = (ActorDTO) session.getAttribute("currentRoundWinnerActor");
		ArrayList<ActorDTO> nextRoundActorList = (ArrayList) session.getAttribute("nextRoundActorList");
	
		if(currnetRoundWinnerActorDTO != null) {
			if(nextRoundActorList == null) {
				nextRoundActorList = new ArrayList<>();
			}
			nextRoundActorList.add(currnetRoundWinnerActorDTO);
			session.setAttribute("nextRoundActorList", nextRoundActorList);
		}
	
		if(currentActorList.size() == 2) {
			session.setAttribute("list", nextRoundActorList);
			session.setAttribute("nextRoundActorList", null);
	
			session.setAttribute("currentRound", 1);
			session.setAttribute("totalRound", Integer.parseInt((String)session.getAttribute("totalRound")) / 2);
		}else {
			currentActorList.remove(0);
			currentActorList.remove(0);
			session.setAttribute("currentRound", currentRound + 1);
			session.setAttribute("list", currentActorList);
		
		}
		
		response.sendRedirect("roundPlayServlet");
		
	}

}
