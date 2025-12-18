select * FROM city;
select * FROM country;
select * FROM countrylanguage;



--1
-- select * FROM country WHERE NAME = 'UNITED STATES';

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

--5
WITH cte_film (film_id, title, category_name)
AS (
    SELECT
        a.film_id,
        a.title,
        c.name AS category_name
    FROM film AS a
    INNER JOIN film_category AS b ON a.film_id = b.film_id
    INNER JOIN category AS c ON b.category_id = c.category_id
),
cte_payment (customer_id, amount, film_id)
AS (
    SELECT
        a.customer_id,
        b.amount,
        c.film_id
    FROM rental AS a
)





--6





use world;
select * FROM city;
select * FROM country;
select * FROM countrylanguage;

--1

--2
select * FROM country where IndepYear is null as '데이터없음';

--3
select upper(name) from country;

--4
select TRIM(name) from country;

--5
select name from country where name = CHAR_LENGTH (10) ;

select * from country where CHAR_LENGTH (name)>20 ORDER BY name DESC;

--6
select ROUND(SurfaceArea,3) from country;





--7
select name FROM country where name POSITION(2);


--10
SELECT DATE_ADD(NOW(), INTERVAL 24 HOUR);

--11
SELECT DATE_SUB(NOW(), INTERVAL 24 HOUR);

--13
select count(*) FROM country;

--14
select sum(GNP), avg(GNP), min(GNP), max(GNP) FROM country;


--15
select ROUND(LifeExpectancy) FROM country ;

--16
SELECT DENSE_RANK()
select * FROM country ORDER BY LifeExpectancy DESC ,NAME ASC;

select * FROM country;


