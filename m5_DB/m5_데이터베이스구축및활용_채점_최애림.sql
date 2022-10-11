昨汽戚斗 奄鋼 AI 誓遂 車欠芝 鯵降切 穿庚引舛

嘘引鯉誤 : 汽戚斗今戚什 姥逐 貢 醗遂

- 汝亜析 : 22.10.07
- 失誤 : 置蕉顕
- 繊呪 : 90


『 HR TABLES(EMPLOYEES, DEPARTMENTS, COUNTRIES, JOB_HISSTORY, JOBS, LOCATIONS, REGIONS)研 醗遂馬食 陥製 霜庚級聖 呪楳馬室推.

select * from employees;
--Q1. HR EMPLOYEES 砺戚鷺拭辞 戚硯, 尻裟, 10% 昔雌吉 尻裟聖 窒径馬室推.
--A. 
select employee_id "ID", first_name||' '||last_name "NAME", salary, salary * 1.1 "10% 昔雌吉 SALARY"
from employees
order by employee_id;


select * from employees;    
--Q2.  2005鰍 雌鋼奄拭 脊紫廃 紫寓級幻 窒径	
--A.        
select *
from employees
where substr(hire_date,1,2) = 05 and substr(hire_date,4,2) < 7;


select * from employees;    
--Q3. 穣巷 SA_MAN, IT_PROG, ST_MAN 昔 紫寓幻 窒径
--A.
select *
from employees
where job_id in ('SA_MAN', 'IT_PROG', 'ST_MAN');


select * from employees;       
--Q4. manager_id 亜 101拭辞 103昔 紫寓幻 窒径
--A.   	
select * 
from employees
where manager_id in (101,102,103);


select * from employees;       
--Q5. EMPLOYEES 砺戚鷺拭辞 LAST_NAME, HIRE_DATE 貢 脊紫析税 6鯵杉 板 湛 腰属 杉推析聖 窒径馬室推.
--A.
select last_name, hire_date, to_char(trunc(add_months(hire_date,6), 'IW') + 7, 'yy/mm/dd day') "脊紫 6鯵杉 板 湛腰属 杉推析"
from employees;


select * from employees;       
--Q6. EMPLOYEES 砺戚鷺拭辞 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 貢 脊紫析 奄層生稽 薄仙析猿走税 W_MONTH(悦紗杉呪)研 舛呪稽 域至背辞 窒径馬室推.(悦紗杉呪 奄層 鎧顕託授)
--A.
select employee_id, last_name, salary, hire_date, trunc(months_between(sysdate, hire_date),0) "悦紗杉呪"
from employees
order by "悦紗杉呪" desc;


--Q7. EMPLOYEES 砺戚鷺拭辞 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 貢 脊紫析 奄層生稽 W_YEAR(悦紗鰍呪)研 域至背辞 窒径馬室推.(悦紗鰍呪 奄層 鎧顕託授)
--A.
select employee_id, last_name, salary, hire_date, 
       trunc(months_between(sysdate, hire_date),0) "悦紗杉呪", 
       trunc(months_between(sysdate, hire_date)/12,0) "悦紗鰍呪"
from employees
order by "悦紗鰍呪" desc;


--Q8. EMPLOYEE_ID亜 筈呪昔 送据税 EMPLPYEE_ID人 LAST_NAME聖 窒径馬室推.
--A. 
select employee_id, last_name
from employees
where mod(employee_id,2) = 1
order by employee_id;


--Q9. EMPLOYEES 砺戚鷺拭辞 EMPLPYEE_ID, LAST_NAME 貢 M_SALARY(杉厭)聖 窒径馬室推. 舘 杉厭精 社呪繊 却属切軒猿走幻 妊薄馬室推.
--A
select employee_id, last_name, salary, round(salary/12,2) "M_SALARY" 
from employees
order by m_salary desc;


--Q10. EMPLOYEES 砺戚鷺拭辞 EMPLPYEE_ID, LAST_NAME, SALARY, HIRE_DATE 貢 脊紫析 奄層生稽 悦紗鰍呪研 域至背辞 焼掘紫牌聖 蓄亜廃 板拭 窒径馬室推.
--2001鰍 1杉 1析 但穣馬食 薄仙猿走 20鰍娃 錘慎鞠紳 噺紫澗 送据税  悦紗鰍呪拭 魚虞 30 去厭生稽 蟹刊嬢  去厭拭 魚虞 1000据税 BONUS研 走厭.
--鎧顕託授 舛慶.    
--A.
--1) 坂 持失
select employee_id, last_name, salary, hire_date, 
       trunc(months_between(sysdate, hire_date)/12,0) "悦紗鰍呪"
       (width_bucket(trunc((to_date('20/12/31')- hire_date)/365)0,20,30)) wb,
       (width_bucket(trunc((to_date('20/12/31')- hire_date)/365)0,20,30))*1000 bonus

from employees;

-- 2) 去厭 蟹刊奄



--Q11. EMPLOYEES 砺戚鷺拭辞 commission_pct 税  Null葵 姐呪研  窒径馬室推.
--A.
select count(*)
from employees
where commission_pct is null;


--Q12. EMPLOYEES 砺戚鷺拭辞 deparment_id 亜 蒸澗 送据聖 蓄窒馬食  POSITION聖 '重脊'生稽 窒径馬室推.
--A.
select e.*, 
       case when e.department_id is null then '重脊'
       else '奄糎 紫据' end "POSITION"
from employees e
where department_id is null;


--Q13. 紫腰戚 120腰昔 紫寓税 紫腰, 戚硯, 穣巷(job_id), 穣巷誤(job_title)聖 窒径(join~on, where 稽 繕昔馬澗 砧 亜走 号狛 乞砧)
--A.
-- 号狛1
select e.employee_id, e.first_name||' '||e.last_name "name", j.job_id, j.job_title
from employees e full outer join jobs j on e.job_id = j.job_id 
where e.employee_id = 120;

-- 号狛2
select e.employee_id, e.first_name||' '||e.last_name "name", j.job_id, j.job_title
from employees e, jobs j
where e.job_id = j.job_id and e.employee_id = 120;


--Q14.  employees 砺戚鷺拭辞 戚硯拭 FIRST_NAME拭 LAST_NAME聖 細食辞 'NAME' 鎮軍誤生稽 窒径馬室推.
--森) Steven King
--A. 
select e.*, e.first_name||' '||e.last_name "NAME"
from employees e;

select * from purprd;
--Q15. lmembers purprod 砺戚鷺稽 採斗 恥姥古衝, 2014 姥古衝, 2015 姥古衝聖 廃腰拭 窒径馬室推.
--A. 陥習戚びびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびび
select (select sum(p1.puramt) from purprd p1) "恥 姥古衝",
       (select sum(p2.puramt) from purprd p2 where substr(purdate, 1, 4) = 2014) "2014 姥古衝",
       (select sum(p3.puramt) from purprd p3 where substr(purdate, 1, 4) = 2015) "2015 姥古衝"
from dual;

select * from employees;
--Q16. HR EMPLOYEES 砺戚鷺拭辞 escape 辛芝聖 紫遂馬食 焼掘人 旭戚 窒径鞠澗 SQL庚聖 拙失馬室推.
--job_id 町軍拭辞  _聖 人析球朝球亜 焼観 庚切稽 昼厭馬食 '_A'研 匂敗馬澗  乞窮 楳聖 窒径
--A. 陥習戚びびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびびび
select *
from employees
where job_id like '%\_A%' escape '\';

--Q17. HR EMPLOYEES 砺戚鷺拭辞 SALARY, LAST_NAME 授生稽 臣顕託授 舛慶馬食 窒径馬室推.
--A. 
select *
from employees
order by salary, last_name;

   
--Q18. Seo虞澗 紫寓税 採辞誤聖 窒径馬室推.
--A.
select e.last_name,d.department_name
from employees e, departments d
where e.department_id = d.department_id and last_name = 'Seo';


select * from purprd;
--Q19. LMEMBERS 汽戚斗拭辞 壱梓紺 姥古榎衝税 杯域研 姥廃 CUSPUR 砺戚鷺聖 持失廃 板 CUSTDEMO 砺戚鷺引 
--壱梓腰硲研 奄層生稽 衣杯馬食 窒径馬室推.
--A.
-- 1) cuspur 砺戚鷺 持失
create table CUSPUR as
select custno, sum(puramt) SUM_PURAMT
from purprd
group by custno
order by custno;

-- 2) demo 砺戚鷺引 衣杯
select c.custno, d.gender, d.age, d.area, c.sum_puramt
from cuspur c, demo d
where c.custno = d.custno
order by c.custno;


--Q20.PURPROD 砺戚鷺稽 採斗 焼掘 紫牌聖 呪楳馬室推.
--A.
-- 2鰍娃 姥古榎衝聖 尻娃 舘是稽 歳軒馬食 壱梓紺, 薦妃紫紺稽 姥古衝聖 妊獣馬澗 AMT_14, AMT_15 砺戚鷺 2鯵研 持失 (窒径鎧遂 : 壱梓腰硲, 薦妃紫, SUM(姥古榎衝) 姥古榎衝)
drop table amt_14_2;
drop table amt_15_2;
drop table amt_year_foj_2;

-- 1-1) amt_14持失
create table AMT_14_2 as
select custno "CUSTNO_2014", asso "ASSO_2014", sum(puramt) "恥 姥古衝_2014"
from purprd
where substr(purdate,1,4) = 2014
group by custno, asso
order by custno, asso;
--溌昔
select * from AMT_14_2;

-- 1-2) amt_15 持失
create table AMT_15_2 as
select custno "CUSTNO_2015", asso "ASSO_2015", sum(puramt) "恥 姥古衝_2015"
from purprd
where substr(purdate,1,4) = 2015
group by custno, asso
order by custno, asso;
--溌昔
select * from AMT_15_2;

--AMT14人 AMT15 2鯵 砺戚鷺聖 壱梓腰硲人 薦妃紫研 奄層生稽 FULL OUTER JOIN 旋遂馬食 衣杯廃 AMT_YEAR_FOJ 砺戚鷺 持失
create table AMT_YEAR_FOJ_2 as
select * 
from amt_14_2 a14 full outer join amt_15_2 a15 on (a14."CUSTNO_2014" = a15."CUSTNO_2015" and a14."ASSO_2014" = a15."ASSO_2015");

select * from AMT_YEAR_FOJ_2;
-- 2-1) null葵 薦暗_姥古衝
update amt_year_foj_2
set "恥 姥古衝_2014" = 0
where "恥 姥古衝_2014" is null;

update amt_year_foj_2
set "恥 姥古衝_2015" = 0
where "恥 姥古衝_2015" is null;

-- 2-2) null葵 薦暗_壱梓腰硲
update amt_year_foj_2
set custno_2014 = custno_2015
where custno_2014 is null;

update amt_year_foj_2
set custno_2015 = custno_2014
where custno_2015 is null;

-- 2-3) null葵 薦暗_薦妃紫
update amt_year_foj_2
set asso_2014 = asso_2015
where asso_2014 is null;

update amt_year_foj_2
set asso_2015 = asso_2014
where asso_2015 is null;

-- 溌昔
select *
from amt_year_foj_2
where custno_2014 is null or custno_2015 is null or asso_2014 is null or asso_2015 is null; 




--14鰍引 15鰍税 姥古榎衝 託戚研 妊獣馬澗 装姶 鎮軍聖 蓄亜馬食 窒径(舘, 壱梓腰硲, 薦妃紫紺稽 姥古榎衝 貢 装姶戚 姥歳鞠嬢醤 敗)
-- 1) 装姶 朔 鎮軍 持失
alter table amt_year_foj_2 
add "姥古 装姶衝" number;

-- 2) 域至
update amt_year_foj_2 x
set "姥古 装姶衝"  = (select "恥 姥古衝_2014" - "恥 姥古衝_2015"
                     from amt_year_foj_2 y
                     where x.custno_2014 = y.custno_2014 and x.asso_2014 = y.asso_2014);

--溌昔
select * from amt_year_foj_2;




--Q(BONUS). HR 砺戚鷺級聖 歳汐背辞 穿端 薄伐聖 竺誤拝 呪 赤澗 推鉦 砺戚鷺聖 拙失馬室推. (森 : 採辞紺 汝液 SALARY 授是)
--A.
create table employees_temp_2 as
select e.employee_id "ID", 
       e.first_name||' '||e.last_name as "NAME", 
       trunc(months_between(sysdate, e.hire_date)/12,0) as "HIRED_YEARS", 
       e.salary "SALARY", 
       d.department_name "DEPART_TITLE",
       j.job_title "JOB_TITLE",
       case when e.salary > 20000 then '企妊戚紫'
            when e.salary > 15000 then '戚紫'
            when e.salary > 10000 then '採舌'
            when e.salary > 5000 then '引舌'
            when e.salary > 3000 then '企軒'
            else '紫据' end as "POSITION"  
from employees e, jobs j, departments d
where e.department_id = d.department_id and e.job_id = j.job_id ;
--溌昔
select * from employees_temp_2;


select depart_title "採辞", position "送厭", count(*) "昔据", trunc(avg(salary),0) "汝液 杉厭", trunc(avg(hired_years),0) "汝液 悦紗尻呪"  
from employees_temp_2
group by depart_title, position 
order by "汝液 杉厭" desc;
