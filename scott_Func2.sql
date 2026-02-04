SELECT name
      ,to_char(birthday, 'Q') || '/4분기' quarter1
      ,ceil(to_char(birthday, 'MM') / 3) || '/4분기' quarter2
      ,decode(to_char(birthday, 'MM')
              ,'01', '1/4분기','02', '1/4분기','03', '1/4분기'
              ,'04', '2/4분기','05', '2/4분기','06', '2/4분기'
              ,'07', '3/4분기','08', '3/4분기','09', '3/4분기'
              ,'10', '4/4분기','11', '4/4분기','12', '4/4분기')
              quarter3
FROM student;

SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT e.*, dname, loc
FROM emp e, dept d
WHERE e.deptno = d.deptno;

-- ANSI vs. ORACLE
SELECT *
FROM emp e
JOIN dept d ON e.deptno = d.deptno
WHERE job = 'SALESMAN';

-- student(profno), professor(profno)
-- 학생번호, 이름, 담당교수번호, 이름
SELECT studno, s.name, p.profno, p.name
FROM student s
full outer JOIN professor p ON s.profno = p.profno;
-- student, professor 
select *
from student;

select *
from professor;

-- 학생번호, 학생이름, 담당교수이름 / 담당교수없음
-- 9615 , Daniel Day-Lewis, Jodie Foster
-- 9712	, Sean Connery, 담당교수없음
SELECT s.studno "학생번호"
     , s.name "학생이름"
     , decode(p.name, null, '담당교수없음', p.name) "교수이름"
FROM student s
LEFT OUTER JOIN professor p ON s.profno = p.profno;

-- nvl(), decode(), case when end
-- student 지역번호 구분 02(서울) 031(경기도) 051(부산) 그외(기타)
SELECT name
      ,substr(tel, 1, instr(tel, ')', 1) - 1) tel
      ,case substr(tel, 1, instr(tel, ')', 1) - 1) when '02' then '서울'
                                                   when '031' then '경기도'
                                                   when '051' then '부산'
                                                   else '기타'
       end "지역명"
FROM student;

SELECT name
      ,jumin
      ,case when substr(jumin, 3, 2) between '01' and '03' then '1/4분기'
            when substr(jumin, 3, 2) between '04' and '06' then '2/4분기'
            when substr(jumin, 3, 2) between '07' and '09' then '3/4분기'
            when substr(jumin, 3, 2) between '10' and '12' then '4/4분기'
       end "분기"
FROM student;
-- 123페이지.
SELECT job, count(*), sum(sal), round(avg(sal), 1) avg
          , min(hiredate)
          , max(hiredate)
FROM emp
GROUP BY job;

-- 부서별 부서명, 급여합게, 평균급여, 인원 
SELECT d.dname, e.*
FROM (SELECT deptno
           , sum(sal) sum
           , round(avg(sal), 1) avg
           , count(*) cnt
      FROM emp
      GROUP BY deptno) e
JOIN dept d ON e.deptno = d.deptno;
-- emp dept 조인.
SELECT d.dname
      ,sum(e.sal) "급여합계"
      ,round(avg(e.sal + nvl(comm, 0)), 1) "평균급여"
      ,count(*) "인원"
FROM emp e
JOIN dept d ON e.deptno = d.deptno
GROUP BY d.dname;

-- rollup()
-- 1)부서별 직무별 평균급여, 사원수.
SELECT deptno
      ,job
      ,avg(sal)
      ,count(*)
FROM emp
GROUP BY deptno
        ,job
union
-- 2)부서별 평균급여, 사원수.
SELECT deptno
      ,'소계' 
      ,round(avg(sal), 1)
      ,count(*)
FROM emp
GROUP BY deptno
union
-- 3)전체 평균급여, 사원수.
SELECT 99
      ,'전체집계'
      ,round(avg(sal), 1)
      ,count(*)
FROM emp
ORDER BY 1;

-- rollup
SELECT deptno
      ,job
      ,round(avg(sal), 1)
      ,count(*)
FROM emp
GROUP BY rollup(deptno, job)
ORDER BY 1;

-- 게시판(board)
-- 글번호, 제목, 작성자, 글내용, 작성시간 --, 조회수, 수정시간, 수정자...
drop table board;
create table board (
  board_no number(10) primary key,--글번호(키역할)
  title    varchar2(300) not null,--, 제목
  writer   varchar2(50)  not null,--, 작성자
  content  varchar2(100) not null,--, 글내용, 
  created_at date default sysdate --작성시간
);
-- 컬럼추가.
alter table board add (click_cnt number);
alter table board modify content varchar2(1000);

desc board;

insert into board (board_no, title, writer, content) 
values (3, 'test', 'user01', '연습글입니다');

insert into board (board_no, title, writer, content) 
values (2, 'test2', 'user02', '연습글입니다2');

select *
from board;
commit;

update board
set    title = 'test3'
where board_no = 3;



