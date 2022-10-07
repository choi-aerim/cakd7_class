----------- DCL-------------
-- 유저 생성
create user c##user01
identified by userpass;
-- 다른 워크시트에서는 생성권한이 없음, 오라클 학습용 서버에서 해야함!

select * from all_users;

-- 유저 삭제
drop user c##user01;




-- 권한 부여
create user c##user01
identified by userpass;
-- 세션 크리에이트, 테이블 크리에이트 권한 부여
grant create session, create table to c##user01;

-- 권한 회수
revoke create session, create table from c##user01;

-- 사용자 암호 변경
alter user c##user01
identified by passuser;

-- 삭제: 관련된 모든 참조된 정보를 삭제
drop user c##user01 cascade;



--커밋과 롤백
create table users(
id number,
name varchar2(20),
age number);

select * from users;

insert into users 
values(1, 'hong gildong', 30);
insert into users 
values(2, 'hong gilsum', 30);


delete 
from users 
where id = 1;
select * from users;

-- insert된 내용 삭제
rollback;
select * from users;

-- insert된 내용 영구 저장
commit;


drop table users;

show autocommit;

