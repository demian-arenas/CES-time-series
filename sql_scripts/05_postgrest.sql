CREATE ROLE web_anon nologin;
GRANT USAGE ON schema public TO web_anon;

GRANT SELECT ON public.women_in_government TO web_anon;
GRANT SELECT ON public.production_supervisory_ratio TO web_anon;