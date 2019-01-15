-- migrate posts
insert into blog_blogpost(
                          id,
                          comments_count,
                          keywords_string,
                          rating_count,
                          rating_sum,
                          rating_average,
                          title,
                          slug,
                          _meta_title,
                          description,
                          gen_description,
                          created,
                          updated,
                          status,
                          publish_date,
                          expiry_date,
                          short_url,
                          in_sitemap,
                          content,
                          allow_comments,
                          featured_image,
                          site_id,
                          user_id
                          )
select
       id,
       comment_count,
       post_name as keywords_string,
       0,
       0,
       0,
       post_title,
       post_title,
       null,
       '',
       true,
       post_date,
       post_modified,
       2,
       post_date,
       null,
       null,
       true,
       post_content,
       true,
       null,
       1,
       post_author
from wp_posts
;
select setval('blog_blogpost_id_seq', eval('select max(id) from blog_blogpost') + 1)
;
delete from blog_blogpost where content is null or content = ''
;
delete from blog_blogpost where title is null or title = ''
;
delete from blog_blogpost
where id not in (select distinct on (content) id from blog_blogpost)
;
delete from blog_blogpost
where id not in (select distinct on (title, slug) id from blog_blogpost)
;