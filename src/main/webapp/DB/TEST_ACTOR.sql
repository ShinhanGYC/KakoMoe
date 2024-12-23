SET SERVEROUTPUT ON;

DECLARE
    oCur SYS_REFCURSOR;
    vActNo   TEST_ACTOR.Actno%TYPE;
    vAname   TEST_ACTOR.name%TYPE;
    vPhoto   TEST_ACTOR.Photo%TYPE;
BEGIN
    SP_TEST_ACTOR_R(0, '-1', '-1', oCur);

    LOOP
        FETCH oCur INTO vActNo, vAname, vPhoto;
        EXIT WHEN oCur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('배우번호: ' || vActNo || ', 성명: ' || vAname || ', 사진: ' || vPhoto);
    END LOOP;

    CLOSE oCur;
END;

