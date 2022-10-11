-- 구매 감소 고객 확인
create table MINUS_CUSTNO as 
select p.*, c.금액차이
from MERGE_PURPRD p full outer join CUSTNO_PURAMT_COMPARED c 
    on p.custno = c.custno
where c.감소여부 = 1;
--확인
select * from MINUS_CUSTNO; 
select count(distinct custno) from MINUS_CUSTNO; 

-- 구매 증가 고객 확인
create table PLUS_CUSTNO as
select p.*, c.금액차이 
from MERGE_PURPRD p full outer join CUSTNO_PURAMT_COMPARED c 
    on p.custno = c.custno
where c.감소여부 = 0;
--확인
select * from PLUS_CUSTNO; 
select count(distinct custno) from PLUS_CUSTNO; 
