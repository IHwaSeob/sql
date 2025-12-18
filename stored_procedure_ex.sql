DROP PROCEDURE if EXISTS ifproc;

select count(*) from customer;

DELIMITER $$

create Procedure doit_proc()

BEGIN
-- 변수 선언
DECLARE customer_cnt int;
DECLARE add_number int;

-- 초기값 설정
SET customer_cnt = 0;
SET add_number =100;

SET customer_cnt=(select count(*) from customer);

select customer_cnt + add_number;

END$$

DELIMITER;


call doit_proc();

show CREATE PROCEDURE doit_proc;


drop PROCEDURE doit_proc;


DELIMITER$$
create Procedure doit_proc()
BEGIN
DECLARE customer_cnt int;
DECLARE add_number int;

-- 초기값 설정
SET customer_cnt = 0;
SET add_number =100;

SET customer_cnt=(select count(*) from customer);

select customer_cnt + add_number;
END$$

DELIMITER;

-- if
-- store_id가 1이면 변수 s_id_one에 1씩 더하고, store_id가 1이 아니면 변수 s_id_two에 1씩 더하고, 마지막에 select로 결과를 반환

select * from customer where customer_id =1;

select * from customer where customer_id =15;
select * from customer where store_id !=1;



DELIMITER $$

CREATE PROCEDURE doit_if(customer_id_input INT)
BEGIN
  -- 변수 선언
  DECLARE store_id_i INT;
  DECLARE s_id_one INT;
  DECLARE s_id_two INT;

  -- 초기값 설정
  SET store_id_i = (
    SELECT store_id
    FROM customer
    WHERE customer_id = customer_id_input
  );

  IF store_id_i = 1 THEN
    SET s_id_one = 1;
  ELSE
    SET s_id_two = 2;
  END IF;

  SELECT store_id_i, s_id_one, s_id_two;
END $$

DELIMITER ;

call doit_if(222);