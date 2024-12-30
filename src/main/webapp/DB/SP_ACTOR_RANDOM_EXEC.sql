DECLARE
    iCur SYS_REFCURSOR; -- 결과를 받을 커서
    v_actor_id             NUMBER;
    v_actor_name           NVARCHAR2(50);
    v_face_code            NUMBER;
    v_actor_worldcup_photo NVARCHAR2(255);

BEGIN
    -- 총 16개의 데이터를 가져오는 경우
    SP_ACTOR_RANDOM(32, iCur);
    
    -- 커서 데이터 출력
    LOOP
        FETCH iCur INTO v_actor_id, v_actor_name, v_face_code, v_actor_worldcup_photo;
        EXIT WHEN iCur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('actor_id: ' || v_actor_id || ', actor_name: ' || v_actor_name || 
                             ', face_code: ' || v_face_code || ', worldcup_photo: ' || v_actor_worldcup_photo);
    END LOOP;
    
    -- 커서 닫기
    CLOSE iCur;
END;
/
