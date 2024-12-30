CREATE OR REPLACE PROCEDURE SP_ACTOR_RANDOM
(
    iTotalRecords IN INT,       -- 가져올 총 레코드 수 (16 또는 32)
    iCur          OUT SYS_REFCURSOR -- 결과 반환용 커서
)
IS
BEGIN
    -- 커서 열기
    OPEN iCur FOR
        WITH BALANCED_DATA AS (
            SELECT 
                a.actor_id, 
                a.actor_name, 
                a.face_code, 
                p.actor_worldcup_photo,
                ROW_NUMBER() OVER (PARTITION BY a.face_code ORDER BY DBMS_RANDOM.VALUE) AS rn
            FROM 
                ACTOR a
            LEFT JOIN 
                PHOTO p ON a.actor_id = p.actor_id
            WHERE 
                a.face_code IN (1, 2, 3, 4) -- face_code 값이 1~4인 데이터만 포함
        )
        SELECT 
            actor_id, 
            actor_name, 
            face_code, 
            actor_worldcup_photo
        FROM 
            BALANCED_DATA
        WHERE 
            rn <= iTotalRecords / 4 -- 각 face_code 별로 가져올 데이터 개수 제한
        ORDER BY 
            face_code, rn;
END SP_ACTOR_RANDOM;

