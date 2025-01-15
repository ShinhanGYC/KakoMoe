CREATE OR REPLACE PROCEDURE SP_ACTOR_RECOMMEND (
    iActorID   IN  INT,              -- 입력된 actor_id
    iCur       OUT SYS_REFCURSOR    -- 결과 반환용 커서
)
IS
    mFaceCode  INT;  -- 입력된 actor_id에 해당하는 face_code 저장용
BEGIN
    -- actor_id에 해당하는 face_code를 가져옴
    SELECT face_code INTO mFaceCode
    FROM ACTOR
    WHERE actor_id = iActorID;

    -- 동일한 face_code를 가진 다른 데이터를 랜덤으로 3개 선택하여 반환
    OPEN iCur FOR
    SELECT * FROM (
        SELECT a.actor_id, a.actor_name, a.face_code, f.face_name, a.actor_debut, a.actor_hit, a.actor_newest, p.actor_profile_photo, p.actor_worldcup_photo
        FROM ACTOR a
        LEFT JOIN FACE f ON a.face_code = f.face_code
        LEFT JOIN PHOTO p ON a.actor_id = p.actor_id
        WHERE a.face_code = mFaceCode
          AND a.actor_id != iActorID
        ORDER BY DBMS_RANDOM.VALUE
    )
    WHERE ROWNUM <= 3;
END SP_ACTOR_RECOMMEND;
/
