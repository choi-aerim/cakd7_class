--DML--

select * from book;
select bookname, price from book;
select publisher from book;

--distinct:중복 빼고
select distinct publisher from book;

-- price가 만원 미만인 것 뽑기
select * from book
where price < 10000;

-- price가 만원 이상 이만원 이하인 도서 검색
select * from book
where 10000 <= price and price <= 20000;

-- 출판사가 굿스포츠 혹은 대한미디어인 도서 검색
select * from book
where publisher = '굿스포츠' or publisher = '대한미디어';

select * from book
where publisher in ('굿스포츠', '대한미디어');

-- 출판사가 굿스포츠 혹은 대한미디어가 아닌 도서 검색
select * from book
where publisher not in ('굿스포츠', '대한미디어');

-- 책이름에 축구가 들어잇는 것
select * from book
where bookname like '%축구%';

-- 도서이름의 왼쪽 두 번째 위치에 '구'라는 문자열을 갖는 도서 검색
select * from book
where bookname like '_구%';

-- 축구에 관한 도서 중 가격이 이만원 이상인 도서 검색
select * from book
where bookname like '%축구%' and price >= 20000;

-- 오름차순 정렬
select * from book
order by bookname;

-- 내림차순 정렬
select * from book
order by bookname desc;

-- 도서를 가격순으로 검색하고 가격이 같으면 이름 순으로 검색
select * from book
order by price, bookname;

--도서를 가격의 내림차순으로 검색하고 가격이 같으면 출판사를 오름차순으로 출력
select * from book
order by price desc, publisher asc;

--
select * from orders;
select sum(saleprice)
from orders;

-- 2번 김연아 고객이 주문한 도서의 총 판매액 구하기
select * from orders;
select sum(saleprice) as "총 판매액" from orders
where custid = 2;

-- saleprice의 합계, 평균, 최소값
-- 합계:
select * from orders;
select avg(saleprice) as "평균", 
min(saleprice) as "최소값", 
max(saleprice) as "최댓값"
from orders;

-- 개수 세기
select * from orders;
select count(*) as "개수"
from orders;

-- custid별 구매한 도서수량, 총 판매액 구하기
select custid, count(*) as 도서수량, sum(saleprice) as "총 판매액" 
from orders
group by custid;

-- 과제1: 가격이 8000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량 구하기
-- 단, 두 권 이상 구매한 고객만 구하기
SELECT custid, COUNT(*) AS "주문도서 총 수량"
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >= 2;


-- 같은 컬럼 기준으로 merge
select * from customer;
select * from orders;

select * from customer, orders
where customer.custid = orders.custid;


-- 고객과 고객의 주문에 관한 데이터를 고객별로 정렬하여 출력
select * from customer, orders
where customer.custid = orders.custid
order by customer.custid;

-- 고객의 이름과 고객이 주문한 도서의 판매가격을 검색
select customer.name, orders.saleprice from customer, orders
where customer.custid = orders.custid;

-- 고객별로 주문한 모든 도서의 총 판매액을 구하고 고객별로 정렬
select customer.name, sum(orders.saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

-- 고객의 이름과 고객이 주문한 도서의 이름 구하기
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid;

-- 가격이 20000원인 도서를 주문한 고객의 이름과 도서 이름 구하기
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid 
and orders.saleprice = 20000;

-- 도서를 구매하지 않은 고객을 포함하여 고객의 이름과 고객이 주문한 도서의 판매가격 구하기
select * from book, orders, customer
where customer.custid = orders.custid and orders.bookid = book.bookid;
-- 참고
SELECT customer.name, NVL(SUM(orders.saleprice),0) as 판매가격 
FROM customer 
LEFT JOIN orders on customer.custid=orders.custid 
GROUP BY customer.name;


-- 서브쿼리: 가장 비싼 도서의 이름을 출력
select bookname
from book
where price = (select max(price) from book);

-- 과제2: 도서를 구매한 적이 있는 고객의 이름을 검색
SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders);

-- 과제3: 대한미디어에서 출판한 도서를 구매한 고객의 이름 출력
SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders 
                 WHERE bookid in (SELECT bookid FROM book WHERE publisher = '대한미디어'));

-- 과제4: 출판사별로 출판사의 평균 도서 가격보다 비싼 도서 출력
SELECT b1.bookname 
FROM book b1
WHERE b1.price > (SELECT AVG(b2.price) FROM book b2 
                  WHERE b2.publisher = b1.publisher);

-- 과제5: 도서를 주문하지 않은 고객의 이름 출력
-- 방법1
SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);

--방법2
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

-- 과제6: 주문이 있는 고객의 이름과 주소 출력
-- 방법1
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM Orders);

-- 방법2
SELECT name, address
FROM customer
WHERE EXISTS (SELECT * FROM orders
              WHERE orders.custid = customer.custid);



