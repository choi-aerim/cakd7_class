SELECT * FROM employees;

-- ��, �̸� ���̱�
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name ||' is a '|| job_id FROM employees;
SELECT last_name ||' is a '|| job_id as EXPLAIN FROM employees;


SELECT DISTINCT job_id FROM employees;

-- commission_pct�� null ���� �� ����
SELECT * 
FROM employees 
WHERE commission_pct IS NULL;

-- commission_pct�� null ���� �ƴ� �� ����
SELECT * 
FROM employees 
WHERE commission_pct IS NOT NULL;

-- employee ���̺��� commission_pct null�� ������ ���
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NULL;

-- employee ���̺��� employee_id�� Ȧ���� �͸� ���
SELECT *
FROM employees
WHERE MOD(employee_id,2) = 1
ORDER BY employee_id;

-- �ݿø�
SELECT round(355.9555,2) from dual;
SELECT round(355.9555,-2) from dual;
-- ����
SELECT trunc(355.9555,1) from dual;

SELECT last_name, trunc(salary/12,1) ���� FROM employees;

--width_bucket (������, �ּҰ�, �ִ밪, bucket ����)
select width_bucket(92,0,100,10) from dual;
select width_bucket(38,0,100,50) from dual;

-- upper: �빮��
select upper('Hello World') from dual;
-- lower: �ҹ���
select lower('Hello World') from dual;

-- ����: king�� ���� ģ���� �ҷ���!
select last_name, salary 
from employees
where lower(last_name) = 'king';


-- length: ����
select job_id, length(job_id) from employees;

-- substr(���ڿ�, �����ε���, ����): Ư�� ���� �ε��� ������� ����
select substr('Hello World',3,3) from dual;
select substr('Hello World',-3,3) from dual;

-- lpad(���ڿ�, ��ü�ڸ���, ���鿡 ä�� ����)
-- rpad(���ڿ�, ��ü�ڸ���, ���鿡 ä�� ����)
select lpad('Hello World',20,'%') from dual;
select rpad('Hello World',20,'%') from dual;

-- trim: ���� ���� ����
-- ltrim(���ڿ�, �����ҹ���): ���ʿ� �����ҹ��ڸ� ����
-- rtrim(���ڿ�, �����ҹ���): �����ʿ� �����ҹ��ڸ� ����
select trim('      Hello World         ') from dual;
select ltrim('      Hello World  ') from dual;
select rtrim('      Hello World  ') from dual;

select ltrim('aaaHello Worldaaa','a') from dual;
select rtrim('aaaHello Worldaaa','a') from dual;
select last_name, trim('A' from last_name) A���� from employees;


-- sysdate: ���� ��¥ �˷���
select sysdate from dual;

-- ����: �ټӿ��� Ȯ��
select * from employees;
select last_name, trunc((sysdate - hire_date)/365,0) "�ټ� ����"
from employees;


-- ����1: employee ���̺��� ä���Ͽ� 6������ �߰��� ��¥�� last_name�� ���� ���
select last_name, hire_date, (hire_date + 30*6) "6���� �ٹ� �� DATE" 
from employees;

select last_name, hire_date, add_months(hire_date, 6) "6���� �ٹ� �� DATE" 
from employees;


-- ����2: �̹� ���� ������ ��ȯ�ϴ� �Լ��� ����Ͽ� ���� ���
select to_char(last_day(sysdate),'dd') "�̹��� ����" 
from dual;

-- ����3: employees ���̺��� ä���ϰ� ����������� �ټӿ��� ���
select last_name, trunc((sysdate - hire_date)/30,0)||'����' "�ټӰ�����"
from employees;

select last_name, trunc(months_between(sysdate, hire_date),0) "�ټӰ�����"
from employees;


-- ����4: �Ի��� 6���� �� ù��° �������� last_name ���� ���
select last_name, hire_date, add_months(hire_date, 6) "6���� �ٹ� ��" ,
        to_char(trunc(add_months(hire_date, 6),'IW')+7, 'yyyy/mm/dd day') "6���� �ٹ� �� ���ƿ��� ������" 
from employees;


-- ����5: job_id���� �����հ�, �������, �ְ���, �������� ���. ��, ��տ����� 5000�̻��� ��츸 �����Ͽ� �������� ����
select job_id, sum(salary) "�����հ�", avg(salary) "�������", max(salary) "�ְ���", min(salary) "��������"
from employees
group by job_id
having avg(salary) >= 5000
order by avg(salary) desc;


select * from employees;
select * from departments;
-- ����6: �����ȣ(employee_id)�� 110�� ����� �μ��� ���
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id and e.employee_id = 110;

select * from employees;
select * from jobs;
-- ����7: �����ȣ�� 120���� ������ ���, �̸�, ����(job_id), ������(job_tit) ���
select e.employee_id "���", e.first_name||' '||e.last_name "�̸�", e.job_id "���� ID", j.job_title "������"
from employees e, jobs j
where e.job_id = j.job_id and e.employee_id = 120;

select * from employees;
-- ����8: ���, �̸�, ������ ����ϱ�. ��, ������ �Ʒ� ���ؿ� ����
    --���, �̸�, ����, ����ϼ���. ��, ������ �Ʒ� ���ؿ� ����
    --salary > 20000 then '��ǥ�̻�'
    --salary > 15000 then '�̻�' 
    --salary > 10000 then '����' 
    --salary > 5000 then '����' 
    --salary > 3000 then '�븮'
    --������ '���'
select employee_id "���", first_name||' '||last_name "�̸�", salary "����",
       case when salary > 20000 then '��ǥ�̻�'
            when salary > 15000 then '�̻�'
            when salary > 10000 then '����'
            when salary > 5000 then '����'
            when salary > 3000 then '�븮'
            else '���' end "����"
from employees
order by decode(����, '��ǥ�̻�', 1, '�̻�', 2, '����', 3, '����', 4, '�븮', 5), ���� desc;

select * from employee_salary;
-- ����9: employees ���̺��� employee_id�� salary�� ����ؼ� employee_salary ���̺��� �����Ͽ� ���
-- **���̺� �����ϱ� ��Ű�� & ������: CREATE TABLE ���θ��� ���̺�� AS SELECT * FROM ���������̺�� [WHERE ��]
-- ** ���̺� ������ �����ϱ�: CREATE TABLE?���θ��� ���̺��?AS SELECT * FROM?���������̺��?WHERE 1=2 [where���� '��'�� �ƴ� ������ �־���]
create table employee_salary 
as select employee_id, salary 
from employees;

-- ����10: employee_salary ���̺� first_name, last_name �÷� �߰��� �� name���� �����Ͽ� ���
alter table employee_salary add name varchar2(50);
update employee_salary es
set name = (select first_name ||' '|| last_name from employees e 
            where es.employee_id = e.employee_id);


-- ����11: employee_salary ���̺� employee_id�� �⺻Ű�� �����ϰ� constraint_name�� ES_PK�� ���� �� ���
alter table employee_salary add constraint "ES_PK" primary key(employee_id);

-- ����12: employee_salary ���̺� employee_id���� constraint_name�� ���� �� ���� ���� Ȯ��
alter table employee_salary drop constraint "ES_PK";
alter table employee_salary drop primary key;