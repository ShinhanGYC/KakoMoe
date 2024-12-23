create or replace PROCEDURE SP_TEST_ACTOR_U
(
    iActNo     IN INT,         -- 배우번호
    iName      IN NVARCHAR2,   -- 성명
    iPhoto     IN NVARCHAR2    -- 사진
)
IS
    newActNo INT; -- 새로운 배우 번호 저장용 변수
BEGIN
    -- 배우 번호가 0이면 다음 번호를 자동 생성
    IF iActNo = 0 THEN
        SELECT NVL(MAX(Actno), 0) + 1 INTO newActNo FROM TEST_ACTOR;
    ELSE
        newActNo := iActNo; -- 입력받은 번호 사용
    END IF;

    -- 배우 정보 삽입
    INSERT INTO TEST_ACTOR (Actno, Name, Photo)
    VALUES (newActNo, iName, iPhoto);

    -- 삽입 성공 메시지 출력 (옵션)
    DBMS_OUTPUT.PUT_LINE('Actor inserted successfully: ' || newActNo || ', ' || iName || ', ' || iPhoto);

EXCEPTION
    -- 예외 처리
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Duplicate actor number: ' || newActNo);
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END SP_TEST_ACTOR_U;
