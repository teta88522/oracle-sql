-- 5일차 테이블 만들기

CREATE TABLE Users(
    user_id varchar2(30) constraint users_user_id_pk PRIMARY KEY,
    password varchar2(100) constraint users_password_no NOT NULL,
    user_name varchar2(50) constraint users_user_name_nn NOT NULL,
    create_at date DEFAULT SYSDATE
);

--responsibility 컬럼 add.
alter table users add responsibility  varchar2(5); -- ADMIN User 

alter table users 
add constraint users_resp_ck check (responsibility in ('Users','Admin'));

update users
set  responsibility = 'Admin'
where 1 = 1; 

drop table users;

insert into users
values ('user01','1234','홍길동',sysdate);
insert into users
values ('user02','1234','홍익인간',sysdate);
insert into users
values ('user03','1234','홍익인간',sysdate);

SELECT * FROM users;

select * from board;

insert into board (board_no,title,content,writer)
values(5,'외래키등록','외래키 테스트','user03');



select *
from emp
order by 1 desc;

select * from dept;

update emp
set deptno = 50
where empno = 7935;

-- board 테이블 안 writer 컬럼 -> Foreign key 
-- users 테이블에 user_id 컬럼 -> reference key
ALTER TABLE board ADD 
CONSTRAINT board_users_id_fk FOREIGN KEY(writer) 
REFERENCES users(user_id);

-- 2교시 
select * FROM dept2;

CREATE TABLE tcons(
    no number(5) CONSTRAINT tcons_no_pk primary key,
    name varchar2(20) CONSTRAINT tcons_name_nn not null,
    jumin varchar2(13) CONSTRAINT tcons_jumin_nn not null
    CONSTRAINT tcons_jumin_uk unique,
    area number(1) CONSTRAINT tcons_area_ck check (1 <= area AND area <= 4),
    deptno varchar2(6) CONSTRAINT tcons_deptno_fk REFERENCES dept2(dcode));
    
INSERT INTO tcons
values(1,'Kurt Russell',12312321,3,1000);
INSERT INTO tcons
values(2,'AL Pacino',123123221,3,1000);

select * from dept2;

select * from tcons;

drop table tcons;
    
SELECT * FROM emp2;

ALTER TABLE tcons 
ADD CONSTRAINT tcons_name_fk FOREIGN KEY (name)
REFERENCES emp2(name);

ALTER TABLE emp2
ADD CONSTRAINT emp2_name_uk UNIQUE(name);
    
-- 3교시
select * from board ;

-- 시퀀스
create sequence board_seq;

select board_seq.nextval from dual;



insert into board (board_no, title, content, writer)
values(board_seq.nextval, '오라클 인덱스','데이터생성시 생성', 'user01'); 
insert into board (board_no, title, content, writer)
values(board_seq.nextval, 'html,css,js','웹프로그램 작성', 'user02'); 
insert into board (board_no, title, content, writer)
values(board_seq.nextval, 'Node.js','JS활용한 서버프로그램', 'user03'); 
    
    
insert into board (board_no,title,content,writer)
select board_seq.nextval,title,content,writer from board;

-- 4교시
-- primary key (unique index)
-- paging 기능.
-- 1페이지에 10건씩 페이지.
-- 1page: 1-10/ 2page:11-20/3page: 21-30 .....


select b.*
from (select rownum rn, a.*
        from (select *
        from board
        order by board_no) a ) b
WHERE b.rn >= (:page-1) * 10
AND b.rn <= :page * 10;
    
select a.*   
from 
(select /*+b INDEX_DESC (b SYS_coo8402) */rownum rn, b.*
from board b)a
WHERE a.rn >= (:page-1) * 10
AND a.rn <= :page * 10;  -- 11G 예전방식. 

select *
from board
order by board_no
offset (:page -1) * 10 rows fetch next 10 rows only;
