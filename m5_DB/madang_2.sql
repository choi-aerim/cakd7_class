
-- 테이블을 활용하는 것이 아닌 단순 계산만 실행할 때 select 문에서 from dual을 사용함
SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;


SELECT * FROM orders;
-- 고객별 평균 주문 금액을 백원 단위로 반올림한 값을 구하세요.
-- round: 반올림
SELECT custid, ROUND(AVG(saleprice), -2)
FROM orders
GROUP BY custid;

SELECT * FROM book;
--도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서목록, 가격을 출력
-- replace: 해당하는 단어를 대체
SELECT bookid, REPLACE(bookname, '야구', '농구') bookname, publisher, price
FROM book;

-- length: 글자수
-- lengthb: 바이트수
-- 별칭 쓸 때, as 사용은 선택 가능
SELECT bookname 제목, length(bookname) 글자수, lengthb(bookname) as 바이트수, publisher, price
FROM book;


-- 박세리 선수 정보 삽입
SELECT * FROM customer;
INSERT INTO customer VALUES(5, '박세리', '대한민국 대전', NULL);

--과제4: customer 테이블에서 같은 성을 가진 사람이 몇 명이나 되는지 성별 인원수 구하기
-- substr(문자열, 시작위치, 길이)
SELECT SUBSTR(name,1,1) "성", count(*) "인원"
FROM customer
GROUP BY SUBSTR(name,1,1);



SELECT * FROM orders;
-- 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하기
SELECT orderid, custid, bookid, saleprice, orderdate, orderdate+10 as "확정일자"
FROM orders;

-- 과제5: 2020년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호 모두 출력
-- dy: 월, 화, 수..../ day: 월요일, 화요일, 수요일...
SELECT orderid 주문번호, TO_CHAR(orderdate,'yyyy-mm-dd day') 주문일, custid 고객번호, bookid 도서번호
FROM orders
WHERE orderdate = to_date('2020-07-07','yyyy-mm-dd');

-- 현재 시간가지고 시간 포맷 변경
SELECT SYSDATE FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATA1
FROM dual;


-- 이름, 전화번호가 포함된 고객목록을 보이기. 단, 전화번호가 없는 고객은 '연락처 없음'으로 표현하여 출력
SELECT * FROM customer;
SELECT name "이름", address "주소", NVL(phone, '연락처 없음') "전화번호"
FROM customer;

-- SELECT COALESCE(NULL, NULL, 'third value', 'forth value'): 세번째 값이 null이 아닌 첫번째 값이기 때문에 세번째 값을 반환
SELECT NAME 이름, phone, COALESCE(phone, '연락처 없음') 전화번호
FROM customer;

-- SQL 조회 결과의 순번을 나타냄, 자료를 일부분만 확인하여 처리할 때 유용함
SELECT ROWNUM 순번, custid 고객번호, name 이름, phone 전화번호
FROM customer
WHERE ROWNUM <= 3;


SELECT * FROM orders;
-- 평균 주문금액 이하의 주문에 대해서 주문번호와 금액 보이기
SELECT orderid, saleprice
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

-- 각 고객의 평균 주문금액보다 큰 금액의 주문 내역에 대해 주문번호, 고객번호, 금액 출력
SELECT orderid, custid, saleprice
FROM orders o1
WHERE saleprice > (SELECT AVG(saleprice) FROM orders o2 
                    WHERE o1.custid = o2.custid );

SELECT * FROM customer;


SELECT * FROM orders;
-- 과제6: 대한민국에 거주하는 고객에게 판매한 도서의 총 판매액을 출력
SELECT SUM(saleprice) "총 도서 판매액"
FROM orders
WHERE custid in (SELECT custid FROM customer WHERE address LIKE '%대한민국%');


-- 과제7: 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 주문번호와 금액 출력
SELECT orderid, saleprice
FROM orders
WHERE saleprice > (SELECT MAX(saleprice) FROM orders WHERE custid = 3);


-- 과제8: 고객번호가 2 이하인 고객의 판매액을 출력(단, 고객이름과 고객별 판매액 포함)




select * from customer;
select * from orders;

-- (+): 왼쪽걸 기준으로 함!
select c.name, sum(o.saleprice)
from orders o, customer c
where c.custid = o.custid(+)
group by c.name;

-- null을 0으로 대체하고 오름차순 정렬하기
SELECT c.name, NVL(SUM(saleprice),0) 고객별판매액
FROM orders o, customer c
WHERE c.custid = o.custid(+)
GROUP BY c.name
ORDER BY 고객별판매액;

-- View는 가상의 테이블이라고 하며, 데이터는 없고 sql만 저장되어 있는 object
-- View는 기본 테이블이나 뷰를 삭제하게 되면 해당 데이터를 기초로 한 다른 뷰들이 자동으로 삭제되고 alter 명령을 사용할 수 없음
-- 내용을 수정하기 위해서는 drop & create를 반복해야하며, 원본 이름으로 생성할 수 없음
-- 실무에서는 "vw_"접미사나 접두사를 붙여 만듬
create view vw_customer
as select *
from customer
where address like '%대한민국%';

select * from vw_customer;



select * from orders;
select * from book;
-- orders 테이블에서 고객이름과 도서이름을 바로 확인할 수 있는 뷰 생성하기
CREATE VIEW vw_cust_book
AS SELECT  c.name "고객이름", o.orderid "주문번호", b.bookname "도서이름", o.saleprice "주문액"
FROM orders o, customer c, book b
WHERE o.custid = c.custid and b.bookid = o.bookid;

-- 김연아 고객이 구입한 도서의 주문번호, 도서이름, 주문액 출력
SELECT  * 
FROM vw_cust_book
WHERE 고객이름 = '김연아';

-- 앞서 생성한 뷰 삭제
DROP VIEW vw_cust_book;






