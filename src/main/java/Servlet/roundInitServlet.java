package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import BeansHome.Actor.NewActorDAO;
import BeansHome.Actor.NewActorDTO;
import java.util.Collections;
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		boolean bContinue = false;   
		// TODO Auto-generated method stub
        request.setCharacterEncoding("UTF-8");
        String requestURI = request.getParameter("round");
        String round	 = requestURI.replaceAll("[^0-9]","");
		System.out.println("roundInitServlet round : " + round);
		
		NewActorDAO ActorDAO = new NewActorDAO();
		
		
		ArrayList<NewActorDTO> ActorDTOList = new ArrayList<>();
		
		
		
		
		try {
			if (ActorDAO.takeRandomActorForWorldcup(Integer.parseInt(round)) == true)
			{
				if (ActorDAO.DBMgr != null && ActorDAO.DBMgr.Rs != null)
				{
					bContinue = true;
				}

				
				if (bContinue == true) {
					while(ActorDAO.DBMgr.Rs.next() == true) {
						ActorDTOList.add(new NewActorDTO());
						ActorDTOList.get(ActorDTOList.size()-1).setActorID(ActorDAO.DBMgr.Rs.getInt("actor_id"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorName(ActorDAO.DBMgr.Rs.getString("actor_name"));
						ActorDTOList.get(ActorDTOList.size()-1).setFaceCode(ActorDAO.DBMgr.Rs.getInt("face_code"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorWorldcupPhoto(ActorDAO.DBMgr.Rs.getString("actor_worldcup_photo"));
						}
					}
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		

        //request.getRequestDispatcher("worldcup.jsp").forward(request, response);
        
  
        
        
        
        for(int i = 0; i < ActorDTOList.size(); i++)
        {
        	System.out.println("ActorDTOList.get(i).getActorID() : " + ActorDTOList.get(i).getActorID());
			System.out.println("ActorDTOList.get(i).getActorName() : " + ActorDTOList.get(i).getActorName());
			System.out.println("ActorDTOList.get(i).getFaceCode() : " + ActorDTOList.get(i).getFaceCode());
			System.out.println("ActorDTOList.get(i).getActorWorldcupPhoto() : " + ActorDTOList.get(i).getActorWorldcupPhoto());
        }
		
		Collections.shuffle(ActorDTOList);
        HttpSession session = request.getSession();
        session.setAttribute("round", round); // round 값 전달
        session.setAttribute("list", ActorDTOList); // ActorDTOList 전달

        // 리다이렉트 처리
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

