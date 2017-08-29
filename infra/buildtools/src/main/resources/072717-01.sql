--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.3
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-07-28 14:51:23 PHT

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2209 (class 1262 OID 24586)
-- Name: emp_management; Type: DATABASE; Schema: -; Owner: postgres
--
CREATE DATABASE emp_management WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_PH.UTF-8' LC_CTYPE = 'en_PH.UTF-8';


ALTER DATABASE emp_management OWNER TO postgres;

-- connect emp_management

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12425)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2211 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 190 (class 1259 OID 32875)
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact (
    id bigint NOT NULL,
    person_id bigint NOT NULL,
    contact_type_id bigint NOT NULL,
    contact_desc character varying(50) NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE contact OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 32873)
-- Name: contact_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contact_id_seq OWNER TO postgres;

--
-- TOC entry 2212 (class 0 OID 0)
-- Dependencies: 189
-- Name: contact_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contact_id_seq OWNED BY contact.id;


--
-- TOC entry 188 (class 1259 OID 32867)
-- Name: contact_type; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact_type (
    id bigint NOT NULL,
    contact_type_code character varying(5) NOT NULL,
    type_desc character varying(30) NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE contact_type OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 32865)
-- Name: contact_type_contact_type_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contact_type_id_seq OWNER TO postgres;

--
-- TOC entry 2213 (class 0 OID 0)
-- Dependencies: 187
-- Name: contact_type_contact_type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contact_type_seq OWNED BY contact_type.id;


--
-- TOC entry 186 (class 1259 OID 32853)
-- Name: person; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE person (
    id bigint NOT NULL,
    last_name character varying(50) NOT NULL,
    first_name character varying(50) NOT NULL,
    mid_name character varying(20) DEFAULT NULL::character varying,
    suffix character varying(4) DEFAULT NULL::character varying,
    title character varying(6) DEFAULT NULL::character varying,
    birth_date date NOT NULL,
    gwa numeric(5,2) DEFAULT NULL::numeric,
    date_hired date,
    employed boolean NOT NULL,
    street character varying(50) DEFAULT NULL::character varying,
    barangay character varying(50) DEFAULT NULL::character varying,
    municipality character varying(50) NOT NULL,
    zipcode integer,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE person OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 32851)
-- Name: person_person_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE person_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE person_id_seq OWNER TO postgres;

--
-- TOC entry 2214 (class 0 OID 0)
-- Dependencies: 185
-- Name: person_person_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE person_id_seq OWNED BY person.id;


--
-- TOC entry 193 (class 1259 OID 32899)
-- Name: person_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE person_role (
    person_id bigint NOT NULL,
    role_id bigint NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE person_role OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 32893)
-- Name: role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE role (
    id bigint NOT NULL,
    role_code character varying(5) NOT NULL,
    role character varying(30) NOT NULL,
    deleted boolean DEFAULT false NOT NULL
);


ALTER TABLE role OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 32891)
-- Name: role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE role_id_seq OWNER TO postgres;

--
-- TOC entry 2215 (class 0 OID 0)
-- Dependencies: 191
-- Name: role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE role_id_seq OWNED BY role.id;


--
-- TOC entry 2069 (class 2604 OID 32878)
-- Name: contact contact_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact ALTER COLUMN id SET DEFAULT nextval('contact_id_seq'::regclass);


--
-- TOC entry 2067 (class 2604 OID 32870)
-- Name: contact_type contact_type_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_type ALTER COLUMN id SET DEFAULT nextval('contact_type_id_seq'::regclass);


--
-- TOC entry 2059 (class 2604 OID 32856)
-- Name: person person_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person ALTER COLUMN id SET DEFAULT nextval('person_id_seq'::regclass);


--
-- TOC entry 2071 (class 2604 OID 32896)
-- Name: role role_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role ALTER COLUMN id SET DEFAULT nextval('role_id_seq'::regclass);


--
-- TOC entry 2079 (class 2606 OID 32880)
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (person_id, id);


--
-- TOC entry 2077 (class 2606 OID 32872)
-- Name: contact_type contact_type_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact_type
    ADD CONSTRAINT contact_type_pkey PRIMARY KEY (id);


--
-- TOC entry 2075 (class 2606 OID 32864)
-- Name: person person_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person
    ADD CONSTRAINT person_pkey PRIMARY KEY (id);


--
-- TOC entry 2083 (class 2606 OID 32903)
-- Name: person_role person_role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person_role
    ADD CONSTRAINT person_role_pkey PRIMARY KEY (person_id, role_id);


--
-- TOC entry 2081 (class 2606 OID 32898)
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- TOC entry 2084 (class 2606 OID 32881)
-- Name: contact fk_contact_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT fk_contact_person_id FOREIGN KEY (person_id) REFERENCES person(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2085 (class 2606 OID 32886)
-- Name: contact fk_contact_type_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT fk_contact_type_id FOREIGN KEY (contact_type_id) REFERENCES contact_type(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2086 (class 2606 OID 32904)
-- Name: person_role fk_role_person_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person_role
    ADD CONSTRAINT fk_role_person_id FOREIGN KEY (person_id) REFERENCES person(id);


--
-- TOC entry 2087 (class 2606 OID 32909)
-- Name: person_role fk_role_role_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY person_role
    ADD CONSTRAINT fk_role_role_id FOREIGN KEY (role_id) REFERENCES role(id);


-- Completed on 2017-07-28 14:51:24 PHT

--
-- PostgreSQL database dump complete
--

