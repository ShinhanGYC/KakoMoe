create or replace PROCEDURE SP_TEST_ACTOR_R
(
	iActNo		IN	int,			-- 배우번호
	iName		IN	nvarchar2,		-- 성명
	iPhoto		IN	nvarchar2,		-- 사진
	iCur		OUT	SYS_REFCURSOR	-- 결과 반환용 커서
)
IS
BEGIN
	DECLARE
		mName	nvarchar2(20);

	BEGIN
		mName := '%' || iName || '%';

		OPEN iCur FOR
		SELECT	a.Actno, a.Name, a.Photo
		FROM	TEST_ACTOR a
		WHERE	(iActno	= 0		OR a.Actno	= iActno)	AND
				(iName	= '-1'	OR a.name	LIKE mName)	AND
				(iPhoto	= '-1'	OR a.Photo	= iPhoto);
	END;
END SP_TEST_ACTOR_R;