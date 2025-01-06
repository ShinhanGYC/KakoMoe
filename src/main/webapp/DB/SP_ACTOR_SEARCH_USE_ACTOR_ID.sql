create or replace PROCEDURE SP_ACTOR_SEARCH_USE_ACTOR_ID
(
    iActorID    IN  INT,            -- 배우 ID
    iCur        OUT SYS_REFCURSOR   -- 결과 반환용 커서
)
IS
BEGIN
    -- 커서 열기 및 결과 반환
    OPEN iCur FOR
    SELECT 
        a.actor_id, 
        a.actor_name, 
        f.face_name, 
        a.actor_debut, 
        a.actor_hit, 
        a.actor_newest, 
        p.actor_profile_photo
    FROM 
        ACTOR a 
    LEFT JOIN 
        FACE f ON a.face_code = f.face_code
    LEFT JOIN 
        PHOTO p ON a.actor_id = p.actor_id
    WHERE 
        a.actor_id = iActorID;   -- Actor ID 조건
END SP_ACTOR_SEARCH_USE_ACTOR_ID;