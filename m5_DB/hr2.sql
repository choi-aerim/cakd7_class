------------------------employees ���̺� ȥ�� Ž��-------------------------
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM employee_salary;
SELECT * FROM job_history;
SELECT * FROM jobs;
SELECT * FROM locations;
SELECT * FROM regions;

SELECT * FROM jobs;
SELECT * FROM departments;
SELECT * FROM employees;

drop view vw_temp_employees;

-- �ʿ��� �÷��� �̾Ƽ� �����
create view vw_temp_employees
as select e.employee_id, e.last_name, e.hire_date, e.salary, j.job_title, d.department_name
from jobs j, employees e, departments d
where j.job_id =e.job_id and e.department_id = d.department_id;

-- Ȯ�� 
select * from vw_temp_employees;

-- �μ��� ���� ���
select department_name "�μ��̸�", count(*) "�ο�", trunc(avg(salary),0) "��� ����"
from vw_temp_employees
group by department_name;



-- ������ ������ �� ����
    --salary > 20000 then '��ǥ�̻�'
    --salary > 15000 then '�̻�' 
    --salary > 10000 then '����' 
    --salary > 5000 then '����' 
    --salary > 3000 then '�븮'
    --������ '���'
create view vw_temp_employees_salary as
select employee_id, last_name, hire_date, salary, job_title, department_name,
       case when salary > 20000 then '��ǥ�̻�'
            when salary > 15000 then '�̻�'
            when salary > 10000 then '����'
            when salary > 5000 then '����'
            when salary > 3000 then '�븮'
            else '���' end  "����"
from vw_temp_employees;

-- Ȯ��
select * from vw_temp_employees_salary;

-- ���޺� ��� ���� Ȯ��
select ����, count(*) "�ο�", trunc(avg(salary),0) "��տ���" 
from vw_temp_employees_salary
group by ����;




-- �μ�/���޺� ��տ��� Ȯ��
select department_name "�μ�", ����, count(*) "�ο�", trunc(avg(salary),0) "��տ���" 
from vw_temp_employees_salary
group by department_name, ����
order by �μ�, decode(����, '��ǥ�̻�',1,'�̻�',2,'����',3,'����',4,'�븮',5);

---------------------------------------------------------------------------------------

-- HR employee ���̺��� �̸�, ����, 10% �λ�� ���� ���
select first_name||' '||last_name �̸�, salary ����, salary*1.1 "10% �λ�� ����"
from employees;

-- HR employees ���̺��� commission_pct null���� ���� ���
select *
from employees
where commission_pct is null;


-- ���� 2: hr ���̺���� �м��ؼ� ��ü ��Ȳ�� ������ �� �ִ� ��� ���̺� 2�� �̻� �ۼ��ϱ�(��: �μ��� ��� salary, ����)
-- �⺻ �ӽ� ���̺� ����(���, �̸�, �ټӿ���, ����, �μ�, ����, ����)
drop table employees_temp;

create table employees_temp as
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
select * from employees_temp;


select depart_title "�μ�", position "����", count(*) "�ο�", trunc(avg(salary),0) "��� ����", trunc(avg(hired_years),0) "��� �ټӿ���"  
from employees_temp
group by depart_title, position 
order by "��� ����" desc;




