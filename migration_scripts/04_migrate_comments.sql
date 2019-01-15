-- migrate comments
insert into django_comments(
                            id,
                            object_pk,
                            user_name,
                            user_email,
                            user_url,
                            comment,
                            submit_date,
                            ip_address,
                            is_public,
                            is_removed,
                            content_type_id,
                            site_id,
                            user_id
                            )
select
      comment_id,
      comment_post_id,
      comment_author,
      comment_author_email,
      comment_author_url,
      comment_content,
      comment_date,
      comment_author_ip,
      true,
      false,
      eval('select id from django_content_type where app_label=''blog'' and model=''blogpost'' '), --content type id
      1,
user_id
from wp_comments
;
select setval('django_comments_id_seq', eval('select max(id) from django_comments') + 1)
;
