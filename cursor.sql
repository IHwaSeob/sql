USE sqlDB;
DROP PROCEDURE IF EXISTS cursorProc;
DELIMITER $$

CREATE PROCEDURE cursorProc()
BEGIN
    DECLARE userHeight INT;                 -- 고객의 키
    DECLARE cnt INT DEFAULT 0;              -- 고객의 인원 수(=읽은 행의 수)
    DECLARE totalHeight INT DEFAULT 0;      -- 키의 합계

    DECLARE endOfRow BOOLEAN DEFAULT FALSE; -- 행의 끝 여부(기본은 FALSE)

    DECLARE userCursor CURSOR FOR           -- 커서 선언
        SELECT height FROM userTbl;

    DECLARE CONTINUE HANDLER                -- 행의 끝이면 endOfRow 변수에 TRUE를 대입
        FOR NOT FOUND SET endOfRow = TRUE;

    OPEN userCursor;                        -- 커서 열기

    cursor_loop: LOOP
        FETCH userCursor INTO userHeight;  -- 고객 키 1개를 대입

        IF endOfRow THEN                   -- 더이상 읽을 행이 없으면 Loop를 종료
            LEAVE cursor_loop;
        END IF;

        SET cnt = cnt + 1;
        SET totalHeight = totalHeight + userHeight;
    END LOOP cursor_loop;

    -- 고객 키의 평균을 출력한다.
    SELECT CONCAT('고객 키의 평균 ==> ', (totalHeight / cnt));

    CLOSE userCursor;                       -- 커서 닫기
END $$

DELIMITER ;


call cursorProc()


