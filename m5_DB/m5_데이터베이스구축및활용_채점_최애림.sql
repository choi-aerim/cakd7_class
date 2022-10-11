������ ��� AI ���� �ַ�� ������ ��������

������� : �����ͺ��̽� ���� �� Ȱ��

- ���� : 22.10.07
- ���� : �־ָ�
- ���� : 90


�� HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)�� Ȱ���Ͽ� ���� �������� �����ϼ���.

select * from employees;
--Q1. HR EMPLOYEES ���̺��� �̸�, ����, 10% �λ�� ������ ����ϼ���.
--A. 
select employee_id "ID", first_name||' '||last_name "NAME", salary, salary * 1.1 "10% �λ�� SALARY"
from employees
order by employee_id;


select * from employees;    
--Q2.  2005�� ��ݱ⿡ �Ի��� ����鸸 ���	
--A.        
select *
from employees
where substr(hire_date,1,2) = 05 and substr(hire_date,4,2) < 7;


select * from employees;    
--Q3. ���� SA_MAN, IT_PROG, ST_MAN �� ����� ���
--A.
select *
from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');


select * from employees;       
--Q4. manager_id �� 101���� 103�� ����� ���
--A.   	
select * 
from employees
where manager_id in (101,102,103);


select * from employees;       
--Q5. EMPLOYEES ���̺��� LAST_NAME, HIRE_DATE �� �Ի����� 6���� �� ù ��° �������� ����ϼ���.
--A.
select last_name, hire_date, to_char(trunc(add_months(hire_date,6), 'IW') + 7, 'yy/mm/dd day') "�Ի� 6���� �� ù��° ������"
from employees;


select * from employees;       
--Q6. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �����ϱ����� W_MONTH(�ټӿ���)�� ������ ����ؼ� ����ϼ���.(�ټӿ��� ���� ��������)
--A.
select employee_id, last_name, salary, hire_date, trunc(months_between(sysdate, hire_date),0) "�ټӿ���"
from employees
order by "�ټӿ���" desc;


--Q7. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� W_YEAR(�ټӳ��)�� ����ؼ� ����ϼ���.(�ټӳ�� ���� ��������)
--A.
select employee_id, last_name, salary, hire_date, 
       trunc(months_between(sysdate, hire_date),0) "�ټӿ���", 
       trunc(months_between(sysdate, hire_date)/12,0) "�ټӳ��"
from employees
order by "�ټӳ��" desc;


--Q8. EMPLOYEE_ID�� Ȧ���� ������ EMPLPYEE_ID�� LAST_NAME�� ����ϼ���.
--A. 
select employee_id, last_name
from employees
where mod(employee_id,2) = 1
order by employee_id;


--Q9. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME �� M_SALARY(����)�� ����ϼ���. �� ������ �Ҽ��� ��°�ڸ������� ǥ���ϼ���.
--A
select employee_id, last_name, salary, round(salary/12,2) "M_SALARY" 
from employees
order by m_salary desc;


--Q10. EMPLOYEES ���̺��� EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE �� �Ի��� �������� �ټӳ���� ����ؼ� �Ʒ������� �߰��� �Ŀ� ����ϼ���.
--2001�� 1�� 1�� â���Ͽ� ������� 20�Ⱓ ��ǿ� ȸ��� ������  �ټӳ���� ���� 30 ������� ������  ��޿� ���� 1000���� BONUS�� ����.
--�������� ����.    
--A.
--1) �� ����
select employee_id, last_name, salary, hire_date, 
       trunc(months_between(sysdate, hire_date)/12,0) "�ټӳ��"
       (width_bucket(trunc((to_date('20/12/31')- hire_date)/365)0,20,30)) wb,
       (width_bucket(trunc((to_date('20/12/31')- hire_date)/365)0,20,30))*1000 bonus

from employees;

-- 2) ��� ������



--Q11. EMPLOYEES ���̺��� commission_pct ��  Null�� ������  ����ϼ���.
--A.
select count(*)
from employees
where commission_pct is null;


--Q12. EMPLOYEES ���̺��� deparment_id �� ���� ������ �����Ͽ�  POSITION�� '����'���� ����ϼ���.
--A.
select e.*, 
       case when e.department_id is null then '����'
       else '���� ���' end "POSITION"
from employees e
where department_id is null;


--Q13. ����� 120���� ����� ���, �̸�, ����(job_id), ������(job_title)�� ���(join~on, where �� �����ϴ� �� ���� ��� ���)
--A.
-- ���1
select e.employee_id, e.first_name||' '||e.last_name "name", j.job_id, j.job_title
from employees e full outer join jobs j on e.job_id = j.job_id 
where e.employee_id = 120;

-- ���2
select e.employee_id, e.first_name||' '||e.last_name "name", j.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id and e.employee_id = 120;


--Q14.  employees ���̺��� �̸��� FIRST_NAME�� LAST_NAME�� �ٿ��� 'NAME' �÷������� ����ϼ���.
--��) Steven King
--A. 
select e.*, e.first_name||' '||e.last_name "NAME"
from employees e;

select * from purprd;
--Q15. lmembers purprod ���̺�� ���� �ѱ��ž�, 2014 ���ž�, 2015 ���ž��� �ѹ��� ����ϼ���.
--A. �ٽ��̤ӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤ�
select (select sum(p1.puramt) from purprd p1) "�� ���ž�",
       (select sum(p2.puramt) from purprd p2 where substr(purdate, 1, 4) = 2014) "2014 ���ž�",
       (select sum(p3.puramt) from purprd p3 where substr(purdate, 1, 4) = 2015) "2015 ���ž�"
from dual;

select * from employees;
--Q16. HR EMPLOYEES ���̺��� escape �ɼ��� ����Ͽ� �Ʒ��� ���� ��µǴ� SQL���� �ۼ��ϼ���.
--job_id Į������  _�� ���ϵ�ī�尡 �ƴ� ���ڷ� ����Ͽ� '_A'�� �����ϴ�  ��� ���� ���
--A. �ٽ��̤ӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤӤ�
select *
from employees
where job_id like '%\_A%' escape '\';

--Q17. HR EMPLOYEES ���̺��� SALARY, LAST_NAME ������ �ø����� �����Ͽ� ����ϼ���.
--A. 
select *
from employees
order by salary, last_name;

   
--Q18. Seo��� ����� �μ����� ����ϼ���.
--A.
select e.last_name,d.department_name
from employees e, departments d
where e.department_id = d.department_id and last_name = 'Seo';


select * from purprd;
--Q19. LMEMBERS �����Ϳ��� ���� ���űݾ��� �հ踦 ���� CUSPUR ���̺��� ������ �� CUSTDEMO ���̺�� 
--����ȣ�� �������� �����Ͽ� ����ϼ���.
--A.
-- 1) cuspur ���̺� ����
create table CUSPUR as
select custno, sum(puramt) SUM_PURAMT
from purprd
group by custno
order by custno;

-- 2) demo ���̺�� ����
select c.custno, d.gender, d.age, d.area, c.sum_puramt
from cuspur c, demo d
where c.custno = d.custno
order by c.custno;


--Q20.PURPROD ���̺�� ���� �Ʒ� ������ �����ϼ���.
--A.
-- 2�Ⱓ ���űݾ��� ���� ������ �и��Ͽ� ����, ���޻纰�� ���ž��� ǥ���ϴ� AMT_14, AMT_15 ���̺� 2���� ���� (��³��� : ����ȣ, ���޻�, SUM(���űݾ�) ���űݾ�)
drop table amt_14_2;
drop table amt_15_2;
drop table amt_year_foj_2;

-- 1-1) amt_14����
create table AMT_14_2 as
select custno "CUSTNO_2014", asso "ASSO_2014", sum(puramt) "�� ���ž�_2014"
from purprd
where substr(purdate,1,4) = 2014
group by custno, asso
order by custno, asso;
--Ȯ��
select * from AMT_14_2;

-- 1-2) amt_15 ����
create table AMT_15_2 as
select custno "CUSTNO_2015", asso "ASSO_2015", sum(puramt) "�� ���ž�_2015"
from purprd
where substr(purdate,1,4) = 2015
group by custno, asso
order by custno, asso;
--Ȯ��
select * from AMT_15_2;

--AMT14�� AMT15 2�� ���̺��� ����ȣ�� ���޻縦 �������� FULL OUTER JOIN �����Ͽ� ������ AMT_YEAR_FOJ ���̺� ����
create table AMT_YEAR_FOJ_2 as
select * 
from amt_14_2 a14 full outer join amt_15_2 a15 on (a14."CUSTNO_2014" = a15."CUSTNO_2015" and a14."ASSO_2014" = a15."ASSO_2015");

select * from AMT_YEAR_FOJ_2;
-- 2-1) null�� ����_���ž�
update amt_year_foj_2
set "�� ���ž�_2014" = 0
where "�� ���ž�_2014" is null;

update amt_year_foj_2
set "�� ���ž�_2015" = 0
where "�� ���ž�_2015" is null;

-- 2-2) null�� ����_����ȣ
update amt_year_foj_2
set custno_2014 = custno_2015
where custno_2014 is null;

update amt_year_foj_2
set custno_2015 = custno_2014
where custno_2015 is null;

-- 2-3) null�� ����_���޻�
update amt_year_foj_2
set asso_2014 = asso_2015
where asso_2014 is null;

update amt_year_foj_2
set asso_2015 = asso_2014
where asso_2015 is null;

-- Ȯ��
select *
from amt_year_foj_2
where custno_2014 is null or custno_2015 is null or asso_2014 is null or asso_2015 is null; 




--14��� 15���� ���űݾ� ���̸� ǥ���ϴ� ���� �÷��� �߰��Ͽ� ���(��, ����ȣ, ���޻纰�� ���űݾ� �� ������ ���еǾ�� ��)
-- 1) ���� �� �÷� ����
alter table amt_year_foj_2 
add "���� ������" number;

-- 2) ���
update amt_year_foj_2 x
set "���� ������"  = (select "�� ���ž�_2014" - "�� ���ž�_2015"
                     from amt_year_foj_2 y
                     where x.custno_2014 = y.custno_2014 and x.asso_2014 = y.asso_2014);

--Ȯ��
select * from amt_year_foj_2;




--Q(BONUS). HR ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺��� �ۼ��ϼ���. (�� : �μ��� ��� SALARY ����)
--A.
create table employees_temp_2 as
select e.employee_id "ID", 
       e.first_name||' '||e.last_name as "NAME", 
       trunc(months_between(sysdate, e.hire_date)/12,0) as "HIRED_YEARS", 
       e.salary "SALARY", 
       d.department_name "DEPART_TITLE",
       j.job_title "JOB_TITLE",
       case when e.salary > 20000 then '��ǥ�̻�'
            when e.salary > 15000 then '�̻�'
            when e.salary > 10000 then '����'
            when e.salary > 5000 then '����'
            when e.salary > 3000 then '�븮'
            else '���' end as "POSITION"  
from employees e, jobs j, departments d
where e.department_id = d.department_id and e.job_id = j.job_id ;
--Ȯ��
select * from employees_temp_2;


select depart_title "�μ�", position "����", count(*) "�ο�", trunc(avg(salary),0) "��� ����", trunc(avg(hired_years),0) "��� �ټӿ���"  
from employees_temp_2
group by depart_title, position 
order by "��� ����" desc;
