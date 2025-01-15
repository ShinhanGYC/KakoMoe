// #################################################################################################
// ServletRoundPlay.java - 서블릿 이상형 월드컵 플레이 모듈 
// #################################################################################################
// ═════════════════════════════════════════════════════════════════════════════════════════
// 외부모듈 영역
// ═════════════════════════════════════════════════════════════════════════════════════════
package Servlet;

import java.io.IOException;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import BeansHome.Actor.ActorDTO;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* ServletRoundPlay			: 서블릿 이상형 월드컵 플레이 클래스<br>
* Inheritance				: HttpServlet
***********************************************************************/
@WebServlet("/ServletRoundPlay")
public class ServletRoundPlay extends HttpServlet {
	
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
 	 * ServletRoundPlay		()	: 생성자
 	 * @param void				: None
 	 ***********************************************************************/
    public ServletRoundPlay() {
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
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = null;					 // 세션 객체
		
		ArrayList<ActorDTO> currentActorList = null; // 배우 배열 리스트 DTO Bean 객체
		List<ActorDTO> currentPair = null;			 // 서로 대결 할 배우 리스트 DTO Bean 객체
		
		@SuppressWarnings("unused")
		int currentRound = 0;						 // 현재 라운드 변수
		@SuppressWarnings("unused")
		int totalRound   = 0;						 // 전체 라운드 변수
		
		
		
		try {		
			
			session = request.getSession();
			
			// -------------------------------------------------------------------------------------------------------
			// session 에서 설정되어 있는 currentRound 파라미터 읽기 
			// 성공 : currentRound 변수 값 설정 
			// 실패 : error.jsp 로 이동 |
			// -------------------------------------------------------------------------------------------------------
			if (session.getAttribute("currentRound") == null) {
				response.sendRedirect("error.jsp");
			}
			else {
				currentRound = (Integer) session.getAttribute("currentRound");
			}
			
 
			// ---------------------------------------------------------------------------------------------------
			// session 에서 설정되어 있는 totalRoynd 파라미터 읽기 
			// 성공 : totalRound 변수 값 설정 
			// 실패 : error.jsp 로 이동 |
			// ---------------------------------------------------------------------------------------------------
			if (session.getAttribute("totalRound") == null ) {
				response.sendRedirect("error.jsp");
			}
			else {
				totalRound = (Integer) session.getAttribute("totalRound");
			}
 
			// -------------------------------------------------------------------------------------------------------------
			// session 에서 설정되어 있는 actorList 파라미터 읽기 
			// 성공 : currentActorList 배열 리스트 값 설정 
			// 실패 : error.jsp 로 이동 |
			// -------------------------------------------------------------------------------------------------------------
			if ((ArrayList<ActorDTO>) session.getAttribute("actorList") == null) {
				response.sendRedirect("error.jsp");
			}
			else {
				currentActorList =  (ArrayList<ActorDTO>) session.getAttribute("actorList");
			}
 
 
			// --------------------------------------------------------------------------------------------------------------------------------------------------------
			// currentActorList 사이즈 읽기 
			// 1 일 경우 : 우승자를 winnerActor 파라미터 설정 후 winner.jsp로 이동 
			// 그 외 :두명의 배우를 currentPair에 설정 후 play.jsp로 이동하여 게임 진행 |
			// --------------------------------------------------------------------------------------------------------------------------------------------------------
			if (currentActorList.size() == 1) {
			 session.setAttribute("winnerActor", currentActorList.get(0));
			 
			 response.sendRedirect("winner.jsp");			
			}
			else {
			 currentPair = currentActorList.subList(0, 2);
			 session.setAttribute("currentPair", currentPair);
			 response.sendRedirect("play.jsp");
			}
	
		}
		catch(Exception Ex){
			session.invalidate();
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
		
		HttpSession session = null; 						// 세션 객체
		
		ArrayList<ActorDTO> currentActorList = null;		// 배우 배열 리스트 DTO Bean 객체
		ArrayList<ActorDTO> nextRoundActorList  = null;	 	// 서로 대결 할 배우 리스트 DTO Bean 객체
		
		int currentRound = 0;								// 현재 라운드 변수
		int totalRound   = 0;								// 전체 라운드 변수
		
		String selectedActorId = null;						// 선택된 배우 ID
		try {
			
			session = request.getSession();
			
			// -----------------------------------------------------------------------------
			// crrentActorList 의 값 설정 : actorList 파라미터 에서 읽기 
			// -----------------------------------------------------------------------------
			currentActorList =  (ArrayList<ActorDTO>) session.getAttribute("actorList");
			
			// -----------------------------------------------------------------------------
			// currentRound 의 값 설정 : currentRound 파라미터 에서 읽기 
			// -----------------------------------------------------------------------------
			currentRound = (Integer) session.getAttribute("currentRound");
			
			// -----------------------------------------------------------------------------
			// totalRound 의 값 설정 : totalRound 파라미터 에서 읽기 
			// -----------------------------------------------------------------------------
			totalRound = (Integer) session.getAttribute("totalRound");
			
			// -----------------------------------------------------------------------------
			// selectedActorId 의 값 설정 : selectedActor 파라미터 에서 읽기 
			// -----------------------------------------------------------------------------
			selectedActorId = request.getParameter("selectedActor");
			
			// -----------------------------------------------------------------------------
			// nextRoundActorList 의 값 설정 : nextRoundActorList 파라미터 에서 읽기 
			// -----------------------------------------------------------------------------
			nextRoundActorList = (ArrayList<ActorDTO>)session.getAttribute("nextRoundActorList");
			

			// -----------------------------------------------------------------------------
			// (32강,16강,8강,4강 라운드가 끝날때 마다 servletRoundPlay 호출
			// -----------------------------------------------------------------------------
			if(currentActorList == null || currentActorList.size() <= 1) {
				response.sendRedirect("ServletRoundPlay");
				
			}
			
			// -----------------------------------------------------------------------------
			// 선택된 배우를 nextRoundActorList에 추가하기
			// -----------------------------------------------------------------------------
			if(selectedActorId != null) {
				if(nextRoundActorList == null) {
					nextRoundActorList = new ArrayList<>();
				}
				for (ActorDTO actorDTO : currentActorList) {
					if(actorDTO.getActorID() == (Integer.parseInt(selectedActorId))) {
						nextRoundActorList.add(actorDTO);
						break;
					}
				}
				session.setAttribute("nextRoundActorList", nextRoundActorList);
			}
		
			// -----------------------------------------------------------------------------
			// 남아있는 배우가 2명일 경우 결승전으로 우승자 뽑기
			// -----------------------------------------------------------------------------
			if(currentActorList.size() == 2) {
				session.setAttribute("actorList", nextRoundActorList);
				session.setAttribute("nextRoundActorList", null);
		
				session.setAttribute("currentRound", 1);
				session.setAttribute("totalRound", totalRound / 2);
			}
			// -----------------------------------------------------------------------------
			// 그 외에는 계속 게임 진행
			// -----------------------------------------------------------------------------
			else {
				currentActorList.remove(0);
				currentActorList.remove(0);
				session.setAttribute("currentRound", currentRound + 1);
				session.setAttribute("actorList", currentActorList);
	
			}
			// -----------------------------------------------------------------------------
			// 설정 완료 후 ServletRoundPlay(get) 요청 
			// -----------------------------------------------------------------------------
			response.sendRedirect("ServletRoundPlay");
		}
		catch (Exception e) {
			
			e.printStackTrace();
		}
		
		
		
	}

}
