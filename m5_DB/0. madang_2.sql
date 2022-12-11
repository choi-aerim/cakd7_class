
-- ���̺��� Ȱ���ϴ� ���� �ƴ� �ܼ� ��길 ������ �� select ������ from dual�� �����
SELECT ABS(-78), ABS(+78)
FROM dual;

SELECT ROUND(4.875,1)
FROM dual;


SELECT * FROM orders;
-- ���� ��� �ֹ� �ݾ��� ��� ������ �ݿø��� ���� ���ϼ���.
-- round: �ݿø�
SELECT custid, ROUND(AVG(saleprice), -2)
FROM orders
GROUP BY custid;

SELECT * FROM book;
--���� ���� '�߱�'�� ���Ե� ������ '��'�� ������ �� �������, ������ ���
-- replace: �ش��ϴ� �ܾ ��ü
SELECT bookid, REPLACE(bookname, '�߱�', '��') bookname, publisher, price
FROM book;

-- length: ���ڼ�
-- lengthb: ����Ʈ��
-- ��Ī �� ��, as ����� ���� ����
SELECT bookname ����, length(bookname) ���ڼ�, lengthb(bookname) as ����Ʈ��, publisher, price
FROM book;


-- �ڼ��� ���� ���� ����
SELECT * FROM customer;
INSERT INTO customer VALUES(5, '�ڼ���', '���ѹα� ����', NULL);

--����4: customer ���̺��� ���� ���� ���� ����� �� ���̳� �Ǵ��� ���� �ο��� ���ϱ�
-- substr(���ڿ�, ������ġ, ����)
SELECT SUBSTR(name,1,1) "��", count(*) "�ο�"
FROM customer
GROUP BY SUBSTR(name,1,1);



SELECT * FROM orders;
-- �ֹ��Ϸκ��� 10�� �� ������ Ȯ���Ѵ�. �� �ֹ��� Ȯ�����ڸ� ���ϱ�
SELECT orderid, custid, bookid, saleprice, orderdate, orderdate+10 as "Ȯ������"
FROM orders;

-- ����5: 2020�� 7�� 7�Ͽ� �ֹ����� ������ �ֹ���ȣ, �ֹ���, ����ȣ, ������ȣ ��� ���
-- dy: ��, ȭ, ��..../ day: ������, ȭ����, ������...
SELECT orderid �ֹ���ȣ, TO_CHAR(orderdate,'yyyy-mm-dd day') �ֹ���, custid ����ȣ, bookid ������ȣ
FROM orders
WHERE orderdate = to_date('2020-07-07','yyyy-mm-dd');

-- ���� �ð������� �ð� ���� ����
SELECT SYSDATE FROM dual;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') SYSDATA1
FROM dual;


-- �̸�, ��ȭ��ȣ�� ���Ե� ������� ���̱�. ��, ��ȭ��ȣ�� ���� ���� '����ó ����'���� ǥ���Ͽ� ���
SELECT * FROM customer;
SELECT name "�̸�", address "�ּ�", NVL(phone, '����ó ����') "��ȭ��ȣ"
FROM customer;

-- SELECT COALESCE(NULL, NULL, 'third value', 'forth value'): ����° ���� null�� �ƴ� ù��° ���̱� ������ ����° ���� ��ȯ
SELECT NAME �̸�, phone, COALESCE(phone, '����ó ����') ��ȭ��ȣ
FROM customer;

-- SQL ��ȸ ����� ������ ��Ÿ��, �ڷḦ �Ϻκи� Ȯ���Ͽ� ó���� �� ������
SELECT ROWNUM ����, custid ����ȣ, name �̸�, phone ��ȭ��ȣ
FROM customer
WHERE ROWNUM <= 3;


SELECT * FROM orders;
-- ��� �ֹ��ݾ� ������ �ֹ��� ���ؼ� �ֹ���ȣ�� �ݾ� ���̱�
SELECT orderid, saleprice
FROM orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

-- �� ���� ��� �ֹ��ݾ׺��� ū �ݾ��� �ֹ� ������ ���� �ֹ���ȣ, ����ȣ, �ݾ� ���
SELECT orderid, custid, saleprice
FROM orders o1
WHERE saleprice > (SELECT AVG(saleprice) FROM orders o2 
                    WHERE o1.custid = o2.custid );

SELECT * FROM customer;


SELECT * FROM orders;
-- ����6: ���ѹα��� �����ϴ� ������ �Ǹ��� ������ �� �Ǹž��� ���
SELECT SUM(saleprice) "�� ���� �Ǹž�"
FROM orders
WHERE custid in (SELECT custid FROM customer WHERE address LIKE '%���ѹα�%');


-- ����7: 3�� ���� �ֹ��� ������ �ְ� �ݾ׺��� �� ��� ������ ������ �ֹ��� �ֹ���ȣ�� �ݾ� ���
SELECT orderid, saleprice
FROM orders
WHERE saleprice > (SELECT MAX(saleprice) FROM orders WHERE custid = 3);


-- ����8: ����ȣ�� 2 ������ ���� �Ǹž��� ���(��, ���̸��� ���� �Ǹž� ����)




select * from customer;
select * from orders;

-- (+): ���ʰ� �������� ��!
select c.name, sum(o.saleprice)
from orders o, customer c
where c.custid = o.custid(+)
group by c.name;

-- null�� 0���� ��ü�ϰ� �������� �����ϱ�
SELECT c.name, NVL(SUM(saleprice),0) �����Ǹž�
FROM orders o, customer c
WHERE c.custid = o.custid(+)
GROUP BY c.name
ORDER BY �����Ǹž�;

-- View�� ������ ���̺��̶�� �ϸ�, �����ʹ� ���� sql�� ����Ǿ� �ִ� object
-- View�� �⺻ ���̺��̳� �並 �����ϰ� �Ǹ� �ش� �����͸� ���ʷ� �� �ٸ� ����� �ڵ����� �����ǰ� alter ����� ����� �� ����
-- ������ �����ϱ� ���ؼ��� drop & create�� �ݺ��ؾ��ϸ�, ���� �̸����� ������ �� ����
-- �ǹ������� "vw_"���̻糪 ���λ縦 �ٿ� ����
create view vw_customer
as select *
from customer
where address like '%���ѹα�%';

select * from vw_customer;



select * from orders;
select * from book;
-- orders ���̺��� ���̸��� �����̸��� �ٷ� Ȯ���� �� �ִ� �� �����ϱ�
CREATE VIEW vw_cust_book
AS SELECT  c.name "���̸�", o.orderid "�ֹ���ȣ", b.bookname "�����̸�", o.saleprice "�ֹ���"
FROM orders o, customer c, book b
WHERE o.custid = c.custid and b.bookid = o.bookid;

-- �迬�� ���� ������ ������ �ֹ���ȣ, �����̸�, �ֹ��� ���
SELECT  * 
FROM vw_cust_book
WHERE ���̸� = '�迬��';

-- �ռ� ������ �� ����
DROP VIEW vw_cust_book;






