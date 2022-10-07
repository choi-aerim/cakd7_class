----------- DCL-------------
-- ���� ����
create user c##user01
identified by userpass;
-- �ٸ� ��ũ��Ʈ������ ���������� ����, ����Ŭ �н��� �������� �ؾ���!

select * from all_users;

-- ���� ����
drop user c##user01;




-- ���� �ο�
create user c##user01
identified by userpass;
-- ���� ũ������Ʈ, ���̺� ũ������Ʈ ���� �ο�
grant create session, create table to c##user01;

-- ���� ȸ��
revoke create session, create table from c##user01;

-- ����� ��ȣ ����
alter user c##user01
identified by passuser;

-- ����: ���õ� ��� ������ ������ ����
drop user c##user01 cascade;



--Ŀ�԰� �ѹ�
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

-- insert�� ���� ����
rollback;
select * from users;

-- insert�� ���� ���� ����
commit;


drop table users;

show autocommit;

