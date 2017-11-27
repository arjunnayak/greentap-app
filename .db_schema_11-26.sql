
--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.0
-- Dumped by pg_dump version 9.6.3

-- Started on 2017-11-26 21:58:54 PST

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS greentap 
--
-- TOC entry 2426 (class 1262 OID 16846)
-- Name: greentap; Type: DATABASE; Schema: -; Owner: arjunnayak
--

CREATE DATABASE greentap WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


ALTER DATABASE greentap OWNER TO arjunnayak;

\connect greentap

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12655)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2429 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 185 (class 1259 OID 16849)
-- Name: business; Type: TABLE; Schema: public; Owner: arjunnayak
--

CREATE TABLE business (
    zip character varying(10),
    year integer,
    address character varying,
    state character varying(50),
    num_employees integer,
    name character varying(200) NOT NULL,
    license_num character varying(30),
    city character varying(30),
    phone character varying(15),
    id integer NOT NULL,
    user_id integer
);


ALTER TABLE business OWNER TO arjunnayak;

--
-- TOC entry 190 (class 1259 OID 16935)
-- Name: business_id_seq; Type: SEQUENCE; Schema: public; Owner: arjunnayak
--

CREATE SEQUENCE business_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE business_id_seq OWNER TO arjunnayak;

--
-- TOC entry 2430 (class 0 OID 0)
-- Dependencies: 190
-- Name: business_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: arjunnayak
--

ALTER SEQUENCE business_id_seq OWNED BY business.id;


--
-- TOC entry 192 (class 1259 OID 16945)
-- Name: contact; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE contact (
    first_name character varying(30),
    last_name character varying(30),
    company character varying(50),
    message character varying,
    inquiry character varying(20),
    id integer NOT NULL,
    phone character varying(20),
    email character varying(100) NOT NULL
);


ALTER TABLE contact OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 16943)
-- Name: contact_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE contact_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE contact_id_seq OWNER TO postgres;

--
-- TOC entry 2431 (class 0 OID 0)
-- Dependencies: 191
-- Name: contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE contact_id_seq OWNED BY contact.id;


--
-- TOC entry 188 (class 1259 OID 16874)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE product (
    business_id integer,
    name character varying(100) NOT NULL,
    description character varying(750),
    id integer NOT NULL,
    image character varying(150)
);


ALTER TABLE product OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 16909)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE product_id_seq OWNER TO postgres;

--
-- TOC entry 2432 (class 0 OID 0)
-- Dependencies: 189
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE product_id_seq OWNED BY product.id;


--
-- TOC entry 186 (class 1259 OID 16855)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "user" (
    first_name character varying(30) NOT NULL,
    password character varying NOT NULL,
    email character varying(30) NOT NULL,
    last_name character varying(30) NOT NULL,
    id integer NOT NULL,
    business_type character varying(20) NOT NULL
);


ALTER TABLE "user" OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16864)
-- Name: user_id_seq1; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_id_seq1
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq1 OWNER TO postgres;

--
-- TOC entry 2433 (class 0 OID 0)
-- Dependencies: 187
-- Name: user_id_seq1; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_id_seq1 OWNED BY "user".id;


--
-- TOC entry 2289 (class 2604 OID 16937)
-- Name: business id; Type: DEFAULT; Schema: public; Owner: arjunnayak
--

ALTER TABLE ONLY business ALTER COLUMN id SET DEFAULT nextval('business_id_seq'::regclass);


--
-- TOC entry 2292 (class 2604 OID 16948)
-- Name: contact id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact ALTER COLUMN id SET DEFAULT nextval('contact_id_seq'::regclass);


--
-- TOC entry 2291 (class 2604 OID 16911)
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product ALTER COLUMN id SET DEFAULT nextval('product_id_seq'::regclass);


--
-- TOC entry 2290 (class 2604 OID 16866)
-- Name: user id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user" ALTER COLUMN id SET DEFAULT nextval('user_id_seq1'::regclass);


--
-- TOC entry 2294 (class 2606 OID 16942)
-- Name: business business_pkey1; Type: CONSTRAINT; Schema: public; Owner: arjunnayak
--

ALTER TABLE ONLY business
    ADD CONSTRAINT business_pkey1 PRIMARY KEY (id);


--
-- TOC entry 2302 (class 2606 OID 16953)
-- Name: contact contact_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY contact
    ADD CONSTRAINT contact_pkey PRIMARY KEY (id);


--
-- TOC entry 2296 (class 2606 OID 16958)
-- Name: user id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT id_unique UNIQUE (id);


--
-- TOC entry 2300 (class 2606 OID 16919)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 2298 (class 2606 OID 16862)
-- Name: user user_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey1 PRIMARY KEY (email);


--
-- TOC entry 2304 (class 2606 OID 16974)
-- Name: product business_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY product
    ADD CONSTRAINT business_product_fkey FOREIGN KEY (business_id) REFERENCES business(id);


--
-- TOC entry 2303 (class 2606 OID 16964)
-- Name: business business_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: arjunnayak
--

ALTER TABLE ONLY business
    ADD CONSTRAINT business_user_fkey FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2428 (class 0 OID 0)
-- Dependencies: 7
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2017-11-26 21:58:54 PST

--
-- PostgreSQL database dump complete
--

