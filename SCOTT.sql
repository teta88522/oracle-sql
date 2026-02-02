-- Oracle(DBMS) + version(21c) xe(database명)
-- user(scott) - 테이블.
-- Structured Query Language (SQL)
SELECT * -- 컬럼명(전체 지목)
FROM student; -- 테이블


-- 1. professor 테이블. 전체 컬럼 조회.
SELECT * 
FROM professor;

-- 2) 학생 --> 학생번호,이름,학년
SELECT studno,name,grade
FROM student;

-- 숙제완료함.
select name || '의 아이디는' || id as "전체설명" -- 별칭(alias)
    ,grade "학년"
from student;

-- james seo의 아이디는 75true 이고 4학년입니다. => alias (학년설명)
select name || '의 ''아이디'' 는 ' || id || '이고' || grade || ' 학년입니다' as "학생 설명"
from student;

SELECT distinct name, grade   -- 중복된 값 제거
FROM student;

-- 연습문제 1
SELECT name || '''s ID: '|| id || ',' || 'WEIGHT is ' ||weight || 'KG'
as "ID AND WEIGHT" 
FROM student;

-- 연습문제 2 
SELECT ename || '(' || job || '), ' || ename || '''' || job || ''''
as "NAME AND JOB"
FROM emp;

SELECT *
FROM emp;


-- WHERE 조건이 만족하는 것
SELECT * 
FROM student
WHERE weight between 60 and 70
AND deptno1 in (102,201);

SELECT *
FROM student
WHERE deptno2 is not null;

-- 비교연산자 연습1) emp 테이블 급여 3000보다 큰 직원,
SELECT *
FROM emp
WHERE SAL > 3000;

-- 비교연산자 연습2) emp 테이블 보너스 있는 직원,
SELECT *
FROM emp
WHERE COMM is not null
AND COMM > 0;

-- 비교연산자 연습 3) student테이블 주전공학과: 101,102,103인 학생.
SELECT * 
FROM student
WHERE deptno1 in(101,102,103);

-- AND / OR 
-- IF (sal > 100 || height >170)
SELECT studno,name,grade,height,weight
FROM student
WHERE (height > 170 
OR weight >60)
AND (grade = 4 OR height > 150);

-- 급여가 2000 이상인 직원, 커미션(급여 + 커미션)
SELECT *
FROM emp
WHERE (comm is null AND
sal > 2000 )or 
(sal + comm) > 2000;

-- 교수=> 연봉이 5000 이상인, 보너스 3번
SELECT *
FROM professor
WHERE (pay * 12 >= 3000 
AND bonus is null) 
OR pay * 12 + BONUS * 3 >= 3000
ORDER BY 5   -- pay 오름차순 정렬
;

-- 문자열 like 연산자
SELECT *
FROM student
WHERE name like '%on____%';

SELECT profno,
       name,
       pay,
       bonus,
       hiredate
FROM professor
WHERE hiredate >to_date('99/01/01', 'rr/mm/dd')
ORDER BY hiredate; -- 1970.01.01

-- 학생테이블, 전화번호(02, 031, 051, 052, 053..)
-- 부산거주.
SELECT *
FROM student
WHERE tel LIKE '051%';

-- 이름 M으로 시작 8개 이상인 사람만 조회.
SELECT *
FROM student
WHERE name LIKE 'M________%';

-- 주민번호 10월달에 태어난 사람 조회.
SELECT *
FROM student
WHERE jumin LIKE '%10_________';