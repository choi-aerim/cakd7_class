--DML--

select * from book;
select bookname, price from book;
select publisher from book;

--distinct:�ߺ� ����
select distinct publisher from book;

-- price�� ���� �̸��� �� �̱�
select * from book
where price < 10000;

-- price�� ���� �̻� �̸��� ������ ���� �˻�
select * from book
where 10000 <= price and price <= 20000;

-- ���ǻ簡 �½����� Ȥ�� ���ѹ̵���� ���� �˻�
select * from book
where publisher = '�½�����' or publisher = '���ѹ̵��';

select * from book
where publisher in ('�½�����', '���ѹ̵��');

-- ���ǻ簡 �½����� Ȥ�� ���ѹ̵� �ƴ� ���� �˻�
select * from book
where publisher not in ('�½�����', '���ѹ̵��');

-- å�̸��� �౸�� ����մ� ��
select * from book
where bookname like '%�౸%';

-- �����̸��� ���� �� ��° ��ġ�� '��'��� ���ڿ��� ���� ���� �˻�
select * from book
where bookname like '_��%';

-- �౸�� ���� ���� �� ������ �̸��� �̻��� ���� �˻�
select * from book
where bookname like '%�౸%' and price >= 20000;

-- �������� ����
select * from book
order by bookname;

-- �������� ����
select * from book
order by bookname desc;

-- ������ ���ݼ����� �˻��ϰ� ������ ������ �̸� ������ �˻�
select * from book
order by price, bookname;

--������ ������ ������������ �˻��ϰ� ������ ������ ���ǻ縦 ������������ ���
select * from book
order by price desc, publisher asc;

--
select * from orders;
select sum(saleprice)
from orders;

-- 2�� �迬�� ���� �ֹ��� ������ �� �Ǹž� ���ϱ�
select * from orders;
select sum(saleprice) as "�� �Ǹž�" from orders
where custid = 2;

-- saleprice�� �հ�, ���, �ּҰ�
-- �հ�:
select * from orders;
select avg(saleprice) as "���", 
min(saleprice) as "�ּҰ�", 
max(saleprice) as "�ִ�"
from orders;

-- ���� ����
select * from orders;
select count(*) as "����"
from orders;

-- custid�� ������ ��������, �� �Ǹž� ���ϱ�
select custid, count(*) as ��������, sum(saleprice) as "�� �Ǹž�" 
from orders
group by custid;

-- ����1: ������ 8000�� �̻��� ������ ������ ���� ���Ͽ� ���� �ֹ� ������ �� ���� ���ϱ�
-- ��, �� �� �̻� ������ ���� ���ϱ�
SELECT custid, COUNT(*) AS "�ֹ����� �� ����"
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >= 2;


-- ���� �÷� �������� merge
select * from customer;
select * from orders;

select * from customer, orders
where customer.custid = orders.custid;


-- ���� ���� �ֹ��� ���� �����͸� ������ �����Ͽ� ���
select * from customer, orders
where customer.custid = orders.custid
order by customer.custid;

-- ���� �̸��� ���� �ֹ��� ������ �ǸŰ����� �˻�
select customer.name, orders.saleprice from customer, orders
where customer.custid = orders.custid;

-- ������ �ֹ��� ��� ������ �� �Ǹž��� ���ϰ� ������ ����
select customer.name, sum(orders.saleprice)
from customer, orders
where customer.custid = orders.custid
group by customer.name
order by customer.name;

-- ���� �̸��� ���� �ֹ��� ������ �̸� ���ϱ�
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid;

-- ������ 20000���� ������ �ֹ��� ���� �̸��� ���� �̸� ���ϱ�
select customer.name, book.bookname
from customer, orders, book
where customer.custid = orders.custid and orders.bookid = book.bookid 
and orders.saleprice = 20000;

-- ������ �������� ���� ���� �����Ͽ� ���� �̸��� ���� �ֹ��� ������ �ǸŰ��� ���ϱ�
select * from book, orders, customer
where customer.custid = orders.custid and orders.bookid = book.bookid;
-- ����
SELECT customer.name, NVL(SUM(orders.saleprice),0) as �ǸŰ��� 
FROM customer 
LEFT JOIN orders on customer.custid=orders.custid 
GROUP BY customer.name;


-- ��������: ���� ��� ������ �̸��� ���
select bookname
from book
where price = (select max(price) from book);

-- ����2: ������ ������ ���� �ִ� ���� �̸��� �˻�
SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders);

-- ����3: ���ѹ̵��� ������ ������ ������ ���� �̸� ���
SELECT name
FROM customer
WHERE custid in (SELECT custid FROM orders 
                 WHERE bookid in (SELECT bookid FROM book WHERE publisher = '���ѹ̵��'));

-- ����4: ���ǻ纰�� ���ǻ��� ��� ���� ���ݺ��� ��� ���� ���
SELECT b1.bookname 
FROM book b1
WHERE b1.price > (SELECT AVG(b2.price) FROM book b2 
                  WHERE b2.publisher = b1.publisher);

-- ����5: ������ �ֹ����� ���� ���� �̸� ���
-- ���1
SELECT name
FROM customer
WHERE custid NOT IN (SELECT custid FROM orders);

--���2
SELECT name
FROM customer
MINUS
SELECT name
FROM customer
WHERE custid IN (SELECT custid FROM orders);

-- ����6: �ֹ��� �ִ� ���� �̸��� �ּ� ���
-- ���1
SELECT name, address
FROM customer
WHERE custid IN (SELECT custid FROM Orders);

-- ���2
SELECT name, address
FROM customer
WHERE EXISTS (SELECT * FROM orders
              WHERE orders.custid = customer.custid);



