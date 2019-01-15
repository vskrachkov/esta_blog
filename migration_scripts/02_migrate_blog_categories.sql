-- migrate categories
insert into blog_blogcategory(id, title, slug, site_id)
select term_id, name, slug, 1
from wp_terms
;
select setval('blog_blogcategory_id_seq', eval('select max(id) from blog_blogcategory') + 1)
;
