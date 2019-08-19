--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
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


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: lists; Type: TABLE; Schema: public; Owner: charlesging
--

CREATE TABLE public.lists (
    id integer NOT NULL,
    name text NOT NULL
);


ALTER TABLE public.lists OWNER TO charlesging;

--
-- Name: lists_id_seq; Type: SEQUENCE; Schema: public; Owner: charlesging
--

CREATE SEQUENCE public.lists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.lists_id_seq OWNER TO charlesging;

--
-- Name: lists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: charlesging
--

ALTER SEQUENCE public.lists_id_seq OWNED BY public.lists.id;


--
-- Name: todos; Type: TABLE; Schema: public; Owner: charlesging
--

CREATE TABLE public.todos (
    id integer NOT NULL,
    name text NOT NULL,
    completed boolean DEFAULT false NOT NULL,
    list_id integer NOT NULL
);


ALTER TABLE public.todos OWNER TO charlesging;

--
-- Name: todos_id_seq; Type: SEQUENCE; Schema: public; Owner: charlesging
--

CREATE SEQUENCE public.todos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todos_id_seq OWNER TO charlesging;

--
-- Name: todos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: charlesging
--

ALTER SEQUENCE public.todos_id_seq OWNED BY public.todos.id;


--
-- Name: lists id; Type: DEFAULT; Schema: public; Owner: charlesging
--

ALTER TABLE ONLY public.lists ALTER COLUMN id SET DEFAULT nextval('public.lists_id_seq'::regclass);


--
-- Name: todos id; Type: DEFAULT; Schema: public; Owner: charlesging
--

ALTER TABLE ONLY public.todos ALTER COLUMN id SET DEFAULT nextval('public.todos_id_seq'::regclass);


--
-- Data for Name: lists; Type: TABLE DATA; Schema: public; Owner: charlesging
--

COPY public.lists (id, name) FROM stdin;
6	Homework
7	Chores
\.


--
-- Data for Name: todos; Type: TABLE DATA; Schema: public; Owner: charlesging
--

COPY public.todos (id, name, completed, list_id) FROM stdin;
4	Math	f	6
3	Science	f	6
5	OOP	f	6
\.


--
-- Name: lists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: charlesging
--

SELECT pg_catalog.setval('public.lists_id_seq', 7, true);


--
-- Name: todos_id_seq; Type: SEQUENCE SET; Schema: public; Owner: charlesging
--

SELECT pg_catalog.setval('public.todos_id_seq', 5, true);


--
-- Name: lists lists_name_key; Type: CONSTRAINT; Schema: public; Owner: charlesging
--

ALTER TABLE ONLY public.lists
    ADD CONSTRAINT lists_name_key UNIQUE (name);


--
-- Name: lists lists_pkey; Type: CONSTRAINT; Schema: public; Owner: charlesging
--

ALTER TABLE ONLY public.lists
    ADD CONSTRAINT lists_pkey PRIMARY KEY (id);


--
-- Name: todos todos_pkey; Type: CONSTRAINT; Schema: public; Owner: charlesging
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_pkey PRIMARY KEY (id);


--
-- Name: todos todos_list_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: charlesging
--

ALTER TABLE ONLY public.todos
    ADD CONSTRAINT todos_list_id_fkey FOREIGN KEY (list_id) REFERENCES public.lists(id);


--
-- PostgreSQL database dump complete
--

