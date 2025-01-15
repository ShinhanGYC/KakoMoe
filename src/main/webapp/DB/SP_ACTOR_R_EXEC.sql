---SET SERVEROUTPUT ON;


DECLARE
    -- 커서에서 반환될 데이터를 받을 변수 선언
    v_actor_id             NUMBER(10);
    v_actor_name           NVARCHAR2(50);
    v_face_code            NUMBER(1);
    v_face_name            NVARCHAR2(50);
    v_actor_debut          NVARCHAR2(100);
    v_actor_hit            NVARCHAR2(100);
    v_actor_newest         NVARCHAR2(100);
    v_actor_profile_photo  NVARCHAR2(255);
    v_actor_worldcup_photo NVARCHAR2(255);
    iCur                   SYS_REFCURSOR; -- 결과 반환용 커서
BEGIN
    -- 프로시저 호출
    SP_ACTOR_R(
        iActorName => '스다', -- 조회하고자 하는 배우명을 입력
        iFaceCode  => 0,       -- 조회하고자 하는 얼굴코드 입력 (0일 경우 모든 얼굴코드 조회)
        iCur       => iCur     -- 결과를 받을 커서
    );

    -- 커서에서 데이터 가져오기
    LOOP
        FETCH iCur INTO v_actor_id, v_actor_name, v_face_code, v_face_name, v_actor_debut, 
                      v_actor_hit, v_actor_newest, v_actor_profile_photo, v_actor_worldcup_photo;
        EXIT WHEN iCur%NOTFOUND;

        -- 커서 데이터 출력
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
