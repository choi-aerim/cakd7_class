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

--newbook ���̺� isbn �Ӽ� �߰�
ALTER TABLE newbook ADD isbn VARCHAR2(15);


SELECT * FROM newbook;
--����1: newbook ���̺��� isbn �Ӽ� �����ϱ�
ALTER TABLE newbook DROP COLUMN isbn;

--����2: newbook ���̺��� �⺻Ű ������ �� �ٽ� bookid �Ӽ��� �⺻Ű�� �����ϱ�
-- PRIMARY KEY ����
ALTER TABLE newbook DROP PRIMARY KEY;
-- PRIMARY KEY ����
ALTER TABLE newbook ADD PRIMARY KEY(bookid);

--����3: newbook ���̺� �����ϱ�
DROP TABLE newbook;


