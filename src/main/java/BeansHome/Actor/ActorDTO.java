//#################################################################################################
//ActorDTO.java - 배우검색 DTO 모듈
//#################################################################################################
//═════════════════════════════════════════════════════════════════════════════════════════
//외부모듈 영역
//═════════════════════════════════════════════════════════════════════════════════════════
package BeansHome.Actor;

import Common.ExceptionMgr;

//═════════════════════════════════════════════════════════════════════════════════════════
//사용자정의 클래스 영역
//═════════════════════════════════════════════════════════════════════════════════════════
/***********************************************************************
* ActorDTO		: 배우검색 DTO 클래스<br>
* Inheritance	: None | 부모 클래스 명
***********************************************************************/
public class ActorDTO
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
	
	// PRIMARY KEY FIELDS
	/** actorID	: Beans 배우ID 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private Integer	actorID = 0;
	/** faceCode	: Beans 얼굴코드 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private Integer	faceCode = 0;
	
	// ACTOR TABLE FIELDS
	/** actorName	: Beans 배우이름 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String	actorName = null;
	/** actorDebut	: Beans 배우데뷔작 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String	acotrDebut = null;
	/** actorDebut	: Beans 배우히트작 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String	acotrHit = null;
	/** actorDebut	: Beans 배우최신작 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String	acotrNewest = null;

	// FACE TABLE FIELDS
	/** faceName	: Beans 얼굴상 이름 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String	faceName = null;
	
	// PHOTO TABLE FIELDS
	/** actorProfilePhoto	:Beans 배우프로필사진 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String	actorProfilePhoto = null;
	/** actorWorldcupPhoto	:Beans 배우이상형월드컵사진 필드(JSP 입력 객체와 1:1 대응, 소문자로 시작) */
	private String	actorWorldcupPhoto = null;
	
	
	// —————————————————————————————————————————————————————————————————————————————————————
	// 생성자 관리 - 필수영역(인스턴스함수)
	// —————————————————————————————————————————————————————————————————————————————————————
	/***********************************************************************
	 * ActorDTO()	: 생성자
	 * @param void	: None
	 ***********************************************************************/
	public ActorDTO()
	{
		try
		{
			// -----------------------------------------------------------------------------
			// 기타 초기화 작업 관리
			// -----------------------------------------------------------------------------
			
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
	public Integer getActorID() {
		return actorID;
	}


	public void setActorID(Integer actorID) {
		this.actorID = actorID;
	}


	public Integer getFaceCode() {
		return faceCode;
	}


	public void setFaceCode(Integer faceCode) {
		this.faceCode = faceCode;
	}


	public String getActorName() {
		return actorName;
	}


	public void setActorName(String actorName) {
		this.actorName = actorName;
	}


	public String getAcotrDebut() {
		return acotrDebut;
	}


	public void setAcotrDebut(String acotrDebut) {
		this.acotrDebut = acotrDebut;
	}


	public String getAcotrHit() {
		return acotrHit;
	}


	public void setAcotrHit(String acotrHit) {
		this.acotrHit = acotrHit;
	}


	public String getAcotrNewest() {
		return acotrNewest;
	}


	public void setAcotrNewest(String acotrNewest) {
		this.acotrNewest = acotrNewest;
	}


	public String getFaceName() {
		return faceName;
	}


	public void setFaceName(String faceName) {
		this.faceName = faceName;
	}


	public String getActorProfilePhoto() {
		return actorProfilePhoto;
	}


	public void setActorProfilePhoto(String actorProfilePhoto) {
		this.actorProfilePhoto = actorProfilePhoto;
	}


	public String getActorWorldcupPhoto() {
		return actorWorldcupPhoto;
	}


	public void setActorWorldcupPhoto(String actorWorldcupPhoto) {
		this.actorWorldcupPhoto = actorWorldcupPhoto;
	}
	// —————————————————————————————————————————————————————————————————————————————————————
}
//#################################################################################################
//<END>
//#################################################################################################

