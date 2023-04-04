create database exam_stduent;
use exam_stduent;

drop table student;
create table student(
	hakbun varchar(8) primary key not null,
    sname varchar(20),
    hcode char(1),
    tel varchar(20),
    jumin char(14),
    dongari varchar(20),
    janghak varchar(10)
);
insert into student values('19910393', '김찬중', '1', '010-1234-1111','780112-1234567','영화',null);
insert into student values('19910394', '이호천', '2', '010-1234-1112','790112-2234567','영화','수상');
insert into student values('19910395', '김도향', '3', '010-1234-1113','800112-1234567',null,null);
insert into student values('20000394', '홍길동', '4', '010-1234-1114','800712-2234567','탁구','수상');
insert into student values('20001093', '김갑돌', '4', '010-1234-1115','780113-1234567','영화',null);
insert into student values('20001094', '김갑순', '2', '010-1234-1116','000112-3234567','테니스',null);

commit;
select * from student;


create table hakgwa(
	hcode char(1), -- 1: 경영학과, 2: 컴퓨터공학과, 3: 수학과, 4: 영문과, 5: DB보안
    hname varchar(20)
);
insert into hakgwa values('1','경영학과');
insert into hakgwa values('2','컴퓨터공학과');
insert into hakgwa values('3','수학과');
insert into hakgwa values('4','영문학과');
insert into hakgwa values('5','DB보안과');
commit;
select * from hakgwa;

drop table sungjuk;
create table sungjuk(
	hakbun varchar(8),
    kor int(3),
    mat int(3),
    eng int(3)
);

insert into sungjuk values('19910393',80,90,100);
insert into sungjuk values('19910394',70,55,80);
insert into sungjuk values('19910395',98,90,90);
insert into sungjuk values('20000394',70,90,100);
insert into sungjuk values('20001093',99,78,100);
-- insert into sungjuk values('20001094',null,null,null);

insert into sungjuk values('20041093',null,null,null);

commit;
select * from sungjuk;

-- 장학금을 한번도 안 받은 학생 조회
select * 
from student 
where janghak is null;


-- 2.동아리가 있는 학생들의 목록을 조회
select * 
from student
where dongari is not null;

-- 3. 최근의 학번 순으로 정렬 조회(학번, 이름, 주민번호)
select 
	hakbun, 
    sname, 
    jumin 
from student
order by hakbun desc;

-- 성별로 조회 case when(조건) then .... when() then else end
select 
	hakbun '학번', 
    sname '이름', 
    jumin '주민번호', 
    case 
		when substr(jumin,8,2)  = '0'
        then '남'
	    when substr(jumin,8,1)  = '2' or substr(jumin,8,1)  = '4' 
        then '여'
	end '성별'
from student;

-- 5. 2000년대 학번 학생들의 모든 정보를 조회
select * 
from student
-- where substr(hakbun, 1, 1) = '2';
where hakbun like '2%';

-- 6. 주민번호를 이용하여 현재의 나이 조회 case when then extract in 
select 
	hakbun '학번', 
    sname '이름', 
    jumin '주민번호', 
    EXTRACT(YEAR FROM now()) 'year',
    substr(replace(now(),'-',''),1,4) '올해년도',
	case 
	   when substr(jumin,1,1) = '0' then concat('20', substr(jumin,1,2)) 
	   else concat('19',substr(jumin,1,2)) 
	end '출생년도',
	case 
	   when substr(jumin,1,1) = 0 then cast(substr(replace(now(),'-',''),1,4) as unsigned) - cast(concat('20',substr(jumin,1,2)) as unsigned) + 1
	   else cast(substr(replace(now(),'-',''),1,4) as unsigned) - cast(concat('19',substr(jumin,1,2)) as unsigned)  + 1
	end '나이'
from student;

select 
	sname,
	case when substr(jumin,8,1) in ('1','2')
		then extract(year from sysdate()) - ('1900' + substr(jumin,1,2)) + 1
		else extract(year from sysdate()) - ('2000' + substr(jumin,1,2)) + 1
    end as '나이'
from student;

-- 7. 동아리가 '영화'동아리만 조회
select * 
from 
(
	select hakbun, sname, hcode, tel, jumin, dongari, janghak
    from student
	where dongari = '영화'
) a;

-- 8.  70년대에 태어난 사람들 모두 조회
select * 
from student
-- where jumin like '7%';
-- where substr(jumin,1,1) = '7';
where substr(jumin,1,2) between 70 and 79;

-- 9. ll학번, 이름, 학과 조회
select 
	s.hakbun, 
    s.sname, 
    h.hname
from student s left join hakgwa h
on s.hcode = h.hcode;  

-- (inner) join       : 두 테이블에 일치하는 것만 표시
-- left (outer) join  : 왼쪽 테이블 기준으로 표시(기준으로 된 것은 모두 표시)
-- right (outer) join : 오른쪽 테이블 기준 표시

update student 
set hakbun = '20041093'
where sname = '김갑순';

commit;

-- 10. 학번, 이름, 학과, 국어점수, 수학점수, 영어점수를 조회
select 
	s.hakbun, 
    s.sname, 
    h.hname,
    j.kor,
    j.mat,
    j.eng
from student s 
left outer join hakgwa h
on s.hcode = h.hcode
left outer join sungjuk j
on s.hakbun = j.hakbun;

create table sungjuk2 as
(
	select 
		s.hakbun, 
		s.sname, 
		j.kor,
		j.mat,
		j.eng
	from student s 
	inner join sungjuk j
	on s.hakbun = j.hakbun
);

select * from sungjuk2;

-- 12. sungjuk2 테이블을 이용해 총점과 평균을 구해봄
select 
	sname '이름', 
    eng+mat+kor "과목총점", 
    round((eng+mat+kor)/3) '평균'
from sungjuk2;    


-- 13. sungjuk2 테이블을 이용해 과목별 총점과 전과목의 총점을 구함
select 
	sum(kor) '한국어 전체총점', 
    round(sum(kor) / count(*)) '한국어 전체평균', 
    sum(mat) '수학 전체총점', 
    round(sum(mat) / count(*)) '수학 전체평균',
    sum(eng) '영어 전체총점', 
    round(sum(eng) / count(*)) '영어 전체평균',
    sum(kor + mat + eng) '전체 총점', 
    round(sum(kor + mat + eng) / (count(*)*3))  '전과목 평균'
from sungjuk2;

-- 14. sungjuk2테이블에서 영어점수가 100점 이상인 이름과 학번을 조회
select hakbun, sname from sungjuk2
where eng >= 100;

-- 15. sungjuk2 테이블의 행의 개수를 조회
select count(*) from sungjuk2;

-- 16. sungjuk2 테이블에서 국어전체평균보다 높은 점수를 가진 사람의 학번과 이름 조회
select 
		hakbun, 
		sname, 
		kor
from
( 
	select 
		hakbun, 
		sname, 
		kor,
		avg_kor
	from sungjuk2 s1,
		 (select round(sum(kor) / count(*)) avg_kor from sungjuk2) s2
) t
where  kor > avg_kor;    


select 
	hakbun, 
	sname, 
	kor
from sungjuk2 
where kor > (select round(sum(kor) / count(*)) from sungjuk2) 
		 


















