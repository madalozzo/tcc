--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.11
-- Dumped by pg_dump version 9.1.11
-- Started on 2013-12-17 00:03:41 BRST

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 171 (class 3079 OID 11685)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1959 (class 0 OID 0)
-- Dependencies: 171
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 161 (class 1259 OID 16859)
-- Dependencies: 5
-- Name: cidade; Type: TABLE; Schema: public; Owner: webadmin; Tablespace: 
--

CREATE TABLE cidade (
    cid_cod integer NOT NULL,
    cid_nome character varying(40) NOT NULL,
    cid_estado character(2) NOT NULL,
    cid_url character varying(40) NOT NULL
);


ALTER TABLE public.cidade OWNER TO webadmin;

--
-- TOC entry 162 (class 1259 OID 16862)
-- Dependencies: 161 5
-- Name: cidade_cid_cod_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE cidade_cid_cod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.cidade_cid_cod_seq OWNER TO webadmin;

--
-- TOC entry 1960 (class 0 OID 0)
-- Dependencies: 162
-- Name: cidade_cid_cod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE cidade_cid_cod_seq OWNED BY cidade.cid_cod;


--
-- TOC entry 163 (class 1259 OID 16864)
-- Dependencies: 5
-- Name: dados_min; Type: TABLE; Schema: public; Owner: webadmin; Tablespace: 
--

CREATE TABLE dados_min (
    dmi_cod bigint NOT NULL,
    dmi_est_cod integer NOT NULL,
    dmi_datahora timestamp with time zone NOT NULL,
    dmi_temp numeric(4,2),
    dmi_luz numeric(4,1),
    dmi_umidade numeric(4,2),
    dmi_pressao numeric(6,0),
    dmi_chuva numeric(7,4),
    dmi_ventomax numeric(4,1),
    dmi_ventomin numeric(4,1),
    dmi_ventomed numeric(4,1),
    dmi_dirvento smallint,
    dmi_real boolean NOT NULL,
    dmi_raios integer,
    dmi_radiacao integer
);


ALTER TABLE public.dados_min OWNER TO webadmin;

--
-- TOC entry 164 (class 1259 OID 16867)
-- Dependencies: 5 163
-- Name: dados_min_dmi_cod_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE dados_min_dmi_cod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dados_min_dmi_cod_seq OWNER TO webadmin;

--
-- TOC entry 1961 (class 0 OID 0)
-- Dependencies: 164
-- Name: dados_min_dmi_cod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE dados_min_dmi_cod_seq OWNED BY dados_min.dmi_cod;


--
-- TOC entry 165 (class 1259 OID 16869)
-- Dependencies: 5
-- Name: estacao; Type: TABLE; Schema: public; Owner: webadmin; Tablespace: 
--

CREATE TABLE estacao (
    est_cod integer NOT NULL,
    est_resp_cod integer NOT NULL,
    est_cidade integer NOT NULL,
    est_sandbox boolean NOT NULL,
    est_nome character varying(100) NOT NULL,
    est_url character varying(20) NOT NULL,
    est_latitude character varying(12) NOT NULL,
    est_longitude character varying(12) NOT NULL,
    est_altitude numeric(6,2) NOT NULL,
    est_token character(64) NOT NULL,
    est_senha character(64) NOT NULL,
    est_prefixo_fotos character varying(30) NOT NULL,
    est_fuso_local smallint NOT NULL,
    est_sens_temp character varying(30),
    est_sens_umidade character varying(30),
    est_sens_pressao character varying(30),
    est_sens_luminosidade character varying(30),
    est_sens_raio character varying(30),
    est_sens_pluviometro character varying(30),
    est_sens_anemometro character varying(30),
    est_sens_anemoscopio character varying(30),
    est_sens_beta_gama character varying(30),
    est_calc_pressao numeric(5,0) NOT NULL,
    est_calc_pluviometro numeric(6,3) NOT NULL,
    est_calc_anemometro numeric(6,3) NOT NULL,
    est_calc_luminosidade numeric(6,2) NOT NULL,
    est_uso character(2),
    est_local character varying(100),
    est_login character varying(5)
);


ALTER TABLE public.estacao OWNER TO webadmin;

--
-- TOC entry 166 (class 1259 OID 16875)
-- Dependencies: 5 165
-- Name: estacao_est_cod_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE estacao_est_cod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.estacao_est_cod_seq OWNER TO webadmin;

--
-- TOC entry 1962 (class 0 OID 0)
-- Dependencies: 166
-- Name: estacao_est_cod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE estacao_est_cod_seq OWNED BY estacao.est_cod;


--
-- TOC entry 167 (class 1259 OID 16877)
-- Dependencies: 5
-- Name: estacao_updt; Type: TABLE; Schema: public; Owner: webadmin; Tablespace: 
--

CREATE TABLE estacao_updt (
    estu_cod integer NOT NULL,
    estu_msg_success text,
    estu_msg_error text,
    estu_msg_info text,
    estu_msg_warn text,
    estu_last_gen_time bigint,
    estu_last_atualizacao timestamp with time zone
);


ALTER TABLE public.estacao_updt OWNER TO webadmin;

--
-- TOC entry 168 (class 1259 OID 16883)
-- Dependencies: 5
-- Name: responsavel; Type: TABLE; Schema: public; Owner: webadmin; Tablespace: 
--

CREATE TABLE responsavel (
    resp_cod integer NOT NULL,
    resp_email character varying(30) NOT NULL,
    resp_senha character varying(64) NOT NULL,
    resp_nome character varying(40) NOT NULL,
    resp_cid_cod integer NOT NULL
);


ALTER TABLE public.responsavel OWNER TO webadmin;

--
-- TOC entry 169 (class 1259 OID 16886)
-- Dependencies: 168 5
-- Name: responsavel_resp_cod_seq; Type: SEQUENCE; Schema: public; Owner: webadmin
--

CREATE SEQUENCE responsavel_resp_cod_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.responsavel_resp_cod_seq OWNER TO webadmin;

--
-- TOC entry 1963 (class 0 OID 0)
-- Dependencies: 169
-- Name: responsavel_resp_cod_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: webadmin
--

ALTER SEQUENCE responsavel_resp_cod_seq OWNED BY responsavel.resp_cod;


--
-- TOC entry 170 (class 1259 OID 16888)
-- Dependencies: 5
-- Name: uf; Type: TABLE; Schema: public; Owner: webadmin; Tablespace: 
--

CREATE TABLE uf (
    uf_sigla character(2) NOT NULL,
    uf_nome character varying(20) NOT NULL
);


ALTER TABLE public.uf OWNER TO webadmin;

--
-- TOC entry 1819 (class 2604 OID 16891)
-- Dependencies: 162 161
-- Name: cid_cod; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY cidade ALTER COLUMN cid_cod SET DEFAULT nextval('cidade_cid_cod_seq'::regclass);


--
-- TOC entry 1820 (class 2604 OID 16892)
-- Dependencies: 164 163
-- Name: dmi_cod; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY dados_min ALTER COLUMN dmi_cod SET DEFAULT nextval('dados_min_dmi_cod_seq'::regclass);


--
-- TOC entry 1821 (class 2604 OID 16893)
-- Dependencies: 166 165
-- Name: est_cod; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY estacao ALTER COLUMN est_cod SET DEFAULT nextval('estacao_est_cod_seq'::regclass);


--
-- TOC entry 1822 (class 2604 OID 16894)
-- Dependencies: 169 168
-- Name: resp_cod; Type: DEFAULT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY responsavel ALTER COLUMN resp_cod SET DEFAULT nextval('responsavel_resp_cod_seq'::regclass);


--
-- TOC entry 1942 (class 0 OID 16859)
-- Dependencies: 161 1952
-- Data for Name: cidade; Type: TABLE DATA; Schema: public; Owner: webadmin
--

COPY cidade (cid_cod, cid_nome, cid_estado, cid_url) FROM stdin;
1	Erechim	RS	erechim
\.


--
-- TOC entry 1964 (class 0 OID 0)
-- Dependencies: 162
-- Name: cidade_cid_cod_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('cidade_cid_cod_seq', 1, true);


--
-- TOC entry 1944 (class 0 OID 16864)
-- Dependencies: 163 1952
-- Data for Name: dados_min; Type: TABLE DATA; Schema: public; Owner: webadmin
--

COPY dados_min (dmi_cod, dmi_est_cod, dmi_datahora, dmi_temp, dmi_luz, dmi_umidade, dmi_pressao, dmi_chuva, dmi_ventomax, dmi_ventomin, dmi_ventomed, dmi_dirvento, dmi_real, dmi_raios, dmi_radiacao) FROM stdin;
785	5	2013-12-05 18:03:46-02	24.53	-1.0	68.98	92303	0.0000	0.0	0.0	0.0	8	t	0	-1
790	6	2013-12-05 18:05:51-02	25.15	-1.0	63.91	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
795	5	2013-12-05 18:08:45-02	24.65	-1.0	67.40	92300	0.0000	0.0	0.0	0.0	8	t	0	-1
800	6	2013-12-05 18:10:52-02	25.38	-1.0	62.52	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
805	5	2013-12-05 18:13:45-02	24.79	-1.0	66.58	92317	0.0000	0.0	0.0	0.0	8	t	0	-1
810	6	2013-12-05 18:15:52-02	25.34	-1.0	62.20	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
815	5	2013-12-05 18:18:44-02	24.77	-1.0	66.29	92316	0.0000	0.0	0.0	0.0	8	t	0	-1
820	6	2013-12-05 18:20:52-02	25.35	-1.0	62.06	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
825	5	2013-12-05 18:23:44-02	24.75	-1.0	66.33	92307	0.0000	0.0	0.0	0.0	8	t	0	-1
830	6	2013-12-05 18:25:52-02	25.35	-1.0	62.01	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
835	5	2013-12-05 18:28:44-02	24.70	-1.0	66.35	92305	0.0000	0.0	0.0	0.0	8	t	0	-1
840	6	2013-12-05 18:30:52-02	25.28	-1.0	62.01	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
845	5	2013-12-05 18:33:43-02	24.65	-1.0	66.38	92324	0.0000	0.0	0.0	0.0	8	t	0	-1
850	6	2013-12-05 18:35:52-02	25.47	-1.0	61.68	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
855	5	2013-12-05 18:38:43-02	24.66	-1.0	66.42	92318	0.0000	0.0	0.0	0.0	8	t	0	-1
860	6	2013-12-05 18:40:52-02	25.76	-1.0	60.40	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
865	6	2013-12-05 18:44:53-02	25.73	-1.0	61.24	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
870	5	2013-12-05 18:47:42-02	24.97	-1.0	67.57	92333	0.0000	0.0	0.0	0.0	8	t	0	-1
875	6	2013-12-05 18:49:51-02	25.82	-1.0	61.51	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
880	6	2013-12-05 18:52:51-02	26.07	-1.0	61.36	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
885	5	2013-12-05 18:55:17-02	25.13	-1.0	66.18	92338	0.0000	0.0	0.0	0.0	8	t	0	-1
890	5	2013-12-05 21:38:11-02	23.99	-1.0	67.13	92516	0.0000	0.0	0.0	0.0	8	t	0	-1
895	5	2013-12-05 21:43:11-02	24.11	-1.0	66.61	92508	17.0000	0.0	0.0	0.0	8	t	0	-1
786	6	2013-12-05 18:03:51-02	25.05	-1.0	65.08	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
791	5	2013-12-05 18:06:45-02	24.59	-1.0	67.72	92304	0.0000	0.0	0.0	0.0	8	t	0	-1
796	6	2013-12-05 18:08:52-02	25.30	-1.0	63.04	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
801	5	2013-12-05 18:11:45-02	24.77	-1.0	66.94	92315	0.0000	0.0	0.0	0.0	8	t	0	-1
806	6	2013-12-05 18:13:52-02	25.35	-1.0	62.35	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
811	5	2013-12-05 18:16:45-02	24.80	-1.0	66.36	92313	0.0000	0.0	0.0	0.0	8	t	0	-1
816	6	2013-12-05 18:18:52-02	25.41	-1.0	61.99	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
821	5	2013-12-05 18:21:44-02	24.76	-1.0	66.27	92300	0.0000	0.0	0.0	0.0	8	t	0	-1
826	6	2013-12-05 18:23:52-02	25.35	-1.0	61.94	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
831	5	2013-12-05 18:26:44-02	24.72	-1.0	66.35	92302	0.0000	0.0	0.0	0.0	8	t	0	-1
836	6	2013-12-05 18:28:52-02	25.32	-1.0	62.01	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
841	5	2013-12-05 18:31:43-02	24.68	-1.0	66.39	92322	0.0000	0.0	0.0	0.0	8	t	0	-1
846	6	2013-12-05 18:33:52-02	25.38	-1.0	61.72	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
851	5	2013-12-05 18:36:43-02	24.62	-1.0	66.51	92324	0.0000	0.0	0.0	0.0	8	t	0	-1
856	6	2013-12-05 18:38:52-02	25.68	-1.0	60.93	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
861	5	2013-12-05 18:41:43-02	24.75	-1.0	66.13	92324	0.0000	0.0	0.0	0.0	8	t	0	-1
871	6	2013-12-05 18:47:51-02	25.71	-1.0	61.51	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
866	5	2013-12-05 18:45:42-02	24.90	-1.0	67.46	92332	0.0000	0.0	0.0	75.0	4	t	0	-1
781	5	2013-12-05 18:01:46-02	24.44	-1.0	68.66	92310	0.0000	0.0	0.0	0.0	8	t	0	-1
876	5	2013-12-05 18:50:42-02	25.05	-1.0	67.09	92342	0.0000	0.0	0.0	0.0	8	t	0	-1
881	5	2013-12-05 18:53:17-02	25.12	-1.0	66.67	92346	0.0000	0.0	0.0	0.0	8	t	0	-1
886	6	2013-12-05 18:55:51-02	26.16	-1.0	60.21	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
891	5	2013-12-05 21:39:11-02	23.94	-1.0	67.08	92515	0.0000	0.0	0.0	0.0	8	t	0	-1
896	5	2013-12-05 21:44:11-02	24.15	-1.0	66.43	92511	0.0000	0.0	0.0	0.0	8	t	0	-1
787	5	2013-12-05 18:04:46-02	24.54	-1.0	68.41	92297	0.0000	0.0	0.0	0.0	8	t	0	-1
792	6	2013-12-05 18:06:52-02	25.20	-1.0	63.55	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
797	5	2013-12-05 18:09:45-02	24.70	-1.0	67.25	92304	0.0000	0.0	0.0	0.0	8	t	0	-1
802	6	2013-12-05 18:11:52-02	25.41	-1.0	62.09	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
807	5	2013-12-05 18:14:45-02	24.80	-1.0	66.50	92315	0.0000	0.0	0.0	0.0	8	t	0	-1
812	6	2013-12-05 18:16:52-02	25.35	-1.0	62.23	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
817	5	2013-12-05 18:19:44-02	24.77	-1.0	66.29	92323	0.0000	0.0	0.0	0.0	8	t	0	-1
822	6	2013-12-05 18:21:52-02	25.32	-1.0	62.11	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
827	5	2013-12-05 18:24:44-02	24.73	-1.0	66.33	92301	0.0000	0.0	0.0	0.0	8	t	0	-1
832	6	2013-12-05 18:26:52-02	25.35	-1.0	61.91	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
837	5	2013-12-05 18:29:44-02	24.69	-1.0	66.35	92313	0.0000	0.0	0.0	0.0	8	t	0	-1
842	6	2013-12-05 18:31:52-02	25.34	-1.0	62.01	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
847	5	2013-12-05 18:34:43-02	24.64	-1.0	66.45	92320	0.0000	0.0	0.0	0.0	8	t	0	-1
852	6	2013-12-05 18:36:52-02	25.54	-1.0	61.27	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
857	5	2013-12-05 18:39:43-02	24.69	-1.0	66.30	92315	0.0000	0.0	0.0	0.0	8	t	0	-1
862	6	2013-12-05 18:41:52-02	25.72	-1.0	60.66	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
867	6	2013-12-05 18:45:51-02	25.71	-1.0	60.98	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
872	5	2013-12-05 18:48:42-02	24.98	-1.0	67.36	92336	0.0000	0.0	0.0	0.0	8	t	0	-1
877	6	2013-12-05 18:50:51-02	25.79	-1.0	61.58	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
782	6	2013-12-05 18:01:51-02	24.87	-1.0	64.51	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
882	6	2013-12-05 18:53:51-02	26.12	-1.0	60.44	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
887	5	2013-12-05 21:35:11-02	23.99	-1.0	66.89	92500	0.0000	0.0	0.0	0.0	8	t	0	-1
892	5	2013-12-05 21:40:11-02	23.98	-1.0	67.05	92518	0.0000	0.0	0.0	0.0	8	t	0	-1
897	5	2013-12-05 21:45:11-02	24.17	-1.0	66.05	92510	0.0000	0.0	0.0	0.0	8	t	0	-1
788	6	2013-12-05 18:04:51-02	25.13	-1.0	63.79	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
793	5	2013-12-05 18:07:45-02	24.62	-1.0	67.55	92299	0.0000	0.0	0.0	0.0	8	t	0	-1
798	6	2013-12-05 18:09:52-02	25.37	-1.0	62.56	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
803	5	2013-12-05 18:12:45-02	24.79	-1.0	66.69	92322	0.0000	0.0	0.0	0.0	8	t	0	-1
808	6	2013-12-05 18:14:52-02	25.35	-1.0	62.30	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
813	5	2013-12-05 18:17:45-02	24.80	-1.0	66.34	92311	0.0000	0.0	0.0	0.0	8	t	0	-1
818	6	2013-12-05 18:19:52-02	25.39	-1.0	61.94	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
823	5	2013-12-05 18:22:44-02	24.76	-1.0	66.29	92302	0.0000	0.0	0.0	0.0	8	t	0	-1
828	6	2013-12-05 18:24:52-02	25.34	-1.0	62.01	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
833	5	2013-12-05 18:27:44-02	24.72	-1.0	66.35	92306	0.0000	0.0	0.0	0.0	8	t	0	-1
838	6	2013-12-05 18:29:52-02	25.34	-1.0	61.99	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
843	5	2013-12-05 18:32:43-02	24.65	-1.0	66.40	92322	0.0000	0.0	0.0	0.0	8	t	0	-1
848	6	2013-12-05 18:34:52-02	25.41	-1.0	61.65	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
853	5	2013-12-05 18:37:43-02	24.65	-1.0	66.45	92324	0.0000	0.0	0.0	0.0	8	t	0	-1
858	6	2013-12-05 18:39:52-02	25.76	-1.0	60.71	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
863	5	2013-12-05 18:42:43-02	24.79	-1.0	66.03	92319	0.0000	0.0	0.0	0.0	8	t	0	-1
868	5	2013-12-05 18:46:42-02	24.93	-1.0	67.19	92339	0.0000	0.0	0.0	11.0	4	t	0	-1
873	6	2013-12-05 18:48:51-02	25.75	-1.0	61.48	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
878	5	2013-12-05 18:51:42-02	25.09	-1.0	67.06	92333	0.0000	0.0	0.0	0.0	8	t	0	-1
883	5	2013-12-05 18:54:17-02	25.12	-1.0	66.43	92339	0.0000	0.0	0.0	0.0	8	t	0	-1
783	5	2013-12-05 18:02:46-02	24.47	-1.0	69.09	92307	0.0000	0.0	0.0	0.0	8	t	0	-1
888	5	2013-12-05 21:36:11-02	23.98	-1.0	66.84	92500	0.0000	0.0	0.0	0.0	8	t	0	-1
893	5	2013-12-05 21:41:12-02	23.98	-1.0	67.33	92518	0.0000	0.0	0.0	0.0	8	t	0	-1
898	5	2013-12-05 21:46:11-02	24.10	-1.0	65.95	92511	0.0000	0.0	0.0	0.0	8	t	0	-1
789	5	2013-12-05 18:05:46-02	24.57	-1.0	67.92	92299	0.0000	0.0	0.0	0.0	8	t	0	-1
794	6	2013-12-05 18:07:52-02	25.26	-1.0	63.33	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
799	5	2013-12-05 18:10:45-02	24.73	-1.0	67.05	92304	0.0000	0.0	0.0	0.0	8	t	0	-1
804	6	2013-12-05 18:12:52-02	25.37	-1.0	62.20	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
809	5	2013-12-05 18:15:45-02	24.79	-1.0	66.43	92310	0.0000	0.0	0.0	0.0	8	t	0	-1
814	6	2013-12-05 18:17:52-02	25.38	-1.0	62.13	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
819	5	2013-12-05 18:20:44-02	24.77	-1.0	66.31	92309	0.0000	0.0	0.0	0.0	8	t	0	-1
824	6	2013-12-05 18:22:52-02	25.34	-1.0	62.06	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
829	5	2013-12-05 18:25:44-02	24.73	-1.0	66.33	92300	0.0000	0.0	0.0	0.0	8	t	0	-1
834	6	2013-12-05 18:27:52-02	25.34	-1.0	61.96	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
839	5	2013-12-05 18:30:44-02	24.69	-1.0	66.35	92319	0.0000	0.0	0.0	0.0	8	t	0	-1
844	6	2013-12-05 18:32:52-02	25.39	-1.0	61.72	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
849	5	2013-12-05 18:35:43-02	24.62	-1.0	66.45	92327	0.0000	0.0	0.0	0.0	8	t	0	-1
854	6	2013-12-05 18:37:52-02	25.61	-1.0	61.07	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
859	5	2013-12-05 18:40:43-02	24.73	-1.0	66.23	92320	0.0000	0.0	0.0	0.0	8	t	0	-1
864	6	2013-12-05 18:42:52-02	25.76	-1.0	60.47	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
869	6	2013-12-05 18:46:51-02	25.68	-1.0	61.17	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
874	5	2013-12-05 18:49:42-02	25.04	-1.0	67.39	92341	0.0000	0.0	0.0	0.0	8	t	0	-1
879	6	2013-12-05 18:51:51-02	25.96	-1.0	61.74	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
784	6	2013-12-05 18:02:51-02	24.98	-1.0	63.71	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
884	6	2013-12-05 18:54:51-02	26.23	-1.0	60.04	100000	0.0000	0.0	0.0	0.0	-1	t	0	-1
889	5	2013-12-05 21:37:11-02	23.95	-1.0	67.28	92510	0.0000	0.0	0.0	0.0	8	t	0	-1
894	5	2013-12-05 21:42:11-02	23.98	-1.0	66.83	92518	5.0000	0.0	0.0	0.0	8	t	0	-1
\.


--
-- TOC entry 1965 (class 0 OID 0)
-- Dependencies: 164
-- Name: dados_min_dmi_cod_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('dados_min_dmi_cod_seq', 898, true);


--
-- TOC entry 1946 (class 0 OID 16869)
-- Dependencies: 165 1952
-- Data for Name: estacao; Type: TABLE DATA; Schema: public; Owner: webadmin
--

COPY estacao (est_cod, est_resp_cod, est_cidade, est_sandbox, est_nome, est_url, est_latitude, est_longitude, est_altitude, est_token, est_senha, est_prefixo_fotos, est_fuso_local, est_sens_temp, est_sens_umidade, est_sens_pressao, est_sens_luminosidade, est_sens_raio, est_sens_pluviometro, est_sens_anemometro, est_sens_anemoscopio, est_sens_beta_gama, est_calc_pressao, est_calc_pluviometro, est_calc_anemometro, est_calc_luminosidade, est_uso, est_local, est_login) FROM stdin;
1	1	1	f	Centro	centro	-	-	1.00	6df3bb2df4ff929fa28e68a0b2fc7a2b5a6e9f0c3947c47990bf07c5a3e14798	e707c32d38e292f40f1014fbc26b7b643ffa07c1957c175ea7a4451a6839a66e	-	-3	-	-	-	-	-	-	-	-	-	1	1.000	1.000	1.00	1 	Rua Fernando Sefrin, Bairro Centro	ekdb7
5	1	1	f	URI 1	uri1	-	-	1.00	26d3487922a7a7016fdd6de1c35aa111599dbe4aee1b0c5d8bfe0c914117c734	43d05f51474ef919a0eddfa64084a16990e5d1d0d675aea30d2d47aa5b445ad4	-	-3	-	-	-	-	-	-	-	-	-	1	1.000	1.000	1.00	1 	Apresentação TCC - 1	j7x8q
6	1	1	f	URI 2	uri2	-	-	1.00	e7893e21358165366377f193a4e30c14287a113f539d74ec46942c5e8c3b4bdf	43166f2d9daa691751a09a69de44f923109333fb724cbf38459541424ab2f284	-	-3	-	-	-	-	-	-	-	-	-	1	1.000	1.000	1.00	1 	Apresentação TCC - 2	gi5ak
\.


--
-- TOC entry 1966 (class 0 OID 0)
-- Dependencies: 166
-- Name: estacao_est_cod_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('estacao_est_cod_seq', 6, true);


--
-- TOC entry 1948 (class 0 OID 16877)
-- Dependencies: 167 1952
-- Data for Name: estacao_updt; Type: TABLE DATA; Schema: public; Owner: webadmin
--

COPY estacao_updt (estu_cod, estu_msg_success, estu_msg_error, estu_msg_info, estu_msg_warn, estu_last_gen_time, estu_last_atualizacao) FROM stdin;
\.


--
-- TOC entry 1949 (class 0 OID 16883)
-- Dependencies: 168 1952
-- Data for Name: responsavel; Type: TABLE DATA; Schema: public; Owner: webadmin
--

COPY responsavel (resp_cod, resp_email, resp_senha, resp_nome, resp_cid_cod) FROM stdin;
1	saulo.zz@gmail.com	no	Saulo Matté Madalozzo	1
\.


--
-- TOC entry 1967 (class 0 OID 0)
-- Dependencies: 169
-- Name: responsavel_resp_cod_seq; Type: SEQUENCE SET; Schema: public; Owner: webadmin
--

SELECT pg_catalog.setval('responsavel_resp_cod_seq', 1, false);


--
-- TOC entry 1951 (class 0 OID 16888)
-- Dependencies: 170 1952
-- Data for Name: uf; Type: TABLE DATA; Schema: public; Owner: webadmin
--

COPY uf (uf_sigla, uf_nome) FROM stdin;
RS	Rio Grande do Sul
SC	Santa Catarina
\.


--
-- TOC entry 1824 (class 2606 OID 16896)
-- Dependencies: 161 161 1953
-- Name: cidade_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin; Tablespace: 
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT cidade_pkey PRIMARY KEY (cid_cod);


--
-- TOC entry 1826 (class 2606 OID 16898)
-- Dependencies: 163 163 1953
-- Name: dados_min_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin; Tablespace: 
--

ALTER TABLE ONLY dados_min
    ADD CONSTRAINT dados_min_pkey PRIMARY KEY (dmi_cod);


--
-- TOC entry 1828 (class 2606 OID 16900)
-- Dependencies: 165 165 1953
-- Name: estacao_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin; Tablespace: 
--

ALTER TABLE ONLY estacao
    ADD CONSTRAINT estacao_pkey PRIMARY KEY (est_cod);


--
-- TOC entry 1830 (class 2606 OID 16902)
-- Dependencies: 167 167 1953
-- Name: estacao_updt_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin; Tablespace: 
--

ALTER TABLE ONLY estacao_updt
    ADD CONSTRAINT estacao_updt_pkey PRIMARY KEY (estu_cod);


--
-- TOC entry 1832 (class 2606 OID 16904)
-- Dependencies: 168 168 1953
-- Name: responsavel_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin; Tablespace: 
--

ALTER TABLE ONLY responsavel
    ADD CONSTRAINT responsavel_pkey PRIMARY KEY (resp_cod);


--
-- TOC entry 1834 (class 2606 OID 16906)
-- Dependencies: 170 170 1953
-- Name: uf_pkey; Type: CONSTRAINT; Schema: public; Owner: webadmin; Tablespace: 
--

ALTER TABLE ONLY uf
    ADD CONSTRAINT uf_pkey PRIMARY KEY (uf_sigla);


--
-- TOC entry 1835 (class 2606 OID 16907)
-- Dependencies: 161 1833 170 1953
-- Name: cidade_cid_estado_fkey; Type: FK CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY cidade
    ADD CONSTRAINT cidade_cid_estado_fkey FOREIGN KEY (cid_estado) REFERENCES uf(uf_sigla);


--
-- TOC entry 1836 (class 2606 OID 16912)
-- Dependencies: 1827 165 163 1953
-- Name: dados_min_dmi_est_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY dados_min
    ADD CONSTRAINT dados_min_dmi_est_cod_fkey FOREIGN KEY (dmi_est_cod) REFERENCES estacao(est_cod);


--
-- TOC entry 1837 (class 2606 OID 16917)
-- Dependencies: 1823 165 161 1953
-- Name: estacao_est_cidade_fkey; Type: FK CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY estacao
    ADD CONSTRAINT estacao_est_cidade_fkey FOREIGN KEY (est_cidade) REFERENCES cidade(cid_cod);


--
-- TOC entry 1838 (class 2606 OID 16922)
-- Dependencies: 165 1831 168 1953
-- Name: estacao_est_resp_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY estacao
    ADD CONSTRAINT estacao_est_resp_cod_fkey FOREIGN KEY (est_resp_cod) REFERENCES responsavel(resp_cod);


--
-- TOC entry 1839 (class 2606 OID 16927)
-- Dependencies: 165 1827 167 1953
-- Name: estacao_updt_estu_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY estacao_updt
    ADD CONSTRAINT estacao_updt_estu_cod_fkey FOREIGN KEY (estu_cod) REFERENCES estacao(est_cod);


--
-- TOC entry 1840 (class 2606 OID 16932)
-- Dependencies: 168 1823 161 1953
-- Name: responsavel_resp_cid_cod_fkey; Type: FK CONSTRAINT; Schema: public; Owner: webadmin
--

ALTER TABLE ONLY responsavel
    ADD CONSTRAINT responsavel_resp_cid_cod_fkey FOREIGN KEY (resp_cid_cod) REFERENCES cidade(cid_cod);


--
-- TOC entry 1958 (class 0 OID 0)
-- Dependencies: 5
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2013-12-17 00:03:41 BRST

--
-- PostgreSQL database dump complete
--

