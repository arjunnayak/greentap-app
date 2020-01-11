--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.0
-- Dumped by pg_dump version 9.6.3

-- Started on 2018-05-25 19:32:00 PDT

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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2474 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_with_oids = false;

--
-- TOC entry 196 (class 1259 OID 17407)
-- Name: additional_license; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE additional_license (
    business_id uuid NOT NULL,
    license_state character varying(50) NOT NULL,
    license_num character varying(256) NOT NULL,
    license_type character varying(256) NOT NULL,
    id uuid NOT NULL
);


--
-- TOC entry 185 (class 1259 OID 16849)
-- Name: business; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE business (
    zip character varying(10),
    year integer,
    address character varying,
    state character varying(50),
    name character varying(200) NOT NULL,
    license_state character varying(50),
    city character varying(30),
    phone character varying(15),
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    description character varying(1024),
    available_in character varying(150),
    image character varying(1024),
    license_num character varying(256),
    license_type character varying(256)
);


--
-- TOC entry 191 (class 1259 OID 17110)
-- Name: concentrate; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE concentrate (
    product_id uuid NOT NULL,
    business_id uuid NOT NULL,
    strain_type character varying(20),
    thc_level smallint,
    cbd_level smallint
);


--
-- TOC entry 193 (class 1259 OID 17133)
-- Name: edible; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE edible (
    product_id uuid NOT NULL,
    business_id uuid NOT NULL
);


--
-- TOC entry 190 (class 1259 OID 17095)
-- Name: flower; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE flower (
    business_id uuid NOT NULL,
    product_id uuid NOT NULL,
    strain_type character varying(10),
    thc_level smallint,
    cbd_level smallint
);


--
-- TOC entry 195 (class 1259 OID 17307)
-- Name: inquiry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE inquiry (
    unit_price integer,
    buyer_user_id uuid,
    seller_business_id uuid,
    id uuid NOT NULL,
    unit_count integer,
    unit_count_type character varying(30),
    product_id uuid
);


--
-- TOC entry 187 (class 1259 OID 16874)
-- Name: product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE product (
    name character varying(100) NOT NULL,
    description character varying(1024),
    image character varying(255),
    id uuid NOT NULL,
    business_id uuid NOT NULL,
    category character varying(50) NOT NULL,
    sub_category character varying(50)
);


--
-- TOC entry 192 (class 1259 OID 17125)
-- Name: product_pricing; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE product_pricing (
    product_id uuid NOT NULL,
    unit_count_type character varying(30) NOT NULL,
    unit_price integer NOT NULL,
    unit_count integer NOT NULL
);


--
-- TOC entry 188 (class 1259 OID 16997)
-- Name: reset_password_request; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE reset_password_request (
    email character varying(100) NOT NULL,
    token character varying(64) NOT NULL,
    "timestamp" timestamp(6) with time zone,
    used boolean DEFAULT false NOT NULL
);


--
-- TOC entry 194 (class 1259 OID 17164)
-- Name: topical; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE topical (
    product_id uuid NOT NULL,
    business_id uuid NOT NULL
);


--
-- TOC entry 186 (class 1259 OID 16855)
-- Name: user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE "user" (
    first_name character varying(50) NOT NULL,
    password character varying NOT NULL,
    email character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    business_type character varying(20) NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    id uuid NOT NULL
);


--
-- TOC entry 189 (class 1259 OID 17030)
-- Name: user_verification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_verification (
    email character varying(100) NOT NULL,
    token character varying(64) NOT NULL
);


--
-- TOC entry 2334 (class 2606 OID 17420)
-- Name: additional_license additional_license_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY additional_license
    ADD CONSTRAINT additional_license_pkey PRIMARY KEY (id);


--
-- TOC entry 2316 (class 2606 OID 17067)
-- Name: business business_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY business
    ADD CONSTRAINT business_pkey PRIMARY KEY (id);


--
-- TOC entry 2330 (class 2606 OID 17114)
-- Name: concentrate concentrate_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concentrate
    ADD CONSTRAINT concentrate_pkey PRIMARY KEY (product_id);


--
-- TOC entry 2328 (class 2606 OID 17099)
-- Name: flower flower_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flower
    ADD CONSTRAINT flower_pkey PRIMARY KEY (product_id);


--
-- TOC entry 2332 (class 2606 OID 17311)
-- Name: inquiry inquiry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inquiry
    ADD CONSTRAINT inquiry_pkey PRIMARY KEY (id);


--
-- TOC entry 2322 (class 2606 OID 17076)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 2324 (class 2606 OID 17083)
-- Name: reset_password_request token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reset_password_request
    ADD CONSTRAINT token_pkey PRIMARY KEY (token);


--
-- TOC entry 2318 (class 2606 OID 17069)
-- Name: user user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_id_unique UNIQUE (id);


--
-- TOC entry 2320 (class 2606 OID 16996)
-- Name: user user_pkey1; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_pkey1 PRIMARY KEY (email);


--
-- TOC entry 2326 (class 2606 OID 17089)
-- Name: user_verification user_verification_token_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_verification
    ADD CONSTRAINT user_verification_token_pkey PRIMARY KEY (token);


--
-- TOC entry 2345 (class 2606 OID 17141)
-- Name: edible business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY edible
    ADD CONSTRAINT business_fkey FOREIGN KEY (business_id) REFERENCES business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2336 (class 2606 OID 17077)
-- Name: product business_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY product
    ADD CONSTRAINT business_product_fkey FOREIGN KEY (business_id) REFERENCES business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2335 (class 2606 OID 17070)
-- Name: business business_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY business
    ADD CONSTRAINT business_user_fkey FOREIGN KEY (user_id) REFERENCES "user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2342 (class 2606 OID 17120)
-- Name: concentrate concentrate_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concentrate
    ADD CONSTRAINT concentrate_business_fkey FOREIGN KEY (business_id) REFERENCES business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2341 (class 2606 OID 17115)
-- Name: concentrate concentrate_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY concentrate
    ADD CONSTRAINT concentrate_product_fkey FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2340 (class 2606 OID 17105)
-- Name: flower flower_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flower
    ADD CONSTRAINT flower_business_fkey FOREIGN KEY (business_id) REFERENCES business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2339 (class 2606 OID 17100)
-- Name: flower flower_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY flower
    ADD CONSTRAINT flower_product_fkey FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2348 (class 2606 OID 17317)
-- Name: inquiry inquiry_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inquiry
    ADD CONSTRAINT inquiry_business_fkey FOREIGN KEY (seller_business_id) REFERENCES business(id) ON UPDATE CASCADE;


--
-- TOC entry 2350 (class 2606 OID 17329)
-- Name: inquiry inquiry_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inquiry
    ADD CONSTRAINT inquiry_product_fkey FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE;


--
-- TOC entry 2349 (class 2606 OID 17322)
-- Name: inquiry inquiry_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY inquiry
    ADD CONSTRAINT inquiry_user_fkey FOREIGN KEY (buyer_user_id) REFERENCES "user"(id) ON UPDATE CASCADE;


--
-- TOC entry 2344 (class 2606 OID 17136)
-- Name: edible product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY edible
    ADD CONSTRAINT product_fkey FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2343 (class 2606 OID 17128)
-- Name: product_pricing product_pricing_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_pricing
    ADD CONSTRAINT product_pricing_product_fkey FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2337 (class 2606 OID 17054)
-- Name: reset_password_request reset_password_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY reset_password_request
    ADD CONSTRAINT reset_password_user_email_fkey FOREIGN KEY (email) REFERENCES "user"(email) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- TOC entry 2346 (class 2606 OID 17172)
-- Name: topical topical_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY topical
    ADD CONSTRAINT topical_business_fkey FOREIGN KEY (business_id) REFERENCES business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2347 (class 2606 OID 17167)
-- Name: topical topical_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY topical
    ADD CONSTRAINT topical_product_fkey FOREIGN KEY (product_id) REFERENCES product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 2338 (class 2606 OID 17059)
-- Name: user_verification user_verification_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_verification
    ADD CONSTRAINT user_verification_user_email_fkey FOREIGN KEY (email) REFERENCES "user"(email) ON UPDATE RESTRICT ON DELETE CASCADE;


-- Completed on 2018-05-25 19:32:00 PDT

--
-- PostgreSQL database dump complete
--

