------------------------employees 테이블 혼자 탐색-------------------------
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

-- 필요한 컬럼만 뽑아서 뷰생성
create view vw_temp_employees
as select e.employee_id, e.last_name, e.hire_date, e.salary, j.job_title, d.department_name
from jobs j, employees e, departments d
where j.job_id =e.job_id and e.department_id = d.department_id;

-- 확인 
select * from vw_temp_employees;

-- 부서별 봉급 계산
select department_name "부서이름", count(*) "인원", trunc(avg(salary),0) "평균 월급"
from vw_temp_employees
group by department_name;



-- 직급을 포함한 뷰 생성
    --salary > 20000 then '대표이사'
    --salary > 15000 then '이사' 
    --salary > 10000 then '부장' 
    --salary > 5000 then '과장' 
    --salary > 3000 then '대리'
    --나머지 '사원'
create view vw_temp_employees_salary as
select employee_id, last_name, hire_date, salary, job_title, department_name,
       case when salary > 20000 then '대표이사'
            when salary > 15000 then '이사'
            when salary > 10000 then '부장'
            when salary > 5000 then '과장'
            when salary > 3000 then '대리'
            else '사원' end  "직급"
from vw_temp_employees;

-- 확인
select * from vw_temp_employees_salary;

-- 직급별 평균 월급 확인
select 직급, count(*) "인원", trunc(avg(salary),0) "평균월급" 
from vw_temp_employees_salary
group by 직급;




-- 부서/직급별 평균월급 확인
select department_name "부서", 직급, count(*) "인원", trunc(avg(salary),0) "평균월급" 
from vw_temp_employees_salary
group by department_name, 직급
order by 부서, decode(직급, '대표이사',1,'이사',2,'부장',3,'과장',4,'대리',5);

---------------------------------------------------------------------------------------

-- HR employee 테이블에서 이름, 연봉, 10% 인상된 연봉 출력
select first_name||' '||last_name 이름, salary 연봉, salary*1.1 "10% 인상된 연봉"
from employees;

-- HR employees 테이블에서 commission_pct null값의 개수 출력
select *
from employees
where commission_pct is null;


-- 과제 2: hr 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블 2개 이상 작성하기(예: 부서별 평균 salary, 순위)
-- 기본 임시 테이블 생성(사번, 이름, 근속연수, 월급, 부서, 직무, 직급)
drop table employees_temp;

create table employees_temp as
select e.employee_id "ID", 
       e.first_name||' '||e.last_name as "NAME", 
       trunc(months_between(sysdate, e.hire_date)/12,0) as "HIRED_YEARS", 
       e.salary "SALARY", 
       d.department_name "DEPART_TITLE",
       j.job_title "JOB_TITLE",
       case when e.salary > 20000 then '대표이사'
            when e.salary > 15000 then '이사'
            when e.salary > 10000 then '부장'
            when e.salary > 5000 then '과장'
            when e.salary > 3000 then '대리'
            else '사원' end as "POSITION"  
from employees e, jobs j, departments d
where e.department_id = d.department_id and e.job_id = j.job_id ;
--확인
select * from employees_temp;


select depart_title "부서", position "직급", count(*) "인원", trunc(avg(salary),0) "평균 월급", trunc(avg(hired_years),0) "평균 근속연수"  
from employees_temp
group by depart_title, position 
order by "평균 월급" desc;




