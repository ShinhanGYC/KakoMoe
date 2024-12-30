SET SERVEROUTPUT ON;

DECLARE
    result_cursor SYS_REFCURSOR;
    v_actor_id INT;
    v_actor_name NVARCHAR2(50);
    v_face_code INT;
    v_face_name NVARCHAR2(50);
    v_actor_debut NVARCHAR2(100);
    v_actor_hit NVARCHAR2(100);
    v_actor_newest NVARCHAR2(100);
    v_actor_profile_photo NVARCHAR2(255);
    v_actor_worldcup_photo NVARCHAR2(255);
BEGIN
    -- actor_id 1을 기준으로 랜덤한 3개의 데이터를 가져오는 프로시저 실행
    SP_ACTOR_RECOMMEND(87662, result_cursor);

    -- 결과 출력
    LOOP
        FETCH result_cursor INTO v_actor_id, v_actor_name, v_face_code, v_face_name, v_actor_debut, v_actor_hit, v_actor_newest, v_actor_profile_photo, v_actor_worldcup_photo;
        EXIT WHEN result_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Actor ID: ' || v_actor_id || ', Actor Name: ' || v_actor_name);
    END LOOP;
    CLOSE result_cursor;
END;
/
