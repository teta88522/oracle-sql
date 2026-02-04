SELECT *
FROM emp;

-- 추가작업
SELECT *
FROM dept;

-- DML(INSERT,UPDATE,DELETE,MERGE)
-- 1) insert into table명 (컬럼1,컬럼2....) values(값1,값2.....);
delete FROM board
WHERE content like '%ㅁㄴㅇ%';

select * from board;

-- insert into board(board_no,title,writer,content,created_at,click_cnt) values(4,'test4','user3','응아','',' ');

-- 4/ 글동록연습/ user01/ sql연습중 
-- insert 완성
insert into board(board_no,title,writer,content)
values ((select max(board_no)+1 from board), :title, :writer, :content);

update board
set  click_cnt = click_cnt + 1,
title =  :Title
,content = :content
WHERE board_no = 2; 

delete from board
where board_no = 3;

select max(board_no)+1 from board;

insert into board -- column전체를 넣겠다 
values(9, 'title','user02','content',sysdate,0);

select * from emp ;

-- max+1, 이름, SALESMAN, 2026-02-01,3000,10,30
insert into emp(empno,ename,job,hiredate,sal,comm,deptno)
values((select max(empno)+1 from emp),'신재성','SALESMAN',to_date('2026-02-01','rrrr-mm-dd'),3000,10,30);

-- 30 부서의 MANGAGER 사번
update emp
set  mgr = (select empno from emp
where deptno = 30
and job ='MANAGER')
where empno = 7935;

select empno from emp;

-- 상품테이블
-- 상품코드, 상품명, 가격, 상품설명,평점(5,4,3,2,1), 제조사, 등록일자
-- key      nn     nn    nn     3               nn    sysdate

drop table sangpum;

CREATE TABLE sangpum(
scode varchar2(12) default 0 primary key ,
sname varchar2(10) not null,
price number(7) not null,
explan varchar2(100) not null,
score number(1) default 3,
made  varchar2(10) not null,
mfdate date default sysdate);

SELECT * FROM sangpum;
INSERT INTO sangpum
values('S'||
(select lpad
(max
(substr(scode,2,3))+1,3,'0')
from sangpum),
:name, :price,:explan,default,:made,to_date(:date1,'RRRR-MM-DD'));



