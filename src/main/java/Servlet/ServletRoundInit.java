// #################################################################################################
// ServletRoundInit.java - 서블릿 이상형 월드컵 라운드 초기 설정 모듈 (DB에서 배우 정보 추출 + 리스트 생성 +  리스트 셔플 + Session 설정 + ServletRoundPlay 전송) 
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package Servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import BeansHome.Actor.ActorDAO;
import BeansHome.Actor.ActorDTO;
import java.util.Collections;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* ServletRoundInit			: 서블릿 이상형 월드컵 라운드 초기 설정 클래스<br>
* Inheritance				: HttpServlet
***********************************************************************/
@WebServlet("/ServletRoundInit")
public class ServletRoundInit extends HttpServlet {
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역상수 관리 - 필수영역
	// —————————————————————————————————————————————————————————————————————————————————————
	/** serialVersionUID : Bean 객체(메모리 객체 데이터) 직렬화 아이디(Servlet 구현시 필수 사항) */
	private static final long serialVersionUID = 1L;
	
	// —————————————————————————————————————————————————————————————————————————————————————
 	// 전역변수 관리 - 필수영역(정적변수) : JSP 쪽에 노출시키려면 Static 등록 필요!
 	// —————————————————————————————————————————————————————————————————————————————————————
 	// /** DBMgr : 오라클 데이터베이스 DAO 객체 선언 */
 	// public static DAO.DBOracleMgr DBMgr = null;
 	// —————————————————————————————————————————————————————————————————————————————————————
 	// 전역변수 관리 - 필수영역(인스턴스변수)
 	// —————————————————————————————————————————————————————————————————————————————————————
 	
 	// —————————————————————————————————————————————————————————————————————————————————————
    // 생성자 관리 - 필수영역(인스턴스함수)
 	// —————————————————————————————————————————————————————————————————————————————————————
 	/***********************************************************************
 	 * ServletRoundInit()		: 생성자
 	 * @param void				: None
 	 ***********************************************************************/
    public ServletRoundInit() {
        super();
        
        try {
        	// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			Common.ExceptionMgr.SetMode(Common.ExceptionMgr.RUN_MODE.DEBUG);
			// -----------------------------------------------------------------------------
        }
        catch (Exception Ex)
		{
			Common.ExceptionMgr.DisplayException(Ex);	// 예외처리(콘솔)
		}
    }
    
    // —————————————————————————————————————————————————————————————————————————————————————
 	// 전역함수 관리 - 필수영역(정적함수)
 	// —————————————————————————————————————————————————————————————————————————————————————

 	// —————————————————————————————————————————————————————————————————————————————————————
 	// 전역함수 관리 - 필수영역(인스턴스함수)
 	// —————————————————————————————————————————————————————————————————————————————————————
 	/***********************************************************************
 	 * doGet()			: Servlet doGet 함수 선언(필수 함수)
 	 * 					: get 방식으로 파라미터를 전달하는 경우 호출됨
 	 * @param request	: 웹 서버 요청에 사용하는 파라미터
 	 * @param response	: 웹 서버 응답시 사용하는 파라미터
 	 * @return void		: None
 	 * @exception ServletException
 	 * @exception IOException
 	 ***********************************************************************/
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		try{
			doPost(request, response);
		}
		catch (Exception Ex){
			Common.ExceptionMgr.DisplayException(Ex);	// 예외처리(콘솔)
		}
	}
	
	/***********************************************************************
	 * doPost()			: Servlet doPost 함수 선언(필수 함수)
	 * 					: post 방식으로 파라미터를 전달하는 경우 호출됨
	 * @param request	: 웹 서버 요청에 사용하는 파라미터
	 * @param response	: 웹 서버 응답시 사용하는 파라미터
	 * @return void		: None
	 * @exception ServletException
	 * @exception IOException
	 ***********************************************************************/
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		boolean bContinue = false;									// DAO 실행 여부 ( true / false )
		
		// -----------------------------------------------------------------------------
		// request parameter : round 파라미터 파싱 (String -> int) 
		// -----------------------------------------------------------------------------
		String requestURI = null;		// round 값 파싱 : (32강 / 16강) 변수
		String roundStr	  = null;		// 숫자 값 파싱   : (32 / 16) 변수
		int round 	      = 0;			// String -> Integer 형 변환 변수
		
		ActorDAO ActorDAO 	= null;		// 배우 DAO Bean 객체(Database Access Object)
		ArrayList<ActorDTO> ActorDTOList = null; // 배우 배열 리스트 DTO Bean 객체(Database Access Object)
		
		HttpSession session = null;		// 세션 객체
		RequestDispatcher dispatcher = null; // forword 객체 
		
		try {
			// -----------------------------------------------------------------------------
			// 한글 인코딩 지정(가장 첫번째로 지정!)
			// -----------------------------------------------------------------------------
			request.setCharacterEncoding("UTF-8");					// 입력 된 파라미터 한글 인코딩
			
			// -----------------------------------------------------------------------------
			// round 변수 값 설정
			// -----------------------------------------------------------------------------
			requestURI = request.getParameter("round");	
			roundStr	 = requestURI.replaceAll("[^0-9]","");
			round = Integer.parseInt(roundStr);		
			
			// -----------------------------------------------------------------	
			// Beans 객체 생성
			// -----------------------------------------------------------------
			ActorDAO = new ActorDAO();		
			ActorDTOList = new ArrayList<>();
			
			// -----------------------------------------------------------------------------
			// DB에서 배우 데이터 랜덤으로 가져오기 (16개 or 32개)
			// -----------------------------------------------------------------------------
			if (ActorDAO.takeRandomActorForWorldcup(round) == true)
			{
				if (ActorDAO.DBMgr != null && ActorDAO.DBMgr.Rs != null)
				{
					bContinue = true;
				}
				
				if (bContinue == true) {
				// -----------------------------------------------------------------------------
				// 가져온 배우 정보 배우 리스트 DTO에 삽입하기
				// -----------------------------------------------------------------------------
					while(ActorDAO.DBMgr.Rs.next() == true) {
						ActorDTOList.add(new ActorDTO());
						ActorDTOList.get(ActorDTOList.size()-1).setActorID(ActorDAO.DBMgr.Rs.getInt("actor_id"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorName(ActorDAO.DBMgr.Rs.getString("actor_name"));
						ActorDTOList.get(ActorDTOList.size()-1).setFaceCode(ActorDAO.DBMgr.Rs.getInt("face_code"));
						ActorDTOList.get(ActorDTOList.size()-1).setFaceName(ActorDAO.DBMgr.Rs.getString("face_name"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorDebut(ActorDAO.DBMgr.Rs.getString("actor_debut"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorHit(ActorDAO.DBMgr.Rs.getString("actor_hit"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorNewest(ActorDAO.DBMgr.Rs.getString("actor_newest"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorProfilePhoto(ActorDAO.DBMgr.Rs.getString("actor_profile_photo"));
						ActorDTOList.get(ActorDTOList.size()-1).setActorWorldcupPhoto(ActorDAO.DBMgr.Rs.getString("actor_worldcup_photo"));
						}
					}
			}
			
			// -----------------------------------------------------------------	
			// 선택된 배우 정보 출력 (서버 콘솔 창)
			// -----------------------------------------------------------------
			//        for(int i = 0; i < ActorDTOList.size(); i++)
			//        {
			//        	System.out.println("ActorDTOList.get(i).getActorID() : " + ActorDTOList.get(i).getActorID());
			//			System.out.println("ActorDTOList.get(i).getActorName() : " + ActorDTOList.get(i).getActorName());
			//			System.out.println("ActorDTOList.get(i).getFaceCode() : " + ActorDTOList.get(i).getFaceCode());
			//			System.out.println("ActorDTOList.get(i).getActorWorldcupPhoto() : " + ActorDTOList.get(i).getActorWorldcupPhoto());
			//        }
			
			// -----------------------------------------------------------------	
			// 배우 리스트 셔플하기
			// -----------------------------------------------------------------
			Collections.shuffle(ActorDTOList);
			
			// -----------------------------------------------------------------	
			// 세션 설정
			// -----------------------------------------------------------------
			session = request.getSession();			   		 // 세션값 가져오기
			session.setAttribute("totalRound", round); 		 // totalRound 파라미터 설정   	 | (16 / 32)
			session.setAttribute("currentRound", 1);   		 // currentRound 파라미터 설정 	 | 1
			session.setAttribute("actorList", ActorDTOList); // actorList 파라미터 설정 	 | ActorDTOList 객체 
	        
	      
			// -----------------------------------------------------------------	
			// 다음 서블릿에 데이터 전달 및 이동하기 
			// -----------------------------------------------------------------
			dispatcher = request.getRequestDispatcher("ServletRoundPlay");
			dispatcher.forward(request, response);
	        
		} 
		catch (Exception e) {
			
			e.printStackTrace();
		}
	}
}

