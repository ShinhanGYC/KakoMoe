DECLARE
    iCur SYS_REFCURSOR; -- 결과를 받을 커서
    v_actor_id             NUMBER(10);
    v_actor_name           NVARCHAR2(50);
    v_face_code            NUMBER(1);
    v_face_name            NVARCHAR2(50);
    v_actor_debut          NVARCHAR2(100);
    v_actor_hit            NVARCHAR2(100);
    v_actor_newest         NVARCHAR2(100);
    v_actor_profile_photo  NVARCHAR2(255);
    v_actor_worldcup_photo NVARCHAR2(255);

BEGIN
    -- 총 32개의 데이터를 가져오는 경우
    SP_ACTOR_RANDOM(32, iCur);
    
    -- 커서 데이터 출력
    LOOP
        FETCH iCur INTO v_actor_id, v_actor_name, v_face_code, v_face_name, 
                        v_actor_debut, v_actor_hit, v_actor_newest, 
                        v_actor_profile_photo, v_actor_worldcup_photo;
        EXIT WHEN iCur%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('actor_id: ' || v_actor_id || ', actor_name: ' || v_actor_name || 
                             ', face_code: ' || v_face_code || ', face_name: ' || v_face_name || 
                             ', actor_debut: ' || v_actor_debut || ', actor_hit: ' || v_actor_hit || 
                             ', actor_newest: ' || v_actor_newest || ', profile_photo: ' || v_actor_profile_photo || 
                             ', worldcup_photo: ' || v_actor_worldcup_photo);
    END LOOP;
    
    -- 커서 닫기
    CLOSE iCur;
END;
/
