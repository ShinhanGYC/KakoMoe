package BeansHome.Actor;


import Common.ExceptionMgr;
import DAO.DBOracleMgr;
//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* ActorDAO		: Actor DAO 클래스<br>
* Inheritance	: None | 부모 클래스 명
***********************************************************************/
public class ActorDAO
{
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역상수 관리 - 필수영역
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(정적변수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역변수 관리 - 필수영역(인스턴스변수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/** DBMgr : 오라클 데이터베이스 DAO 객체 */
	public DBOracleMgr DBMgr = null;
	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * ActorDAO()	: 생성자
	 * @param void	: None
	 ***********************************************************************/
	public ActorDAO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			ExceptionMgr.SetMode(ExceptionMgr.RUN_MODE.DEBUG);
			
			this.DBMgr = new DBOracleMgr();
			
			//this.DBMgr.SetConnectionString("gyc2024.duckdns.org", 5004, "educ", "educ", "XE");
			this.DBMgr.SetConnectionStringFromProperties("db.properties");	
			// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
	}
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(정적함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 전역함수 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * ReadActorList()	: 배우정보 읽기
	 * @param  ActorDTO	: 배우정보 DTO(조건용)
	 * @return boolean	: 쿼리 실행 여부(true|false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean ReadActorList(ActorDTO actorDTO) throws Exception
	{
		String sSql = null;				// DML 문장
		Object[] oPaValue = null;		// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		
		try
		{
			// -----------------------------------------------------------------------------
			// 배우정보 읽기
			// -----------------------------------------------------------------------------
			if (actorDTO.getActorName() != null)
				
			{
				if (this.DBMgr.DbConnect() == true)
				{
					// 배우정보 읽기 DML
					sSql = "BEGIN SP_ACTOR_R(?,?,?); END;";
					
					// IN 파라미터 만큼 메모리 할당
					oPaValue = new Object[2];
					
					
					oPaValue[0] = actorDTO.getActorName();
					oPaValue[1] = actorDTO.getFaceCode();
				

					// DML 문장 실행
					if (this.DBMgr.RunQuery(sSql, oPaValue, 3, true) == true)
					{
						bResult = true;
					}
				}
			}
			
			// -----------------------------------------------------------------------------
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		
		return bResult;
	}
	/***********************************************************************
	 * takeRandomActorForWorldcup()	: 이상형 월드컵용 배우 정보 무작위로 가져오기
	 * @param  roundValue	: 필요한 배우의 수
	 * @return boolean	: 쿼리 실행 여부(true|false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean takeRandomActorForWorldcup(int roundValue) throws Exception
	{
		String sSql = null;				// DML 문장
		Object[] oPaValue = null;		// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 배우정보 읽기 DML
				sSql = "BEGIN SP_ACTOR_RANDOM(?,?); END;";
				
				// IN 파라미터 만큼 메모리 할당
				oPaValue = new Object[1];
				oPaValue[0] = roundValue;
	
				// DML 문장 실행
				if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true) == true)
				{
					bResult = true;
				}
			}
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		return bResult;
	}
	/***********************************************************************
	 * takeRecommendActorSameFaceCode()	: 같은 얼굴상을 가진 배우 정보 3명 랜덤으로 가져오기
	 * @param  actorID	: 배우 ID (조건용)
	 * @return boolean	: 쿼리 실행 여부(true|false)
	 * @throws Exception 
	 ***********************************************************************/
	public boolean takeRecommendActorSameFaceCode(int actorId) throws Exception
	{
		String sSql = null;				// DML 문장
		Object[] oPaValue = null;		// DML 문장에 필요한 파라미터 객체
		boolean bResult = false;
		try
		{
			if (this.DBMgr.DbConnect() == true)
			{
				// 배우정보 읽기 DML
				sSql = "BEGIN SP_ACTOR_RECOMMEND(?,?); END;";
				
				// IN 파라미터 만큼 메모리 할당
				oPaValue = new Object[1];
				oPaValue[0] = actorId;
	
				// DML 문장 실행
				if (this.DBMgr.RunQuery(sSql, oPaValue, 2, true) == true)
				{
					bResult = true;
				}
			}
		}
		catch (Exception Ex)
		{
			ExceptionMgr.DisplayException(Ex);		// 예외처리(콘솔)
		}
		return bResult;
	}
}
//#################################################################################################
//<END>
//#################################################################################################