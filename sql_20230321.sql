
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
select distinct depart 
from emp 
where depart is not null;

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
insert into salesman values('s205','홍길동', '2005-06-03',400,'부산');

commit;

select * from salesman;

insert into car values('c1','소나타',1800,1200,'서울');
insert into car values('c2','소나타',2000,1300,'서울');
insert into car values('c3','레조',1500,1100,'인천');
insert into car values('c4','레조',2000,1200,'인천');
insert into car values('c5','카니발',3000,1800,'광주');
insert into car values('c6','SM5',2000,1300,'부산');
insert into car values('c7','SM5',2000,1350,'부산');

select * from car;

insert into sale values('s123','c1',12);
insert into sale values('s123','c2',20);
insert into sale values('s123','c3',42);
insert into sale values('s123','c4',18);
insert into sale values('s123','c5',10);
insert into sale values('s123','c6',null);
insert into sale values('s202','c1',34);
insert into sale values('s202','c2',14);
insert into sale values('s134','c2',21);
insert into sale values('s241','c2',null);
insert into sale values('s241','c4',31);
insert into sale values('s123','c5',13);

select * from sale;

-- salesman 테이블의 모든 정보 조회
select * from salesman;

-- 판매된 승용차의 차량번호를 중복없이 조회
select distinct cno 
from car;

-- 현재 판매중인 모든 차량명과 중량을 톤으로 환산하여 조회
select cname, weight*0.001 as '톤 환산무게' from car;

-- 인천이 출고지인 차량의 차량번호와 차량명 조회
select cno, cname 
from car
where outlet = '인천';

-- 출고지가 부산이고 배기량이 2500cc 이상인 차량의 차량명과 배기량 조회
select cno, cname, cc
from car
where outlet = '부산'
and cc > 2500;

-- 영업 사원의 모든 정보를 실적이 낮은 순부터 조회
select * from salesman 
order by point asc;

-- 영업사원의 모든 정보를 실적순으로 검색하되 실적이 같은 경우 입사한 순서대로 정렬
select * from salesman 
order by point asc, hire asc;

-- 실적이 높은 영업사원 3명의 모든 정보를 실적순으로 조회
select * from salesman 
order by point desc
limit 3;

-- row_number() over (order by point desc) 사용
select * from (
	select 
		row_number() over(order by point desc) as rnum,
		sno, 
		sname,
		hire,
		point,
		branch
	from salesman
) a
where rnum <= 3;

-- 실적2등, 3등, 4등 영업사원의 모든 정보 조회
-- max(), not in
-- select 3개
select * from (
	select 
		row_number() over(order by point desc) as rnum,
		sno, 
		sname,
		hire,
		point,
		branch
	from salesman
) a
where rnum in (2, 3, 4);


select * from (
	select 
		row_number() over(order by point desc) as rnum,
		sno, 
		sname,
		hire,
		point,
		branch
	from (
		select * 
        from salesman
        where point not in (select max(point) from salesman)
    ) b
) c
where rnum <= 3;






























