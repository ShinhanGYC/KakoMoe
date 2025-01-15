create or replace PROCEDURE SP_ACTOR_R
(
	
    iActorName  IN  nvarchar2,      -- 배우명
	iFaceCode  	IN	int,			-- 얼굴코드
	iCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	DECLARE
		mName	nvarchar2(50);

	BEGIN
		mName := '%' || iActorName || '%';


		OPEN iCur FOR
        SELECT a.actor_id, a.actor_name, a.face_code, f.face_name, a.actor_debut, a.actor_hit, a.actor_newest, p.actor_profile_photo, p.actor_worldcup_photo
        FROM ACTOR a 
        LEFT JOIN FACE f
        ON a.face_code = f.face_code
        LEFT JOIN PHOTO p
        ON a.actor_id = p.actor_id
		WHERE	(iFaceCode = 0	OR a.face_code	= iFaceCode)	AND
				(iActorName	= '-1' OR a.actor_name	LIKE mName);
	END;
END SP_ACTOR_R;

