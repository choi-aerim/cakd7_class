-- ���� ���� �� Ȯ��
create table MINUS_CUSTNO as 
select p.*, c.�ݾ�����
from MERGE_PURPRD p full outer join CUSTNO_PURAMT_COMPARED c 
    on p.custno = c.custno
where c.���ҿ��� = 1;
--Ȯ��
select * from MINUS_CUSTNO; 
select count(distinct custno) from MINUS_CUSTNO; 

-- ���� ���� �� Ȯ��
create table PLUS_CUSTNO as
select p.*, c.�ݾ����� 
from MERGE_PURPRD p full outer join CUSTNO_PURAMT_COMPARED c 
    on p.custno = c.custno
where c.���ҿ��� = 0;
--Ȯ��
select * from PLUS_CUSTNO; 
select count(distinct custno) from PLUS_CUSTNO; 
