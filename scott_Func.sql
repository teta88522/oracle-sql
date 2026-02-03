SELECT profno,
       name,
       pay * 12 + nvl(bonus, 0) * 3 as "연봉",
       pay,
       nvl(bonus, 0) as "bonus"
FROM professor;

-- initcap('문자열'/컬럼)
SELECT initcap('hello') as "인사"
FROM dual;

SELECT profno
       ,initcap(name)
FROM professor;

SELECT ename,
LOWER(ename) "LOWER" ,
UPPER(ename) "UPPER" 
FROM emp
WHERE deptno = 10 ;

SELECT ename, 
LENGTH(ename) "LENGTH",
LENGTHB(ename) "LENGTHB"
FROM emp
WHERE deptno = 20 ;

SELECT '신재성' "NAME",
LENGTH('신재성') "LENGTH",
LENGTHB('신재성') "LENGTHB"
FROM dual ;

SELECT ename , LENGTH(ename)
FROM emp
WHERE LENGTH(ename) > LENGTH('&ename') ;

-- concat
SELECT CONCAT(ename , job)
FROM emp
WHERE deptno = 10 ;

-- 예1 교수테이블의 이름에 'st'(대소문자 구분없이)가 포함된 교수의 교수번호,
SELECT profno,name
FROM professor
WHERE LOWER(name) LIKE  '%st%'; 


-- 예2 교수테이블의 교수이름이 10글자가 안되는 교수의 번호,이름,이메일 출력
SELECT profno,
       name,
       email,
       profno || name,
       concat(profno, name)
FROM professor
WHERE LENGTH(name) < 10;

-- substr
SELECT 'hello, world' 
        ,substr('hello, world', 1, 6)  "SUBSTR1" -- + 값이면 왼쪽 순번,
        ,substr('hello, world', -5, 5) "SUBSTR2" -- - 값이면 오른쪽부터 왼쪽 순번
        ,substr('0'||7, -2, 2) mm
        ,substr('02)3456-2345', 1,instr('02)3456-2345', ')',1) -1) "instr1"
        ,substr('031)2345-2312',1,instr('031)2345-2312', ')', 1)-1) "instr2"
        ,instr('031)2345-2312', ')') instr3 -- 문자열에서 찾을 문자열의 위치 반환
FROM dual;

-- 주 전공이 201번인 학생들 -> 전화 번호 지역번호 구분
SELECT name,
       tel,
       substr(tel,1,2 ) "지역번호",
       substr(tel,instr(tel, ')')+1 ) 전화번호,
       substr(tel
       ,instr(tel, ')',1)+1  -- 시작 위치
       ,instr(tel,'-',1) - instr(tel, ')',1)-1) -- 출력하는 개수
       "전화번호 앞4자리"       
FROM student
WHERE deptno1 = 201;

SELECT hpage,
       substr(hpage,instr(hpage, '.')+1)
FROM professor
WHERE hpage is not null;

-- Ipad/rpad
select lpad('hello',10,'*')
from dual;

-- LPAD 퀴즈
SELECT lpad(ename, 9, '1234567') lpad
FROM emp
WHERE deptno = 10;

SELECT rpad(ename,10,'-') 
FROM emp;
-- RPAD 퀴즈
SELECT RPAD(ename, 9,substr('123456789',lengthb(ename)+ 1)) RPAD
FROM emp
WHERE deptno = 10;

-- Ltrim('값', '찾을문자열')
SELECT ltrim('Hello', 'H')
FROM dual;

--replace('값','찾을 문자열','대체 문자열')
SELECT replace('Hello','o','o world!')
FROM dual;

SELECT ename
      ,replace(ename, substr(ename, 1,2), '**') replace
      ,substr(ename,1,2)
FROM emp
WHERE deptno = 10;

-- 문제 1
SELECT replace(ename, substr(ename,2,2), '-'),
substr(ename,2,2)
FROM emp
WHERE deptno = 20;
-- 문제 2
SELECT name,
jumin,
replace(jumin,substr(jumin,-7,7),'-/-/-/-') sujeong
FROM student
WHERE deptno1 = 101;

-- 문제 3
SELECT name,
tel,
replace(tel,substr(tel,instr(tel,')')+1,3),'***')
FROM student
WHERE deptno1 = 102;

-- 문제 4 
SELECT name,
tel,
    replace(tel,
            substr(tel,
                instr(tel, '-')+1,4)
                                ,'****')
FROM student
WHERE deptno1 = 101;



SELECT
round(123.456,-2),
trunc(123,4)
,mod(12,5)
,ceil(15.4)
,FLOOR(12.34)
,power(3,2)
FROM dual;

--날짜 관련함수
SELECT
add_months(SYSDATE, 0) next_months --값일
,months_between(sysdate + 28, sysdate)
FROM dual;



SELECT 
EMPNO,
ename
,hiredate
,trunc(months_between(sysdate,hiredate)/12) || '년' ||
mod(trunc(months_between(sysdate, hiredate)),12) ||'개월' "근속년수"
FROM emp;

SELECT PROFNO, --교수번호, 이름, 입사일자, 급여( 20년 이상, Software Engineering)
NAME,
HIREDATE,
position,
pay,
p.deptno,
d.deptno
FROM professor p, department d
WHERE 20 <= (months_between(sysdate,hiredate)/12)
AND p.deptno = d.deptno -- 두 테이블간의 equal 조건
AND d.dname = 'Software Engineering'
ORDER BY 3;

select EMPNO,
ename,
job,
d.deptno,
dname,
trunc(months_between(sysdate,hiredate)/12) || '년'
from emp e, dept d
WHERE e.deptno = d.deptno
AND d.dname = 'SALES'
AND (months_between(sysdate,hiredate)/12) >= 40
order by e.empno;  
--sales부서에서 근속년 40년이 넘는 사람.
--사번,이름,급여,부서명


--학과
SELECT *
FROM department;

SELECT profno, name, p.deptno, d.deptno,dname
FROM professor p, department d 
WHERE p.deptno = d.deptno -- 16*12=192
AND d.dname = 'Computer Engineering'; -- 다른 테이블의 값도 비교조건으로 가능


-- 2 + '2'
SELECT 2 + to_number('2',9)
,concat(2,'2')
,sysdate
FROM dual
WHERE sysdate > '2026/02/03';

-- to_char(날짜, '포맷문자')
SELECT sysdate
,to_char(sysdate,'RRRR-MM-DD HH24:MI:SS') to_char
,to_date('05/2024/03','MM/RRRR/DD') to_date
FROM dual;

-- to_char
SELECT to_char(12345.6789, '099,999.99') -- 반올림 한 연산결과를 문자출력.
FROM dual;

-- 형 변환 퀴즈 1
SELECT studno,
name,
to_char(birthday,'DD-MON-RR'),
birthday
FROM student s
WHERE to_char(birthday, 'MM') = '01';

-- nvl()
SELECT nvl(10,0)    -- null ? 0 : 10
FROM dual;

SELECT pay + nvl(bonus,0) "월급"
FROM professor;

-- student(profno) -> 9999없으면/담당교수번호
--                    담당교수없음/담당교수번호
SELECT
s.name,
nvl(s.profno,9999) "profno",
nvl(s.profno||'','담당교수없음')
FROM student s
ORDER BY s.profno;

-- decode(A,B, '같은조건','다른조건')
SELECT decode(10, 20, '같다','다르다') -- a == b ? 같다 : 다르다
FROM dual;

SELECT decode(profno, null,9999,profno)
FROM student
ORDER BY profno DESC;

SELECT decode('A','A', '현재값은 a입니다','B','현재B','기타')
FROM dual;


-- 유형 1
SELECT profno,
name,
deptno,
decode(deptno,101,'Computer Engineering',' ')
FROM professor;
-- 유형 2
SELECT deptno,
name,
decode(deptno,101,'Computer Engineering','ETC')Dname
FROM professor;
-- 유형 3
SELECT deptno,
name,
decode(deptno,101,'Computer Engineering',102,
'Multimedia Engineering',103,'
Software Engineering','ETC') Dname
FROM professor;
-- 유형 4
SELECT deptno,
name,
decode(deptno,101,decode(name,'Audie Murphy','BEST!')) ETC
FROM professor;
-- 유형 5
SELECT deptno,
name,
decode(deptno,101,decode(name,'Audie Murphy','BEST!','GOOD!')) ETC
FROM professor;
-- 유형 6
SELECT deptno,
name,
decode(deptno,101,decode(name,'Audie Murphy','BEST!','GOOD!'),'N/A') ETC
FROM professor;