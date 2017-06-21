--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry, geography, and raster spatial types and functions';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE auth_group (
    id integer NOT NULL,
    name character varying(80) NOT NULL
);


ALTER TABLE auth_group OWNER TO demo;

--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_id_seq OWNER TO demo;

--
-- Name: auth_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE auth_group_id_seq OWNED BY auth_group.id;


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE auth_group_permissions (
    id integer NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_group_permissions OWNER TO demo;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_group_permissions_id_seq OWNER TO demo;

--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE auth_group_permissions_id_seq OWNED BY auth_group_permissions.id;


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


ALTER TABLE auth_permission OWNER TO demo;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_permission_id_seq OWNER TO demo;

--
-- Name: auth_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE auth_permission_id_seq OWNED BY auth_permission.id;


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


ALTER TABLE auth_user OWNER TO demo;

--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE auth_user_groups (
    id integer NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


ALTER TABLE auth_user_groups OWNER TO demo;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_groups_id_seq OWNER TO demo;

--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE auth_user_groups_id_seq OWNED BY auth_user_groups.id;


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_id_seq OWNER TO demo;

--
-- Name: auth_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE auth_user_id_seq OWNED BY auth_user.id;


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE auth_user_user_permissions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


ALTER TABLE auth_user_user_permissions OWNER TO demo;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth_user_user_permissions_id_seq OWNER TO demo;

--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE auth_user_user_permissions_id_seq OWNED BY auth_user_user_permissions.id;


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


ALTER TABLE django_admin_log OWNER TO demo;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_admin_log_id_seq OWNER TO demo;

--
-- Name: django_admin_log_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE django_admin_log_id_seq OWNED BY django_admin_log.id;


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


ALTER TABLE django_content_type OWNER TO demo;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_content_type_id_seq OWNER TO demo;

--
-- Name: django_content_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE django_content_type_id_seq OWNED BY django_content_type.id;


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE django_migrations (
    id integer NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


ALTER TABLE django_migrations OWNER TO demo;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_migrations_id_seq OWNER TO demo;

--
-- Name: django_migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE django_migrations_id_seq OWNED BY django_migrations.id;


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


ALTER TABLE django_session OWNER TO demo;

--
-- Name: django_site; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE django_site (
    id integer NOT NULL,
    domain character varying(100) NOT NULL,
    name character varying(50) NOT NULL
);


ALTER TABLE django_site OWNER TO demo;

--
-- Name: django_site_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE django_site_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE django_site_id_seq OWNER TO demo;

--
-- Name: django_site_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE django_site_id_seq OWNED BY django_site.id;


--
-- Name: heatmap_heatmap; Type: TABLE; Schema: public; Owner: demo
--

CREATE TABLE heatmap_heatmap (
    id integer NOT NULL,
    location geography(Point,4326),
    cityname varchar(30) NOT NULL,
    useremail varchar(60) NOT NULL,
    sessiontuningin varchar(150) NOT NULL
);


ALTER TABLE heatmap_heatmap OWNER TO demo;

--
-- Name: heatmap_heatmap_id_seq; Type: SEQUENCE; Schema: public; Owner: demo
--

CREATE SEQUENCE heatmap_heatmap_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE heatmap_heatmap_id_seq OWNER TO demo;

--
-- Name: heatmap_heatmap_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: demo
--

ALTER SEQUENCE heatmap_heatmap_id_seq OWNED BY heatmap_heatmap.id;


--
-- Name: auth_group id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group ALTER COLUMN id SET DEFAULT nextval('auth_group_id_seq'::regclass);


--
-- Name: auth_group_permissions id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group_permissions ALTER COLUMN id SET DEFAULT nextval('auth_group_permissions_id_seq'::regclass);


--
-- Name: auth_permission id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_permission ALTER COLUMN id SET DEFAULT nextval('auth_permission_id_seq'::regclass);


--
-- Name: auth_user id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user ALTER COLUMN id SET DEFAULT nextval('auth_user_id_seq'::regclass);


--
-- Name: auth_user_groups id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_groups ALTER COLUMN id SET DEFAULT nextval('auth_user_groups_id_seq'::regclass);


--
-- Name: auth_user_user_permissions id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_user_permissions ALTER COLUMN id SET DEFAULT nextval('auth_user_user_permissions_id_seq'::regclass);


--
-- Name: django_admin_log id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_admin_log ALTER COLUMN id SET DEFAULT nextval('django_admin_log_id_seq'::regclass);


--
-- Name: django_content_type id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_content_type ALTER COLUMN id SET DEFAULT nextval('django_content_type_id_seq'::regclass);


--
-- Name: django_migrations id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_migrations ALTER COLUMN id SET DEFAULT nextval('django_migrations_id_seq'::regclass);


--
-- Name: django_site id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_site ALTER COLUMN id SET DEFAULT nextval('django_site_id_seq'::regclass);


--
-- Name: heatmap_heatmap id; Type: DEFAULT; Schema: public; Owner: demo
--

ALTER TABLE ONLY heatmap_heatmap ALTER COLUMN id SET DEFAULT nextval('heatmap_heatmap_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY auth_group (id, name) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('auth_group_id_seq', 1, false);


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('auth_group_permissions_id_seq', 1, false);


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can add group	2	add_group
5	Can change group	2	change_group
6	Can delete group	2	delete_group
7	Can add permission	3	add_permission
8	Can change permission	3	change_permission
9	Can delete permission	3	delete_permission
10	Can add user	4	add_user
11	Can change user	4	change_user
12	Can delete user	4	delete_user
13	Can add content type	5	add_contenttype
14	Can change content type	5	change_contenttype
15	Can delete content type	5	delete_contenttype
16	Can add session	6	add_session
17	Can change session	6	change_session
18	Can delete session	6	delete_session
19	Can add heatmap	7	add_heatmap
20	Can change heatmap	7	change_heatmap
21	Can delete heatmap	7	delete_heatmap
22	Can add site	8	add_site
23	Can change site	8	change_site
24	Can delete site	8	delete_site
\.


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('auth_permission_id_seq', 24, true);


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('auth_user_id_seq', 1, false);


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('auth_user_user_permissions_id_seq', 1, false);


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('django_admin_log_id_seq', 1, false);


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	group
3	auth	permission
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	heatmap	heatmap
8	sites	site
\.


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('django_content_type_id_seq', 8, true);


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2017-04-15 15:21:54.914469-07
2	auth	0001_initial	2017-04-15 15:21:54.96047-07
3	admin	0001_initial	2017-04-15 15:21:55.000335-07
4	admin	0002_logentry_remove_auto_add	2017-04-15 15:21:55.012261-07
5	contenttypes	0002_remove_content_type_name	2017-04-15 15:21:55.035262-07
6	auth	0002_alter_permission_name_max_length	2017-04-15 15:21:55.042403-07
7	auth	0003_alter_user_email_max_length	2017-04-15 15:21:55.053077-07
8	auth	0004_alter_user_username_opts	2017-04-15 15:21:55.064978-07
9	auth	0005_alter_user_last_login_null	2017-04-15 15:21:55.074673-07
10	auth	0006_require_contenttypes_0002	2017-04-15 15:21:55.075994-07
11	auth	0007_alter_validators_add_error_messages	2017-04-15 15:21:55.085681-07
12	auth	0008_alter_user_username_max_length	2017-04-15 15:21:55.097648-07
13	heatmap	0001_initial	2017-04-15 15:21:55.110935-07
14	sessions	0001_initial	2017-04-15 15:21:55.11916-07
15	sites	0001_initial	2017-04-16 11:08:08.027092-07
16	sites	0002_alter_domain_unique	2017-04-16 11:08:08.034128-07
\.


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('django_migrations_id_seq', 16, true);


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY django_session (session_key, session_data, expire_date) FROM stdin;
\.


--
-- Data for Name: django_site; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY django_site (id, domain, name) FROM stdin;
1	example.com	example.com
\.


--
-- Name: django_site_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

SELECT pg_catalog.setval('django_site_id_seq', 1, true);


--
-- Data for Name: heatmap_heatmap; Type: TABLE DATA; Schema: public; Owner: demo
--

-- COPY heatmap_heatmap (id, location, cityname, useremail, sessiontuningin) FROM stdin;
-- 1	0101000020E6100000F40A557BA2DA51C039B302E89CD94440	Warwick	rogelio35-warwick@outlook.com	mockSession-4
-- 2	0101000020E6100000CC6A7011CE0A55C0B53C6AA741D84340	Kettering	charles53-kettering@outlook.com	mockSession-1
-- 3	0101000020E610000018BFDF1EBA5855C07A275591C0184440	Muncie	martin15-muncie@outlook.com	mockSession-2
-- 4	0101000020E6100000874C9E57618052C09A4F0C7F3C5B4440	New York	ayrton32-new-york@gmail.com	mockSession-6
-- 5	0101000020E610000026C632FD92CA52C01B99EC44EEF94340	Philadelphia	keith1-philadelphia@outlook.com	mockSession-1
-- 6	0101000020E610000022670696C8575EC05810148953344340	Elk Grove	lauren78-elk-grove@gmail.com	mockSession-4
-- 7	0101000020E6100000F86008EFE1CD55C0AE8218E8DA6B3E40	Pensacola	rogelio90-pensacola@outlook.com	mockSession-1
-- 8	0101000020E6100000387DE2A540955EC02383DC4598CD4740	Seattle	lauren94-seattle@outlook.com	mockSession-2
-- 9	0101000020E6100000E53AD7416F9C5EC065F558445EA04740	Tacoma	martin88-tacoma@gmail.com	mockSession-3
-- 10	0101000020E6100000FFA14F9ABCFF53C03DE7B86466384440	Pittsburgh	charles79-pittsburgh@gmail.com	mockSession-4
-- 11	0101000020E61000003E6079EBD7A853C034E66498C9E34140	Raleigh	john54-raleigh@gmail.com	mockSession-4
-- 12	0101000020E6100000F062AB15B70056C00CCE3BA98AE74440	Downers Grove	martin22-downers-grove@outlook.com	mockSession-2
-- 13	0101000020E6100000DC018D88988F5DC0CA5D3A9CAF064140	Los Angeles	rogelio97-los-angeles@gmail.com	mockSession-2
-- 14	0101000020E610000022BCE24E8E6F58C03E07962364443E40	Austin	roger37-austin@outlook.com	mockSession-4
-- 15	0101000020E610000008FE5CD9AAD757C05581FF52ABC23D40	Houston	charles34-houston@outlook.com	mockSession-5
-- 16	0101000020E610000029CBB50D48D953C06BB0BA1F014B4240	Danville	john50-danville@outlook.com	mockSession-1
-- 17	0101000020E61000004A737511F0C054C00E1BC0B6D9414540	Warren	rogelio36-warren@gmail.com	mockSession-3
-- 18	0101000020E61000006DB0CB4BD90656C0B21F73AFDDEE4440	Wheaton	martin40-wheaton@outlook.com	mockSession-2
-- 19	0101000020E6100000DFBF7971623B52C0821ABE8575A74440	New Haven	john6-new-haven@gmail.com	mockSession-7
-- 20	0101000020E6100000C3521333310F5CC0365A0EF450CA4040	Peoria	roger74-peoria@outlook.com	mockSession-6
-- 21	0101000020E6100000387DE2A540955EC02383DC4598CD4740	Seattle	rogelio33-seattle@gmail.com	mockSession-6
-- 22	0101000020E6100000B1E1E99532C15DC076AD1809C8AF4140	Bakersfield	roger35-bakersfield@outlook.com	mockSession-7
-- 23	0101000020E6100000A7F809B1C4C351C053AEF02E172E4540	Boston	keith32-boston@gmail.com	mockSession-8
-- 24	0101000020E610000082E7397D98C954C0C525225745544540	Rochester Hills	martin56-rochester-hills@outlook.com	mockSession-7
-- 25	0101000020E6100000D6091E95511154C0D4EFC2D66C453A40	Coral Springs	charles19-coral-springs@outlook.com	mockSession-2
-- 26	0101000020E61000009FB0C403CABB51C0EB9BEA7F6FD14440	New Bedford	ayrton68-new-bedford@gmail.com	mockSession-6
-- 27	0101000020E6100000127FB9BBF3695EC02DA4B217C0564240	Salinas	lauren99-salinas@yahoo.com	mockSession-2
-- 28	0101000020E6100000D56C2FB399965DC0655B615518FB4040	Inglewood	rogelio98-inglewood@outlook.com	mockSession-5
-- 29	0101000020E610000009F02774A8CE5DC015FDA19927234140	San Buenaventura (Ventura)	john98-san-buenaventura@outlook.com	mockSession-8
-- 30	0101000020E6100000B19D94EED38B56C07B78E0AD3D264040	Jackson	john3-jackson@outlook.com	mockSession-6
-- 31	0101000020E61000004257C7968A775DC080A378F06EDF4040	Santa Ana	ayrton87-santa-ana@gmail.com	mockSession-6
-- 32	0101000020E610000019051C9D4EE855C01F16C50666F04440	Chicago	lauren83-chicago@gmail.com	mockSession-2
-- 33	0101000020E6100000387DE2A540955EC02383DC4598CD4740	Seattle	keith58-seattle@outlook.com	mockSession-4
-- 34	0101000020E61000004E3ADBEDC42055C0AA4F28FA328D4340	Cincinnati	martin78-cincinnati@gmail.com	mockSession-7
-- 35	0101000020E610000084EA8B29FD895EC081F33D7ECADC4240	San Leandro	martin85-san-leandro@gmail.com	mockSession-3
-- 36	0101000020E61000006079EB5715F45DC05D31C802CBC34340	Reno	rogelio58-reno@gmail.com	mockSession-3
-- 37	0101000020E6100000FCB26AC658F351C074136BA79C214540	Worcester	martin7-worcester@outlook.com	mockSession-3
-- 38	0101000020E6100000383F0FFFFAC856C0E8D0330752753E40	Baton Rouge	roger94-baton-rouge@outlook.com	mockSession-4
-- 39	0101000020E6100000A7C4BF19C6935DC0DBEA28BD25174140	Burbank	charles3-burbank@outlook.com	mockSession-4
-- 40	0101000020E61000007EFE7BF0DABD5BC019236D3E09324040	Oro Valley	roger9-oro-valley@gmail.com	mockSession-2
-- 41	0101000020E61000001EFF0582800056C088C157CFA4F04440	Lombard	lauren31-lombard@outlook.com	mockSession-8
-- 42	0101000020E61000008FABEC165C4253C06DD795E01E744340	Washington	roger45-washington@gmail.com	mockSession-7
-- 43	0101000020E61000000AF31E671A3855C0F30EA6176B944140	Cleveland	rogelio58-cleveland@yahoo.com	mockSession-3
-- 44	0101000020E6100000874C9E57618052C09A4F0C7F3C5B4440	New York	martin61-new-york@outlook.com	mockSession-7
-- 45	0101000020E610000009A7052FFA9855C087269A513DEC4140	Murfreesboro	rogelio75-murfreesboro@outlook.com	mockSession-8
-- 47	0101000020E6100000D763C7EB661558C0E4A3C519C3A03E40	College Station	charles14-college-station@outlook.com	mockSession-5
-- 46	0101000020E6100000387DE2A540955EC02383DC4598CD4740	Seattle	martin40-seattle@outlook.com	mockSession-4
-- 49	0101000020E610000026C632FD92CA52C01B99EC44EEF94340	Philadelphia	martin14-philadelphia@outlook.com	mockSession-2
-- 48	0101000020E61000001D3059260D6158C0A3F43B03D9BB4140	Oklahoma City	charles44-oklahoma-city@outlook.com	mockSession-4
-- 50	0101000020E6100000B4D8DC87728A57C052BBBABE6AC74640	St. Cloud	ayrton2-stcloud@outlook.com	mockSession-5
-- 51	0101000020E6100000DEC5A0B8881257C0594BA6AF8C5F4140	Little Rock	keith83-little-rock@outlook.com	mockSession-1
-- 52	0101000020E61000009AB8B0C9F53554C0CE6CFC2E119D4140	Charlotte	rogelio75-charlotte@yahoo.com	mockSession-1
-- 53	0101000020E6100000E8E96D7D228356C0AC10A0F023934140	Memphis	john54-memphis@outlook.com	mockSession-6
-- 54	0101000020E6100000E659492B3E355AC05F9445065EDD4340	Aurora	martin48-aurora@outlook.com	mockSession-3
-- 55	0101000020E6100000DD3B0F93151256C07900304388044540	Elgin	rogelio54-elgin@outlook.com	mockSession-3
-- 56	0101000020E6100000A7C4BF19C6935DC0DBEA28BD25174140	Burbank	rogelio3-burbank@outlook.com	mockSession-7
-- 57	0101000020E6100000ADF13E332D1154C01B649291B3B83940	Coral Gables	charles31-coral-gables@gmail.com	mockSession-2
-- 58	0101000020E61000005EDD0C9299EA56C0E4F6CB272BFD4440	Cedar Rapids	ayrton73-cedar-rapids@outlook.com	mockSession-7
-- 59	0101000020E6100000234DBC033CC451C0DCD20F8F69364540	Malden	martin20-malden@outlook.com	mockSession-7
-- 60	0101000020E6100000A9948DBD4D4D54C0971128AC9E953D40	Palm Coast	john77-palm-coast@outlook.com	mockSession-6
-- 61	0101000020E61000006CF9371EA24A5DC07FD305065A924040	San Marcos	john25-san-marcos@outlook.com	mockSession-5
-- 62	0101000020E6100000BCAA58A1EDC254C075012F336C2A4540	Detroit	martin10-detroit@yahoo.com	mockSession-6
-- 63	0101000020E610000034F5BA45603F5AC0268458479FDE4340	Denver	ayrton98-denver@gmail.com	mockSession-8
-- 64	0101000020E610000034F5BA45603F5AC0268458479FDE4340	Denver	martin58-denver@gmail.com	mockSession-4
-- 65	0101000020E610000058A192840E5D52C0D2730B5D89B24440	Danbury	martin45-danbury@gmail.com	mockSession-2
-- 66	0101000020E6100000DEC5A0B8881257C0594BA6AF8C5F4140	Little Rock	ayrton90-little-rock@gmail.com	mockSession-8
-- 67	0101000020E6100000C4DB3983759857C066EE6B6E96744340	Lees Summit	rogelio32-lee-summit@outlook.com	mockSession-6
-- 68	0101000020E61000003196E99788E354C0EA8722EEFBD44440	Toledo	lauren62-toledo@outlook.com	mockSession-8
-- 69	0101000020E6100000874C9E57618052C09A4F0C7F3C5B4440	New York	keith48-new-york@outlook.com	mockSession-1
-- 70	0101000020E61000009A92510ADFFF57C08BDAA2714DA04440	Omaha	keith40-omaha@gmail.com	mockSession-8
-- 71	0101000020E61000009FB0C403CABB51C0EB9BEA7F6FD14440	New Bedford	john63-new-bedford@outlook.com	mockSession-8
-- 72	0101000020E610000023426D65D38655C0B8F7BA568CCE4340	Greenwood	keith87-greenwood@outlook.com	mockSession-6
-- 73	0101000020E6100000EABC7CA1363F55C0291D5146013B4040	Columbus	charles3-columbus@gmail.com	mockSession-7
-- 74	0101000020E6100000A543F17478F05BC049E1308793704040	Casa Grande	john28-casa-grande@outlook.com	mockSession-7
-- 75	0101000020E6100000E53AD7416F9C5EC065F558445EA04740	Tacoma	john64-tacoma@outlook.com	mockSession-5
-- 76	0101000020E6100000EBF0C63835455AC01BD7BFEB33DA4340	Lakewood	keith60-lakewood@yahoo.com	mockSession-8
-- 77	0101000020E6100000D3A23EC91D8A55C0FB928D075BE24340	Indianapolis	rogelio59-indianapolis@gmail.com	mockSession-6
-- 78	0101000020E6100000874C9E57618052C09A4F0C7F3C5B4440	New York	keith71-new-york@gmail.com	mockSession-1
-- 79	0101000020E610000011853BBC8CE455C06010470D5CFC4240	Evansville	rogelio27-evansville@outlook.com	mockSession-8
-- 80	0101000020E610000087414FB9788F56C0C033EBD67CFE3D40	Kenner	lauren36-kenner@outlook.com	mockSession-8
-- 81	0101000020E6100000A86851442B5558C05D8132D7B3604040	Fort Worth	john80-fort-worth@outlook.com	mockSession-7
-- 82	0101000020E610000026C632FD92CA52C01B99EC44EEF94340	Philadelphia	roger1-philadelphia@outlook.com	mockSession-3
-- 83	0101000020E610000019051C9D4EE855C01F16C50666F04440	Chicago	lauren88-chicago@outlook.com	mockSession-5
-- 84	0101000020E61000007F243669E48D5EC049FCE5EECEBD4740	Renton	ayrton75-renton@outlook.com	mockSession-2
-- 85	0101000020E61000005FF0694E5E5958C078BD8FFEF2CC3B40	Corpus Christi	lauren78-corpus-christi@gmail.com	mockSession-1
-- 86	0101000020E6100000948444DAC6875EC054B2F73D45D64740	Redmond	martin28-redmond@yahoo.com	mockSession-1
-- 87	0101000020E6100000DF7E0A919D7F5DC0A84EACF82BE04040	Westminster	keith79-westminster@gmail.com	mockSession-6
-- 88	0101000020E6100000D86BD509C38C56C05001309E41504340	St. Louis	rogelio8-st-louis@outlook.com	mockSession-3
-- 89	0101000020E6100000AE1DD665429D54C02C6519E258F33B40	Tampa	john66-tampa@outlook.com	mockSession-1
-- 90	0101000020E6100000290F666E996752C02002582E655A4440	Hempstead	lauren66-hempstead@gmail.com	mockSession-7
-- 91	0101000020E6100000A05FA5CC177C5DC0A5E9FD90C8084140	West Covina	keith34-west-covina@outlook.com	mockSession-4
-- 92	0101000020E610000034F5BA45603F5AC0268458479FDE4340	Denver	rogelio13-denver@outlook.com	mockSession-7
-- 93	0101000020E61000003DE64D8F377858C0B993E3A9A2324240	Enid	roger20-enid@gmail.com	mockSession-2
-- 94	0101000020E61000009DCB1EB2927552C08A2DF30CD0744440	Mount Vernon	ayrton58-mount-vernon@outlook.com	mockSession-7
-- 95	0101000020E61000000CBE7A26C57C54C0BFEE192E17903A40	Cape Coral	lauren80-cape-coral@gmail.com	mockSession-4
-- 96	0101000020E61000009BA0979BB9785EC0981E03684AAB4240	San Jose	martin0-san-jose@gmail.com	mockSession-3
-- 97	0101000020E61000004E2A1A6B7FF25BC02C955C6A29AD4040	Gilbert	keith65-gilbert@outlook.com	mockSession-4
-- 98	0101000020E6100000DC018D88988F5DC0CA5D3A9CAF064140	Los Angeles	ayrton0-los-angeles@outlook.com	mockSession-1
-- 99	0101000020E6100000FB703557725753C07044F7AC6BCE4140	Greenville	charles51-greenville@outlook.com	mockSession-3
-- 100	0101000020E610000089D8BB9A979F58C07304BA40936C3D40	San Antonio	martin80-san-antonio@outlook.com	mockSession-5
-- 101	0101000020E610000003160A229C525EC0D7A94DF795FA4240	Stockton	john68-stockton@outlook.com	mockSession-7
-- 102	0101000020E6100000387DE2A540955EC02383DC4598CD4740	Seattle	john46-seattle@gmail.com	mockSession-5
-- 103	0101000020E6100000DFFB1BB4D79A5EC0529ACDE330E34240	San Francisco	john9-san-francisco@outlook.com	mockSession-5
-- 104	0101000020E61000001AC638DACC3F5EC08B7BE2EFCDD14240	Modesto	charles99-modesto@outlook.com	mockSession-2
-- 105	0101000020E6100000BEA59C2FF66954C0D1425DFF09553E40	Jacksonville	john92-jacksonville@gmail.com	mockSession-6
-- 106	0101000020E6100000387DE2A540955EC02383DC4598CD4740	Seattle	martin19-seattle@outlook.com	mockSession-7
-- 107	0101000020E6100000F1D6F9B74B4352C01FD7868A71C74440	Waterbury	roger50-waterbury@gmail.com	mockSession-3
-- 108	0101000020E6100000A1BE654E97FE52C0FB3262B02C6D4240	Virginia Beach	ayrton40-virginia-beach@outlook.com	mockSession-3
-- 109	0101000020E6100000A6D24F38BB5554C0EFBE74A444D54440	Mentor	keith7-mentor@outlook.com	mockSession-7
-- 110	0101000020E6100000130203522C0E55C0B10F577325FC4040	Peachtree Corners	martin73-peachtree-corners@outlook.com	mockSession-6
-- 111	0101000020E6100000948444DAC6875EC054B2F73D45D64740	Redmond	charles24-redmond@outlook.com	mockSession-4
-- 112	0101000020E610000089D8BB9A979F58C07304BA40936C3D40	San Antonio	ayrton11-san-antonio@outlook.com	mockSession-1
-- 113	0101000020E61000003295D97BCC1154C0ADAB5D6E8BDB3940	Hialeah	rogelio52-hialeah@outlook.com	mockSession-7
-- 114	0101000020E6100000FFA14F9ABCFF53C03DE7B86466384440	Pittsburgh	charles27-pittsburgh@yahoo.com	mockSession-3
-- 115	0101000020E6100000F45ABF4F0B205BC0C0B6D9B342E44640	Billings	charles15-billings@outlook.com	mockSession-5
-- 116	0101000020E6100000963A6D324F4A5DC09240834D9D5B4040	San Diego	roger92-san-diego@gmail.com	mockSession-8
-- 117	0101000020E61000008EC5DBEFF55057C06F48A302277D4640	Minneapolis	martin0-minneapolis@gmail.com	mockSession-8
-- 118	0101000020E6100000D87C0162376154C05D77A9C76C8A4440	Akron	lauren99-akron@gmail.com	mockSession-3
-- 119	0101000020E6100000F86008EFE1CD55C0AE8218E8DA6B3E40	Pensacola	roger31-pensacola@gmail.com	mockSession-1
-- 120	0101000020E610000079EA910637B853C02E967DB2BD864140	Fayetteville	john99-fayetteville@gmail.com	mockSession-5
-- 121	0101000020E6100000738577B9884F57C04A52E3EF28534640	Lakeville	keith49-lakeville@gmail.com	mockSession-7
-- \.


--
-- Name: heatmap_heatmap_id_seq; Type: SEQUENCE SET; Schema: public; Owner: demo
--

-- SELECT pg_catalog.setval('heatmap_heatmap_id_seq', 121, true);


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: demo
--

COPY spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: django_site django_site_domain_a2e37b91_uniq; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_domain_a2e37b91_uniq UNIQUE (domain);


--
-- Name: django_site django_site_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_site
    ADD CONSTRAINT django_site_pkey PRIMARY KEY (id);


--
-- Name: heatmap_heatmap heatmap_heatmap_pkey; Type: CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY heatmap_heatmap
    ADD CONSTRAINT heatmap_heatmap_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_group_name_a6ea08ec_like ON auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_user_groups_group_id_97559544 ON auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX auth_user_username_6821ab7c_like ON auth_user USING btree (username varchar_pattern_ops);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX django_session_expire_date_a5c62663 ON django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX django_session_session_key_c0390e0f_like ON django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: django_site_domain_a2e37b91_like; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX django_site_domain_a2e37b91_like ON django_site USING btree (domain varchar_pattern_ops);


--
-- Name: heatmap_heatmap_location_id; Type: INDEX; Schema: public; Owner: demo
--

CREATE INDEX heatmap_heatmap_location_id ON heatmap_heatmap USING gist (location);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: demo
--

ALTER TABLE ONLY django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

