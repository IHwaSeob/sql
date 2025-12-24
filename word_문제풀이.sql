select * FROM city;
select * FROM country;
select * FROM countrylanguage;



--1
-- select * FROM country WHERE NAME = 'UNITED STATES';

use world;

select * 
FROM country A INNER JOIN city B ON A.CODE=B.`CountryCode`  
WHERE A.NAME = 'UNITED STATES';


--2

WITH pop AS (SELECT Name, Population, CountryCode FROM city ORDER BY Population DESC LIMIT 10)
SELECT *
FROM pop A INNER JOIN country B ON A.CountryCode = B.Code;

select * from (SELECT Name, Population, CountryCode FROM city ORDER BY Population DESC LIMIT 10) as A
INNER JOIN country B ON A.CountryCode = B.Code;

--3
select * from countrylanguage A inner join country B on A.CountryCode=B.Code where A.`Language` = 'English';

select * from country where code in ( select countrycode from countrylanguage where Language = 'English');

--4
use sakila;
select * from actor;
select * from category;

SELECT
    a.first_name,
    a.last_name,
    c.title,
    c.release_year,
    e.name AS category_name
FROM actor AS a
INNER JOIN film_actor AS b ON a.actor_id = b.actor_id
INNER JOIN film AS c ON b.film_id = c.film_id
INNER JOIN film_category AS d ON c.film_id = d.film_id
INNER JOIN category AS e ON d.category_id = e.category_id
WHERE e.name = 'Action'
ORDER BY title;


use sakila;
--5
WITH cte_film (film0_id, title, category_name)
AS (
	SELECT 
		a.film_id, a.title, c.name as category_name
	FROM film AS a
		INNER JOIN film_category AS b ON a.film_id = b.film_id
		INNER JOIN category AS c ON b.category_id = c.category_id
), cte_payment (customer_id, amount, film_id)
AS (
	SELECT 
		a.customer_id, b.amount, c.film_id
	FROM rental AS a
	INNER JOIN payment AS b on a.rental_id = b.rental_id
	INNER JOIN inventory AS c ON a.inventory_id = c.inventory_id
) SELECT
	a.customer_id, a.first_name, a.last_name,
	c.category_name,
	COUNT(*) AS rental_count,
	SUM(b.amount) AS amount
FROM customer AS a
	INNER JOIN cte_payment AS b on a.customer_id = b.customer_id
	INNER JOIN cte_film AS c ON b.film_id = c.film_id
GROUP BY a.customer_id, a.first_name, a.last_name, c.category_name
ORDER BY a.customer_id;



show DATABASEs;

use employees;

--6
WITH RECURSIVE cte_emp (employee_id, employee_name, manager_id, employee_level)
AS
(SELECT
		employee_id, employee_name, manager_id, 1 as employee_level
	FROM emp
	WHERE manager_id IS NULL
	
	UNION ALL
	
	SELECT
		e.employee_id, e.employee_name, e.manager_id, r.employee_level+ 1
	FROM emp AS e
		INNER JOIN cte_emp AS r ON e.manager_id = r.employee_id
)SELECT
	employee_name, employee_level,
	(SELECT employee_name FROM emp WHERE employee_id = cte_emp.manager_id) AS Manager
FROM cte_emp
ORDER BY employee_level, manager_id;


use world;
select * FROM city;
select * FROM country;
select * FROM countrylanguage;

--1
select concat(`name`,' ',`Continent`,' ',`Population`) FROM country;

--2 확인
select * FROM country where IndepYear is null;

select name, ifnull(IndepYear, '데이터없음') FROM country where IndepYear is null;


--3
select upper(name),lower(name) from country;

--4
select name, TRIM(name) from country;

--5
-- select name from country where name = CHAR_LENGTH (10) ;

select * from country where CHAR_LENGTH (name)>20 ORDER BY name DESC;

--6
select name, SurfaceArea, position('.' in SurfaceArea) from country;

select round(SurfaceArea) from country;

--7
select name, SUBSTRING(name,2,4) FROM country ;


--8
select CODE, REPLACE(CODE, 'A', 'Z') from country;

--9
select CODE, REPLACE(CODE, 'A', repeat('Z',10)) from country;

--10
SELECT DATE_ADD(NOW(), INTERVAL 24 HOUR);

--11
SELECT DATE_SUB(NOW(), INTERVAL 24 HOUR);

--12
select dayname('2024.01.01');

--13
select count(*) FROM country;

--14
select sum(GNP), avg(GNP), min(GNP), max(GNP) FROM country;


--15
select ROUND(LifeExpectancy) FROM country ;

--16
select LifeExpectancy, NAME FROM country ORDER BY LifeExpectancy DESC, NAME ASC;


--17

select rank() over (order by LifeExpectancy desc), NAME, LifeExpectancy FROM country;
select ROW_NUMBER() over (order by LifeExpectancy desc), NAME, LifeExpectancy FROM country;

--18
select DENSE_RANK() over (order by LifeExpectancy desc), NAME, LifeExpectancy FROM country;







--1

-- select * from countrylanguage;

select `CountryCode`, `Language`, Percentage, if(`Percentage`>=5,'5+','5-') from countrylanguage;

--2
-- 기대수명 열이 100보다 크면 'wow' 
-- 기대수명 열이 80보다 크면 'best' 
-- 기대수명 열이 70보다 크면 'good' 
-- 기대수명 열이 60보다 크면 'normal' 
-- 기대수명 열이 60보다 작으면 'sad' 

select name, LifeExpectancy,
CASE 
	WHEN `LifeExpectancy`>=100 THEN 'wow' 
	WHEN `LifeExpectancy`>=80 THEN 'best' 
	WHEN `LifeExpectancy`>=70 THEN 'good' 
	WHEN `LifeExpectancy`>=60 THEN 'normal' 				
	ELSE  'sad' 
END
from country;


--3
--두 개의 입력값 (시작값, 마지막 값)을 받아 두입력값 범위 사이의 숫자를 순차적으로 더하는 스토어드 프로시저 작성

delimiter $$

CREATE PROCEDURE doit_sum(IN p_start INT, IN p_end INT)
BEGIN
    DECLARE tot INT DEFAULT 0;
    DECLARE i INT;

    SET i = p_start;

    WHILE i <= p_end DO
        SET tot = tot + i;
        SET i = i + 1;
    END WHILE;

    SELECT tot;
END $$

delimiter ;

call doit_sum(0,10);


--4

drop Procedure if exists doit_sum;


--5

CREATE VIEW v_country_language
AS
SELECT
    a.Name,
    a.Region,
    b.Language,
    b.IsOfficial,
    b.Percentage
FROM country AS a
INNER JOIN countrylanguage AS b
    ON a.Code = b.CountryCode;

SELECT * FROM v_country_language;


--6
drop view v_country_language;