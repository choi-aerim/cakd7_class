-- DDL
create table newbook(
bookid      number,
bookname    varchar2(20)   not null,
publisher   varchar2(20)   unique,
price       number default 10000   check(price>1000),
primary key (bookid));

desc newbook;

drop table newbook;

CREATE TABLE newcustomer(
custid NUMBER PRIMARY KEY,
name VARCHAR2(40),
address VARCHAR2(40),
phone VARCHAR2(30)
);

DESC newcustomer;

CREATE TABLE neworders(
orderid NUMBER NOT NULL,
custid NUMBER NOT NULL,
bookid NUMBER NOT NULL,
saleprice NUMBER,
orderdate DATE,
PRIMARY KEY(orderid),
FOREIGN KEY(custid) REFERENCES newcustomer(custid) ON DELETE CASCADE
);

DESC neworders;

CREATE TABLE newbook(
bookid NUMBER PRIMARY KEY,
bookname VARCHAR(20) NOT NULL,
publisher VARCHAR(20) UNIQUE,
price NUMBER DEFAULT 10000 CHECK(price > 1000)
);

DESC newbook;
DROP TABLE newbook;

--newbook 테이블에 isbn 속성 추가
ALTER TABLE newbook ADD isbn VARCHAR2(15);


SELECT * FROM newbook;
--과제1: newbook 테이블의 isbn 속성 삭제하기
ALTER TABLE newbook DROP COLUMN isbn;

--과제2: newbook 테이블의 기본키 삭제한 후 다시 bookid 속성을 기본키로 변경하기
-- PRIMARY KEY 삭제
ALTER TABLE newbook DROP PRIMARY KEY;
-- PRIMARY KEY 지정
ALTER TABLE newbook ADD PRIMARY KEY(bookid);

--과제3: newbook 테이블 삭제하기
DROP TABLE newbook;


