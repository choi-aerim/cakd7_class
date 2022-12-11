--lmembers
--[����_1006_1] purprd �����ͷ� ���� �Ʒ� ������ �����ϼ���.
--2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ����(��³���:����ȣ,���޻�,SUM(���űݾ�)���űݾ�)
drop table amt_14;
drop table amt_15;

create table AMT_14 as
select custno "����ȣ", asso "���޻�", sum(puramt) "�� ���ž�_2014"
from purprd
where substr(purdate,1,4) = 2014
group by custno, asso
order by custno, asso;
-- Ȯ��
select * from amt_14;

create table AMT_15 as
select custno "����ȣ", asso "���޻�", sum(puramt) "�� ���ž�_2015"
from purprd
where substr(purdate,1,4) = 2015
group by custno, asso
order by custno, asso;
-- Ȯ��
select * from amt_15;


--AMT14�� AMT15 2�� ���̺��� ����ȣ�� ���޻縦 �������� FULL OUTER JOIN �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
drop table amt_year_foj;

-- 1)���̺� ����
create table AMT_YEAR_FOJ as
select a14."����ȣ" "����ȣ_2014", a14."���޻�" "���޻�_2014", 
       a15."����ȣ" "����ȣ_2015", a15."���޻�" "���޻�_2015", 
       a14."�� ���ž�_2014", a15."�� ���ž�_2015" 
from amt_14 a14 full outer join amt_15 a15 on (a14."����ȣ" = a15."����ȣ" and a14."���޻�" = a15."���޻�");

-- 2)null�� ����
update amt_year_foj
set "����ȣ_2014" = "����ȣ_2015"
where "����ȣ_2014" is null;
update amt_year_foj
set "���޻�_2014" = "���޻�_2015"
where "���޻�_2014" is null;

update amt_year_foj
set "����ȣ_2015" = "����ȣ_2014"
where "����ȣ_2015" is null;
update amt_year_foj
set "���޻�_2015" = "���޻�_2014"
where "���޻�_2015" is null;

update amt_year_foj
set "�� ���ž�_2014" = 0 
where "�� ���ž�_2014" is null;
update amt_year_foj
set "�� ���ž�_2015" = 0 
where "�� ���ž�_2015" is null;

--2-2) null�� ����
CREATE TABLE AMT_YEAR_FOJ_3   
    AS SELECT NVL(A.CUSTNO,B.CUSTNO) CUSTNO, NVL(A.ASSO,B.ASSO) ASSO, NVL(A.PURAMT_SUM,0) AMT14, NVL(B.PURAMT_SUM,0) AMT15
    FROM AMT_14 A FULL OUTER JOIN AMT_15 B ON A.CUSTNO=B.CUSTNO AND A.ASSO=B.ASSO;
SELECT * FROM AMT_YEAR_FOJ_3;

-- Ȯ��
select *
from amt_year_foj
where "����ȣ_2014" is null or "����ȣ_2015" is null or "���޻�_2014" is null or "���޻�_2015" is null or "�� ���ž�_2014" is null or "�� ���ž�_2015" is null;


--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ���(��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)
select * from amt_year_foj;

-- 1) ���÷� ����
alter table amt_year_foj
add "���űݾ� ����" number;
-- Ȯ��
select * from amt_year_foj;


-- 2) ������ ä���
update amt_year_foj x
set "���űݾ� ����" = (select "�� ���ž�_2015" - "�� ���ž�_2014" 
                     from amt_year_foj y
                     where x."����ȣ_2014" = y."����ȣ_2014" and x."���޻�_2014" = y."���޻�_2014");
                     
select count(*) from demo;