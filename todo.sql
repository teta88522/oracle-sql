SELECT ename || '''s ' || 'sal is $' || sal
FROM emp;

    
    
-- 107page
SELECT empno,
ename,
sal,
comm,
to_char(sal*12+comm,'99,999') SALARY
FROM emp
WHERE ename = 'ALLEN';

SELECT name,
pay,
bonus,
to_char(pay*12+bonus,'99,999') TOTAL
FROM professor 
WHERE deptno = 201;

-- 108page
SELECT empno,
ename,
hiredate,
sal,
'$'|| to_char((sal*12+comm)*1.15,'99,999') "15%up"
FROM emp
WHERE comm is not null;

-- 113page
SELECT empno,
ENAME,
comm,
NVL2(comm,'Exist',NULL)
FROM emp
WHERE deptno = 30;

-- 학생테이블의 생년월일을 기준으로 1~3 => 1/4 분기 = 이런식으로 출력
 --                                 4~6 => 1/4 분기
  --                                7~9 => 1/4 분기
    --                              10~12 => 1/4 분기
    
    
    