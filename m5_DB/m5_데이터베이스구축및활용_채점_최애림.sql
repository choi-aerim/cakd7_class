빅데이터 기반 AI 응용 솔루션 개발자 전문과정

교과목명 : 데이터베이스 구축 및 활용

- 평가일 : 22.10.07
- 성명 : 최애림
- 점수 : 90


※ HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)를 활용하여 다음 질문들을 수행하세요.

select * from employees;
--Q1. HR EMPLOYEES 테이블에서 이름, 연봉, 10% 인상된 연봉을 출력하세요.
--A. 
select employee_id "ID", first_name||' '||last_name "NAME", salary, salary * 1.1 "10% 인상된 SALARY"
from employees
order by employee_id;


select * from employees;    
--Q2.  2005년 상반기에 입사한 사람들만 출력	
--A.        
select *
from employees
where substr(hire_date,1,2) = 05 and substr(hire_date,4,2) < 7;


select * from employees;    
--Q3. 업무 SA_MAN, IT_PROG, ST_MAN 인 사람만 출력
--A.
select *
from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');


select * from employees;       
--Q4. manager_id 가 101에서 103인 사람만 출력
--A.   	
select * 
from employees
where manager_id in (101,102,103);


select * from employees;       
--Q5. EMPLOYEES 테이블에서 LAST_NAME, HIRE_DATE 및 입사일의 6개월 후 첫 번째 월요일을 출력하세요.
--A.
select last_name, hire_date, to_char(trunc(add_months(hire_date,6), 'IW') + 7, 'yy/mm/dd day') "입사 6개월 후 첫번째 월요일"
from employees;


select * from employees;       
--Q6. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 현재일까지의 W_MONTH(근속월수)를 정수로 계산해서 출력하세요.(근속월수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date, trunc(months_between(sysdate, hire_date),0) "근속월수"
from employees
order by "근속월수" desc;


--Q7. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 W_YEAR(근속년수)를 계산해서 출력하세요.(근속년수 기준 내림차순)
--A.
select employee_id, last_name, salary, hire_date, 
       trunc(months_between(sysdate, hire_date),0) "근속월수", 
       trunc(months_between(sysdate, hire_date)/12,0) "근속년수"
from employees
order by "근속년수" desc;


--Q8. EMPLOYEE_ID가 홀수인 직원의 EMPLPYEE_ID와 LAST_NAME을 출력하세요.
--A. 
select employee_id, last_name
from employees
where mod(employee_id,2) = 1
order by employee_id;


--Q9. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME 및 M_SALARY(월급)을 출력하세요. 단 월급은 소수점 둘째자리까지만 표현하세요.
--A
select employee_id, last_name, salary, round(salary/12,2) "M_SALARY" 
from employees
order by m_salary desc;


--Q10. EMPLOYEES 테이블에서 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 및 입사일 기준으로 근속년수를 계산해서 아래사항을 추가한 후에 출력하세요.
--2001년 1월 1일 창업하여 현재까지 20년간 운영되온 회사는 직원의  근속년수에 따라 30 등급으로 나누어  등급에 따라 1000원의 BONUS를 지급.
--내림차순 정렬.    
--A.
--1) 뷰 생성
select employee_id, last_name, salary, hire_date, 
       trunc(months_between(sysdate, hire_date)/12,0) "근속년수"
       (width_bucket(trunc((to_date('20/12/31')- hire_date)/365)0,20,30)) wb,
       (width_bucket(trunc((to_date('20/12/31')- hire_date)/365)0,20,30))*1000 bonus

from employees;

-- 2) 등급 나누기



--Q11. EMPLOYEES 테이블에서 commission_pct 의  Null값 갯수를  출력하세요.
--A.
select count(*)
from employees
where commission_pct is null;


--Q12. EMPLOYEES 테이블에서 deparment_id 가 없는 직원을 추출하여  POSITION을 '신입'으로 출력하세요.
--A.
select e.*, 
       case when e.department_id is null then '신입'
       else '기존 사원' end "POSITION"
from employees e
where department_id is null;


--Q13. 사번이 120번인 사람의 사번, 이름, 업무(job_id), 업무명(job_title)을 출력(join~on, where 로 조인하는 두 가지 방법 모두)
--A.
-- 방법1
select e.employee_id, e.first_name||' '||e.last_name "name", j.job_id, j.job_title
from employees e full outer join jobs j on e.job_id = j.job_id 
where e.employee_id = 120;

-- 방법2
select e.employee_id, e.first_name||' '||e.last_name "name", j.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id and e.employee_id = 120;


--Q14.  employees 테이블에서 이름에 FIRST_NAME에 LAST_NAME을 붙여서 'NAME' 컬럼명으로 출력하세요.
--예) Steven King
--A. 
select e.*, e.first_name||' '||e.last_name "NAME"
from employees e;

select * from purprd;
--Q15. lmembers purprod 테이블로 부터 총구매액, 2014 구매액, 2015 구매액을 한번에 출력하세요.
--A. 다쉬이ㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣ
select (select sum(p1.puramt) from purprd p1) "총 구매액",
       (select sum(p2.puramt) from purprd p2 where substr(purdate, 1, 4) = 2014) "2014 구매액",
       (select sum(p3.puramt) from purprd p3 where substr(purdate, 1, 4) = 2015) "2015 구매액"
from dual;

select * from employees;
--Q16. HR EMPLOYEES 테이블에서 escape 옵션을 사용하여 아래와 같이 출력되는 SQL문을 작성하세요.
--job_id 칼럼에서  _을 와일드카드가 아닌 문자로 취급하여 '_A'를 포함하는  모든 행을 출력
--A. 다쉬이ㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣㅣ
select *
from employees
where job_id like '%\_A%' escape '\';

--Q17. HR EMPLOYEES 테이블에서 SALARY, LAST_NAME 순으로 올림차순 정렬하여 출력하세요.
--A. 
select *
from employees
order by salary, last_name;

   
--Q18. Seo라는 사람의 부서명을 출력하세요.
--A.
select e.last_name,d.department_name
from employees e, departments d
where e.department_id = d.department_id and last_name = 'Seo';


select * from purprd;
--Q19. LMEMBERS 데이터에서 고객별 구매금액의 합계를 구한 CUSPUR 테이블을 생성한 후 CUSTDEMO 테이블과 
--고객번호를 기준으로 결합하여 출력하세요.
--A.
-- 1) cuspur 테이블 생성
create table CUSPUR as
select custno, sum(puramt) SUM_PURAMT
from purprd
group by custno
order by custno;

-- 2) demo 테이블과 결합
select c.custno, d.gender, d.age, d.area, c.sum_puramt
from cuspur c, demo d
where c.custno = d.custno
order by c.custno;


--Q20.PURPROD 테이블로 부터 아래 사항을 수행하세요.
--A.
-- 2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성 (출력내용 : 고객번호, 제휴사, SUM(구매금액) 구매금액)
drop table amt_14_2;
drop table amt_15_2;
drop table amt_year_foj_2;

-- 1-1) amt_14생성
create table AMT_14_2 as
select custno "CUSTNO_2014", asso "ASSO_2014", sum(puramt) "총 구매액_2014"
from purprd
where substr(purdate,1,4) = 2014
group by custno, asso
order by custno, asso;
--확인
select * from AMT_14_2;

-- 1-2) amt_15 생성
create table AMT_15_2 as
select custno "CUSTNO_2015", asso "ASSO_2015", sum(puramt) "총 구매액_2015"
from purprd
where substr(purdate,1,4) = 2015
group by custno, asso
order by custno, asso;
--확인
select * from AMT_15_2;

--AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
create table AMT_YEAR_FOJ_2 as
select * 
from amt_14_2 a14 full outer join amt_15_2 a15 on (a14."CUSTNO_2014" = a15."CUSTNO_2015" and a14."ASSO_2014" = a15."ASSO_2015");

select * from AMT_YEAR_FOJ_2;
-- 2-1) null값 제거_구매액
update amt_year_foj_2
set "총 구매액_2014" = 0
where "총 구매액_2014" is null;

update amt_year_foj_2
set "총 구매액_2015" = 0
where "총 구매액_2015" is null;

-- 2-2) null값 제거_고객번호
update amt_year_foj_2
set custno_2014 = custno_2015
where custno_2014 is null;

update amt_year_foj_2
set custno_2015 = custno_2014
where custno_2015 is null;

-- 2-3) null값 제거_제휴사
update amt_year_foj_2
set asso_2014 = asso_2015
where asso_2014 is null;

update amt_year_foj_2
set asso_2015 = asso_2014
where asso_2015 is null;

-- 확인
select *
from amt_year_foj_2
where custno_2014 is null or custno_2015 is null or asso_2014 is null or asso_2015 is null; 




--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
-- 1) 증감 빈 컬럼 생성
alter table amt_year_foj_2 
add "구매 증감액" number;

-- 2) 계산
update amt_year_foj_2 x
set "구매 증감액"  = (select "총 구매액_2014" - "총 구매액_2015"
                     from amt_year_foj_2 y
                     where x.custno_2014 = y.custno_2014 and x.asso_2014 = y.asso_2014);

--확인
select * from amt_year_foj_2;




--Q(BONUS). HR 테이블들을 분석해서 전체 현황을 설명할 수 있는 요약 테이블을 작성하세요. (예 : 부서별 평균 SALARY 순위)
--A.
create table employees_temp_2 as
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
select * from employees_temp_2;


select depart_title "부서", position "직급", count(*) "인원", trunc(avg(salary),0) "평균 월급", trunc(avg(hired_years),0) "평균 근속연수"  
from employees_temp_2
group by depart_title, position 
order by "평균 월급" desc;
