select o.orderdate, sum(o.saleprice)
from orders o, customer c
where c.custid = o.custid 
group by o.custid;
-- order by o.custid;
use madang;

select * from customer;
select * from orders;

-- 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 조회
select c.name, b.bookname, o.saleprice
from orders o
left join customer c
on c.custid = o.custid
left join book b
on o.bookid = b.bookid
where b.price = 20000;

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 주문한 도서의 판매가격조회
select c.name, b.bookname, o.saleprice
from customer c
left join  orders o
on c.custid = o.custid
left join book b
on o.bookid = b.bookid;


select c.name, o.saleprice
from customer c
left join  orders o
on c.custid = o.custid;

-- 가장 비싼 도서의 이름조회
select * 
from book
where price = (select max(price) from book);

-- 도서를 구매한 적이 있는 고객의 이름을 조회
select distinct c.name
from customer c
right join  orders o
on c.custid = o.custid;

use madang;
-- 대한미디어에서 출판한 도서를 구매한 고객의 이름
select c.name, b.bookname, b.publisher, o.saleprice
from customer c
left join  orders o
on c.custid = o.custid
left join book b
on o.bookid = b.bookid
where b.publisher = '대한미디어';


select name
from customer
where custid in (
					select custid 
					from orders
                    where bookid in (
										select bookid
                                        from book
                                        where publisher = '대한미디어'
									)
				) ;


-- 출판사별로 출판사의 평균도서 가격보다 비싼도서
select a.bookname, a.price, b.price avg_price
from (
		select *
		from book
	  ) a
inner join
	(
		select publisher, round(avg(price)) price
		from book
		group by publisher
	) b
on a.publisher = b.publisher
where a.price > b.price;


select a.bookname, a.price from book a
where a.price > (select avg(b.price) from book b where a.publisher = b.publisher);


-- 대한민국에서 거주하고 도서를 주문한 고객의 이름 조회

select distinct c.name 
from customer c 
left join orders o
on c.custid = o.custid
where address like '대한민국%'
and saleprice is not null;

-- 대한민국에서 거주하는 고객의 이름과 도서를 주문한 고객의 이름을 빼고 조회
select distinct c.name 
from customer c 
where address like '대한민국%'

union

select distinct c.name
from orders o,
customer c
where o.custid = c.custid;

-- 대한민국에서 거주하는 고객의 이름에서 도서를 주문한 고객의 이름을 빼고 조회
select *
from customer 
where address like '대한민국%'
and name not in (
					select distinct c.name
					from customer c
					inner join orders o
					on o.custid = c.custid
				);

-- 대한민국에서 거주하는 고객 중 도서를 주문한 고객의 이름을 조회
select *
from customer 
where address like '대한민국%'
and name in (
					select distinct c.name
					from customer c
					inner join orders o
					on o.custid = c.custid
				);
                
                
-- 주문이 있는 고객의 이름과 주소를 조회 exists
select name, address
from customer c
where exists (
				select *
				from orders o
				where o.custid = c.custid
			 );
                
-- 주문하지 않은 고객의 이름과 주소를 조회 not exists
select name, address
from customer c
where not exists (
					select *
					from orders o
					where o.custid = c.custid
			     );

/*
 create table newbook(
	bookid int,
    bookname varchar(20),
    publisher varchar(20),
    price int,
    primary key(bookid)
)    

create table newbook(
    bookname varchar(20),
    publisher varchar(20),
    price int default 10000 check(price>1000),
    primary key(bookname, publisher)
)    

 create table neworder(
	orderid int,
    custid int not null,
    bookid int not nulll,
    saleprice int,
    orderdate date,
    primary key(orderid),
    foreign key(userid) references newcustomer(custid : primary key) on delete cascade
    
    alter : 생성된 테이블의 속성과 속성에 관한 제약을 변경하며 기본키 및 외래키를 변경함
    add, drop : 속성을 추가하거나 제거
    modify : 속성의 기본값을 설정하거나 삭제
) ;

1) newbook테이블에 varchar(13)의 자료형을 가진 isbn속성을 추가
   alter table newbook add isbn varchar(13);
   
2) newbook테이블에 isbn의 속성의 데어터 타입을 int형으로 바꿈
   alter table newbook modify isbn integer;

3) newbook테이블에 isbn의 속성 삭제
   alter table newbook drop column isbn;
   
4) newbook테이블의 bookid속성에 not null 제약조건을 적용
   alter table newbook modify bookid integer not null;

5) newbook테이블의 bookid 속성도 기본키로 변경(삭제 후 추가해야 함!!)
   alter table newbook modify primary key(orderid, bookid);

   alter table 테이블 이름
	add 속성이름 데이터타입
    drop column 속성이름
    modify 속성이름 데이터타입
    modify 속성이름 null | not null
    add primary key 속성이름
    add | drop 제약이름

6) newbook 테이블 삭제
    drop table newbook
    
*/

-- book 테이블에 하나의 레코드 추가
insert into book values(11,'스포츠 의학', '한솔의학서적', 90000);
commit;

create table imported_book(
	bookid int,
	bookname varchar(40),
	publisher varchar(40),
	price int
);

insert into imported_book values(21,'Zen Golf','Pearson', 12000);
insert into imported_book values(22,'Soccer Skills','Human Kinetics', 15000);
commit;

select * from imported_book;

-- imported_book을 book테이블에 모두 삽입
insert into book
(
  select * 
  from imported_book
);

commit;


select * from imported_book;
select * from book;

update customer 
set address = '대한민국 부산'
where custid = 5;

-- 11번 '스포츠 의학'의 출판사를 imported_book테이블의 21번 출판사와 동일하게 변경

update book
set publisher = (select publisher from imported_book where bookid = 21)
where bookid = 11;

-- book 테이블에서 도서번호가 11인 도서를 삭제
delete from book
where bookid = 11;

rollback;


-- 절대값
select abs(-78), abs(+78) from dual;

-- 반올림
select round(4.875, 1);

-- 함수 연산
-- 고객별 평균주문금액
select 
	custid '고객번호', 
    FORMAT(round(sum(saleprice)/count(*), 2) , 2) '평균금액' 
from orders
group by custid;

select round(14335645.4555, -2)
from dual;

select 
	bookid, 
    replace(bookname, '야구','농구'), 
    publisher, 
    price 
from book;

select * from book;

-- 굿스포츠에서 출판한 도서의 제목과 제목의 글자수 조회
select bookname '제목',char_length(bookname) '문자수', length(bookname) '바이트수'
from book
where publisher = '굿스포츠';

-- 고객중에서 같은 성을 가진 사람이 몇명이나 되는지 성별 인원수 조회
select substr(name, 1, 1) '성', count(*) '인원'
from customer
group by substr(name, 1, 1);

select 
	substr('abcdedg', 3, 4), 
    substr('abcdedg', 3)
from dual;

-- 마당서점은 주문일로부터 10일후 매출을 확정한다. 각 주문의 확정날자 조회
select 
	orderid   '주문번호', 
    orderdate '주문일', 
    date_format(adddate(orderdate, interval 10 day),'%Y-%m-%d') adddate
from orders;

-- 마당 서점이 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 조회
-- 단, 주문일은 %Y-%m-%d형태로 표시
use madang;
select orderdate from orders
where orderdate = '2014-07-07'; -- str_to_date('20140707','%Y%m%d');

select 
	o.orderid, 
    STR_TO_DATE(o.orderdate,'%Y%m%d') orderdate, 
    c.custid, 
    c.name, 
    b.bookid, 
    b.bookname, 
    FORMAT(o.saleprice,0) saleprice
from customer c
left join orders o
on c.custid = o.custid
left join book b
on o.bookid = b.bookid
where o.orderdate = date_format('20140707','%y%m%d');

-- DBMS 시스템상의 오늘 날짜를 반환 sysdate
select sysdate() from dual;

select sysdate(),
date_format(sysdate(), '%Y.%m/%d %M %h:%s') sydate from dual;

create table mybook(
	bookid int,
	price int
);
insert into mybook values(1, 10000);
insert into mybook values(2, 20000);
insert into mybook values(3, null);
commit;
select * from mybook;

select price+100
from mybook
where bookid = 3;

select sum(price), avg(price), count(*), count(price)
from mybook;
-- where bookid >= 4;

select * from mybook
where price is null;

select * from mybook
where price = '';

select * from mybook
where price is not null;

-- 이름, 전화번호가 포함된 고객목록 조회, 단 전화번호가 없는 고객은 '연락처 없음'으로 표시
select 
	name, 
    case 
		when phone is null then '연락처 없음'
        else phone
	end phone
from customer;

select 
	name, 
    ifnull(phone, '연락처없음') phone
from customer;

-- @변수
set @seq=0;
select (@seq:=@seq+1) '순번', custid, name, phone
from customer
where @seq < 2;

-- practice
select * 
from book;

set @rnum = 0;
select *, (@rnum:=@rnum+1) as rownum
from book;

select *, (@rnum:=@rnum+1) as rownum
from book, (select @rnum:=0) r
where @rnum < 5;


select *, (@rnum:=@rnum+1) as rownum
from book
, (select @rnum:=0 from dual) r
where @rnum < 5;

select *, (@rnum:=@rnum+1) as rownum
from (select * from book order by price) b,
(select @rnum:=0 from dual) r
where @rnum < 5;


-- subquery
-- 마당서점의 고객별 판매액을 조회(고객이름과 고객별 판매액을 출력)

select 
	  a.custid
    , name
    , sum(saleprice) total
from
(
	select c.custid, name, saleprice
	from customer c
	join orders o
	on c.custid = o.custid
) a
group by a.custid;

select 
	  custid
    , (select name from customer c where c.custid = o.custid) name
    , sum(saleprice) total
from orders o
group by custid;

-- Orders 테이블에 각 주문에 맞는 도서이름 조회
select 
	  bookid    
    , (select bookname from book b where b.bookid = o.bookid) bookname
    , sum(saleprice) total
from orders o
group by bookid;


select 
	  bookid    
    , (select bookname from book b where b.bookid = o.bookid) bookname
    , sum(saleprice) total
from orders o
group by bookid;


alter table orders add bname varchar(40);
update orders o
set bname = (select bookname from book b where b.bookid = o.bookid);

-- 고객번호가 2 이하인 고객의 판매액을 조회(고객이름과 고격별 판매금액 출력)
use madang;

select c.name, sum(saleprice) 
from (select * from customer where custid <= 2) c
inner join orders o
on c.custid = o.custid
group by c.custid, c.name;


-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액을 조회
select * 
from orders
where saleprice <= (select avg(saleprice) from orders);

-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해서 주문번호, 고객번호 조회
select o2.orderid, o2.custid, o2.saleprice, o1.savg 
from 
	(
		select 
			custid, 
            avg(saleprice) savg 
        from orders 
        group by custid
	) o1
	join orders o2 
	on o1.custid = o2.custid
where o2.saleprice > o1.savg;

select * 
from orders od
where saleprice > (
					select avg(saleprice) 
                    from orders so 
                    where od.custid = so.custid
				  );

-- 대한 민국에 거주하는 고객에게 판매한 도서의 총판매액
select sum(saleprice) 
from orders
where custid in (
					select custid 
                    from customer 
                    where address like '대한민국%'
				);
                
select sum(saleprice) 
from orders o
where exists (
					select * 
                    from customer c
                    where address like '대한민국%'
                    and o.custid = c.custid
				);                
                
-- 3번고객이 주문한 도서의 최대금액보다 높은 금액의 도서를 구입한 주문번호를 조회
select * 
from orders
where saleprice > (
						select max(saleprice) 
						from orders 
						where custid=3
				  );                
                
                
select * 
from orders
where saleprice > all(
						select saleprice 
						from orders 
						where custid=3
				  );                       

-- view : 하나 이상의 테이블을 합하여 만든 가상의 테이블                
-- 뷰의 장점
-- 자주 사용되는 복잡한 질의를 뷰로 미리 정의해 놓을 수 있음
-- 사용자 별로 필요한 데이터만 선별하여 보여줄수 있고 중요한 질의의 경우 내용을 암호화 할 수 있음
-- 미리 정의된 뷰를 일반 테이블처럼 사용할 수 있기 때문에 편리하고 사용자가 필요한 정보만 요구에 맞게 가공하여 뷰로 만들어 쓸수 있음

-- 뷰의 특징
-- 원본 데이터 값에 따라 같이 변함
-- 독립적인 인덱스 생성이 어려움
-- 삽입, 삭제, 갱신 연산에 많은 제약이 따름

create view vw_book as
select *
from book
where bookname like '축구%';

create view vw_customer as
select * from customer
where address like '%대한민국%';


select * from vw_customer;


select * from vw_book;



-- orders테이블에 고객이름과 도서이름을 바로 확인할 수 있는 뷰를 생성후
-- 김연아 고객이 구입한 도서의 주문번호, 도서이름, 주문액을 조회

create view vm_order_info as
select o.orderid, b.bookid, bookname, c.custid, c.name
from orders o 
join book b
on o.bookid = b.bookid
join customer c
on c.custid = o.custid;

select * from vm_order_info
where name = '김연아';

	









