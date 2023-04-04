drop schema madang;
create schema madang;
use madang;

drop table IF EXISTS Orders cascade;
drop table IF EXISTS Book;
create table Book(
	bookid integer primary key,
    bookname varchar(40),
    publisher varchar(40),
    price integer
);

select * from Book;
create table Customer(
	custid integer primary key,
    name varchar(40),
    address varchar(50),
    phone varchar(20)
);


drop table orders;
create table Orders(
    orderid integer primary key,
    custid integer,
    bookid integer,
    saleprice integer,
    orderdate date
   -- foreign key(custid) references Customer(custid),
   -- foreign key(bookid) references Book(bookid)
);

INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);
INSERT INTO Customer VALUES (6, '박지성', '독일 맨체스타', '000-5000-2222');

INSERT INTO Orders VALUES (1, 1, 1, 6000, STR_TO_DATE('2014-07-01','%Y-%m-%d')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, STR_TO_DATE('2014-07-03','%Y-%m-%d'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, STR_TO_DATE('2014-07-03','%Y-%m-%d')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, STR_TO_DATE('2014-07-04','%Y-%m-%d')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, STR_TO_DATE('2014-07-05','%Y-%m-%d'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, STR_TO_DATE('2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, STR_TO_DATE( '2014-07-07','%Y-%m-%d'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, STR_TO_DATE('2014-07-08','%Y-%m-%d')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, STR_TO_DATE('2014-07-09','%Y-%m-%d')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, STR_TO_DATE('2014-07-10','%Y-%m-%d'));
    
commit;    

-- 데이터 정의어(DDL) : create, alter, drop
-- 데이터 조작어(DML) : select, insert, delete, up
-- 데이터 제어어(DCL) : grant, revoke

-- 1. 김연아 고객의 전화번호 조회
select * 
from Customer 
where name = '김연아';

-- 2. 책이름, 가격
select bookname, price
from Book;

-- 3. 모든 도서의 도서번호, 도서이름, 출판사, 가격을 조회
select 
	bookid, 
    bookname, 
    publisher, 
    price 
from book;

-- 4. 도서 테이블에 있는 모든 출판사조회
select publisher from book;

-- 5. 중복제거
select distinct publisher from book;

-- 연산자
-- =, <>,<, <=, >, >=
-- between
-- in, not in
-- like, not like
-- is null, is not null
-- and, or, not

-- 6. 가격이 20,000원 미만인 도서 조회
select * 
from book
where price < 20000;

-- 가격이 10,000원 이상 20,000원이하인 도서 조회
select *
from book
-- where price between 10000 and 20000;
where price >= 10000 
and price <= 20000;

-- 출판사가 '굿스포츠' 혹은 '대한미디어'인 도서를 조회
select * from book 
-- where publisher = '굿스포츠' or publisher = '대한미디어';
where publisher in ('굿스포츠', '대한미디어');

-- 출판사가 '굿스포츠' 혹은 '대한미디어'가 아닌 도서를 조회
select * from book 
where publisher not in ('굿스포츠', '대한미디어');


-- 축구의 역사를 출간한 출판사 조회
select publisher 
from book
where bookname = '축구의 역사';

-- 도서이름에 '축구'가 포함된 출판사 조회
select * 
from book
where bookname like '%축구%';

-- 도서 이름의 왼쪽 두번째 위치에 '구'라는 문자열을 갖는 도서를 조회
select * 
from book
where substr(bookname,2,1) = '구';

-- 와일드 문자
-- + : 문자열을 연결
-- % : 0개 이상의 문자열과 일치
-- []  : 1개의 문자와 일치  : '[0-5]%' : 0-5사이 숫자로 시작하는 문자열
-- [^] : 1개의 문자와 불일치 : '[^0-5]%' : 0-5사이 숫자로 시작하지 않는 문자열
-- _ : 특정 위치의 1개의 문자와 일치


-- 축구에 관한 도서 중 가격이 20,000 원 이상인 도서를 조회
select * 
from book
where bookname like '%축구%' 
and price > 20000;

-- 도서를 이름순으로 조회
select * from book
order by bookname asc;

-- 도서를 가격순으로 조회하고, 가격이 같으면 이름순으로 조회
select * 
from book
order by price asc, bookname asc;

-- 도서를 가격의 내림차순으로 조회하고, 가격이 같으면 출판사의 오름차순으로 조회
select * 
from book
order by price desc, publisher asc;

-- 고객이 주문한 도서의 총 판매액을 조회
select sum(saleprice) '총매출액' 
from orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액을 조회
select sum(saleprice) 
from orders 
where custid = 2;

-- 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 조회
select 
	sum(saleprice) tot, 
    round(sum(saleprice)/count(*)) avg, 
    min(saleprice) min, 
    max(saleprice) max 
from orders;

-- 마당서점의 도서 판매 건수를 조회
select count(*) cnt 
from orders o, book b 
where b.bookid = o.bookid
and publisher = '마당서점';

select * from book;

-- 고객별로 주문한 도서의 총 수량과 총 판매액을 조회
select o.custid, c.name, count(*) cnt, sum(o.saleprice) saleprice
from orders o 
left join customer c
on c.custid = o.custid
group by o.custid
order by sum(o.saleprice) desc;

select custid, custid, bookid, saleprice, orderdate from orders;
use madang;

-- 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총수량 조회
-- 단, 두권 이상 구매한 고객만 조회
-- count(*) : 테이블의 모든 행수를 센다. (단, not null)

select custid, count(*) from orders
where saleprice > 8000
group by custid
having count(*) >=2 ;

-- having <검색 조건> 뒤에는 sum, avg, max, min, count 집계함수가 와야한다.
select o.custid, c.name, count(*) 
from orders o 
left join customer c
on c.custid = o.custid
where saleprice > 8000
group by o.custid
having count(*) >=2 ;

-- group by로 해당컬럼으로 묶은 후 select에는 group by에서 사용한 컬럼과 집계함수만 올수 있다.
select bookid, sum(saleprice) from orders
group by custid;

select * 
from Customer c 
join Orders o
on c.custid = o.custid;

select * from Customer, Orders;

-- 고객과 고객의 주문에 관한 데이터를 고객번호 순으로 정렬

select * 
from Customer c 
join Orders o
on c.custid = o.custid
order by c.custid;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 조회
select c.name, o.saleprice
from orders o
left join customer c
on c.custid = o.custid;


-- 고객별로 주문한 모든 도서의 총 판매액을 구하고, 고객별로 정렬 조회
select  c.custid, sum(saleprice) tot
from orders o
, customer c
where o.custid = c.custid
group by c.custid
order by o.custid;

-- 고객의 이름과 고객이 주문한 도서의 이름
select c.name, b.bookname, o.saleprice
from orders o
left join customer c
on c.custid = o.custid
left join book b
on o.bookid = b.bookid;













    
























































































































