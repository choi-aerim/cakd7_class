SELECT * FROM employees;

-- 성, 이름 붙이기
SELECT last_name, 'is a', job_id FROM employees;
SELECT last_name ||' is a '|| job_id FROM employees;
SELECT last_name ||' is a '|| job_id as EXPLAIN FROM employees;


SELECT DISTINCT job_id FROM employees;

-- commission_pct가 null 값인 행 추출
SELECT * 
FROM employees 
WHERE commission_pct IS NULL;

-- commission_pct가 null 값이 아닌 행 추출
SELECT * 
FROM employees 
WHERE commission_pct IS NOT NULL;

-- employee 테이블에서 commission_pct null값 개수를 출력
SELECT COUNT(*)
FROM employees
WHERE commission_pct IS NULL;

-- employee 테이블에서 employee_id가 홀수인 것만 출력
SELECT *
FROM employees
WHERE MOD(employee_id,2) = 1
ORDER BY employee_id;

-- 반올림
SELECT round(355.9555,2) from dual;
SELECT round(355.9555,-2) from dual;
-- 내림
SELECT trunc(355.9555,1) from dual;

SELECT last_name, trunc(salary/12,1) 월급 FROM employees;

--width_bucket (지정값, 최소값, 최대값, bucket 개수)
select width_bucket(92,0,100,10) from dual;
select width_bucket(38,0,100,50) from dual;

-- upper: 대문자
select upper('Hello World') from dual;
-- lower: 소문자
select lower('Hello World') from dual;

-- 예제: king이 성인 친구들 불러왓!
select last_name, salary 
from employees
where lower(last_name) = 'king';


-- length: 길이
select job_id, length(job_id) from employees;

-- substr(문자열, 시작인덱스, 길이): 특정 문자 인덱싱 방법으로 추출
select substr('Hello World',3,3) from dual;
select substr('Hello World',-3,3) from dual;

-- lpad(문자열, 전체자릿수, 공백에 채울 문자)
-- rpad(문자열, 전체자릿수, 공백에 채울 문자)
select lpad('Hello World',20,'%') from dual;
select rpad('Hello World',20,'%') from dual;

-- trim: 양쪽 공백 제거
-- ltrim(문자열, 제거할문자): 왼쪽에 제거할문자를 제거
-- rtrim(문자열, 제거할문자): 오른쪽에 제거할문자를 제거
select trim('      Hello World         ') from dual;
select ltrim('      Hello World  ') from dual;
select rtrim('      Hello World  ') from dual;

select ltrim('aaaHello Worldaaa','a') from dual;
select rtrim('aaaHello Worldaaa','a') from dual;
select last_name, trim('A' from last_name) A삭제 from employees;


-- sysdate: 현재 날짜 알려줌
select sysdate from dual;

-- 예제: 근속연수 확인
select * from employees;
select last_name, trunc((sysdate - hire_date)/365,0) "근속 연수"
from employees;


-- 과제1: employee 테이블에서 채용일에 6개월을 추가한 날짜를 last_name과 같이 출력
select last_name, hire_date, (hire_date + 30*6) "6개월 근무 후 DATE" 
from employees;

select last_name, hire_date, add_months(hire_date, 6) "6개월 근무 후 DATE" 
from employees;


-- 과제2: 이번 달의 말일을 반환하는 함수를 사용하여 말일 출력
select to_char(last_day(sysdate),'dd') "이번달 말일" 
from dual;

-- 과제3: employees 테이블에서 채용일과 현재시점간의 근속월수 출력
select last_name, trunc((sysdate - hire_date)/30,0)||'개월' "근속개월수"
from employees;

select last_name, trunc(months_between(sysdate, hire_date),0) "근속개월수"
from employees;


-- 과제4: 입사일 6개월 후 첫번째 월요일을 last_name 별로 출력
select last_name, hire_date, add_months(hire_date, 6) "6개월 근무 후" ,
        to_char(trunc(add_months(hire_date, 6),'IW')+7, 'yyyy/mm/dd day') "6개월 근무 후 돌아오는 월요일" 
from employees;


-- 과제5: job_id별로 연봉합계, 연봉평균, 최고연봉, 최저연봉 출력. 단, 평균연봉이 5000이상인 경우만 포함하여 내림차순 정렬
select job_id, sum(salary) "연봉합계", avg(salary) "연봉평균", max(salary) "최고연봉", min(salary) "최저연봉"
from employees
group by job_id
having avg(salary) >= 5000
order by avg(salary) desc;


select * from employees;
select * from departments;
-- 과제6: 사원번호(employee_id)가 110인 사람의 부서명 출력
select e.employee_id, e.last_name, d.department_name
from employees e, departments d
where e.department_id = d.department_id and e.employee_id = 110;

select * from employees;
select * from jobs;
-- 과제7: 사원번호가 120번인 직원의 사번, 이름, 업무(job_id), 업무명(job_tit) 출력
select e.employee_id "사번", e.first_name||' '||e.last_name "이름", e.job_id "업무 ID", j.job_title "업무명"
from employees e, jobs j
where e.job_id = j.job_id and e.employee_id = 120;

select * from employees;
-- 과제8: 사번, 이름, 직급을 출력하기. 단, 직급은 아래 기준에 의함
    --사번, 이름, 직급, 출력하세요. 단, 직급은 아래 기준에 의함
    --salary > 20000 then '대표이사'
    --salary > 15000 then '이사' 
    --salary > 10000 then '부장' 
    --salary > 5000 then '과장' 
    --salary > 3000 then '대리'
    --나머지 '사원'
select employee_id "사번", first_name||' '||last_name "이름", salary "월급",
       case when salary > 20000 then '대표이사'
            when salary > 15000 then '이사'
            when salary > 10000 then '부장'
            when salary > 5000 then '과장'
            when salary > 3000 then '대리'
            else '사원' end "직급"
from employees
order by decode(직급, '대표이사', 1, '이사', 2, '부장', 3, '과장', 4, '대리', 5), 월급 desc;

select * from employee_salary;
-- 과제9: employees 테이블에서 employee_id와 salary만 출력해서 employee_salary 테이블을 생성하여 출력
-- **테이블 복사하기 스키마 & 데이터: CREATE TABLE 새로만들 테이블명 AS SELECT * FROM 복사할테이블명 [WHERE 절]
-- ** 테이블 구조만 복사하기: CREATE TABLE?새로만들 테이블명?AS SELECT * FROM?복사할테이블명?WHERE 1=2 [where절에 '참'이 아닌 조건을 넣어줌]
create table employee_salary 
as select employee_id, salary 
from employees;

-- 과제10: employee_salary 테이블에 first_name, last_name 컬럼 추가한 후 name으로 변경하여 출력
alter table employee_salary add name varchar2(50);
update employee_salary es
set name = (select first_name ||' '|| last_name from employees e 
            where es.employee_id = e.employee_id);


-- 과제11: employee_salary 테이블에 employee_id에 기본키를 적용하고 constraint_name을 ES_PK로 지정 후 출력
alter table employee_salary add constraint "ES_PK" primary key(employee_id);

-- 과제12: employee_salary 테이블에 employee_id에서 constraint_name을 삭제 후 삭제 여부 확인
alter table employee_salary drop constraint "ES_PK";
alter table employee_salary drop primary key;