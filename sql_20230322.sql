use car_sale;
select * from salesman;

delete from salesman where sno = 's205';
commit;

-- 전체영업사원의 수(테이블의 모든 row수) count(*), count(column)
select count(*) from salesman;

-- 영업사원들의 실적 점수의 평균 avg()
select avg(point) from salesman;

-- 영업 사원별로 판매한 전체 차량의 대수 조회 sum()
select 
	sno, 
    sum(qty) qty
from sale
group by sno;


-- 30대 이상 판매한 영업사원의 사번조회
select 
	sno, 
    sum(qty) qty
from sale
group by sno
having sum(qty) >= 30;

-- 차량명이 '소'로 시작하는 차량의 모든 정보조회
select * 
from car
where cname like '소%';

-- 김씨가 아닌 영업사원의 사번과 이름을 조회
select 
	sno, 
    sname
from salesman
where sname not like '김%' ;

-- 배기량이 널값인 차량
select cno, cname 
from car
where cc is null;

select *
from sale
where qty is null;


-- 차량번호 'C4'를 판매한 영업사원의 이름 조회
select  m.*
from sale s,
     salesman m
where 1 = 1     
and s.sno = m.sno
and s.cno = 'C4';

select s.sname
from salesman s
inner join sale s2
on s.sno = s2.sno
where s2.cno = 'C4';

select s1.* 
from car c,
     sale s,
	 salesman s1
where s.sno = s1.sno
and   s.cno = c.cno
and   s.cno in ('c6', 'c7');

-- 'sm5'차량을 판매한 사원의 이름을 조회
select s.sname
from salesman s 
inner join sale s2
on s.sno = s2.sno
join car c
on s2.cno = c.cno
and c.cname = 'sm5';


-- 차량번호 'c6'인 판매대수를 null에서 30으로 수정
update sale
set qty = 30
where qty is null
and cno ='C6';

commit;

select * from sale 
where qty is null;

-- 사번이 's123'인 사원 실적을 100점 증가 set +
update salesman 
set point = point + 100
where sno='s123';
commit;

-- 모든 사원의 실적을 100점 감소
update salesman 
set point = point + 100;
commit;

-- 사번이 'S123'인 사원의 레코드 삭제
delete from salesman where sno = 's134';
rollback;

select * from car;

-- 부산에 출고되는 모든 차량을 삭제
delete from car 
where outlet = '부산';
commit;

rollback;

-- 사원테이블의 모든 정보를 삭제
delete from salesman;

select * from salesman;
rollback;

-- 새로운 스키마 생성
create database exam_sungjuk;
use exam_sungjuk;
drop table sungjuk;
create table sungjuk(
	hakbun varchar(4),
	id varchar(20),
	sname varchar(20),
	email varchar(100),
	kor int(3),
	eng int(3),
	mat int(3)
);

insert into sungjuk values('1','a1','홍길동','kkk@k.com',80,70,90);
insert into sungjuk values('2','b1','이선생','iii@i.com',76,38,89);
insert into sungjuk values('3','c1','양선생','ooo@o.com',90,70,80);
insert into sungjuk values('4','d1','파선생',null,45,20,100);
insert into sungjuk values('5','e1','주선생',null,100,100,100);

-- 학번을 역순으로 정렬
select * from sungjuk order by hakbun desc;

-- 학번을 역순으로 정렬하고 상위 2명만 출력
select * 
from
(
	select 
		row_number() over(order by hakbun desc) as rnum,
		s.*
	from sungjuk s
) t
where t.rnum <= 2;

--  이메일이 없는 레코드 출력
select * 
from sungjuk 
where email is null;

-- 이메일이 있는 레코드만 출력
select * 
from sungjuk 
where email is not null;

select * 
from sungjuk
where hakbun not in (
	select hakbun
	from sungjuk 
	where email is null
);

select * 
from sungjuk
where email like '%@%';

select * 
from sungjuk
-- where hakbun between 3 and 5;
where hakbun >= 3 
and hakbun <= 5;

-- 이름에 '선'이 들어가면서 영어 점수가 60점 이상인 레코드 조회
select * 
from sungjuk
where sname like '%선%'
and eng > 60;

-- 국어 점수가 80점 이상이면서 수학 점수가 90점 이상인 레코드 조회
select * 
from sungjuk
where kor >= 80
and mat >= 90;

-- 국어점수가 90점 이상이거나 이름이 '김'으로 시작하는 레코드 조회
select * 
from sungjuk
where kor >= 90
or sname like '김%';

-- 학번이 3번 이상이면서 영어 점수가 70점 이상인 레코드 조회
select * from sungjuk
where hakbun >= 3
and eng >= 70;

-- 수학 점수만 100점인 필드 중에서 수학 점수만 출력하여 중복 레코드 제거
select distinct * 
from sungjuk
where mat = 100;


-- 이름이 '생'으로 끝나고 이메일이 없는 레코드 조회
select * 
from sungjuk 
where email is null
and sname like '%생';

-- 조회 결과치를 테이블로 생성하기
create table sungjuk_result as (
	select * 
    from sungjuk 
    where eng >= 70 
);

select * 
from sungjuk ;

-- 아이디가 e1인 사용자 이메일 'w@w.com' 국어점수 80점으로 수정
update sungjuk
set email = 'w@w.com',
    kor = 80
where id ='e1';

-- 이름이 파선생 레코드 삭제
delete from sungjuk where sname='파선생';

rollback;
commit;
    









