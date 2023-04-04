-- 사전 설정 ( 수동 commit 을 하기위함)
-- [Edit] - [Preferences] - [Sql Editor] - Safe Updates 체크해제
--                                       - [SQL Execution] - Ned connections use auto commit mode 해제 

CREATE TABLE `sql_db`.`sqlmember` (
  `member_id` char(8) NOT NULL,
  `member_name` char(5) NOT NULL,
  `member_address` char(10) DEFAULT NULL,
  PRIMARY KEY (`member_id`)
);

drop table `sql_db`.`sqlmember`;

-- 스키마(DB)의 선택 및 조회
use sql_db; 
select * from sqlmember;

create table sql_db.member(
	name varchar(10),
    userid varchar(10),
    pwd varchar(20),
    email varchar(20),
	phone char(13),
    admin int(1) default 0,
    primary key(userid)
);    

-- 데이터 추가 Query수행 후 commit수행필요!
insert into sql_db.member(name, userid, pwd, email, phone, admin) values('이소미', 'somi','1234','gmd@naver.com','010-2362-5158',0);
insert into sql_db.member(name, userid, pwd, email, phone, admin) values('하상오', 'sang12','1234','ha12@naver.com','010-5629-8888',1);
insert into sql_db.member(name, userid, pwd, email, phone, admin) values('김윤승', 'light','1234','youn1004@naver.com','010-9999-8282',0);
insert into sql_db.member values('김윤승', 'light2','1234','youn1004@naver.com','010-9999-8282',0);
commit;

-- 아이디가 'somi'인 것만 조회
select * from member where userid = 'somi';

-- 관리자인 것만 , admin = 1
select * from member where admin = 1;

-- 아이디가 'somi'인 레코드의 폰 번호 변경
update member set phone = '010-1111-2222' where userid='somi';
commit;

-- 아이디가 'somi' 삭제
delete from member where userid='somi';
commit;


select * from sql_db.member;
delete from sql_db.member;
commit;


-- 데이터 저장 / 삭제 / 복구
create table sql_db.student  (
	stu_id int(4),
    name varchar(10),
    age int(3),
    address varchar(5)
);

use sql_db;
select * from student;

insert into student values(1, '홍길동', 20, '서울');
commit;

-- -------------------------------------------------------------------------
-- 트랜잭션 도구
START TRANSACTION;
-- COMMIT, ROLLBACK이 나올 때까지 실행되는 모든 SQL 추적
COMMIT;
-- 모든 코드를 실행(문제가 없을 경우에)
ROLLBACK;
-- START TRANSACTION 실행 전 상태로 되돌림(문제 생기면)

START TRANSACTION; -- 트랜잭션 시작
SELECT * FROM member;  -- 초기상태 보여줌
delete from member where userid='somi';

SELECT * FROM member;  -- 초기상태 보여줌
ROLLBACK;         -- 트랜잭션이 선언되기 전 상태로 되돌아감
SELECT * FROM member;   -- 수정 전의 초기 상태를 보여줌

START TRANSACTION; -- 다시 트랜잭션 시작
update member set phone = '010-1111-2222' where userid='somi';
COMMIT;   -- 트랜잭션 이후 모든 동작을 적용
SELECT * FROM member; -- 적용된 결과 보여줌
-- -------------------------------------------------------------------------

delete from student;
-- commit;

rollback;

-- DDL(Data Definition Language) : 데이터베이스를 정의
-- create, alter, drop

-- DML(Data Munipulation Language) : 데이터에 대해 조회 수정 삭제
-- select, insert, update, delete

-- DCL(Data Control Language) : 권한 부여 취소
-- grant revoke

truncate table sql_db.student;
drop table sql_db.student;
rollback; -- rollback시 복구 안됨!!

-- 조회 Query
-- select 컬럼 from 테이블 
-- where 조건
-- group by 컬럼 
-- having 조건 
-- order by 컬럼 asc/desc

-- primary key : 레코드의 중복을 방지, 반드시 유일한 값, null값 허용 안됨, pk
-- unique      : 반드시 유일한 값 또는 null값을 가질수 있다.
-- not null    : 반드시 값을 가져야 함!
-- check       : 지정한 조건에 일치하는 데이터 값만 저장

use sql_db;
drop table if exists customer;

create table customer(
	id int(4) not null,
    name varchar(10) not null,
    address varchar(5) unique,
    age int(3) constraint customer_age_ck check(age >=30),
    primary key(id)
);

select * from customer;

insert into customer values(100, '홍길동', '서울시', 40);
commit;


use sql_db;
create table emp(
  emp_id varchar(10) primary key,
  ename varchar(10),
  salary int(5),
  depart varchar(10)
);  

select * from emp;
insert into emp values('a111','홍길동',2000,'관리');
insert into emp values('a222','이순신',4000,'개발');
insert into emp values('a333','유관순',3500,'영업');
insert into emp values('a444','강감찬',4500,'개발');
insert into emp values('a555','이성계',5500,'관리');
insert into emp values('a666','나신입',1800,null);
commit;
  
-- id, name  
select emp_id, ename from emp;

-- 전체조회
select * from emp;

-- 년봉
select ename, salary, salary*12 from emp;

-- 별칭
select ename as 사원명, salary as 월급 from emp;

-- 부서
select depart from emp;

-- depart 항목이 중복제거 distinct  및 공백이 아닌 것
select distinct depart from emp where depart is not null;

-- 월급이 3000이상 
select emp_id, ename, salary 
from emp 
where salary >= 3000;

-- ID가 a111
select emp_id, ename, salary 
from emp 
where emp_id = 'a111';

-- 급여가 2000 ~ 4000 between and
select emp_id, ename, salary  
from emp
where salary between 2000 and 4000;

-- 홍길동과 이순신의 급여를 동시에 조회
select emp_id, ename, salary  
from emp
where ename in ('홍길동', '이순신');

-- emp_id가 a111,a222,a333 동시에 조회
select emp_id, ename, salary  
from emp
where emp_id in ('a111','a222','a333');

-- like : 정확하게 일치하는 경우가 아닌 임의의 문자 또는 문자열 포함한 데이터를 검색할때 사용
-- %(퍼센트) : 없거나 여러개의 문자를 대체한다.
-- _(언더바) : 하나의 문자를 대체한다.

-- 성이 "이"로 시작하는 사원을 조회
select emp_id, ename, salary  
from emp
where ename like '이%';
-- where ename like '이__';

-- 사원명 끝자가 순으로 끝나는 사원 조회
select emp_id, ename, salary  
from emp
where ename like '%순';
-- where ename like '__순';

-- 사원명 끝자가 "동"이면서 사원명이 3글자 조회
select emp_id, ename, salary  
from emp
-- where ename like '%동' 
where ename like '__동' ;
-- and char_length(ename) = 3;

-- 급여가 3000에서 4000까지 제외한 나머지 사원조회
select emp_id, ename, salary  
from emp
where salary < 3000
or salary > 4000;

select emp_id, ename, salary  
from emp
where salary not between 3000 and 4000;

-- 급여를 오름차순으로 조회 order by asc desc
select emp_id, ename, salary  
from emp
order by salary asc;

-- 부서순으로 정렬하고 부서가 같으면 다시 급여순으로 정렬하는 SQL작성
select emp_id, ename, salary, depart  
from emp
order by depart asc, salary desc;

use car_sale;

create table salesman(
	sno char(4) primary key comment '사번',
    sname varchar(20) not null comment '성명',
    hire date comment '입사일',
    point int(4) comment '실적 포인트',
    branch varchar(20) comment '지점'
);

create table car(
	cno char(2) primary key comment '차량번호',
    cname varchar(20) not null comment '성명',
    cc int(4) comment '배기량',
    weight int(4) comment '무게',
    outlet varchar(20) comment '출고지'
);

create table sale(
	sno char(4) not null comment '사번',
    cno char(2) not null comment '차량번호',
    qty int(3) comment '판매량'
	-- FOREIGN KEY (`sno`) REFERENCES `salesman` (`sno`),
	-- FOREIGN KEY (`cno`) REFERENCES `car` (`cno`)
);

drop table sale;
insert into salesman values('s123','기필호', '1998-10-12',200,'인천');
insert into salesman values('s202','김두환', '2005-05-03',400,'경기');
insert into salesman values('s134','박성식', '2002-03-01',100,'서울');
insert into salesman values('s241','임홍석', '2003-06-02',300,'부산');
insert into salesman values('s345','최재현', '2004-03-01',200,'광주');

select * from salesman;

insert into car values('c1','소나타',1800,1200,'서울');
insert into car values('c1','소나타',1800,1200,'서울');
insert into car values('c1','소나타',1800,1200,'서울');
insert into car values('c1','소나타',1800,1200,'서울');









