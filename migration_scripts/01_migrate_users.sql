-- create helper function
create or replace function eval(expression text) returns integer
as
$body$
declare
  result integer;
begin
  execute expression into result;
  return result;
end;
$body$
language plpgsql
;

-- migrate users
insert into
  auth_user(
            id,
            password,
            last_login,
            is_superuser,
            username,
            first_name,
            last_name,
            email,
            is_staff,
            is_active,
            date_joined
            )
select
       id,
       md5('1'),
       null,
       true,
       user_login,
       user_nicename,
       '',
       user_email,
       true,
       true,
       user_registered
from wp_users
;
select setval('auth_user_id_seq', eval('select max(id) from auth_user') + 1)
;