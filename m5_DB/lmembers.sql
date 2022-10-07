--lmembers
--[과제_1006_1] purprd 데이터로 부터 아래 사항을 수행하세요.
--2년간 구매금액을 연간 단위로 분리하여 고객별, 제휴사별로 구매액을 표시하는 AMT_14, AMT_15 테이블 2개를 생성(출력내용:고객번호,제휴사,SUM(구매금액)구매금액)
drop table amt_14;
drop table amt_15;

create table AMT_14 as
select custno "고객번호", asso "제휴사", sum(puramt) "총 구매액_2014"
from purprd
where substr(purdate,1,4) = 2014
group by custno, asso
order by custno, asso;
-- 확인
select * from amt_14;

create table AMT_15 as
select custno "고객번호", asso "제휴사", sum(puramt) "총 구매액_2015"
from purprd
where substr(purdate,1,4) = 2015
group by custno, asso
order by custno, asso;
-- 확인
select * from amt_15;


--AMT14와 AMT15 2개 테이블을 고객번호와 제휴사를 기준으로 FULL OUTER JOIN 적용하여 결합한 AMT_YEAR_FOJ 테이블 생성
drop table amt_year_foj;

-- 1)테이블 생성
create table AMT_YEAR_FOJ as
select a14."고객번호" "고객번호_2014", a14."제휴사" "제휴사_2014", 
       a15."고객번호" "고객번호_2015", a15."제휴사" "제휴사_2015", 
       a14."총 구매액_2014", a15."총 구매액_2015" 
from amt_14 a14 full outer join amt_15 a15 on (a14."고객번호" = a15."고객번호" and a14."제휴사" = a15."제휴사");

-- 2)null값 제거
update amt_year_foj
set "고객번호_2014" = "고객번호_2015"
where "고객번호_2014" is null;
update amt_year_foj
set "제휴사_2014" = "제휴사_2015"
where "제휴사_2014" is null;

update amt_year_foj
set "고객번호_2015" = "고객번호_2014"
where "고객번호_2015" is null;
update amt_year_foj
set "제휴사_2015" = "제휴사_2014"
where "제휴사_2015" is null;

update amt_year_foj
set "총 구매액_2014" = 0 
where "총 구매액_2014" is null;
update amt_year_foj
set "총 구매액_2015" = 0 
where "총 구매액_2015" is null;

--2-2) null값 제거
CREATE TABLE AMT_YEAR_FOJ_3   
    AS SELECT NVL(A.CUSTNO,B.CUSTNO) CUSTNO, NVL(A.ASSO,B.ASSO) ASSO, NVL(A.PURAMT_SUM,0) AMT14, NVL(B.PURAMT_SUM,0) AMT15
    FROM AMT_14 A FULL OUTER JOIN AMT_15 B ON A.CUSTNO=B.CUSTNO AND A.ASSO=B.ASSO;
SELECT * FROM AMT_YEAR_FOJ_3;

-- 확인
select *
from amt_year_foj
where "고객번호_2014" is null or "고객번호_2015" is null or "제휴사_2014" is null or "제휴사_2015" is null or "총 구매액_2014" is null or "총 구매액_2015" is null;


--14년과 15년의 구매금액 차이를 표시하는 증감 컬럼을 추가하여 출력(단, 고객번호, 제휴사별로 구매금액 및 증감이 구분되어야 함)
select * from amt_year_foj;

-- 1) 빈컬럼 생성
alter table amt_year_foj
add "구매금액 증감" number;
-- 확인
select * from amt_year_foj;


-- 2) 증감액 채우기
update amt_year_foj x
set "구매금액 증감" = (select "총 구매액_2015" - "총 구매액_2014" 
                     from amt_year_foj y
                     where x."고객번호_2014" = y."고객번호_2014" and x."제휴사_2014" = y."제휴사_2014");
                     
select count(*) from demo;