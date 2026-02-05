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


-- merge into table
-- using table2 
-- on 병합조건
-- when matched then
-- update ...
-- when not matched then
-- insert ...
merge into sangpum s1
using (select 'S014' scode,
'돈까스' sname, 5000 price,'아주마이음' explan,3 score,'asd' MADE from sangpum) s2 
on (s1.scode = s2.scode)
when matched then
update set
s1.sname = s2.sname,
s1.price = s2.price,
s1.explan = s2.explan
when not matched then
    insert (scode,sname,price,explan,made)
    values(s2.scode,s2.sname,s2.price,s2.explan,s2.made);

SELECT *
FROM board;

INSERT INTO board(board_no,title,writer,content)
values(1,'test1','user01','asd');
INSERT INTO board(board_no,title,writer,content)
values(2,'test1','user01','asd');
INSERT INTO board(board_no,title,writer,content)
values(3,'test1','user01','asd');
INSERT INTO board(board_no,title,writer,content)
values(4,'test1','user01','asd');
INSERT INTO board(board_no,title,writer,content)
values(5,'test1','user01','asd');
INSERT INTO board(board_no,title,writer,content)
values(6,'test1','user01','asd');
INSERT INTO board(board_no,title,writer,content)
values(7,'test1','user01','asd');

