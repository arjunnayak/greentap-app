--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.17
-- Dumped by pg_dump version 9.6.17

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE postgres; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON DATABASE postgres IS 'default administrative connection database';


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
-- Name: additional_license; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.additional_license (
    business_id uuid NOT NULL,
    license_state character varying(50) NOT NULL,
    license_num character varying(256) NOT NULL,
    license_type character varying(256) NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE public.additional_license OWNER TO postgres;

--
-- Name: business; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.business (
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


ALTER TABLE public.business OWNER TO postgres;

--
-- Name: concentrate; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.concentrate (
    product_id uuid NOT NULL,
    business_id uuid NOT NULL,
    strain_type character varying(20),
    thc_level smallint,
    cbd_level smallint
);


ALTER TABLE public.concentrate OWNER TO postgres;

--
-- Name: edible; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edible (
    product_id uuid NOT NULL,
    business_id uuid NOT NULL
);


ALTER TABLE public.edible OWNER TO postgres;

--
-- Name: flower; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.flower (
    business_id uuid NOT NULL,
    product_id uuid NOT NULL,
    strain_type character varying(10),
    thc_level smallint,
    cbd_level smallint
);


ALTER TABLE public.flower OWNER TO postgres;

--
-- Name: inquiry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.inquiry (
    unit_price integer,
    buyer_user_id uuid,
    seller_business_id uuid,
    id uuid NOT NULL,
    unit_count integer,
    unit_count_type character varying(30),
    product_id uuid
);


ALTER TABLE public.inquiry OWNER TO postgres;

--
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    name character varying(100) NOT NULL,
    description character varying(1024),
    image character varying(255),
    id uuid NOT NULL,
    business_id uuid NOT NULL,
    category character varying(50) NOT NULL,
    sub_category character varying(50)
);


ALTER TABLE public.product OWNER TO postgres;

--
-- Name: product_pricing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product_pricing (
    product_id uuid NOT NULL,
    unit_count_type character varying(30) NOT NULL,
    unit_price integer NOT NULL,
    unit_count integer NOT NULL
);


ALTER TABLE public.product_pricing OWNER TO postgres;

--
-- Name: reset_password_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reset_password_request (
    email character varying(100) NOT NULL,
    token character varying(64) NOT NULL,
    "timestamp" timestamp(6) with time zone,
    used boolean DEFAULT false NOT NULL
);


ALTER TABLE public.reset_password_request OWNER TO postgres;

--
-- Name: topical; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.topical (
    product_id uuid NOT NULL,
    business_id uuid NOT NULL
);


ALTER TABLE public.topical OWNER TO postgres;

--
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    first_name character varying(50) NOT NULL,
    password character varying NOT NULL,
    email character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    business_type character varying(20) NOT NULL,
    verified boolean DEFAULT false NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- Name: user_verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_verification (
    email character varying(100) NOT NULL,
    token character varying(64) NOT NULL
);


ALTER TABLE public.user_verification OWNER TO postgres;

--
-- Data for Name: additional_license; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.additional_license (business_id, license_state, license_num, license_type, id) VALUES ('c4a58a75-227c-4de0-b920-f9c1de703d4f', 'CA', '124356789', 'medical-retailer', 'bd3f1731-5e2d-4beb-a1bb-073f2bf6949d');


--
-- Data for Name: business; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'District Edibles', 'CA', 'San Francisco', '5101112222', '918ae191-50f8-4ed2-8d44-7758190d1b63', '855acf4b-6095-4516-8fc9-00802b71d1d3', 'Small batch, from Scratch.  Made with OrganaLabs premium activated CO2 cannabis oil.', 'CA', 'https://greentap-images-dev.s3.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fEUWHEKPaQsqzLAVf9kRA_District%2BEdibles%2BLogo_Gold.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Shepherds Meadow Farm', 'CA', 'San Francisco', '5101112222', '15f95efc-418a-4a7e-b89d-320c94bbc31f', '717a40c4-ee8a-4546-aa5a-a3304c50e99c', 'We are a small artisanal family farm in the heart of the Emerald Triangle. Utilizing organic farming methods, exclusive strains and zero pesticides we strive to sustainably produce some of the finest cannabis available. We always favor quality over quantity and with laboratory testing results validating these efforts, we feel we are succeeding in bringing connoisseur grade cannabis to market.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2faioQ93JyTuq5tqeq4IWH_top%2Blogo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Lola Lola', 'CA', 'San Francisco', '5101112222', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'bfd6268a-02b2-4dd0-88c1-d451b2bdc913', 'In Lolandia, our craft is cannabis and our tribe is magic. We source only the choicest flower and most colorful concentrates from Golden State alchemists, so every but you breathe has been hand picked, hand packed and hand extracted with the kindest of vibes. Our alchemy is one part science and two parts Lola. Our mission is to deliver experiences that inspire expansion of the mind, community, and overall wellbeing of humankind.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fAC6LailpRbGGdg4N4CyN_Screen%2BShot%2B2016-12-14%2Bat%2B2.52.14%2BPM.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Flurish Group', 'CA', 'San Francisco', '5101112222', 'f14d95df-5695-49fc-ac32-f64b7b766da1', '22d827e3-6f35-413a-9a51-037ab44f91f0', 'FLURISH GROUP WAS CREATED WITH A MISSION TO CREATE THE BEST TASTING GOURMET GUMMY EDIBLES. WE FOUND FLURISH IN THE IDEA THAT TAKING YOUR CANNABIS SHOULD BE A POSITIVE EXPERIENCE.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fYsQqgHLzT6q5t77PVrT0_logoblack.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'PureCure', 'CA', 'San Francisco', '5101112222', 'dcc0e87b-c2f5-42c5-8227-192dc466c048', 'd579a85a-3072-4157-bf30-1d3183a16cbc', 'PureCure is dedicated to providing pure and potent medicines to our patients. We use a lab grade organic ethanol extraction process that leaves us with very high quality product. We believe in moving away from the current culture associating Marijuana with smoke inhalation which is counter to the medicating effect of the plant. PureCure provides several different state of the art methods for ingestion. From our Premium Strain Specific Vapor Cartridges to our Sublingual Breath Strips, PureCure is here to make sure patients have access to  clean, potent, and consistent medicine.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2f1CO0g9jrT3ysJnKPuVkA_PureCure%2BLogo%2B1000pxl.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Upside Edibles', 'CA', 'San Francisco', '5101112222', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880', '4de210b9-ace9-429d-a462-81d78f1690c3', 'We are committed to producing peace by piece. Each and every bite of our delicious, gourmet food delivers a consistent dose of premium grade cannabis. We are laser-focused on bringing the greatest relief to our customers with the greatest culinary experience.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Upside%2BEdibles.jpeg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Marley Natural', 'CA', 'San Francisco', '5101112222', 'db1f29ec-93dc-4b9a-bb95-439d673ea62e', '59b7100a-355c-412f-82f7-8fc05c813dac', 'Marley Natural is a premium product line crafted with awareness, authenticity, and a genuine respect for natures nourishing benefits. Our flower, accessories, and body care products are all responsibly sourced and integrity driven. Each of our offerings is a direct reflection of the Marley ethos that integrates natures goodness with a belief in the positive potential of herb. As agents of change, we promote positivity, connectivity, and personal transformation. And as believers in progress, we offer an exceptional lifestyle line that is inspired by Jamaicas vibrant culture. We are proud to be the official Bob Marley cannabis brand.

Marley Natural supports Rise Up, giving back to Jamaica and communities harmed by prohibition. Learn more MarleyNatural.com/rise-up', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Marley%2BNatural.jpeg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Dixie Elixirs & Edibles', 'CA', 'San Francisco', '5101112222', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', '6aa53d14-d4ad-4e34-8aed-a25783572a2f', 'Dixie is the trusted source for innovative, safe, effective and delicious cannabis products. We are proud to provide our customers with products infused with triple lab tested and pure extracted THC. From balms and bath soaks to tinctures and truffles, each of our products offers premium, consistent and reliable results you can trust.

So go ahead. Have a Dixie.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fxnC4PsA6S8SGSUynjIJI_logo%2Bupdate.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Kushy Punch', 'CA', 'San Francisco', '5101112222', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f', '727f7d47-b30f-4689-a239-f2ea3fc384f6', 'Our passion at Kushy Punch, is to make every person that comes into contact with our products better, healthier and happier. To create the best cannabis products on earth, we start with the best organic ingredients we can get our hands on. Always sourced locally. We make sure everything we release from our factory holistically fulfills the needs of your mind, body, and soul.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2f8Jgkz9IaR6KsIbYTwGin_Untitled-1.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'LIV', 'CA', 'San Francisco', '5101112222', 'f7568095-cd17-425d-a8c2-2389149cd2a9', 'a6715176-f535-488c-8fdf-581a64089bca', 'LIV comes to you after many years of painstaking dedication and research directed towards bringing you the ultimate vaping and concentrate experience.
After 5 years of research and development, we have engineered the most superior cannabis product, specifically designed to enhance your lifestyle.

LIV is available in 250mg disposable pens & 500mg shatterproof ceramic cartridges.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fcjDtsl2dSIC46zeC0Xxy_CLEAR.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Legion of Bloom', 'CA', 'San Francisco', '5101112222', '19b5defc-296b-49fe-9edc-3e21e8b7e246', 'db2d498c-4b19-43a8-9278-3b608f4aaa45', 'The Legion of Bloom is a values driven company committed to providing the highest quality cannabis products possible. Our promise is to elevate health and well-being through sustainable and conscious cultivation and extraction.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fEQqpe0ZT5OGJaLOyj6nw_LoB_Logo_01_Gold-BOLD.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Lord Jones', 'CA', 'San Francisco', '5101112222', '2f262183-cb2a-4cae-a4ee-dbdf1fbd0193', '8288af89-5b9f-48e2-bd05-b9289a667dae', 'Lord Jones manufactures and distributes the worlds finest cannabis-infused products. Lord Jones confections are made by hand in small batches from single origin Ecuadorian dark chocolate, imported natural European fruit essences and pure California-grown cannabis extract. Lord Jones Pain & Wellness formula topicals have been developed by a veteran team of personal care experts to deliver full-spectrum whole plant medicine that provides relief from pain, inflammation and a variety of skin conditions.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2frsGP2xeTFOUryXsQMYiA_Lord_Jones.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Merosity Distribution', 'CA', 'San Francisco', '5101112222', '5f1bd2ea-af31-480c-8853-93a881f4d0e2', 'c0d9ee6b-72d8-4b57-a26d-845f0375b552', 'California Wholesale Distributor', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fDwusX5pQyyfCwvMjNPxg_IMG_0703_clipped_rev_2.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Speakeasy 710', 'CA', 'San Francisco', '5101112222', '25a50a78-d35e-4e0f-8e5d-136df32bbd46', '046d12a6-16de-402b-9cbc-a4f2066e2a28', 'Speakeasy was built by industry pioneers with a principle philosophy to provide high quality cannabis oil products through innovative scientific techniques and extraordinary service. Speakeasy sets the standard for product quality in the emerging cannabis industry.
Today, Speakeasy has evolved into one of the most esteemed cannabis oil producers in the world; not because our lead Ph.D. Scientist has won first place Cannabis Cups — 6 times, but because our product is produced with an end-to-end system that ensures purity, potency and quality in every product we sell. With a high level of integrity and imagination, Speakeasy is committed to being a global leader in the development and supply of top shelf cannabis products. Consistent feedback and regular communication with industry experts ensures that Speakeasy is offering predictability and pushing the envelope of what is possible in cannabis concentrate consumption. Looking forward, the company plans to release many new products designed to meet the wide r', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Speakeasy%2B710.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'The Bloom Brand', 'CA', 'San Francisco', '5101112222', 'b706b903-8bee-4a26-b292-687d74467565', 'ce08150b-3f53-4d1b-817e-b83513a3a00c', 'The premier lifestyle cannabis brand. Born in Los Angeles, est. 2013. Available in California and Washington.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fl1fYCz7oSuOvh5vV37oD_bloomlogo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Cafe Herbier', 'CA', 'San Francisco', '5101112222', 'bde837ec-7ff8-4733-8eea-a65854e4acb3', 'c7889a78-7cc9-4872-9a94-d97a263cb78b', 'Made fresh upon order, we create french pastries with the finest homemade infused butter. Everything is fresh and organic using the highest quality cannabis.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fwW9HiEV7QFiiwiBEingV_15622203_1462290753799401_8987530381214590614_n.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Temple Extracts', 'CA', 'San Francisco', '5101112222', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', '9135b077-4e29-48b5-abae-8dd68ac197aa', 'Sustainability, quality and purity are core principles at Temple Extracts. We carefully select our top shelf source material from our network of sustainable and ecologically-friendly farmers, all of whom are passionate about their commitment to the finest standards of organic horticulture. All of our extracts are Strain Specific, Single Origin and carefully handcrafted in limited edition small batches. You can always count on uncompromising purity with artisan, boutique, heritage and proven THC and CBD genetics.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fFl1z9UgaQjmxJnj0ou11_temple-logo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', '101 CBD', 'CA', 'San Francisco', '5101112222', '9a5de623-ea63-41e2-8a8d-c8e10c1523aa', '3ef122d5-45fa-4080-851c-8500bd6e97cc', '101CBD.org is your one-stop-shop for CBD oil, CBD vapes, CBD topicals, CBD Edibles and other CBD products that are pure organic and undeniably effective. All of our products come in either Raw CBD or Decarboxilated CBD forms.  The 101CBD.org founders made it their quest to provide only the highest quality products to help with many neurological ailments from Autism to PTSD and many other afflictions including pain, anxiety and insomnia.  We look forward to helping you treat the ailments you or a loved one are suffering from with our lab certified CBD products and matching the right product for your specific needs.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fex0VxcOMTYqoIOwW2XUT_101CBD.ORG-LOGO300widewhite.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Tokin', 'CA', 'San Francisco', '5101112222', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'bc5df233-4113-4899-971c-47296bfd0c72', 'Tokin is committed to be the best producer of concentrates and oil cartridges available on the market. What separates Tokin and competing brands is the high quality and consistency found every product. Every cartridge is infused with the purest and highest levels of THC and CBD to ensure every user is receiving the best possible experience. Many enjoy our products that contain oils which are well-known for relieving health issues and promoting overall wellness.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fw8dgBMzLQRWPzPzf6oMP_tokin%2Bclear%2Bword%2Bonly%2Bcopy%2B2%2Bcopy.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Dutchy', 'CA', 'San Francisco', '5101112222', 'c21e5742-5b5a-4a45-a38e-3943bfeee1e0', '00aff001-dc9f-4db6-93db-1c47cf40c93a', 'Dutchy is a fine line of cannabis flower and concentrate products made for sharing. Perfect for good friends, good bud and good times, our quality whole flower, pre-rolls and oil are carefully sourced to provide the right amount of THC to enhance time with your friends. Products are currently available in WA state locations.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2f19YdUUk4TWOcGmaS8grL_Dutchy%2BLogo%2B300x300.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'AbsoluteXtracts', 'CA', 'San Francisco', '5101112222', '44085103-1ecd-4c33-b918-5d2b3576c9c4', '49e2cfcc-c382-4dfa-99e6-f511e285a693', 'AbsoluteXtracts—ABX—is a homegrown Northern California company committed to providing patients with pure, safe, and potent cannabis concentrates.

A quality vape experience starts with healthy plants. Hearty clones are taken from young, carefully tended mother plants, genetically fingerprinted, and tested for viruses and pathogens.

These cannabis plant-starts are grown in greenhouses and on small family farms throughout Northern California. When ready, theyre harvested and transported to Santa Rosa for processing.

The plant materials are tested for pesticides, molds and bacteria. After passing inspection, the herb is dried, cured and processed in a pharmaceutical grade "clean" room.

We use clean, high pressure carbon dioxide at low temperatures to extract the cannabis oil. We employ proprietary methods to preserve the terpenes, that give each strain its distinctive smell and flavor.

We package our cannabis oil in our own specially made cartridges that are designed to ensure easy flow and a reliabl', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AbsoluteXtracts%2BLogo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Evergreen Organix', 'CA', 'San Francisco', '5101112222', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', '4a4a1b93-9587-4b60-a757-1a555cb95ac3', 'Established in 2015, Evergreen Organix has grown to be Nevadas premiere marijuana edibles producer.   We are 100% locally owned, family operated, and have proudly rooted our brand in the Silver State.  Following the Nevada Strict Cannabis Guidelines, we can ensure you that our testing is exact, absolute and very detailed for your protection.  Our potency will be exact and not estimated and the third party lab results will let you know you are consuming the cleanest and safest products in the country!

Philosophy

Founded on the principles of quality and care, Evergreen Organix has developed our product line using only the finest ingredients and premium cannabis.   We put a tremendous amount of effort into all avenues of our production.  From hand crafting to small batching, we closely monitor every phase of product development to make sure that the end results are delicious and consistent.  We work hard to make sure that consumers are getting a premium cannabis experience every time they choose an Evergreen O', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fOtQ8HatATiiP3zkAR4O6_Toplogo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'The Green Cacao Company', 'CA', 'San Francisco', '5101112222', '770f4155-7fc2-4c44-a4d1-f5c631d0e5db', 'f5d0c385-c482-4dfc-8a31-edcdef762c8a', 'The Green Cacao Company endorses a multi-faceted approach to health and self care, including:  diet & nutrition, exercise & movement, contemplative practice, creative expression, time spent in nature & the well- informed use all medicines.

In addition to theobroma cacao & outdoor whole plant cannabis, a range of botanical & organically grown superfoods are included in each bar.  Each ingredient offers wellness benefits ~ we do not use fillers.

Based on the principal that human wellbeing is dependent upon the health of our environment, NON GMO & ORGANICALLY GROWN ingredients are always first choice when sourcing.  And, our packaging is made with post consumer waste & biodegradable materials, such as plant-based cellulose, not plastic.

TGCC is committed to creating edibles responsibly. We develop top shelf, plant-based, nutrient-dense, healthy & delicious products.  Each botanical ingredient we use offers wellness benefits ~ it‘s all “˜plant medicine‘.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fL42RUUrESCeHuJqz5HbK_the_green_cacao_company_overview_logo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Select Oil', 'CA', 'San Francisco', '5101112222', '8daceba2-d712-4161-aef8-ab2f49199dda', '4634c035-96d4-4fcc-b3b4-be3ac5bb75ba', 'Respected for our consistent quality and innovation, Select remains at the cutting edge of cannabis science. Honored winners of 2017 Dope Industry Awards, we are dedicated to curating the science of feeling.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fEPJyQ0NRyuCpaAJ4NtzG_Black%2BS%2BIcon.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'HIMALAYA Vapor Distilled', 'CA', 'San Francisco', '5101112222', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', '1bca1746-a154-468d-90b8-453bd7ff5fbc', 'We keep cannabis real. Our single origin carts deliver the original strain-specific terpenes and cannabinoids.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fq218R9cSNShnV7BPNLqg_fu-logo-brown-on-white_300x300_buffer_2.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Satori Chocolates', 'CA', 'San Francisco', '5101112222', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', '94e78573-5577-484b-969c-a8c39ae43331', 'Satori dark chocolate is made with Cacao Fino de Aroma, one of the worlds most highly sought cacaos. Our award-winning milk chocolate is sustainably grown and made by our neighbors, master chocolatiers TCHO Chocolates.

Our cannabis oil is made from premium cannabis strains, grown in the California sun, then carefully extracted using the highest production standards by our friends at ABX / AbsoluteXtracts.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2f9GpAPgdRHKzfcAzDuruF_Satori%2BChoc%2BBW%2Blogo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Healing Light Bodega', 'CA', 'San Francisco', '5101112222', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'd72e6540-84ba-4c6f-9690-593ab0792264', 'Patients deserve to have Medical Marijuana that is clean and natural. As farmers and patients, we respect the plant and grow only the best Medical Cannabis using only the best farming practices.

All medicinal cannabis products cultivated and produced are thoroughly tested by CB Labs in Novato, CA for Cannabinoid Potency, Terpene Content, Pesticides, Microbiological Contamination (mold, fungus, yeast, E Coli) and Residual Solvents (for extracts). All Medical Cannabis must receive a SLAMM Certification (Safe Legal Access to Medical Marijuana) to be offered on our menu.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fXIf5JyzwR2m60gFPhFDE_healing%2Blight%2Bbodega.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Flav', 'CA', 'San Francisco', '5101112222', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'bd62ce2b-39d3-4d57-b6eb-10a9f305cca6', 'Flav concentrate represents an advancement in cannabis science. Purified raw cannabinoids are first collected via a solventless process and then unique terpene blends are added to create the different final products. Raw cannabinoids of high purity minimize the exposure to inhaling unwanted fats and waxes that may lead to conditions such as lipid pneumonia. The terpene blends are formulated in a laboratory using food grade components and are prepared based on actual strain data. The final solvent free product is a concentrate that is more like that of the actual flowers and is free of residual solvents and unwanted contaminants. Inspired by strain profiles with every input monitored for purity and quality. Flav concentrate represents cutting edge scientific knowledge and cannabis insight in every package.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fULu1TQCpRta44gby3FeZ_Flav%2Bprimary%2Bjpeg.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'GFarmaLabs', 'CA', 'San Francisco', '5101112222', 'bb1d7f02-fee7-4d0c-b3ac-b51d6559edf8', 'a87b5bb9-f186-48fe-bae1-d2b59bad79d1', 'Committed to Cannabis Innovation', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2f2Cc6CvdeRqCN5IW9PcXT_Screenshot%2B2017-04-10%2B17.25.03.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Delta9', 'CA', 'San Francisco', '5101112222', '560dc886-4ada-456f-a6b4-32ae1f1de146', '26d9e896-390f-4392-bf90-558dd1a713b4', 'The story of Delta 9 goes back to the start of the medicinal marijuana revolution. For over 15 years, our team has closely worked with government bodies, medical experts and law officials on common sense reform. Our award-winning team of PhD scientist, flavor engineers and cannabis advocates are passionate about personal choice, and constantly innovating to provide the highest quality cannabis products.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fwRk3r09yQyi3wAHwjtz7_IGLOGO-2.JPG', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Care By Design', 'CA', 'San Francisco', '5101112222', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', '4e703475-f2f7-48c0-a429-131b79e038c3', 'Care By Design offers CBD-rich cannabis in easy-to-use sprays, gel caps, vaping products, and edibles. We also offer pure CBD-rich oil in a convenient applicator for cooking, oral dosing or topical administration. We offer a variety of CBD-to-THC ratios for flexible dosing. Our cannabis oil is cleanly extracted using a supercritical CO2 method, and our products are lab tested to ensure the highest quality. We test for cannabinoid and terpene profiles, potency, and contamination. We verify that each bottle contains a consistent amount of active ingredient for reliable dosing. Our CBD-rich cannabis oil is extracted from local, sustainably grown cannabis. With five ratios of CBD-to-THC (from 18:1 to 1:1) to choose from, patients can adjust their cannabis medicine to suit their specific condition and personal preferences.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fPssWLJ8xRL2y4wD0Ys1G_cbd%2Blogo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Whoopi & Maya', 'CA', 'San Francisco', '5101112222', '4095902f-89c6-4f26-b666-01474c00b690', 'ee43b1bd-502d-45bd-b50c-0b1732120b04', 'When the legendary Whoopi Goldberg decided to follow her heart and take a leap into the medical cannabis market, she went looking for the best ingredients, the best medicine and the most talented infuser she could find. Maya Elisabeth, the founder of Om Edibles since 2008, has won seven High Times Cannabis Cup awards, and enjoys a growing reputation as one of the best creators of medical cannabis products in California. The two women hit it off from the moment they met and quickly decided that the Whoopi & Maya Synergy would begin with a Signature Line of medical cannabis products designed specifically for relief from menstrual discomfort. As you will see, they have succeeded spectacularly. Soak, Savor, Rub & Relax -- with Whoopi & Maya', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/W.26M-logo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'The Herbsmith', 'CA', 'San Francisco', '5101112222', '7a592902-2f45-4b5c-a41a-4fb9db6925ea', '1880d23c-e666-483c-8b99-8f48a9688c27', 'The Herbsmith hearkens back to days of yore, when blacksmiths and apothecaries were esteemed keepers of man. Their dedication to perfection was unquestioned, and the
wielders of their craft grew stronger from it. It is with great honor that the Herbsmith presents our expertly crafted remedies. It is our mission to heal and fortify mankind.

The Herbsmith fashions a variety of cannabis implements including fine vapor cartridges, highly purified concentrates, and kief-infused edibles.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fPggg4pA6QFOMSUQCW3EK_new_Logo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'THClear', 'CA', 'San Francisco', '5101112222', 'c51e906c-a2c7-4c29-9617-7304158ebbff', '123c13a1-a98f-4f18-bac7-3c58093e993b', 'We are the industry leader in solventless distillate. We currently produce Disposable Pens, Cartridges, Honey Pots, Syringes, Edibles, Bath Salts, Joints, Shatter Sticks, THCA, Moon Rocks, Lava Rocks, Crumble, 50/50, and different types of battery kits!

For wholesale or product inquiries, please contact us at ezsupplycannabis@gmail.com.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fdj10HAbeR3a9Ny5mGkTR_Screen%2BShot%2B2017-12-21%2Bat%2B12.13.13%2BPM.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Flow Kana', 'CA', 'San Francisco', '5101112222', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '47ebd383-18a8-4be5-8af1-e6eaa7aa2200', 'Flow Kana is a different kind of cannabis business. We want to change the way our patients think about cannabis and the world as a whole.

Our values are simple. Respect the land and the medicine that it produces. No contaminants, no fancy packaging, no overpriced storefront. We bring the best of the farm to our patients doors.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'GG Strains LLC', 'CA', 'San Francisco', '5101112222', '59b10e8c-06dd-49fe-a6e9-c37ae7031524', '1a9f7f7f-6677-48ce-b7c4-fc3adc4a5a94', 'Official Home of GG Strains, Creators of award winning #GG4 fka Gorilla Glue #4, also creators of  GG1 & GG5, Purple Glue, and GlueChee
Veterans in all aspects of cultivation & breeding of medical cannabis/marijuana! .

GG4 fka Gorilla Glue 4 was the first and only GG strain to be released to the public.
Winter of 2016 we officially launched Gorilla GLue #5 in limited release areas along with GG1. To make sure you are getting verified product please feel free and contact us or view or website to check out our partners, and cultivators in authorized states. GG Strains is also creators of Purple Glue and exclusive only to our authorized partners Phat Panda in WA.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fBKoMiVTSwq8mYEvMZPKj_New-GGSTRAINS-PNG.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Altai', 'CA', 'San Francisco', '5101112222', 'a5290c13-6b25-4060-b42a-c8151be600ec', 'ffa8ac8b-3831-48bb-a23b-c5b469d476b8', 'Inspired by the past and focused on the future, Altai creates artisanal edibles thoughtfully crafted for well-being and enjoyment. We pay homage to a rich and ancient history of cannabis use spanning well over 2,500 years.

Our brand is inspired by the discovery of the princess mummy, found interred in the Siberian permafrost. Undisturbed for over 2,500 years, her burial chamber revealed ceremonial bridled horses, treasures and a vessel of cannabis to ease her pain.

Altai Brands is produced by Cypress Manufacturing Company, a California not-for-profit medical marijuana collective. Produced in Monterey County, California, we are proud to offer a variety of low-dose artisanal edibles including bonbons, lozenges, chocolate bars and truffles. All Altai products are sold in childproof packaging with clear, precise dosage levels and safety warnings.

A proud member of the California Cannabis Industry Association since 2015.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fjc51fkeQRpGbJDv6Gcof_Alta_HexLogo_2.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'The Genezen Project', 'CA', 'San Francisco', '5101112222', '4a25225f-69c7-4b9f-94aa-c3c6f3356d92', 'ebc2a00c-0bcb-4649-b456-4c0c50d01e4e', 'The Genezen Project is dedicated to providing customers with unique cultivars that are chosen by us through a selection process beginning from seed. We are in search of cultivars with unique characteristics that can help with various ailments and which are only available from us so our customers can be sure they are being provided quality clean product when purchasing any cultivars with The Genezen Project name on them.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fArPiLGwTR36XtYdwk1bc_THE%2BGENEZEN%2BPROJECT%2BCOLOR_print-02.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Waxman Concentrates', 'CA', 'San Francisco', '5101112222', 'f485dabf-e394-4727-88ff-222bdc0a4629', 'd0569d64-fdda-4a22-84f0-fee1b7987e6e', 'Waxman is a premier concentrated cannabis producer. We feature waxes, C02 oils and shatters that are produced using our non-BHO proprietary techniques. We have even pioneered a flavored process that incorporates flavors such as Blueberry, Pineapple, Watermelon and more. Our distinctive silicon packaging is also very sought after.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/waxman.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Moon Mans Mistress', 'CA', 'San Francisco', '5101112222', '8a039435-604a-47bd-8463-045fe3532fba', 'bc0d8245-5150-4b79-8fc6-0f98c31e0859', 'We are an artisanal paleo edible company committed to taste-worthy products healthy for the body with a focus on healing, performance, and recovery.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2filkrZ4eGSnOy1ikLzZhv_300dpi-vertical-moonmansmistress-01.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'True Humboldt', 'CA', 'San Francisco', '5101112222', '277436db-eebf-4421-9b71-8e1425aeba31', '02acfac6-7c6b-4bac-803d-f240ed6e6db5', 'Humboldt is more than a place where great medicine is grown. Its an icon, a legend, an idea, a philosophy, and, to True Humboldt, its even a mission. We believe cannabis can play a healing role in a patients life. Physically. Emotionally. Environmentally. Even spiritually. Thats why weve dedicated ourselves to offering the best cannabis and services available anywhere.

While we obsess about maintaining the world-renowned tradition of Humboldts superior quality, we also focused on breaking new ground in getting our excess medicine to patients that need it. By helping farmers and dispensaries smooth the reimbursement process, weve successfully developed a complete distribution network throughout the state.

Were a growing network of farmers.
Were run by a conscience, not a corporation. The founding members have lived in Humboldt for an average of 25 years. We raise our families in Humboldt, and we run our businesses throughout Humboldt County and in Arcata. Were always interested in talking to like-minded farm', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/True%2BHumboldt.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Treat Yourself', 'CA', 'San Francisco', '5101112222', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031', 'cc798a17-a3fc-42b9-9d78-49cf83015e63', 'We are women who create healthy cannabis-infused products with women in mind. We value self-care and strive to promote a cannabis culture of women and men who share in our belief of "my body is my temple." We create nutrient-packed products with only the finest quality ingredients. When designing our products, our goal is to cultivate health and happiness while creating an enjoyable experience for our patients.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fCE59tWFOTrSAXhdPnmtb_Logo_CMYK%2Bcopy-2.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Frosted Flowers', 'CA', 'San Francisco', '5101112222', '6357010e-8192-4b93-b354-51d5f00e798d', 'd4ab19f2-2fea-4895-b28f-657371bd6748', 'Frosted Flowers prides itself on purity, quality and consistency. All of our products are laboratory tested for potency, terpenes, pesticides, residual solvents and microbiological count. Our master grower has perfected the art of cultivating perfectly formed trichome stalks with swollen resin glands and extremely unique terpene profiles. Most of our strains test above 20% cannabinoids and include HighTimes winners. Frosted Flowers consistently produces superior products that collectives and consumers have grown to trust.

All of our flowers are grown utilizing semi organic cultivation techniques. We irrigate with a top feed recirculating system and a rockwool blended base. This enables our master grower to know exactly what each plants need is and adjust their nutrients, feeding schedules and ambi-ent environment appropriately.  Doing so ensures each plant achieve its maximum potential.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2ffDWsZd59S9icaiuOqz6S_frosted_flowers_vector_logo-for-web.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'HI-FI Edibles', 'CA', 'San Francisco', '5101112222', 'ce44b0c8-092c-4d8f-abce-eb4d014ff2b8', '13f8669a-3bf9-4664-9fb4-7d90702cfbc1', 'We are taking the next step in the evolving cannabis movement. Our approach to making the finest quality edibles is evident in the attention to detail. Hence, we craft our chocolate with good intentions and the highest quality ingredients. We are dedicated to consistency which is why we start with highly refined oil.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fWTWtJWAJTM2lA7pXrA7y_HI-FI%2Blogo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Aces Extracts', 'CA', 'San Francisco', '5101112222', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'b140e82e-eb34-493e-be90-3b8690ab0dce', 'Driving the future of cannabis concentrates, Aces goes beyond typical solvent extraction by using a distillation technique that results in a pure cannabinoid oil that is free of chlorophyll, plant matter, tars and any residual solvents. Aces delivers an exceptional tasting, smooth drawing product that is the result of our proprietary extraction and distillation method.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fB4n2JN6T3SbSVtBZykCI_Aces-logo-12X12-white.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Chong''s Choice', 'CA', 'San Francisco', '5101112222', 'dae661be-8751-4226-91d0-69a5624aa76b', 'd912110e-8734-4d2e-a69d-a51753c70707', 'When you hear the name Tommy Chong you immediately think of Cannabis. As one half of the legendary comedy duo Cheech & Chong he helped pioneer a completely unique brand of comedy directed at the counter culture movement of the early 70s.  The pair came to define a generation of young entertainers and single handedly launched the genre of Stoner Comedy. And at the heart of this brand of entertainment was, of course, cannabis. On screen and off Tommy became a vocal advocate for his favorite herb.  In a time where cannabis had to be talked about in whispers, Tommy was a loud voice for the advocacy movement, working tirelessly to legitimize the use of this healing plant.  Now that society has moved in a more positive direction regarding the medicinal and recreational use of cannabis, Tommys voice continues to ring out loudly, touting its benefits and place in society.  His message has never changed, and his passion has remained as strong as it was on stage many years ago.  Now Tommy is thrilled to share that pass', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Chong_s%2BChoice%2BCannabis%2BLogo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'HerbaBuena', 'CA', 'San Francisco', '5101112222', '6574ed59-73a6-43d3-955a-66218e6433d5', '15db6274-8390-40e3-9546-aeaf7f25eab0', 'Delivering the finest certified biodynamic and organically sun grown cannabis products curated for purity, potency and effect. Professional health consultations available and social club events throughout northern California. Herbabuena has been featured in the SF chronicle, Seven by Seven, Edible Marin in Wine Country, and Cannabis Now. We craft a line of award winning solution based products from our permitted garden in Mendocino and carry a thoughtfully curated catalog of Californias finest brands.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fsMzuFxPRQaeSuNi2MYn7_HerbaBuenaComplete_Square.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Caliva', 'CA', 'San Francisco', '5101112222', '248408b7-2c93-4cb1-8a92-ed81595409b0', '7dbd0f37-34f4-40de-9e09-82eabd34e2cb', 'This is: our refined line of classic cannabis products made to be easy, fun and consistent so you know how youll feel, every time. From your coffee table to the top of a mountain, Caliva Collection is the essence of cannabis refined.
 You are: an informed yet classy consumer looking for fun, trusted, convenient and consistent cannabis experiences to suit your healthy and hectic lifestyle.

Weve got something for everyone.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fbr7FwvPvQZr0eBNqFQbw_new_caliva_logo_360.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Hemp Hope Group', 'CA', 'San Francisco', '5101112222', 'be6e8cce-a790-42a2-9b16-3a8a4db9ff35', 'ba878b78-ac9d-4f8e-ab1c-a9e2683d9397', 'The Hemp Hope Group is a Medical cannabis, Rec cannabis, and Industrial Hemp group of companies, investors, and workers operating nationwide to promote and expand the canna industry globally.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fpUd2GWSQtCLBs7I23dow_HHG%2B2017%2BLogo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Connected Cannabis Co.', 'CA', 'San Francisco', '5101112222', '748c6a1a-5a9d-46fb-a732-3b6318fad9c9', '031a556f-3ee8-41ba-8239-7fd860a3aa03', 'Who We Are

Were not jumping on the marijuana trend in this country. Its catching up to us. Weve been living this life for years, because we believe in doing what you want. In freedom of expression. In pursuing happiness, and helping out others along the way.¨

So we provide the highest quality recreational and medicinal marijuana products youll find. How do we know this? Because our toughest critics are ourselves, and if its not something we love its not going on the shelves. Ask our budtenders to help find the perfect match for what youre looking for, and keep doing you.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fihLMUfbLQWGIy7T375ew_Logo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Farmacy Bliss', 'CA', 'San Francisco', '5101112222', '0cb2135f-039d-489b-8791-1961fdb778dc', '24b426d7-66c5-4c03-b397-15efe2846e4b', 'We produce medical grade CBD products that help alleviate excessive stress, anxiety, insomnia, chronic pain, inflammatory and auto-immune conditions.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/logo_fbliss3.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Brite Labs', 'CA', 'San Francisco', '5101112222', 'abb41639-40f0-4542-a129-87fa98644f51', 'd72d7507-9489-4872-814a-fd54be82b886', 'Brite Labs is a California medical cannabis collective making pure supercritical CO2 extracts on behalf of our member-patients. Our extracts stand out for their scientifically designed mix of purity, potency, and flavor.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Brite%2BLabs.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Ganja Gold', 'CA', 'San Francisco', '5101112222', '575f652a-31ed-4ff2-a8c0-ae0e09ce3ea1', '1913119e-db20-4d4b-be04-0a6c50f6728a', 'A Pure, Potent, Strain-specific experience.
Thats what we deliver in every Ganja Gold product-and experience we call Connoisseur Pure. Crafted from the top 1% of available cannabis, our products are exclusive to all who seek a top-shelf experience. Call us particular, call  us exacting, call us purveyors of a higher standard, but we only accept the top 1%, and leave the other 99% to those with less exacting standards. We seek out responsible growers and personally inspect, smell and sample each plant we consider, backing our experiential findings with testing from one of the highest regarded labs in the world. Its called integrity. We care about our patients and customers, producing only products we would use ourselves or provide to family and friends.
When youre in the top 1%, you can confidently lay claim to offering a premium product delivering an exceptional experience.
Purity matters, because you matter.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fn8HS7yRU20pvWwNBW5Eg_1200ppi.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'LOL Edibles', 'CA', 'San Francisco', '5101112222', '6ac976a1-2f75-45cc-9144-4525d4c72853', '4316c6e1-1a1a-4e18-b8ee-d25c47306130', 'LOL Edibles creates delicious medical snacks that are infused with cannabis. LOL Edibles has been voted the #1 line of edibles in California! LOL Edibles makes a variety of infused candy, chips, and baked goods.

For wholesale or product inquiries, please contact us at lolediblesmedia@gmail.com', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fluNJRKC6RCmzT9X4O5hL_Screen%2BShot%2B2017-12-14%2Bat%2B2.04.53%2BPM.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Everest Live Resin', 'CA', 'San Francisco', '5101112222', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'a4562c05-58bc-437f-924b-7a5772c2e8fc', 'Everest offers ultimate quality and flavor with their groundbreaking method of flash-frozen fresh whole-plant extraction. Inspired by the shaman of Nepal who created the worlds first Live Resin at the base of Everest Mountain, Everest recreates that level of purity with modern techniques. Their proprietary process yields a golden, glistening wax, high in terpenes and cannabinoids with flavor that is strikingly similar to the original plant. Available in concentrates and unique full-spectrum gummy candy.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fobWDHOtARwaRKib0rpmt_Untitled-1.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Northern Emeralds', 'CA', 'San Francisco', '5101112222', 'f05c84a2-8aa9-43de-b622-9c68a2442cf4', '1877d0d2-86d5-4172-bacb-82295b491197', 'Northern Emeralds is the premier cannabis brand to emerge from the Emerald Triangle, Americas original home of boutique flower.  We combine distinct heirloom genetics with a  proprietary, innovative cultivation process perfected over decades.  We offer our partners a product of unparalleled quality, consistent from batch to batch, supplied with impeccable reliability.  We take pride in our rapid sell-through rate and growing recognition among connoisseurs.  We passionately believe responsible cannabis consumption is a benefit to the health and wellness of our community, and we are committed to setting the standard for excellence as our industry evolves.  We are in relentless pursuit of the cannabis plants  true potential and are proud to be a lead producer of Californias newest craft crop.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fA9ruyw6ORROGDa82rFrj_leafly_NE-logo2.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Little House Foods', 'CA', 'San Francisco', '5101112222', 'c8a9ba26-9bfe-42c9-ac8d-dd8abec61a2e', 'd32e621e-b66d-435d-b203-3557a4f599ab', 'We do things a bit differently, and that‘s the way we like it!

Little House was founded as a pipe dream that subsequently became reality in 2016. We will be proud to be among Oregon‘s first recreational cannabis edibles. Our mission is to normalize the use of recreational marijuana and our vision is to support a new kind of relaxation. Our hand-crafted products are made with love to ensure your experience is easy, safe and simple.



Balancing taste notes with the perfect cannabinoid blend, Little House products intend you the best start to your personal marijuana experience. Just like you don‘t choose wine based on alcohol percentage, we know you want an edible that primarily tastes good and makes you feel good too.



Our Process

We start with high-quality cannabis, blended by our resident expert, and infuse a variety of fats and oil to create the best foundation for each product‘s flavor profile. We test our products for taste, texture, intoxication experience and shelf-stability. We are constant', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fNvQBQqz0RVaFIQKXCqkf_Banner_Logo_v2-2.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Humboldt Marijuana Co', 'CA', 'San Francisco', '5101112222', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'e5b06676-97b0-4018-a156-be9cb7f50ee9', 'Humboldt Marijuana Company specializes in cannabis extracts and organically grown flower. They offer the purest, most potent marijuana experience possible for consumers who care about what they put in their body. Caring about their customers and actively involved with healing organizations, Humboldt Marijuana Company is dedicated to creating a pure smoking and/or dabbing experience for all lovers of cannabis.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fYdKywbEySZGwVUSL5wpW_circle%2Bpart%2Bof%2Blogo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'ISLAND', 'CA', 'San Francisco', '5101112222', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', '8d512c9b-ab87-4471-ada1-53425bc143e6', 'Island Cannabis Co. was established in 2014 in Los Angeles, CA with the goal of responsibly producing artisanal quality, 100% natural cannabis products. Inspired by the golden-age of 1970s coastal California, we create products that capture the spirit of that time. We handcraft each product with care and only source cannabis from California cultivators who share our philosophy and enthusiasm for the craft. All cannabis is tested by an independent lab to ensure quality and safety.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fCSyySlTZGfZPIIgRkp9Q_Island-Palm-Tree.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Veda Chews', 'CA', 'San Francisco', '5101112222', 'ceb9853f-9206-4b44-9aea-749dd4c156bd', '7b519da0-9a69-44f1-b1a3-89b4ba844c05', 'Each package contains a pharmaceutical-grade tray with four individually-sealed and clearly labeled doses of our Vegan, non-GMO, sugar free, chocolate caramel High CBD Chews!', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fgJK6UWXXRPO0nAAvmCEd_VedaChews_ByAvedica_VerticalLogo.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Utopia', 'CA', 'San Francisco', '5101112222', '353d517f-8807-467b-bd28-719de8ce065b', 'a9945fc2-5fa0-436d-b65b-301f7951243f', 'Utopia is built on authenticity, transparency and quality above all else. Orignially developed as an exotic indoor flower brand, Utopia quickly garnered attention with the launch of the potent C. Banana strain (testing as high as 35% THC). Disheartened by the industrys lack of quality, clean-tested cannabis, we set out to develop a branded alternative to the unlabeled, un-tested products that filled dispensary shelves. Our commitment to consumers has resulted in products focused on purity, higher business ethics and unparalleled quality. Today, Utopia can be found throughout CA and has award-winning indoor flowers, high cannabinoid / high terpene extracts and healthy edibles.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fOMOliONQK287ddv3ubXl_Utopia_July_17_HIGH_RES-36.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Foreman Farms', 'CA', 'San Francisco', '5101112222', 'c6d1feaf-8194-4883-8b71-e9f3935863ad', '554966ae-10d1-4be8-9b31-32f9f8fe8ced', 'Foreman Farms is driven to bring innovative products to the market. We are also proud to use top-notch quality control methods that separate us from other companies.

We believe in everything we sell - from our organic flowers, to our delicious edibles and premium blunts. By employing unrivaled standards, we are confident you can safely enjoy our products without any compromises in potency or flavor.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fX4weJ6fqT2mwVZWnRJxB_logo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'IndigoPro', 'CA', 'San Francisco', '5101112222', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'ec1bfe0c-71ff-401c-b55d-84761744d2c8', 'REVOLUTIONARY VAPORIZER TECHNOLOGY MEETS THE FINEST CANNABIS OILS

IndigoPros Advanced Vapor System provides a smooth, easy draw that vibrates discretely to let you know its working. This innovative ceramic atomizer cartridge technology features the purest cannabis nectar, CO2-extracted from The Farms craft cannabis in Boulder, Colorado.

IndigoPros Features & Benefits:
Magnetic, leak-resistant ceramic cartridges, pop on & off for ease of use
Draw indicator discreetly vibrates when activated
Durable exterior casing, virtually unbreakable under normal use
Clean vapor with no burnt taste
Choose from a variety of flavored artisanal oils
Long-lasting battery, vapes while charging
Includes compact carrying/storage case', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fYz9dSTcpQZGm4OjxvRNn_indigo_pro_leafly_profile.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'W Vapes', 'CA', 'San Francisco', '5101112222', '9e60564e-b5d3-45ce-8a38-43b440cf837a', '657522b8-0a4c-4593-ac32-efe39373ea88', 'W Vapes aims to produce the #1 cannabis concentrate in the world. We adhere to the highest standards in every aspect of the creation process; sourcing, extraction, customer service, and packaging, we are constantly innovating our methods and finding new ways to fulfill the needs of patients and dispensaries. We only use pesticide-free cannabis sourced from local growers that implement organic-level controls in their grows. Our products are tested vigorously at every phase of the extraction process to ensure they are entirely free of contaminants.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fh6n2I2gsSWOs8a1XPjIS_W_logo_weedmaps_leafly.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Herbalogics', 'CA', 'San Francisco', '5101112222', 'f07d61b1-bc61-444d-932f-dddf2f2af72a', '158911e8-703b-4d9a-8d74-aee6cf386cd5', 'Herbalogics produces cannabis-based health and wellness products serving patients in compliance with CA Prop 215, SB 420 Sections 11362.5 & 11362.7 of HSC.

The products that we have developed contain the highest grade concentrates and extracts whose entire life cycle from strain selection and cultivation to processing and manufacturing was done using natural, organic, pesticide and hormone free nutrients, and purified Ph balanced water. Our extracts use only the highest of food grade, and vegetable-based products to deliver a product that is organic, non-GMO, pure and free of materials that can cause harmful side effects.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fyeX5dqIPQ8yVDmOlHEhG_facebook_photo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Pure Vape', 'CA', 'San Francisco', '5101112222', '62152838-604f-4b36-8b54-3c29499fae2f', 'a648dc2c-957f-4c73-8b79-6ff15a56d14f', 'At Pure, we produce clean, 100% natural cannabis oil that is safely extracted with state-of-the-art CO2 machinery. To maintain consistency and the highest standards in purity, every batch is lab tested before and after extraction.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fT0V8gA21QESJqdyQFmeR_green%2Blogo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Calyx Garden', 'CA', 'San Francisco', '5101112222', 'd7fc6634-8d8f-4446-8d4e-2b0672f7089f', '90e2f6f4-367a-4110-9328-3f392729a330', 'Calyx Garden is a brand of high potency cannabis varieties that were bred to cover a wide spectrum of highly desired traits. All of the varieties have a very unique cannabinoid ratio and terpenoid profile that were selected over many years of selective breeding with a focus on introducing beautiful, high cannabinoid flowers that have exceptional flavors and aromas. We have covered a wide spectrum ranging from Sativa dominant varieties to Indica dominant varieties that all have a unique cannabinoid ratio to cover a range of medicinally, recreationally and spiritually desired effects.
Our products are currently distributed to dispensaries throughout California. At this time we are expanding to other cannabis producers by offering several of our high grade brands and are working constantly on creating new hybrid strains which will be released in the near future.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fZG8A0HXQ0G87fQi3vr0y_Calyx%2BGarden%2BLogo%2B.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Eel River Organics', 'CA', 'San Francisco', '5101112222', '08f5de46-f0d1-4bec-8a50-45f25f10be26', '3c23bc96-a444-489a-8731-7edcaa466ae6', 'Sustainably grown in Humboldt County.  Dry farmed medical cannabis using 100% organic methods in the nutrient rich soil alongside the Eel River.  Sun grown, naturally cured, producing exceptional flavor and exceptional quality. Our vape oil is extracted using CO2 distillate process.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fXq4EtpA0SYKtG39bBChL_Leafly%2BERO%2Bwith%2Bwood%2Bgrain.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Eureka Vapor', 'CA', 'San Francisco', '5101112222', '00c34f8e-3da9-4b3f-b108-25d4c917768d', '6c06734c-4438-4f75-add2-fcd02fe17632', 'Our CO2 extracted amber oil and Molecular Separated distillate is unmatched in quality and potency. As such we see the need to keep our oil as clean and pure as possible. This is why we never use PG, VG, PEG, or any synthetic additives. Our strain specific terpene profiles have undergone rigorous testing, evaluation, and critique in order to provide quality, flavorful oil. We believe this is the way cannabis should be!', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fr29ivlhyToyaKRKXXXHX_Black%2BE%2BDrop%2B300%2Bx%2B300.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Crafted Extracts', 'CA', 'San Francisco', '5101112222', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', '33ab029a-df02-494f-8424-edd4ada0d6f2', 'Crafted Extracts solvent free oil cartridges are a premium product like created with sustainability, and awareness. Our materials are responsibly sourced and crafted with care.

Our extraction methods preserve the fullest natural terpene profiles, allowing you to enjoy the finest flavors with premium effect. We use a hand-crafted, specially formulated oil to maintain a perfect level of THC to terpene levels.

We are dedicated to developing superior products, we have a strict quality assurance process, to make sure the product is consistent and safe. We stand behind the quality of our products and ensure you will always the getting the cleanest oil possible.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fA5tMPTVTlCsLdeF5uh2X_Crafted-Cannabis-Co-Logo-Reverse%2B1.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Lucy Goosey Edibles', 'CA', 'San Francisco', '5101112222', '4aa30ac3-fdd2-4e21-973f-7a688023fe09', '702f8787-75a3-44d7-bd89-430b745b1078', 'Made with 90% activated THC Distillate for consistent potency and no weed taste.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2f3dcEYgQRzihOR31tWjpg_Logo_3x3_jpeg.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'VVS Pens', 'CA', 'San Francisco', '5101112222', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', '74696318-f888-4d77-b193-d1307b51608b', 'Nothing beats being able to smoke almost anywhere and travel with technological elegance. Discreet. Smooth. Potent. Ultra Premium, Styled in different metallics platinum and variation of gold with the strain you want and need. Cartridges: $50, rechargeable pens: $20 and the disposable pens: (1 gram of cannabis oil) starting at $40 price point.

There is an overwhelming demand for #VVSPENS. The Vaporizer game deserved a much needed premium/luxury device. VVS pens will soon be all over the state of California. Later in Colorado, Washington and Oregon. Any clubs or dispensaries interested in carrying these pens, please contact via email: sales@vvspens.com.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fMej4Wj0GQ2Omd5MjMn6v_VVS.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Kiva Confections', 'CA', 'San Francisco', '5101112222', '4ed6b674-9e03-4a47-992c-9019ee7dc026', '3399587c-028b-465e-9907-31dbb7695fb4', 'By adhering to the highest standards of product quality, certified production methods, efficacy testing and innovation, KIVA Confections will continue to produce and deliver the safest, most convenient and delicious tasting medical cannabis products to a discerning and deserving community.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fZimfiLx2TfipXVmnHZXY_kiva_confections_logo_300x300.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Humboldt Gold', 'CA', 'San Francisco', '5101112222', '80600697-efca-418d-bd60-ffe738468a3a', 'c5aec149-9542-4bf1-8d5e-f9c2a25a41d3', 'Humboldt Gold is pleased to deliver consistency and honesty in each of our cannabis products. Our menu of Co2 Extracted Cannabis Oil is available in vape cartridges and glass syringe applicators, making administering your euphoria a breeze. A dab of Humboldt Gold is guaranteed to provide consistency in flavor, potency, and effect. Take a rip from our cartridge or dab from our syringe for an experience that will leave you feeling golden.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fuB61cvFoR4ixiCMzyriY_HG_Logo_Name_Final.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Keef Brands', 'CA', 'San Francisco', '5101112222', '78c5d260-8775-46ec-861d-902a023b2167', 'baea47e4-260c-462b-a1a2-7836077b530b', 'Keef Cola \\ OilStix', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fKFhvaippQ8WU5FDmNZfV_Leafly%2BLogo-01.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Punch Edibles', 'CA', 'San Francisco', '5101112222', 'a05f9fb7-b804-4ea2-9aa3-eaecc7aa7850', '35a8b50e-d19f-4843-993e-eec9a821ac2b', 'Sensible Size. High Dose.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fhqoTGVolTqqN64icdAfi_PEfist_300x300.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Enliven Essentials', 'CA', 'San Francisco', '5101112222', '0f70b3f1-7f71-42b5-a8f1-39649ed8c922', '66c15b19-fc90-48ac-88ab-9911505b9cbc', 'Our Family:

Us? Its really about you! But if you want to know about us here it is. We are a New York family owned business. CBD oil has benefited many members of our family before we opened our company. However, their was a problem in the market, QUALITY. Most products out there, were lacking in quality or were just plain too expensive. That is when we realized the opportunity. We can help so many people like ourselves not just with the product but with quality at the right price. Just because CBD is so in demand does not mean it should be a fortune! So we created Enliven Essentials. CBD infused products with premium quality at affordable prices.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2for3BALqhT2UdAaFW4ADA_E%2Bjpeg.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Pure Ratios', 'CA', 'San Francisco', '5101112222', '893111d3-6962-4cc2-8576-bc6b1dc1668b', 'a3ae1212-c0e1-4247-9eb1-26b01eb20bf7', 'True to its name, Pure Ratios‘ products are free of artificial additives and enhanced by herbal components that have been proven in Natural medicine to both protect the body and provide therapeutic direction to the formulation. Today, Pure Ratios offers a unique collection of lab tested cannabis and hemp based CBD products (Interested in CBD products — Click Here) intended to help manage pain and discomfort through long lasting, consistent dosing of cannabinoids. For many people, Pure Ratios family of products are becoming a healthy addition to their daily lives. Pure Ratios products are naturally pure, chemical and additive free. Our products are produced from extracting compounds from the entire plant, to capture all of the plants beneficial properties through a proprietary CO2 extraction method. What patients have known to be effective medicine for centuries is being confirmed by modern science. Given the means to accurately dose using the cannabis plant, medical cannabis patients can easily mirror the', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fUdDNM86CQoaduNqtSpfN_logo-testimonial-2.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Palomar Craft Cannabis', 'CA', 'San Francisco', '5101112222', '1160c17a-f575-48ae-b4f0-ee304abe6db4', '7cee460d-4754-4d44-8b31-7fd13dc17537', 'Palomar is focused on the well being of the people we serve and the plants we grow.

Founded in 2010 - Palomar is committed to producing the highest quality cannabis using responsible growing methods and innovative technology. For the safety and well being of our consumers, we omit any use of harmful pesticides or synthetic fertilizers. We ensure that every plant is individually cared for by hand, starting with our own special blend of organic soil. Every batch is lab tested and the results are tracked by batch codes.

Our cannabis is grown thoughtfully with our fans best interests at heart and it is our promise to deliver one of the finest experiences within the cannabis world.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fekcv0daTQeqROiqrkhVn_Palomar%2BO%2B300px%2BX%2B300px-01-01.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Elite Hemp Products', 'CA', 'San Francisco', '5101112222', '1a241391-4051-48e8-8417-29fbcc0b7c9f', '685667b8-c10d-4acf-9e3d-abf12a31bbf3', 'At elite we strive perfection, as a company we are always trying to improve the quality of our products and provide an exceptional experience for our costumers.
   With 100X strength products we plan to revolutionize the market and improve everyones life. As well, our goal is to expand worldwide and make Elite the most recognized Hemp based brand in the market.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fqMGK5yW5QbmtcLXItk94_Attachment-1%2B1.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', '4.20Bar CA', 'CA', 'San Francisco', '5101112222', '0984d06f-cce1-445e-8486-9f176652c145', '424a6f31-ed81-48ea-b279-94fd7d6c1061', 'The 4.20 Bar line is created by VCC Brands.  VCC Brands creates a world where cannabis is consumed in a spirit of wellness, freedom and fun by providing consumers with access to delicious, healthy, reliably-tested and packaged cannabis products. We are committed to collaborating with other industry leaders, researchers, regulators and policy makers to create a thriving cannabis industry that benefits everyone.

4.20 Bar- The most delicious bar on the market.  Tempered couverture chocolate that is handcrafted by our expert chocolatiers. Made with Fair Trade Cacao.

4.20 Bar Peppermint Patty- Our master chocolatiers created a cool, cannabis-activated peppermint filling and encased it in a non-active chocolate shell.

4.20 Brownie- Your favorite bar got baked!  The 4.20 Bar has given rise to the 4.20 Brownie, try every flavor!', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fztmmkrbLSvCxZaMUAQUn_420Bar_Logo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'BaKed', 'CA', 'San Francisco', '5101112222', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', '845a3fa7-2dc2-407d-a728-784ac2b68140', 'BaKeds delicious and potent edibles are guaranteed to make you feel good! Weve supplied our candies, fish snacks and baked goods to dispensaries in the greater Los Angeles area for more than 7 years. We started out because we love baking, and we love sharing our creations.

All of our THC treats are handcrafted using our signature recipes and premium, solvent-free and CO2 extracted cannabis oil to create deliciously soothing edibles that taste as good as they feel.

Our MOST POPULAR products are our Drop Candies (25mg THC), Lollipops (25mg - 90mg THC) and irresistible Killer Fish crackers (32mg - 95mg THC).

All of our products provide reliable and effective relief for pain, sleep problems and anxiety as well as aiding in relaxation and mood elevation.  Everything is routinely tested to ensure consistent dosages and potency. You can find our range of uplifting edibles at more than 100 dispensaries throughout LA.

We hope you enjoy getting BaKed with us!', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2ftTSqnr35RAuleMQh7Rzk_baked-edibles.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Spliffin', 'CA', 'San Francisco', '5101112222', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', '2af011af-da25-4ec9-ab94-8799918692e7', 'SpliffinÂ® offers premium vaping concentrates, hardware and unparalleled service for those with discerning taste. We have a genuine passion for our craft and we approach our work with the broad understanding that not all patients desire the same product for the same reasons.
Utilizing the latest advancements in solvent-free extraction, our cannabis concentrates are painstakingly refined to preserve the plants natural essence.

Decades of research and our groundbreaking technology allow us to capture the optimum concentration of our strains aromatic terpenes. Our proprietary extracts and enhancers are expertly blended to suit a broad spectrum of patient palates and preferences.

SpliffinÂ® is introducing higher production standards, superior products, and an entirely new level of sophistication. Patients can and should expect Spliffin products to deliver consistently satisfying effects. Each batch is formulated, processed and tested to ensure consistency. Our principal goal is to ensure our users receive o', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fK4iFmCYAQxK4giE9SVV3_spliffin%2Blogo.jpg', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('93715', NULL, '123 Example St', 'CA', 'Orchid Essentials', 'CA', 'San Francisco', '5101112222', 'a09f62b4-b320-41ec-986c-0b11836a643f', '0ec5faa9-956d-4c7a-bab8-cd1ce6236412', 'Orchid products are handcrafted and designed for maximum flavor and overall enjoyment. Our proven processes and passion for what we do carries through into our products.', 'CA', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/https.3a.2f.2fs3.amazonaws.com.2fleafly-s3.2fbrands.2flogos.2fITg17bRjRmCKWYgBfV3i_Orchid_Logo_Blue300px.png', 'CA12345678', 'test-license-type');
INSERT INTO public.business (zip, year, address, state, name, license_state, city, phone, id, user_id, description, available_in, image, license_num, license_type) VALUES ('94533', NULL, '123 Example St', 'CA', 'Costco', 'CA', 'San Jose', '1234567890', 'c4a58a75-227c-4de0-b920-f9c1de703d4f', '52eeac2e-e0b9-4278-bc99-9c47fab6f506', NULL, 'CA', NULL, '123456789', 'medical-distributor');


--
-- Data for Name: concentrate; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2b1a7875-079f-49b5-8400-17b84d413d23', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1db4f75f-9e7d-494c-a3c9-250f92c5f963', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('78ea62c8-e7c0-46e4-b71a-50583df47091', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c035618e-38eb-417e-991e-2de64303bfa2', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f51086f5-da9a-4aa7-b513-3d0e58f84082', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0fa3818b-ebc1-49cf-9f12-e3dbb3705a26', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('55b40393-8788-41b1-9300-ad11dff1e368', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('199f17c6-35c3-4842-ad2c-1bbf644c2846', 'dcc0e87b-c2f5-42c5-8227-192dc466c048', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c71ae1e3-ed48-4dcf-9a7f-dc5836c9a397', 'dcc0e87b-c2f5-42c5-8227-192dc466c048', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b4e83c4b-e8fb-4b82-a28e-4820871b6576', 'f7568095-cd17-425d-a8c2-2389149cd2a9', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c2265772-4f4a-4f51-96e7-1c70b5729e6b', 'f7568095-cd17-425d-a8c2-2389149cd2a9', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('45e12b50-5dcf-42e7-bb5c-33386938642e', 'f7568095-cd17-425d-a8c2-2389149cd2a9', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('90e817bf-30ad-41d6-9f89-da9e85c96bf8', 'b706b903-8bee-4a26-b292-687d74467565', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('377eaf52-286e-4bb0-8b81-71a842f3bd68', 'b706b903-8bee-4a26-b292-687d74467565', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5c0ff0fd-6e8d-444e-887a-0b502dfd423b', 'b706b903-8bee-4a26-b292-687d74467565', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a17ea33a-5369-4ea9-9064-1c8f99211a91', 'b706b903-8bee-4a26-b292-687d74467565', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4105bf0c-ce41-4517-b628-f1238b338b5e', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('56eb809c-fdd1-457e-bab9-23c6d712e458', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('de71824e-4ad8-45a1-a828-474319038d39', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e3e40c28-64ba-418b-bd4e-fede56b1ba4e', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9e77a446-abc5-4777-aa4b-7e846c91e1f9', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c18b32e7-084d-461f-9543-87141595ecea', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ce77a212-aec6-45b7-8eab-847b2bdd3898', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b307eebd-86f0-479f-a734-273d2dd8fe7b', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('81e2ee5c-4673-4cc1-b304-4e3ba804c5c1', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9afb6c15-883a-490d-9214-2b14a37eebf5', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9421cfab-4252-4ed8-9372-e01e86cece11', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0f77d7fb-ce55-4a31-b82a-63a4ca135d7c', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2e1351cd-5d5b-42a1-9fcb-10a55081ccc9', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bb3f473d-c623-4c55-bc8d-11c31852df46', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b4d2a03f-e09e-439c-a443-54407af68178', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0825e44a-870b-4407-8f23-38b131d4c4fa', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f12bafbd-9b2c-4d27-9d4f-cf7a662a3b9c', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f1822cce-614c-46b2-97a0-e8e00ac42333', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('360bed58-ae61-4724-8a79-28d3cf27ca4d', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('81e07a47-7c89-452d-832f-0742d3c1b29e', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('280fe1ee-6162-4d70-8642-52c5dbfaafe1', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1f73675b-a1d4-420f-983e-36b606b61384', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c5660891-6347-4f0f-9add-001828446886', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('261b8bb4-0e9b-4f25-8d3e-445919cbae78', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0c15224a-e9b8-43bc-89dd-1cda7a9ace68', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e79e0eb3-379f-4da0-b041-0af877fd68a5', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2b3aad10-a69a-4c8e-96c7-39feb8e6f340', '9a5de623-ea63-41e2-8a8d-c8e10c1523aa', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0065cb07-9657-4904-a418-ade6bdde2b6a', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a3390c36-36b6-40a9-aa01-ebd3dbca4426', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('153add19-d6e1-4f92-8dfd-c764afbfffe5', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7d570bb9-5f67-4937-a71b-dee7a7a6111d', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4320bddd-4009-4322-9639-e9ff6f60505a', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('69f5fcc8-1732-499d-b709-182650784466', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('32490607-1acb-49c6-b63e-9b41a13283f8', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('d3074d1e-98d8-4ca8-a1de-699d05585dd4', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0c5a2b01-91bc-4c60-826a-50a12714c8f7', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('47bce484-8436-4a06-95ce-60b081d097be', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('707af121-6f61-4bb8-bbbe-b7eca6ea4170', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f2003c77-f503-406b-8c48-cd37cde20fea', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('01f21fa5-8e46-4c1d-a59a-ea227d407811', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('3c0c193f-ecda-4cdd-b5cb-d052217dbd4b', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1e09bf78-1d0d-4a1a-ae5e-3e695ef3d79b', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7f90a0c6-5d8a-479d-99c1-6ce2a53acebc', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0fb7e173-03fb-4c1d-834c-63addb7aab3d', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('82d838e4-9db4-4be5-bd37-15ac026b3b96', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('159f5c4b-7f8f-4ad6-9d6e-be834c4056b1', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9bf96cd3-d285-463b-ad60-329a8bc4280a', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f85f6d38-3053-4cd1-85d2-5501617dfdaa', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c62b3a22-f989-41bf-9e81-72b9e034b148', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('276243e6-4225-4504-a2be-9f5ccfe961e9', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('fa257699-fb82-4591-83a3-ea94d6c0e595', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('faef52c0-2faf-4acf-bd9d-2f50d3b01145', '8daceba2-d712-4161-aef8-ab2f49199dda', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('65d9753c-3457-4259-9db6-d3852c324512', '8daceba2-d712-4161-aef8-ab2f49199dda', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7498f85b-9970-4c40-8940-1144ae8d86d1', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('552eeefc-4fed-452e-9b70-f5a18ad59f92', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bada125a-179c-4548-a86e-a92ffba2fdf4', '8daceba2-d712-4161-aef8-ab2f49199dda', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('d539ce45-63ba-4b3e-a709-157f3a13bc21', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('75d514a7-f3d3-4a9e-896e-8e0dca9e3dbc', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('37eefafe-cbf1-4671-88b8-c65501cd6fd3', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cd7936ae-0f73-4106-ab95-43a1869eb3a1', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ac28ecc6-f50e-4798-b061-51b2133ca43b', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('610f0452-9fba-4ee6-8cd0-cbb17d2318a5', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('3068c3e9-72b9-4ed9-99b0-0547cae5464a', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2a2d56f6-779a-4496-8d90-f2f84b7f23dc', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('16307bb3-93d9-4b92-a86f-368a58e4c932', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ba73b60d-ba53-4c41-bcdf-ab2a234184da', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8afb39d4-0176-4c21-b08b-32fc63e88af2', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f708b42e-31cf-458e-ab46-768e902b73a7', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('50f3d975-d4ca-4686-bfa4-ffd8887afdf0', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b804b27c-045f-42d8-abdd-67b5454b2a72', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b1dc551c-a2d5-438a-bd70-9425ab4d9a51', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('712d8912-eb7e-4afc-905e-75aeb83a6faf', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cf472148-f53d-48ef-a125-5ec083ff0098', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cfe658dc-c076-4b6a-b419-ede04b102955', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7c6d3460-9d4e-40f3-9d77-be7666ff653f', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cab51329-809d-44e6-988e-4909c473556e', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('982c93b9-5675-4a32-b0ec-f365f80171d5', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5f712d3e-03d1-4fc5-b318-0a075ef9b838', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8471ae59-097c-4414-9e5a-b5c9b3c89ea9', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4e119218-f26c-4bed-aaa7-77a3d09bd335', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7f3a5ae9-3d64-4802-b773-1f1a29adf61d', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('79686ddb-e6a8-49c5-bc4f-afae77447531', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5d6cc179-586d-4151-ad6c-8f4aefcbdb62', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b38cdf5e-f768-4ed0-a473-ac653971d156', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c1d147af-7eae-4fe6-b6a4-a69c97b20b42', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('72277fd2-c69d-4940-a0a2-005aba21896b', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8e1a45ff-99b7-485b-b81c-2815509ff843', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e336cf7f-37ee-411b-a104-89d46d288fa0', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('65b0ed7a-c990-4ad8-adcf-5fad211b175c', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5bc72e76-d5d4-4667-a077-8be843c69aa2', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2fd14c4f-0134-48f6-8e67-7a7c6de99b57', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2a235dcf-6930-4300-9f0f-3c4857794217', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('56ca9dc8-7029-42b8-bcaf-72b8cefb0ed6', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('15e51fb6-2e1f-4a0d-b078-8c7e2d2b0863', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b6a1c5c7-917c-450c-b877-5efa6adee719', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5f9d5bd7-2447-434d-a01d-24eba787d98a', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('abb61108-c5b5-42bc-b072-fd4f70a5d5b7', 'bb1d7f02-fee7-4d0c-b3ac-b51d6559edf8', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f31d1d97-5dfc-40ec-b168-3e798e3a5731', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9c042a40-0d0a-452c-8e04-2b4adae178f9', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('88970c1d-0883-45d9-a5d8-ae047d576025', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('137b3f4f-aed2-40d2-ba67-84976cc82621', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('693debc8-6d5a-4f93-8b69-1b573401a3b2', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('640d1ccc-a827-4d48-bee8-54384009ec04', '7a592902-2f45-4b5c-a41a-4fb9db6925ea', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('951c71ed-ba8b-465d-929f-23efcb176319', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('6f33b6e7-4478-419d-b646-f6531eb9be94', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('723ec544-0663-4086-9776-5004ec4381a9', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('80b66701-2a12-4cde-a4d2-8cf9dcd4f865', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1a2756b9-0935-4c24-a497-309c4964e825', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('45821d91-e838-4d0a-be90-b42604e34606', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c57e0249-910d-4b89-9289-2895b2587006', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1dd795bb-4824-46b9-aed9-42563a26e149', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('d9735fd2-3363-4331-af32-34a782e41b92', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4ab1def1-04b0-470c-9afc-3bbd0dbef2c5', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('015926c6-cad8-4206-bbd1-8d5782de207a', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b834bc79-de7a-4773-837f-953cf705ea73', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bae849f1-199d-451f-ad8c-2e2b8233af17', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('26cfb8ae-d3f3-4a3b-9172-830d9433ca6f', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4a627bfb-7638-4c08-b71d-6989efb512d6', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('68c3f4fc-907e-4ead-9bb1-c3a9ae6c320b', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bfb73044-e1ed-49c7-9fbe-5d3688056e40', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e1acaf10-b1e6-4cc6-9f8b-eb1de86aa4e1', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('02f12e6c-fc01-467a-a7af-ca9f1b38f083', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e419add3-1426-4d36-a0ba-74ba9080df92', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ed3d355c-0132-4e16-88ff-2c8c5ebd3bf7', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c434fc71-75f5-4ccc-9f4f-41c365796391', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c2090487-36ab-4845-a2eb-b348e208e7ee', 'f485dabf-e394-4727-88ff-222bdc0a4629', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8ac853e7-65c4-4a77-8f5f-51688d6efca2', 'dae661be-8751-4226-91d0-69a5624aa76b', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('60fbb585-5ff0-4286-93cd-f32c6c5d5dfb', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('02b9e059-5de2-401a-a0b2-3ca8f6982bae', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1f61716e-aabc-4858-845f-441101d922ef', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('50b4ec33-2957-4d1d-861b-60e75691e802', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('05cdb185-1937-4f1b-af8e-f87ed5c2ed0b', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('02846ec8-360a-4487-9376-6829b57667d6', '6574ed59-73a6-43d3-955a-66218e6433d5', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('53ddfb81-4f12-4456-be79-dcd3d37bb6bf', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a9e7aaa3-9690-49e0-a59c-22956ba5d71f', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a9fcace9-49c7-4606-9113-38bf018357db', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('18c6babb-e3ad-41d8-9c9f-bdcee11b622d', '6574ed59-73a6-43d3-955a-66218e6433d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e41d93ba-1737-4df9-89d1-9d109cbc5703', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bad26806-c603-48ae-aa27-71ae09fcff83', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a4074def-301c-4baa-8572-ae4e48cbf525', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cc238ce8-913e-4f39-8656-513ddeeb2b05', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ac1da630-3a03-4154-bd7e-b8e1383f1418', 'be6e8cce-a790-42a2-9b16-3a8a4db9ff35', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('6113263e-0c20-4eec-9200-81919f95fed4', 'be6e8cce-a790-42a2-9b16-3a8a4db9ff35', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b3cb31cb-6841-48bb-8649-5068d56dd511', 'abb41639-40f0-4542-a129-87fa98644f51', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ebcc2e95-61ab-46fa-9ad4-dbc1657de95b', '575f652a-31ed-4ff2-a8c0-ae0e09ce3ea1', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('3a281d7a-42a4-4c9c-bdde-c8fc9bb10069', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('49db0896-1feb-4d4d-9dd4-bd7865cab6fd', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('fd73d9ca-72d3-4ea8-8058-318aa4b7a736', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cc34a74c-8dc3-4804-b68b-1891509077dc', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8309d6d0-861c-4591-9a72-a053f44cc59b', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5da4d374-e659-4d4c-a393-9df94a91f2ea', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5e817f64-2566-4898-93f0-147ae02a641f', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a535083b-f63f-4910-b77f-bcf9033b7deb', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('94499f7e-39dd-4a64-9390-daf83e6bbf37', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7a6b878e-cd03-43c6-81f9-cf76a4fd51a2', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('15621ccb-1745-49a5-b484-43614111457c', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ea82f181-caa9-41ce-bcc8-96b6dcf03110', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2981b7b0-2d3f-4764-84cd-e81dbaba1d0a', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('911bebbf-de49-4c53-953b-2e0d18045417', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('27e0b3fd-76b4-41b1-8d20-c1daec1b04d4', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('07869656-dc46-4c56-871b-e3cb79ea5071', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('d096dc09-e61a-4af6-8d91-325208c12749', 'c21e5742-5b5a-4a45-a38e-3943bfeee1e0', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('77c2474f-6f2e-4a02-a429-d3d6d47725f3', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cf7f593b-7d81-4d10-9db2-8464a67d920b', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('dabdac6a-6ef9-471e-acaf-c7c2e45a73ae', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8789ac98-28aa-4c96-affd-a3d36ae166e5', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('81b886cf-d2d8-490c-8e00-725a27c965e2', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('07d618d4-8ff2-4c2a-a120-e81013c7e567', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('77ff7a53-225b-43ce-a39d-90de6a064c90', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7a43e8c3-f213-4a83-99df-4d68cec2ac33', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4159e3ce-3fc4-4c7f-b2be-c2c9fddc7c58', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ac46fa63-db55-496b-91d5-38d9a4f62696', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('dd568018-7b1c-4f74-88cf-2169df962881', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5e22d7a3-aef3-4039-bace-0fd8d21993a0', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('fdc9bc1d-5039-4ddc-832d-c9e3e21f6660', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('51c62336-742e-4ee0-b8fc-02d9f89aaebb', '353d517f-8807-467b-bd28-719de8ce065b', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bb619f83-71af-4f54-bd13-34894e4cea60', '353d517f-8807-467b-bd28-719de8ce065b', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('fd668619-a3ff-49ec-a4ba-bea63d19e138', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('14d2e0b7-3d0b-4a3f-a9a4-2bdb65f0b787', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c7b287a5-ccbd-4d28-800c-668ae46ab00b', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2ca1e799-3dde-4abe-bb2b-9144de5e5072', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5aeec0d3-8aff-4c71-90e8-6a76124a4bb7', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9b1d4e5e-41f9-49f0-bcbc-0ab95e821eff', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5b98037e-103b-40f2-988d-ea624fb001a2', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('47241a6b-a7b2-46eb-af45-92555d5dca74', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ceb6684b-c910-4ada-bc6f-30798269eccc', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2b060cdf-4bb9-4291-9da6-ac8e31c5f77f', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('003d1360-9ed4-4cb0-b547-1d69499593be', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9ccbb18c-8978-4f6e-8663-ff37888ebb3f', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('fbd919ec-8d4a-480f-80e0-ef3a02352aaf', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b48e5ca6-2435-4957-86d9-0bfe21141d4b', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('eb9aa087-5c9f-46a1-940a-8c39617e8cbd', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('3e74cd7d-facb-41af-847b-13be51ac3687', '62152838-604f-4b36-8b54-3c29499fae2f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c86c3b8e-fc6b-4491-affe-664aa044a0e8', '62152838-604f-4b36-8b54-3c29499fae2f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bf2a0cf3-3a33-4745-9644-dcccd733bca0', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('de74245c-d4bf-4075-bbe2-0fb77e32c011', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5904f1ce-9adf-446a-a6b2-512a500c10ed', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('69120ea2-a21e-46ce-b0cc-a23839137b08', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('67234c33-3817-4869-a8fe-8f67a31ee49d', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('72cd01a5-2b97-4afb-8287-30d14d868c69', '62152838-604f-4b36-8b54-3c29499fae2f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8e0a0d5f-9d4f-4222-8cd9-5d16d41e42e6', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('29b2b308-e767-4436-921f-97718700d68d', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0e14e1aa-a47d-46fa-a03a-3a3ac642a5a9', '62152838-604f-4b36-8b54-3c29499fae2f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0c1752fe-7b80-4b8e-8593-3b9fd91065b7', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('80cfb54b-6295-46d0-9fc7-c716d32c77ae', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f9acd2db-1ad8-46cc-9703-f64d4a24aea0', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1731a29e-ea22-4e70-94e3-6c3ec502b0fa', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0f10fe38-62e0-4d55-911f-93771c79f45f', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('99fd59c8-68b7-4b11-9322-d144162a47b7', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('19de6a9a-29d2-4785-8332-593504e51780', '62152838-604f-4b36-8b54-3c29499fae2f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('407ec7eb-0156-4078-ab63-a11a2e50f25f', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c1d5bcd2-efb7-4b20-a340-9cf5028e6b95', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a4434f94-3c0c-4bf2-900b-ff6a07f6536b', '62152838-604f-4b36-8b54-3c29499fae2f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('88b8de7b-6de8-427a-9320-4e8035c90b53', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cca4d451-7ea1-4f99-b45e-929375dfd964', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b8634c93-b2eb-4fb7-b266-4e937dec8cfc', '62152838-604f-4b36-8b54-3c29499fae2f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('542285ed-ca20-44e1-b6f2-e3e467fa1490', '62152838-604f-4b36-8b54-3c29499fae2f', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('19fd34f5-5d51-44ec-9450-b8ac48af9626', '62152838-604f-4b36-8b54-3c29499fae2f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('98e5f2b6-c6a5-40b3-933a-4603b5266cea', 'd7fc6634-8d8f-4446-8d4e-2b0672f7089f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('63ccd726-1714-4d3d-97f4-85e64480fe4f', '08f5de46-f0d1-4bec-8a50-45f25f10be26', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1c7f6720-56d3-467a-ab54-f8439a34362c', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('99c916bc-d88a-43a6-a7cd-37cb04e48df4', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('cd7166f6-d205-4932-8c5c-c3132a25aba6', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('27508085-b4d4-4b38-80c3-d672cad74990', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('aac60e50-a7ed-443c-9b5f-c6e734bc6093', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f02c9dfb-23d5-4db0-bf97-49c78fe179ae', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f3c79a3b-d26d-4c05-b106-79df36bfc43e', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c6322ef2-56ad-41b9-b304-c4594f1218d1', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b9615e2b-51d5-49ad-8ab5-3c84f7dfac40', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('31dccf6c-12ff-49f8-9318-804f419de7db', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('3fb6ed1b-33e6-4ec7-b61a-0975943f374e', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('2bd96a1e-b3c6-4485-90b5-8eb2d90c206c', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f1fabb01-fcf4-4c9d-b42d-66ccc82f431c', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a7150749-bbe6-47bf-b2a6-a8823a38eb0e', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('7970f52a-4fd6-4925-a764-d07684086da8', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bad111f4-7ee0-4aaf-8915-6950066e9c2e', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('222f226a-a134-4ba3-9558-4526c8938bcf', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('49017097-1a0d-445f-b3f4-b8434d33655b', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1e8b5aee-b4fe-4fca-8687-0a7c74e6d5b8', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('68889393-327e-4e1e-9530-f103297efd86', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('74b569b0-b162-4495-b14f-e7287b515aff', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e91dbecc-42c1-4fc3-8023-b6ccad93c7d6', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4f96a66f-6f57-499a-9de0-30afc34c2910', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('495f4442-ce44-4287-b0ff-158ec76d6c10', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('ce44a7e5-d570-425f-ac17-aed7fda6e0e5', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b31499f3-ecbb-4e7d-a379-3e3a8418c24b', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('985d40a2-0808-4fa3-b155-d779045e9db8', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e2ded3ef-ece5-4dd1-95c5-f7ea63b1eabc', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('bdd2524b-1457-44fd-9fbf-4f256c2597f2', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('47abf0bd-ece4-4bae-a614-34407c491020', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f100b7a9-f719-48d9-beaf-d500085a9ade', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('634777c6-e859-45e6-be07-048da1e5df53', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c961e248-193d-464b-a157-d2a0e74994b6', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0637da15-2b95-4916-ab16-92be5530fbd1', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('beac4edd-1d55-48ad-b9a7-6eb235ce12e7', '80600697-efca-418d-bd60-ffe738468a3a', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a6a980ea-2da1-41d7-9cbf-52fda8b326f7', '80600697-efca-418d-bd60-ffe738468a3a', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('13b9b8c7-fc6f-4a47-a457-71572c045915', '80600697-efca-418d-bd60-ffe738468a3a', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('4cb80207-8cf4-4144-9280-d5c756f4453d', '78c5d260-8775-46ec-861d-902a023b2167', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('54172f95-d531-403d-bbea-b42df934289a', '78c5d260-8775-46ec-861d-902a023b2167', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('77a2f4a9-382a-4a3b-8040-49e4d79f55d9', '78c5d260-8775-46ec-861d-902a023b2167', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('538d0353-3bbb-4036-a7ab-066f776cb926', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('36ba155f-1c0c-4584-b2a0-3f6a5f170f72', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'indica', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('e1c548b7-3190-40e3-a939-5cdec8601d54', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a4daaa83-e737-4737-9622-2590fd8da16c', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('93c05baa-ec3e-4dfd-acd5-b12ec3222f9c', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a1611795-c1fb-472a-b672-0e9c23a7e4f2', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('71cd9063-31d2-421f-afe5-ba090468f436', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9faf4b74-3cf5-4823-ae78-e20b95486ddd', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a6de8dae-aba9-42cf-abb9-4928c7e7d161', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('c38720ef-b7dc-4ccb-b743-ca38a29319d4', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('9e6633fb-0b4d-47cd-b49b-e81328d3ddce', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('8d6612fc-578d-44eb-96ad-1c41d15c83e8', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0ea846c6-b10c-4fbf-ad07-ff9981a7096d', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('b291a8dd-38de-4f1c-92f1-ca4541a55898', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('3f801501-83a9-4225-bf6e-00b3b5f194a8', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'sativa', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('a4ba0784-3a91-4960-8c1e-d43e5a3e6b81', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('54029068-048b-4cf2-a877-4b3a0b213f21', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('85f7bcbc-bf35-477d-af20-bf1f2b27a108', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('0c33d445-b126-4b9c-960f-d2e67e091105', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('1979b206-bac4-47e2-9ed1-7e249e540e76', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('5f28b4b9-d18f-4085-8e4e-a8b7561c1606', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('911c185f-a514-4c15-83f5-02c89f1c0439', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('f6898013-d3b0-4260-b41d-f87137b3ff51', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'hybrid', NULL, NULL);
INSERT INTO public.concentrate (product_id, business_id, strain_type, thc_level, cbd_level) VALUES ('3c765aee-b372-4fbc-9d1f-e5b723faa526', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'sativa', NULL, NULL);


--
-- Data for Name: edible; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.edible (product_id, business_id) VALUES ('53256df8-6e3d-45da-99e1-19261a552d24', '918ae191-50f8-4ed2-8d44-7758190d1b63');
INSERT INTO public.edible (product_id, business_id) VALUES ('db516171-23ef-4b02-8e2c-6e91f71a3926', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('48f47640-a071-414a-98ed-a550c11a5c98', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('8e6e72b0-e4d0-43ef-9ac9-526f7620890c', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('75f23c47-d260-4e31-9819-2019f3502ca6', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('ae9b9b88-3d90-4a66-be66-c32d15984110', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('c904d8fc-e78d-4f9e-821b-19d0f7b6ac25', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('2ea3a6c4-0cd5-4514-9a13-361c9be54546', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('fa7f8926-0f6e-4057-8a2b-e57f0c0cc45b', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('2d57bf4f-af15-4ede-9b7b-d161dea87682', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('f348bd8d-6048-4f1c-8677-bdc6bb90ad89', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('553099e9-a9b5-468b-ad17-b6602430a484', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('f5b9010a-6504-4959-8ec7-582347e67688', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('b81ea2ba-a40d-437a-9ee9-77bd80457fd9', 'f14d95df-5695-49fc-ac32-f64b7b766da1');
INSERT INTO public.edible (product_id, business_id) VALUES ('fdab2d71-3e45-40c0-9ae4-22f4a1685da6', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880');
INSERT INTO public.edible (product_id, business_id) VALUES ('9fa60cc0-c984-4262-a4e3-0c421f486c3b', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880');
INSERT INTO public.edible (product_id, business_id) VALUES ('a3438500-92ed-4f63-b83a-259f1f308a35', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880');
INSERT INTO public.edible (product_id, business_id) VALUES ('6a8184cb-799d-453b-95a4-12fb9bbd4818', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880');
INSERT INTO public.edible (product_id, business_id) VALUES ('eb647ff7-cf52-46cf-95fd-d5814cd616ee', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880');
INSERT INTO public.edible (product_id, business_id) VALUES ('54f11c7f-f556-42fe-a8e2-5687e0058cf2', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('5e24512f-e014-498c-8d94-d97acd0af217', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('4c3c92c4-a7f6-4163-8e21-a1e84cb78fd4', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('e102d3a2-1789-4846-b17a-f26bdf4e2f20', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('91700a02-2d08-47d4-a000-02f1b1e661d2', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('9b8b7f19-9029-47cc-848e-b8957f1239b5', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('ee2756de-c922-4a14-ab39-5a9707aaab77', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('632e1d53-a113-409d-a869-bc3d9eb7a2c1', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('c2b08000-2dcc-4e0e-a4bf-3f1e77fe2bab', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('b07e4112-e5c1-44c2-a355-5e8acdf8627f', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('6e3ba76c-13c5-42cd-b89d-2105b8208e81', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('121c5115-85ce-417d-b7a7-27c66eef282d', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('45829af5-e0f6-483f-9c21-2a81acf2d8cd', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('6397012e-deae-4e75-9cc2-198a04464ce4', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('cad88dc3-62e0-47a9-bc4b-5b43869ad079', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('1d4ce953-b650-4eab-8c4f-2e4f43638234', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('ebbc0414-d14d-4f06-9fd5-6476e22130c0', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('1a8674bb-85d1-4bb5-b015-05c0322c7088', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('b28bf7de-95cb-47bc-b4bf-51588d4ed66f', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32');
INSERT INTO public.edible (product_id, business_id) VALUES ('e3532f7b-d54e-4f33-a418-32422295cd70', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('c7852358-8b83-4f86-a230-a1f1e2c36708', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('8a99861e-140c-4090-b35a-d9fc54305019', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('ef179adf-06ee-4169-a768-9861a7deb67c', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('33265b21-20b0-4d7a-87bc-0299efbc7e6d', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('2d79f494-858b-4222-ab13-7cd5cecae200', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('918c6e8d-621c-4db6-95f4-d8b9e0fb10d5', '2f262183-cb2a-4cae-a4ee-dbdf1fbd0193');
INSERT INTO public.edible (product_id, business_id) VALUES ('1e053228-2a56-4e5d-9db9-3e8f30b3ee13', '2f262183-cb2a-4cae-a4ee-dbdf1fbd0193');
INSERT INTO public.edible (product_id, business_id) VALUES ('e810c935-855b-48b8-9350-0674e1c222c3', '2f262183-cb2a-4cae-a4ee-dbdf1fbd0193');
INSERT INTO public.edible (product_id, business_id) VALUES ('812144d7-4b17-4535-82de-ff888305c7d5', 'bde837ec-7ff8-4733-8eea-a65854e4acb3');
INSERT INTO public.edible (product_id, business_id) VALUES ('367230f7-a97e-4359-8a37-9e333a440cdf', 'bde837ec-7ff8-4733-8eea-a65854e4acb3');
INSERT INTO public.edible (product_id, business_id) VALUES ('9380e487-c97a-433e-a9e7-1b58089b126f', 'bde837ec-7ff8-4733-8eea-a65854e4acb3');
INSERT INTO public.edible (product_id, business_id) VALUES ('3eb3ad63-c482-4f12-b70e-e6c800cfcc31', 'bde837ec-7ff8-4733-8eea-a65854e4acb3');
INSERT INTO public.edible (product_id, business_id) VALUES ('9d0a6b6c-099f-497b-b3a4-0e00e58d086a', 'bde837ec-7ff8-4733-8eea-a65854e4acb3');
INSERT INTO public.edible (product_id, business_id) VALUES ('7391ecb2-54ad-452b-9081-d0438f0ae7bb', 'bde837ec-7ff8-4733-8eea-a65854e4acb3');
INSERT INTO public.edible (product_id, business_id) VALUES ('74a3638c-b415-415e-b6b3-d53023aba22e', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('9c3514af-3870-4f90-9ae2-f23cd185f7e8', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('de269d07-f79e-4edf-a450-723a41f6cbb0', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('b4377d88-d4c6-4bac-899f-bea06b7a24f7', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('82485294-a75c-455a-82c7-8c758ec44558', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('04cfbc19-035f-493f-9d84-94f7ddcbb75c', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('66a19a16-f40c-4245-9a86-b5d699f2d462', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('aeb9602c-3744-4a16-903e-5ab2774cb54a', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('4dad4c0f-390a-4cd5-9dbe-ebe04bc4ab33', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('22d43864-ba10-4ece-b607-475e930c5d19', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('ae4623ca-1849-468e-9594-25fb39827bd0', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('2b95541e-3a76-495c-bbce-253fb6de9790', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('3b981ec7-2b53-4346-aee1-25d9d3038895', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('90088ed9-dc15-4249-9817-8f9c89106c78', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('8e9e6611-0c98-4935-a32f-21bc1de10dfe', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('54aa04be-762b-49a5-9547-1ff0dc14b612', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('f537f4d7-5543-4b12-97e7-92fe047a700e', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('7240b4eb-f447-447f-9fe3-c3f30b8e8b4c', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('5cf23b40-0ed9-48da-bf53-06c64f3b5165', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('83329d95-b715-44a5-a87e-a4a4a4790b8f', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('9d96fd68-0846-4c03-9c0b-64600a31d423', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b');
INSERT INTO public.edible (product_id, business_id) VALUES ('42a30bfd-13c7-475a-af20-5e9b61b12aaf', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('d949ef1d-44e1-40a0-b004-066eb5e06f17', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('64d0d6f9-edb5-41f7-bc68-ab488674a3f2', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('749d9e26-9fc2-49b0-bcb7-6d5aec62df34', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('eb8e9916-1a6b-4a4a-825a-50597e89ad06', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('c3b240c5-6e2c-44c1-ac74-43003c3f83bc', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('516a0394-31f7-4276-b0d6-75bc3e47937a', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('5a2a58a3-999f-4eac-b426-0f74dc4799fb', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('ec322f60-083d-4e25-af77-49037b069ae6', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('f7c2840d-3422-4844-8691-b0e0d9d2743f', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('8aa61d0a-8295-43fa-953f-652c039019f3', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('0fecc130-1cee-465e-b250-fafee584b42d', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('dd8f0dcd-8255-4c8b-a912-c6a2eedb8267', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('849baac0-8a08-46be-812e-7bfdfe2a1ac9', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('7d41000c-b98e-44ba-b759-dbe6888bca42', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('5e0d1f3a-350d-45a8-b521-602921579275', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('ef79722c-8399-4630-b557-24568186c33a', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('44b4e0c7-bd1d-4dd0-8118-20be8ab57a8e', '90c82657-0d5e-4e7e-8721-eedb93dbcc57');
INSERT INTO public.edible (product_id, business_id) VALUES ('46ed1698-2198-4d57-bf2f-e3e3b6fd0da1', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('c929326e-d212-44fe-9b44-e1bc59388eea', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('eea4a765-625b-4e62-9a03-8199114011ce', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('3f688c66-f679-4d51-b970-3d8d998923cf', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('1918c5b9-a1ec-438a-9f83-1e8c1c93779f', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('a46c74d1-69b8-4020-8b10-af24cfc60d4d', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('b287905d-4afe-4f8b-8493-c4eac081214b', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('2831d3aa-afc8-477b-92a7-b57583223dc5', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('ce29753b-6f46-43f1-a5ac-89a05f749641', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('bff5a279-b4b3-453b-8c02-6534a118d13c', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('efe24116-e456-49ab-81bd-2c15f82d2e3f', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('8f69e927-b0e3-40bf-b99f-808ebf0ca595', 'ccfe4fcf-72d5-42e2-94e3-645bac549234');
INSERT INTO public.edible (product_id, business_id) VALUES ('27b9bf34-1031-4255-a905-9585940a2991', 'bb1d7f02-fee7-4d0c-b3ac-b51d6559edf8');
INSERT INTO public.edible (product_id, business_id) VALUES ('7b78b5b2-d075-4c8f-8b68-c30f8e2ba47f', 'bb1d7f02-fee7-4d0c-b3ac-b51d6559edf8');
INSERT INTO public.edible (product_id, business_id) VALUES ('42ded46d-ec27-4b7e-971c-ecc153acfb01', '560dc886-4ada-456f-a6b4-32ae1f1de146');
INSERT INTO public.edible (product_id, business_id) VALUES ('33ebf9c4-300e-42f8-b8bd-88136c20e0e6', '560dc886-4ada-456f-a6b4-32ae1f1de146');
INSERT INTO public.edible (product_id, business_id) VALUES ('d5a501ee-4b5c-476b-b7df-adc5ef8e7010', '7a592902-2f45-4b5c-a41a-4fb9db6925ea');
INSERT INTO public.edible (product_id, business_id) VALUES ('81b39994-0828-4867-93fe-5f9afd606e13', '7a592902-2f45-4b5c-a41a-4fb9db6925ea');
INSERT INTO public.edible (product_id, business_id) VALUES ('05b37153-3a9a-402d-9a6a-4baa99672e61', '7a592902-2f45-4b5c-a41a-4fb9db6925ea');
INSERT INTO public.edible (product_id, business_id) VALUES ('19a3bea8-acbc-4050-8467-f887393e10f7', '7a592902-2f45-4b5c-a41a-4fb9db6925ea');
INSERT INTO public.edible (product_id, business_id) VALUES ('b40e47c1-5439-441f-88c8-38382998025f', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('2d4b75a7-df14-4913-8512-f5616baa8535', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('d18e46e1-ffa5-49a4-9c7d-dc0a68ae62f0', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('32c1e745-20c0-40da-9288-3cdcb3d880af', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('b8c37e22-245a-44a8-b819-b6e859e093d4', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('72225a74-cfbd-413d-aba9-ee43ab7054dc', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('78cf883a-cc18-4c9b-8e12-15e566dc2380', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('27778f93-d829-4850-92a5-88ccf14a9850', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('d748d875-fb1c-4160-9117-5ecc74833007', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('1dfaa558-4aab-4791-b487-a2a9f27341e8', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('c2a9f939-e5e6-463b-af22-d54f2cde4061', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('014055bd-3cd2-4341-a97e-1071dda7aa00', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('99691074-5218-4a86-b2dd-6bf3b0e5f97a', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('dfafe2ce-c838-4960-b509-23a1f151d6c9', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('187dd138-b510-4950-89a1-574f05149ec0', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('920b001b-c6dc-44fb-95f7-363817cd70f6', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('cdf47be0-334f-4cb8-8f65-8c35c4851a41', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('483a3b79-8e9d-4beb-b645-6969bb042b4b', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('ea782337-1bd1-4e6c-b02b-6b66676204c6', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('0c2dac98-d5ea-4032-87ec-e159ff4d2555', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('fde25c1b-15e7-4829-bd16-d7c003063eef', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('67f6e908-1e03-45fa-beff-31d8fcdfe068', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('d44b99a2-9bc2-4bc6-9600-f6aa7025eb4a', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('a945e4e8-f31b-4794-8c00-468ed317170a', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('19ccfb9c-3aca-4660-9cf5-4dfa2fa5b804', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('67cb5be7-aa7a-4021-ade0-b450ea668d97', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('af723634-0c52-40ec-95eb-4b748015f348', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('37a7fd24-3e29-4f8e-8c66-47eb397b5566', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('077f2bbd-1ac6-4091-9abe-44709fc7a6f9', 'c51e906c-a2c7-4c29-9617-7304158ebbff');
INSERT INTO public.edible (product_id, business_id) VALUES ('6e81a748-8899-40e5-a06a-1a519c1eab3d', 'a5290c13-6b25-4060-b42a-c8151be600ec');
INSERT INTO public.edible (product_id, business_id) VALUES ('1cdb2b5c-d44b-4a30-81d6-30dc84c91fa3', 'a5290c13-6b25-4060-b42a-c8151be600ec');
INSERT INTO public.edible (product_id, business_id) VALUES ('01a661ce-a9d6-4741-88c2-014d685c09a7', '8a039435-604a-47bd-8463-045fe3532fba');
INSERT INTO public.edible (product_id, business_id) VALUES ('6598caf6-c8f4-476e-905e-1236e78c3442', '8a039435-604a-47bd-8463-045fe3532fba');
INSERT INTO public.edible (product_id, business_id) VALUES ('29762c8f-33a0-4fac-8e34-6f68d1c1f794', '8a039435-604a-47bd-8463-045fe3532fba');
INSERT INTO public.edible (product_id, business_id) VALUES ('fd6ff4e0-f1c5-4085-a1b3-9db7be0e7071', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031');
INSERT INTO public.edible (product_id, business_id) VALUES ('69531feb-ffee-4968-830e-abdad6d72741', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031');
INSERT INTO public.edible (product_id, business_id) VALUES ('bb1b42d8-f1ab-434a-a4db-e2f9978625e3', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031');
INSERT INTO public.edible (product_id, business_id) VALUES ('f5b5ae64-5dc1-4cbb-bf39-c907b0d78934', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031');
INSERT INTO public.edible (product_id, business_id) VALUES ('82a0b4a1-f96e-46cd-ae9f-6bec4bcf100d', 'dae661be-8751-4226-91d0-69a5624aa76b');
INSERT INTO public.edible (product_id, business_id) VALUES ('32d0298a-0b5c-45a5-9654-d327923b52f0', '6574ed59-73a6-43d3-955a-66218e6433d5');
INSERT INTO public.edible (product_id, business_id) VALUES ('1269a492-a445-4411-b713-5954750e8dac', '6574ed59-73a6-43d3-955a-66218e6433d5');
INSERT INTO public.edible (product_id, business_id) VALUES ('b1948ab7-46c1-47c5-b048-a95cc9bcd16b', '0cb2135f-039d-489b-8791-1961fdb778dc');
INSERT INTO public.edible (product_id, business_id) VALUES ('edee4fc9-25c9-4bda-981a-89ea35008a77', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('358a66ea-a548-4688-9565-1459c2ca5f7e', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('e81c1463-10f4-4a1f-b283-9a75e2953e8b', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('47e101ef-5bd4-43c7-8487-d265692adf80', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('68d5ddc8-c9e8-416d-ab85-64df33e5623c', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('c930492f-e888-4371-95d0-bc59b295cd09', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('7fa41a2a-876e-4ce5-a813-0ccc7c662d82', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('b5ac6e0e-f3c9-4cc0-a998-aff9149a205d', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('2822778e-80d1-46e6-ad4e-0da5f3a7a8da', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('a5c04ce4-af58-485d-aae0-59df374fdc38', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('eaa92577-0ee2-46ed-bdf8-33a01195af2b', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('aa581e8e-bd11-44bd-a2ac-42c6f7997a3d', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('1500cfbc-e8c6-4dce-bc7e-65bf6cd5e748', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('f945acc2-93d0-4095-9419-e3ecaba855d3', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('fba6bc93-8d03-4f79-9f2d-4ba124ba2c1e', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('d4b93c21-9825-4553-80ab-81edf8acfd56', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('79fb3630-62fd-4ba9-b830-75e8af0644f9', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('10bb4b61-1295-49cb-93de-a1bae145b52f', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('7ac34e22-3cd4-45c2-b395-f9bda8432c50', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('746f2c4f-35c0-4b86-9ee0-2de04d134a75', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('558c8929-d787-44b8-9f7c-2d5ab1506ac4', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('4a99d2d8-c2d7-4289-831e-46e9e674894c', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('d832e4cc-2dd4-4816-b0b0-272004469a96', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('5d1e220b-59cb-429b-8a2d-d1a878901da3', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('81a21a9f-d231-4b3c-933b-adb7fc2775ad', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('8a80a06e-4f89-459f-8a9f-32ad5f9d640b', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('90cad047-c37a-47d8-ac98-c690a6d6f17a', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('0a57644a-8483-42a6-8d07-fe854457898f', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('fec52ae7-cb5f-46e8-9fd6-91cdbdeb22b1', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('e30c91d1-fb8c-48fa-9409-7d94ea48a396', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('12bc6a8f-d8e8-42bc-b0e8-c5db93f7d9b3', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('bfafdf1c-c31a-491c-a9a3-fa1e59718ce6', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('a870a2a5-414e-43e7-8e85-74e68b727402', '6ac976a1-2f75-45cc-9144-4525d4c72853');
INSERT INTO public.edible (product_id, business_id) VALUES ('ef49b518-584a-4239-aae1-3fd451c45813', 'ce44b0c8-092c-4d8f-abce-eb4d014ff2b8');
INSERT INTO public.edible (product_id, business_id) VALUES ('a846e804-ba05-4e82-975c-67b54ccfbb1f', 'c8a9ba26-9bfe-42c9-ac8d-dd8abec61a2e');
INSERT INTO public.edible (product_id, business_id) VALUES ('3719fd64-d550-4603-a379-1550a07a9f35', 'ceb9853f-9206-4b44-9aea-749dd4c156bd');
INSERT INTO public.edible (product_id, business_id) VALUES ('4f50d844-82c3-499d-a794-2d7cf6201a28', 'ceb9853f-9206-4b44-9aea-749dd4c156bd');
INSERT INTO public.edible (product_id, business_id) VALUES ('7fc6876b-752a-4f9a-a8f8-27077ab6cdf4', 'ceb9853f-9206-4b44-9aea-749dd4c156bd');
INSERT INTO public.edible (product_id, business_id) VALUES ('cf32d340-bb56-4e01-b170-28097384a5dc', 'ceb9853f-9206-4b44-9aea-749dd4c156bd');
INSERT INTO public.edible (product_id, business_id) VALUES ('ccd5a71e-e24c-4bbe-9bd8-42953bdcc28c', 'ceb9853f-9206-4b44-9aea-749dd4c156bd');
INSERT INTO public.edible (product_id, business_id) VALUES ('037910d1-025f-40fc-844f-265687de4070', 'ceb9853f-9206-4b44-9aea-749dd4c156bd');
INSERT INTO public.edible (product_id, business_id) VALUES ('52de2433-0f99-4a0e-b0d6-a56e9b24df24', 'c6d1feaf-8194-4883-8b71-e9f3935863ad');
INSERT INTO public.edible (product_id, business_id) VALUES ('45787be7-6923-479b-a390-f6b378791583', '4aa30ac3-fdd2-4e21-973f-7a688023fe09');
INSERT INTO public.edible (product_id, business_id) VALUES ('317416b5-7765-445e-91ad-cb7a3498d326', '4aa30ac3-fdd2-4e21-973f-7a688023fe09');
INSERT INTO public.edible (product_id, business_id) VALUES ('dd7e4709-10c6-408a-8537-54a08adfaed4', '4aa30ac3-fdd2-4e21-973f-7a688023fe09');
INSERT INTO public.edible (product_id, business_id) VALUES ('9bae30c6-3a39-49a3-9a7f-1f831614536c', '4aa30ac3-fdd2-4e21-973f-7a688023fe09');
INSERT INTO public.edible (product_id, business_id) VALUES ('904190d4-47c5-4902-9b48-f6fd9abfbfe4', '4aa30ac3-fdd2-4e21-973f-7a688023fe09');
INSERT INTO public.edible (product_id, business_id) VALUES ('4e089844-c67c-427b-992c-3ed9bdf115bd', '4ed6b674-9e03-4a47-992c-9019ee7dc026');
INSERT INTO public.edible (product_id, business_id) VALUES ('964d5eba-5fd4-41ab-a4fa-300f0e584e11', '4ed6b674-9e03-4a47-992c-9019ee7dc026');
INSERT INTO public.edible (product_id, business_id) VALUES ('637f8a69-7fde-4dcd-a943-9693809c8326', '4ed6b674-9e03-4a47-992c-9019ee7dc026');
INSERT INTO public.edible (product_id, business_id) VALUES ('6d4f22c1-d6c6-432f-a383-824b20d58e1a', '4ed6b674-9e03-4a47-992c-9019ee7dc026');
INSERT INTO public.edible (product_id, business_id) VALUES ('74411298-c585-442b-9faa-c75be6455366', '4ed6b674-9e03-4a47-992c-9019ee7dc026');
INSERT INTO public.edible (product_id, business_id) VALUES ('2480da84-5a73-44d1-861e-145a37b2c794', '4ed6b674-9e03-4a47-992c-9019ee7dc026');
INSERT INTO public.edible (product_id, business_id) VALUES ('8dd76942-b0eb-4e3f-ac61-fee7c1f4b3d7', '4ed6b674-9e03-4a47-992c-9019ee7dc026');
INSERT INTO public.edible (product_id, business_id) VALUES ('a966e260-fea5-4ace-86c6-bb9e3ecce7b2', 'a05f9fb7-b804-4ea2-9aa3-eaecc7aa7850');
INSERT INTO public.edible (product_id, business_id) VALUES ('279c598c-acfa-4176-bf96-c7fa2bf635ab', 'a05f9fb7-b804-4ea2-9aa3-eaecc7aa7850');
INSERT INTO public.edible (product_id, business_id) VALUES ('f9b901ce-5739-4b3b-a245-5cf670a1d0ee', 'a05f9fb7-b804-4ea2-9aa3-eaecc7aa7850');
INSERT INTO public.edible (product_id, business_id) VALUES ('158fa062-4961-40ca-ac4c-3acdc426723e', '0f70b3f1-7f71-42b5-a8f1-39649ed8c922');
INSERT INTO public.edible (product_id, business_id) VALUES ('52de3373-3106-4b09-b674-47c530a2991d', '893111d3-6962-4cc2-8576-bc6b1dc1668b');
INSERT INTO public.edible (product_id, business_id) VALUES ('993a5d2c-dff6-4721-996e-0d9567739a37', '893111d3-6962-4cc2-8576-bc6b1dc1668b');
INSERT INTO public.edible (product_id, business_id) VALUES ('962c459d-3e19-4c4c-b0a8-ded087089780', '893111d3-6962-4cc2-8576-bc6b1dc1668b');
INSERT INTO public.edible (product_id, business_id) VALUES ('856528e3-d36f-47dd-83fa-0e07932c5dc6', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('d37a9a59-62b9-4ae1-a341-1b710ea63cbe', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('7d2bcd3d-bfd9-4626-9835-5e374e9ed75a', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('b3e30f24-eb38-4ed0-a495-c08bcc748db4', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('ef4aadae-20cb-4366-a02b-b3d91ba97da9', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('0f9a4ff2-64dc-45d4-a51b-579cce3a8508', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('c3e0db75-30d2-46d7-8f3a-6f3928dd62a0', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('92dbd6f8-b83e-4bb6-8de1-aee982292aa2', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('bac01c31-1aac-496d-b71b-1e9901dc7ef9', '1a241391-4051-48e8-8417-29fbcc0b7c9f');
INSERT INTO public.edible (product_id, business_id) VALUES ('a04e355b-4634-4243-b476-d2b56b7b909f', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('fe8f5dc8-f68d-4c4b-b7aa-821d870450ef', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('f1976659-b1c4-402c-89ec-91648b7963f0', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('907b5e8c-587a-44ab-9bbb-40bd80a8399d', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('101686b1-96b5-40f6-8979-3e78fde263e1', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('830bf577-b4b5-4ecd-8638-4fb402f2b6e6', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('54b34178-ef06-4e24-ae11-c1554dd5006a', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('941e8aeb-5a33-448a-af27-0ce473a6a7b3', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('7c3609ef-3072-40dc-8309-3b580bca642b', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('923adc57-c2a4-4f34-8839-d9671d1bf311', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('3c67f34d-eb28-4f90-a942-0b435afbbe94', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('02751eb2-35fa-4a1c-8ade-83091a29162e', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('f89e875b-0ace-45a5-943c-b7fe27db06bf', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('9dfb96d2-fa20-444f-8eec-c00bd395ab87', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('f8118f72-8d20-41c6-8b8e-d7cb30f75d6b', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('0abf14f3-d002-42d9-85a1-2034eac0d4b5', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('9b101e25-58de-4219-8e7b-9527cd3139ae', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('c4c9b9d3-ffac-4e2c-8e73-56cdea4009f6', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('bf94df73-dcc4-45c4-a226-348d76ac9620', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('8f6c1736-5264-4103-88e7-668e66598580', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('cd8e6076-f75d-4ee8-9f39-2f769d1affb5', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('80dbaea8-7d42-40f9-94df-e80bd05c22d4', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a');
INSERT INTO public.edible (product_id, business_id) VALUES ('3a47b87c-6885-4969-bbcd-d23a5dcfad66', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('5beec3c0-3c1a-47d0-8476-0580fe4d084f', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('b744f42c-9aab-4cab-9dcd-0451536b4df3', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('7d23c7f7-404d-43a2-b0d4-10f8ce3a4470', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('7110ad9e-091a-4364-9bd7-513ded741c49', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('5e6cf8a9-ea74-43e3-8b3e-ae383540b008', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('3392e9b9-3ef1-4ecc-ae62-08b489d113eb', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('d17c2d30-fd46-4a63-be13-4152293e152f', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('e1037063-a7cc-475a-b7ce-438a328623bb', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('b33b3941-f4ee-4918-8c3d-39546f499f36', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('65302c3d-d2ed-4606-b82f-774c7942f31b', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('418da1c0-cbe8-42dd-8ff6-d30a565c4778', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('722928f3-faff-4d22-b931-1abb280155ad', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('f20343a5-60bf-46a1-97a4-7d279f63f709', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('a13cc212-2589-43aa-b120-f5f6e3674c6a', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('5542bc9e-eec9-4714-9dff-9b7ee20c4417', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('ed243247-e4b0-48ea-b366-5b8d19be5805', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('3fbcfa77-1817-4cdb-8482-b973a5093337', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('1326ba21-78eb-4029-92d7-b20867ca8110', '0984d06f-cce1-445e-8486-9f176652c145');
INSERT INTO public.edible (product_id, business_id) VALUES ('645e11a0-d7f2-4760-a138-5e311320529d', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('b6dd7bd3-6030-4305-abfd-bc4bf81f8a31', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('4170a756-f8c8-40f3-9c5c-0f4ecebedd2f', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('9d99bf64-7971-40b3-a6a7-276a1666d9a0', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('c2219c86-dfe4-4791-9c7f-fb54e773cccc', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('e7870edd-dbf4-4192-96cc-48f742e0c78a', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('43ddff0f-e6de-446c-8df2-91a60d69ad82', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');
INSERT INTO public.edible (product_id, business_id) VALUES ('2f3f44da-e0a5-4df0-b7d4-91cb1452101c', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f');


--
-- Data for Name: flower; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('15f95efc-418a-4a7e-b89d-320c94bbc31f', '9a35bde3-3067-49af-9a84-31b5bb36a261', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('15f95efc-418a-4a7e-b89d-320c94bbc31f', '371b6067-2f80-4673-b88d-3c33ae19df45', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('15f95efc-418a-4a7e-b89d-320c94bbc31f', '19c52295-5820-4947-927d-5d44dc3470db', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('3e6d08f3-aba2-43e9-8839-301a94c5c9e8', '1754ad2d-95b5-4d0f-9bb8-b0a830db16be', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('db1f29ec-93dc-4b9a-bb95-439d673ea62e', '8836c5db-5867-4be5-942f-b829fc666547', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('db1f29ec-93dc-4b9a-bb95-439d673ea62e', '3eb83a8d-b8d3-4882-ac31-89fe2d793933', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('19b5defc-296b-49fe-9edc-3e21e8b7e246', 'bd74eaa4-90d8-443d-8d2c-26ce7d036c3c', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('5f1bd2ea-af31-480c-8853-93a881f4d0e2', '72b0f594-84a9-4485-b196-cfa93d298e66', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('5f1bd2ea-af31-480c-8853-93a881f4d0e2', '796c7a44-e295-4c81-bf64-e54bde49f79d', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1e628a11-3700-4f2d-b2ff-d40ef5b7141b', '4f810ab7-6322-4d65-bd23-c07bbaa2439a', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'dca3ff0b-a928-4119-b0c9-b2572bce7759', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'f693f051-5381-4b0b-963d-e52f309356a7', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'e304a542-92a4-496d-9f49-062e9a732858', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'fabb3134-1fd7-4ad2-bae0-3edbbd07847a', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', '5f2964ae-18e1-4dcf-9aed-3ddf98ac8238', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'a409be97-668b-4fa6-a531-9e0ec5d544ec', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'a1b3a06e-c13d-4e65-ac40-461c7fe7eb8e', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'f1711456-ee35-414c-8c70-f06289491d5d', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', '0c1d0af6-a9c3-43e9-9c37-891fe6435d2c', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('4a25225f-69c7-4b9f-94aa-c3c6f3356d92', 'a267ab03-6ce2-4d3f-b4bd-b3be31c90230', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'e55b2b91-ae2c-4359-be3b-8c941a40c0b7', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', '56a6a6bc-84de-495d-a0cd-5095492a931d', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'c1cc7f54-b350-4472-bca5-9ec43eac2960', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', '8f784b32-df5b-43ba-94fd-98ad29617898', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'e8a64300-db3a-486b-bd04-e477b112b106', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'bbfa9dbd-3d1d-459e-8ce6-439c041db821', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'd83db73b-af35-4430-8056-99ba6b4cd46c', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'd2c3ac31-7c5c-4a73-9e47-af5b5262277e', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'ce3f33fe-3acf-4e44-94b3-ea95da957b75', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'c96557b9-f1c3-441d-af22-cfd50bd1d212', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', '90d1a675-bb01-490c-a753-75141281466c', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', '6a94be6b-586d-43ad-9ece-1273c1fff217', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'ab462553-2ce5-405c-8f23-6f65eefbd70e', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', '5cb0d88a-9955-46c9-9a74-8cced763c69a', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', '137c6923-8e06-4413-8286-5a8d7650b884', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'db468f8e-683c-47a4-918b-533db27a24bd', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('277436db-eebf-4421-9b71-8e1425aeba31', 'cc91e871-f734-46a1-82a0-c1ad097e5276', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('dae661be-8751-4226-91d0-69a5624aa76b', '86bbb807-c3cd-4b8d-b204-b045ca6e0853', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('dae661be-8751-4226-91d0-69a5624aa76b', '8b8d9195-612f-4a4d-8a03-ef9eba7362c8', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('748c6a1a-5a9d-46fb-a732-3b6318fad9c9', '8ae3b6d8-85c9-4c67-84dd-4ea326856d5c', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('748c6a1a-5a9d-46fb-a732-3b6318fad9c9', '286f4189-ec49-4d4b-9423-30e7a2cd2d58', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('748c6a1a-5a9d-46fb-a732-3b6318fad9c9', '84527ad5-36d2-4351-b083-812b8e4e2be6', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('748c6a1a-5a9d-46fb-a732-3b6318fad9c9', '84aa60c8-d27c-43ef-8edf-c9064d2af8f8', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('748c6a1a-5a9d-46fb-a732-3b6318fad9c9', '8194f0d9-7741-4444-a0f4-a08920376332', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('748c6a1a-5a9d-46fb-a732-3b6318fad9c9', '4cf39391-3aa4-44e2-b6e8-47569fd609d4', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('6357010e-8192-4b93-b354-51d5f00e798d', 'cf630c37-1b04-4052-89a4-94640a15b1f4', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('6357010e-8192-4b93-b354-51d5f00e798d', 'fc4b2f57-0231-4285-b980-530002dabc73', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('6357010e-8192-4b93-b354-51d5f00e798d', 'fd9bfc58-e77c-401f-9a4d-73e46453573e', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('6357010e-8192-4b93-b354-51d5f00e798d', '05ccfd39-f4da-4727-81f3-d684aaa87ad1', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '1c776faa-7867-43c8-8b26-4aa6ccc569c5', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'afff6b73-a26d-473b-a2da-80b221bcdc3c', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '7723c4b6-7ece-4bb2-a02c-eb1ed4ab2919', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '227a6cc3-e067-4b7b-a266-0c7c0d1fddd9', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '31c97d05-e52b-4758-a377-1440395575d6', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '4bc2f2f8-e974-4798-9690-4f7700e6d84e', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '022a9f64-3bcf-45ed-a029-6468b7e90365', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'b41d9155-5e83-4757-a70c-bd3d0c6c0ca4', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '0299388e-98ba-4a86-8829-b1e40ca4f2c7', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', '3885c243-52c2-45da-8985-df3eecb8ff91', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('f05c84a2-8aa9-43de-b622-9c68a2442cf4', '7d81e90d-e278-4592-b1b9-bcfeb9f2b6b6', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('f05c84a2-8aa9-43de-b622-9c68a2442cf4', '92dfad36-c006-47ef-8145-47e8962fd6a6', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('f05c84a2-8aa9-43de-b622-9c68a2442cf4', 'c67df4f0-4c4c-4f2a-85ca-edd801d0f777', 'indica', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('353d517f-8807-467b-bd28-719de8ce065b', '93935598-9ad9-487c-bf27-501ba07df2d9', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('353d517f-8807-467b-bd28-719de8ce065b', 'f1fb434e-b154-4e0c-b0f3-85e3e46bfd39', 'sativa', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('59b10e8c-06dd-49fe-a6e9-c37ae7031524', 'e6cb99d3-22ee-4176-9098-84b0f44958f4', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('59b10e8c-06dd-49fe-a6e9-c37ae7031524', '37edf99d-f619-42c5-83df-63342cdeb344', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('59b10e8c-06dd-49fe-a6e9-c37ae7031524', '690741f9-8d55-4e47-93a4-9497242c4783', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('f07d61b1-bc61-444d-932f-dddf2f2af72a', 'd34a4577-29da-4b74-bc4c-e185c232195b', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '9c36b30b-5d14-45e2-be61-eb20c7542603', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '98eabbc1-1c51-4fc5-a360-c658128d6fbc', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '964c2abb-3f00-474e-af46-fa2461335245', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '1f647411-cddc-4d42-b075-ae2ee07aae17', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '64a2c207-afda-41d6-8e61-b1b5500cc0b8', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '67cc1f6e-94da-4cd1-a056-85af22c78826', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '4ff09e9a-6280-4397-a34f-36b8839845c4', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '9f37391a-adbf-49b3-81f6-9eb9830008e7', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', '1229fc31-d602-460d-b547-26f9ce701af9', 'hybrid', NULL, NULL);
INSERT INTO public.flower (business_id, product_id, strain_type, thc_level, cbd_level) VALUES ('1160c17a-f575-48ae-b4f0-ee304abe6db4', 'adae8e23-8cd3-4c79-b60e-d3a8e7982a24', 'hybrid', NULL, NULL);


--
-- Data for Name: inquiry; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: product; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('District Edible Gummies', 'Small batch, from Scratch.  Made with OrganaLabs premium activated CO2 cannabis oil in 10mg and 25mg dosing with only 1gram of sugar per gummie.  All come in individual blister packs to maintain freshness and ease.  Available in 3 unique flavors per dominance of Indica, Sativa and Hybrid.

Indica: Blue Raspberry, Lemon-lime, Orange
Sativa: Cherry Cola, Strawberry, Tropical Punch
Hybrid: Peach, Sour Apple, Watermelon', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/X18Brp4pR2CuXKaOU1l4_District_gummies.jpg', '53256df8-6e3d-45da-99e1-19261a552d24', '918ae191-50f8-4ed2-8d44-7758190d1b63', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Wing Attack Plan R', 'As with most ogkb phenotypes flavor notes show doughy cookies, citrus haze, lime and mixed tropical fruit. To many, it offers an ideal blend of cookies and haze, reminiscent of older pre-dutch haze flavor profiles. Hard EXTREMELY dense buds combine with exotic fruity flavors to create a truly breath taking stone. A rare gem, this specific phenotype expresses everything you could ask for in an indica; dense, sedating flowers with a premium blend of positive sativa characteristics like excellent node spacing.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xuGuIUe7SxKIq2L2bCFY_wing.2battack.2benhanced.2b.jpg', '9a35bde3-3067-49af-9a84-31b5bb36a261', '15f95efc-418a-4a7e-b89d-320c94bbc31f', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Honey Banana', 'This cannabis strain earns its name with a resinous coat as sticky as honey and an unmistakable banana aroma. Boasting intensely sweet aromas on the inhale and a sugary smoke on exhale. She leans heavily toward the sativa side of the family, providing weighty full-body effects coupled with an invigorating buzz of cerebral euphoria.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SodZDMfMRKWw59F9xhnw_honey.2benhanced.jpg', '371b6067-2f80-4673-b88d-3c33ae19df45', '15f95efc-418a-4a7e-b89d-320c94bbc31f', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cherry Pie', 'This sweet Cherry Pie expresses a terpene profile thats both earthy and pungent while still being extremely sweet and berry-forward. With buds that are dense and full of orange hairs with a touch of purple, this strain smells of sweet and sour cherry pie. The longer its allowed to mature the deeper the purple expression. A strain that is both true to its name and powerful this variety will surely be a favorite among both hardened and light smokers.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nIEOtCYUQpO5Y8ZB7D8i_cleaned.2bcherry.2bleafly.JPG', '19c52295-5820-4947-927d-5d44dc3470db', '15f95efc-418a-4a7e-b89d-320c94bbc31f', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('*FLOWER', 'Enjoy the superior flavor and freshness of 100% organic flower, grown and harvested to the highest standards of alchemy.

-Meticulously farmed, sun-kissed artisanal cannabis
-Hand picked, hand trimmed and hand packed
-Glass cured for long-lasting freshness
-High potency cannabinoids', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SZscO8jzTB2xANmB4IKE_BlackJack_HighRes01.jpg', '1754ad2d-95b5-4d0f-9bb8-b0a830db16be', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Diesel Cartidge (.5g)', 'Delivers creative and energizing effects coupled with total euphoria

THC: 70%+', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YAraIuoSkqxkOPGKC2bE_File_001.jpeg', '2b1a7875-079f-49b5-8400-17b84d413d23', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Raspberry Cartridge (.5g)', 'Reduces Anxiety and Promotes Focus
An uplifting effect that settles the mind while increasing energy and alertness.
Great for daytime use.

THC: 70%+', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/sF07lFdS2Op3UEBykKil_CARTRIDGES_SOURRASPBERRY.jpg', '1db4f75f-9e7d-494c-a3c9-250f92c5f963', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tangie Cartridge (.5g)', 'Perfect mingling of euphoria and elation. Delivers mental clarity and creativity.

THC: 18.56%  CBD: .16%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Tnzvx4TOTVuil8ywKazq_Lola_cartridges_04.jpg', '78ea62c8-e7c0-46e4-b71a-50583df47091', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sunset Sherbert Cartridge (.5g)', 'Sweet tasting- known for its powerful body effects followed by cerebral jolts of energy

THC: 70%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/tJYGRHl4TUOy4kzczt6T_CARTRIDGES_SUNSETSHERBERT.jpg', 'c035618e-38eb-417e-991e-2de64303bfa2', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer Cartridge (.5g)', 'Delivers invigorating cerebral experiences,
induces creativity, and energizes the body.
THC: 70%+', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/w0vAX89RlStUanlHLaPw_Lola_02.jpg', 'f51086f5-da9a-4aa7-b513-3d0e58f84082', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lemon OG Cartridge (.5g)', 'Elevates mood and relieves stress.
Fast-acting and euphoric relaxant that stimulates hunger and promotes good sleep
THC: 25.26% CBD: .02%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/elrNRcuGTwqWPfFXvCSf_Lola_cartridges_01.jpg', '0fa3818b-ebc1-49cf-9f12-e3dbb3705a26', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OIL CARTRIDGES', 'Enjoy the delicious, smooth and clean quality of 100% organic and strain-specific cannabis oil.

•	Extracted from Grade A, organic cannabis
•	High potency cannabinoids
•	First generation, single-origin terpenes
•	No solvents or harmful additives
•	Batch tested for potency and residual solvents
•       THC: 70%+
Lola Lola ™ | Alchemy Reimagined', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kKZMBjR8RyEZ1CavTUfN_Lola_62.jpg', '55b40393-8788-41b1-9300-ad11dff1e368', '3e6d08f3-aba2-43e9-8839-301a94c5c9e8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Hybrid 4 Piece Watermelon Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vGRTaZnLSA2zBzsYHNvC_IMG_8973.jpg', 'db516171-23ef-4b02-8e2c-6e91f71a3926', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 15MG Single Assorted Gummies', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XkyER8WR4OT5WKuWSP34_IMG_3171-2.jpg', '48f47640-a071-414a-98ed-a550c11a5c98', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 300MG Hybrid 4 Piece Mango Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/I9ljOimxQouZ7JarUvXB_IMG_9040.jpg', '8e6e72b0-e4d0-43ef-9ac9-526f7620890c', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 300MG Hybrid 4 Piece Pineapple Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gVzaK90QQlCAAwB6DBQc_IMG_9042.jpg', '75f23c47-d260-4e31-9819-2019f3502ca6', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 300MG Sativa 4 Piece Watermelon Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2WpV9UOFQMKDmyyB6pjO_IMG_9038.jpg', 'ae9b9b88-3d90-4a66-be66-c32d15984110', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group CBD (7:1) 40 MG Mixed Berry Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CO9X7AQQRSiPjqaGI89W_Flurish.2bGroup.2bCBD.jpg', 'c904d8fc-e78d-4f9e-821b-19d0f7b6ac25', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Hybrid 4 Piece Mango Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SVQhRGNrRoyZikA2Gi8J_IMG_8967.jpg', '2ea3a6c4-0cd5-4514-9a13-361c9be54546', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Hybrid 4 Piece Pineapple Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cqms5W3XRvi7uONwvnE7_IMG_8966.jpg', 'fa7f8926-0f6e-4057-8a2b-e57f0c0cc45b', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Hybrid 4 Piece Sour Apple Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CDXN981REWqbiMCxarCC_IMG_8969.jpg', '2d57bf4f-af15-4ede-9b7b-d161dea87682', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Sativa 4 Piece Mango Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xXIRBBpETByKsHqIG8dm_IMG_9036.jpg', 'f348bd8d-6048-4f1c-8677-bdc6bb90ad89', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Sativa 4 Piece Pineapple Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8ZSS67pITaGCXY2MIb8E_IMG_8978.jpg', '553099e9-a9b5-468b-ad17-b6602430a484', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Sativa 4 Piece Sour Apple Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4jXg20VRRSqCr7vcHsfK_IMG_8976.jpg', 'f5b9010a-6504-4959-8ec7-582347e67688', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Flurish Group 150MG Sativa 4 Piece Watermelon Box', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IUrEPP08QcenjzTvAhLw_IMG_8974.jpg', 'b81ea2ba-a40d-437a-9ee9-77bd80457fd9', 'f14d95df-5695-49fc-ac32-f64b7b766da1', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strain Specific Cartridges', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5yq6OddcSgmj7ejQal1a_PureCure_Vape.2bCart_3.jpg', '199f17c6-35c3-4842-ad2c-1bbf644c2846', 'dcc0e87b-c2f5-42c5-8227-192dc466c048', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1 Gram PureCure Applicator', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6MPCi8TcTiKsnCd6XMaz_purecure.png', 'c71ae1e3-ed48-4dcf-9a7f-dc5836c9a397', 'dcc0e87b-c2f5-42c5-8227-192dc466c048', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Toffee', 'We craft crave-inducing toffee based on an award winning recipe hand dipped in our signature Belgian chocolate.  6 pieces per pack.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/toffee_greenbag%2B%281%29.png', 'fdab2d71-3e45-40c0-9ae4-22f4a1685da6', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880', 'edible', 'chocolate');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Bites - Cherry', 'We make delicious chocolate covered fruit bites, created with all natural, organic, no sugar added fruit hand dipped in our signature Belgian chocolate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cherry_fb_greenbag.png', '9fa60cc0-c984-4262-a4e3-0c421f486c3b', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880', 'edible', 'chocolate');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Bites - Strawberry', 'We make delicious chocolate covered fruit bites, created with all natural, organic, no sugar added fruit hand dipped in our signature Belgian chocolate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/strawberry_fb_greenbag.png', 'a3438500-92ed-4f63-b83a-259f1f308a35', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880', 'edible', 'chocolate');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Bites - Blood Orange', 'We make delicious chocolate covered fruit bites, created with all natural, organic, no sugar added fruit hand dipped in our signature Belgian chocolate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/bloodorange_fb_greenbag.png', '6a8184cb-799d-453b-95a4-12fb9bbd4818', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880', 'edible', 'chocolate');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Whole Fruit - Apricots', 'We create simple, chocolate-covered Apricots with dried, imported Turkish Apricots hand dipped in our signature Belgian chocolate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/apricot_greenbag%2B%281%29.png', 'eb647ff7-cf52-46cf-95fd-d5814cd616ee', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880', 'edible', 'chocolate');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Peace and Relief Cream - Full Plant Extract', 'We are committed to giving you peace + relief from from pain and irritation with a topical cream made from the highest grade THC/CBD full plant extract.

- fast, consistent, effective relief from pain, muscle soreness, inflammation & skin irritation with no psychoactive "high"
- lab tested
- rapid absorption for quick reapplication
- delicious scent
- smooth, creamy texture  that evenly delivers medicine to your cannabinoid receptors', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/peace%2Band%2Brelief%2Bcream%2B%281%29.png', 'db80f713-d4c7-4003-885e-3786f6250df4', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880', 'topical', 'balm');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('STUDIO: Ghost OG, Hybrid', 'Tune into shimmering downtempo bliss with this celebrated indica-leaning OG hybrid. Sweet notes of citrus and pine induce deep relaxation and upward release from stress and worry. Produced with care and respect, these crystal-covered herbs are a modern blessing for the mind, body, and spirit.

LINEAGE:
OG KUSH

TASTE:
CITRUS, EARTHY, AND SWEET

EFFECTS:
DEEP RELAXATION', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/GAaaI41hQBSnv5TloSd8_web1.jpg', '8836c5db-5867-4be5-942f-b829fc666547', 'db1f29ec-93dc-4b9a-bb95-439d673ea62e', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('STUDIO: Platinum Cookies, Hybrid', 'Platinum Cookies provides a lively and sweet euphoric lift that quickly builds up layers of long-lasting positive energy. This truly powerful, mindfully grown sativa-leaning hybrid delivers the friendliest of fire, raising inner comfort and consciousness. Its a treat for the senses, lush with flavors of spice and fruit.

LINEAGE:
A CROSS OF OG KUSH AND DURBAN POISON

TASTE:
FRUITS AND SPICES

EFFECTS:
PHYSICAL RELIEF AND MOOD-LIFTING', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WRF2QyF4TrafQyYwUEyH_MN_Studio_08.jpg', '3eb83a8d-b8d3-4882-ac31-89fe2d793933', 'db1f29ec-93dc-4b9a-bb95-439d673ea62e', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Synergy Watermelon Gummies', 'The best of both worlds come together in perfect harmony with vibrant watermelon flavor to help ease what ails you. Each delicious gummy contains 5MG of THC and 5MG of CBD for an entourage effect that leaves you with a very balanced and manageable high while also providing great pain relief. So bite into a watermelon gummy like it‘s summer time at the pool and enjoy the THC:CBD Synergy.

-Our gummies are handmade and fully infused
-Let the Gummie fully dissolve in your mouth for quicker up-take
-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver—transforming from a Î”-9 is to a more potent 11-hydroxy -Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SMHbAoURpy33pUJbAluZ_Synergy-Watermelon--e1492103749997.jpeg', '54f11c7f-f556-42fe-a8e2-5687e0058cf2', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tropic Twist Gummies', 'Sit back, relax and let our fruity delicious Indica dominant Tropic Twist gummies ease your mind and take you Caribbean dreaming. Easy to share with your friends at the beach or while stranded by yourself on a desert island.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/y0t6CMH8R4aPACmx96cZ_Tropic-Twist-e1492112899203.jpg', '5e24512f-e014-498c-8d94-d97acd0af217', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Orange Awakening Mints - 5MG', 'When you‘ve got places to go and things to do, Orange Awakening Mints provide a great, low, consistent dosage and fit discreetly into your pocket. They‘re formulated with Siberian ginseng, ginkgo, matcha and orange oil to help enhance your alertness and increase your stamina.

- Discreet edible perfect for delivering a low, consistent dose
- Sold in child-resistant blister packs
- 16, 5 mg THC mints per package
- Allowing Dixie Mints to completely dissolve under your tongue will result in fastest activation
- Dixie Mints are triple lab tested for consistency and quality', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/i5dFQWkYSeWIXH0C4gct_AmakeningMints-80mg-HighRes.jpeg', '4c3c92c4-a7f6-4163-8e21-a1e84cb78fd4', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Peppermint Relaxing Mints - 5MG', 'Dixie‘s Peppermint Relaxing Mints deliver 5mg of CO2 Extracted THC that will ease you into a peaceful state of zen. Each mint contains ingredients such as peppermint oil, ashwagandha, lemon balm and passion flower that support a soothing and relaxing effect.

- Dissolves smoothly for quick absorption
- New formula ensures reliable experience
- 16, 5 mg THC mints per package
- Triple lab tested for quality and consistency
- Sold in child resistant blister pack', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HtZ3dAMZSWGgj7GhWuOZ_RelaxingMints-80mg-HighRes.jpeg', 'e102d3a2-1789-4846-b17a-f26bdf4e2f20', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lemon Fruit Tarts', 'Pucker up for a refreshing burst of sweet and tart with Dixie Lemon Fruit Tarts. These classically-flavored lemon tarts are the perfect size (and dosage) for whatever strikes your mood.

-Our fruit tarts are handmade and fully infused

-Let the tart fully dissolve in your mouth for quicker up-take

-Dixie Edibles are triple lab tested for consistency and quality

-When you consume a Dixie edible, the THC is processed in your liver—transforming from a Î”-9 is to a more potent 11-hydroxy

-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2WNRNJjWQe24aOmnAQaQ_Dixie-Tarts_Lemon.jpg', '91700a02-2d08-47d4-a000-02f1b1e661d2', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer Sativa Cartridge', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vqeQvMqCQbSbUM1eleaB_TDC-JKH.2bSAT.jpg', '8309d6d0-861c-4591-9a72-a053f44cc59b', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Grape Fruit Tarts', 'Embrace the power of purple with Dixie‘s Grape Fruit Tarts. These tiny tarts allow for controlled and effective medication practically anywhere.

-Our fruit tarts are handmade and fully infused

-Let the tart fully dissolve in your mouth for quicker up-take

-Dixie Edibles are triple lab tested for consistency and quality

-When you consume a Dixie edible, the THC is processed in your liver—transforming from a Î”-9 is to a more potent 11-hydroxy

-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/3Gkl6nzSKa2i54Lc8OcA_Dixie-Tarts_Grape.jpg', '9b8b7f19-9029-47cc-848e-b8957f1239b5', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cherry Fruit Tarts', 'Small size, big cherry flavor. Mixing slightly sweet with a little tart, Dixie Cherry Fruit Tarts offer a complete and effective high with the bonus of discrete convenience.

-Our fruit tarts are handmade and fully infused

-Let the tart fully dissolve in your mouth for quicker up-take

-Dixie Edibles are triple lab tested for consistency and quality

-When you consume a Dixie edible, the THC is processed in your liver—transforming from a Î”-9 is to a more potent 11-hydroxy

-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cK5CIeyRSxkoIHIJP6Kw_Dixie-Tarts_Cherry.jpg', 'ee2756de-c922-4a14-ab39-5a9707aaab77', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Citrus Blast Gummies', 'Blasting with juicy citrus flavors, our Sativa dominant gummy will have you feeling great in no time! Easy to share with your friends, enjoy before a concert, barbecue or anytime you need an extra kick!

-Our gummies are handmade and fully infused
-Let the Gummie fully dissolve in your mouth for quicker up-take
-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver—transforming from a Î”-9 is to a more potent 11-hydroxy -Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ujll8ehTdmGM1xWaM73Q_Citrus-Blast-e1492113042266.jpeg', '632e1d53-a113-409d-a869-bc3d9eb7a2c1', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blazin‘ Cinnamon Gummies', 'The best complement to your blazing is our Blazin‘ Cinnamon gummies. With an even blend of Indica and Sativa strains, these hybrid gummies put your mouth on alert but leave your mind at ease. So gather up your best friends and Blaze on!

-Our gummies are handmade and fully infused
-Let the Gummie fully dissolve in your mouth for quicker up-take
-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver—transforming from a Î”-9 is to a more potent 11-hydroxy -Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9RhtYPaCTgqAmw6jjJUU_Capture.JPG', 'c2b08000-2dcc-4e0e-a4bf-3f1e77fe2bab', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Synergy Mixed Berry Mints', 'The next big thing is bursting with a bold new ï¬‚avor. Our Synergy Mints are the best of both worlds thanks to equal parts CBD and THC. These easy-to-dose mints produce a well-rounded eï¬€ect that‘s greater than the sum of the individual cannabinoids.

- Discreet edible perfect for delivering a low, consistent dose
- Sold in child-resistant blister packs
- 16, 5 MG THC/ 5 MG CBD mints per package
- Allowing Dixie Mints to completely dissolve under your tongue will result in fastest activation
- Dixie Mints are triple lab tested for consistency and quality', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/MmouYMzSfGFoJNK14sa4_Dixie-SynergyMints-Box-Mockup-1200.jpeg', 'b07e4112-e5c1-44c2-a355-5e8acdf8627f', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('500 MG Orange Milk Chocolate', 'Smooth, sweet milk chocolate pairs perfectly with natural orange flavor to give patients a tasty twist on medicine delivery. Hand crafted using only the highest quality Belgium milk chocolate, all-natural flavorings and pure extracted THC we take great care to ensure that patients can feel good about feeling good.

-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy
-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too
-INGREDIENTS: Milk Chocolate (Sugar, Milk, Cocoa Butter, Cocoa Mass, Emulsifier {Soy Lecithin}, Natural Vanilla Flavor), THC Oil, Natural Flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ZvYNl2l8RNyQt1Bv2sRw_Capture.JPG', '6e3ba76c-13c5-42cd-b89d-2105b8208e81', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('500 MG Peppermint Dark Chocolate', 'Rich chocolate with a peppermint twist, this bar offers you the medicine you need crafted into a delicious, decadent treat. We use the highest quality 70% dark chocolate, natural peppermint oil and cannabis that is pesticide-free to ensure that patients can feel good about feeling good.

-Chocolate with 70% or more cacao has been shown to lower blood glucose levels, cholesterol and blood pressure
-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy
-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too
-INGREDIENTS: Dark Bittersweet Chocolate (Chocolate Liquor, Sugar, Cocoa Butter, Emulsifier {Soy Lecithin}, Vanilla Extract), THC Oil, Natural Flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6XXnkmxR5mXKMl2GkpEo_ff.JPG', '121c5115-85ce-417d-b7a7-27c66eef282d', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Birthday Cake White Chocolate Bar', 'Who thought classic vanilla cake with rainbow sprinkles could get any better? Throw in the delightful effects of a little THC and we have really upped the ante on a nostalgic classic.  Rainbow sprinkles, frosting flavors and creamy white chocolate come together with the perfect amount of THC. This bar is worth waiting a year for…or at least until you can get to your nearest dispensary.

*Also available in 200 MG per bar and 16 MG per serving in select markets*

-Dixie Edibles are triple lab tested for consistency and quality

-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy

-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too

INGREDIENTS: White Chocolate (Sugar, Cocoa Butter, Powdered Milk, Soy Lecithin [Emulsifier], Vanilla Extract), Non Pareils (Sugar, Dextrin, Starch, Titanium Dioxide, Confectioner‘s Glaze, Carnauba Wax, FD&C Red #40, FD&C Red #3, FD', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cyIU43hOQpSZEbzvkVNA_dd.JPG', '45829af5-e0f6-483f-9c21-2a81acf2d8cd', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kushy Punch Indica (100mg THC) Plum Gummy', 'The attractive, enigmatic plum makes his appearance rather gallantly, offering you a taste as deep as its flesh is ripe. The midsummer‘s harvest delivers you a unique flavor, commonly overlooked, yet rarely forgotten. As you melt into your couch, you‘re reminded of the calming, relaxing, and pain reliving effects of Indica. Reward yourself with a slice of healing, courtesy of Plum.
Some of the main effects of INDICA include: Increased Appetite, Deep Relaxation, Sleep Aid, Body Resting, Pain, Nausea, Stress, and Anxiety Relief', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9cf3QeZ2TEqdZigNMZCM_KP-24.2b3.jpg', 'ef179adf-06ee-4169-a768-9861a7deb67c', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Straight Up Dark Chocolate Bar', 'Bold, rich and decadent our Straight Up Dark Chocolate gets right to the point — world class 70% cacao chocolate and pure, clean extracted THC. Enjoy all the health benefits of 70% dark chocolate paired with the benefits of whole-plant cannabis.  Treat yourself and taste-buds to a truly luscious chocolate experience.

-Chocolate with 70% or more cacao has been shown to lower blood glucose levels, cholesterol and blood pressure
-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy
-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too

INGREDIENTS: Milk Chocolate (Sugar, Milk, Cocoa Butter, Cocoa Mass, Emulsifier {Soy Lecithin}, Natural Vanilla Flavor), THC Oil, Natural Flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/E1XvfobqRrSJB13i4DIp_Capture.JPG', '6397012e-deae-4e75-9cc2-198a04464ce4', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Straight Up Milk Chocolate Bar', 'Straight up smooth, sweet and delicious milk chocolate made even more delightful with the purest, sweet extracted THC. A truly melty experience for both your mouth and your mood. Sit back, relax and melt away.

-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy
-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too

INGREDIENTS: Milk Chocolate (Sugar, Milk, Cocoa Butter, Cocoa Mass, Emulsifier {Soy Lecithin}, Natural Vanilla Flavor), THC Oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/7R0MgJmR3eemtSppwzmb_dd.JPG', 'cad88dc3-62e0-47a9-bc4b-5b43869ad079', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('SYNERGY Milk Chocolate 1:1', 'Our premium, sustainability-sourced milk chocolate is now available perfectly balanced with equal parts CBD and THC. The anti-anxiety and anti-inflammation benefits of CBD combined with THC‘s natural stress relieving properties make for a more effective experience than THC alone.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YgECgyRITHW17iZ2ab31_Synergy-bar-compjgg.jpg', '1d4ce953-b650-4eab-8c4f-2e4f43638234', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('500 MG Orange Milk Chocolate', 'Smooth, sweet milk chocolate pairs perfectly with natural orange flavor to give patients a tasty twist on medicine delivery. Hand crafted using only the highest quality Belgium milk chocolate, all-natural flavorings and pure extracted THC we take great care to ensure that patients can feel good about feeling good.

-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy
-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too
-INGREDIENTS: Milk Chocolate (Sugar, Milk, Cocoa Butter, Cocoa Mass, Emulsifier {Soy Lecithin}, Natural Vanilla Flavor), THC Oil, Natural Flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ZvYNl2l8RNyQt1Bv2sRw_Capture.JPG', 'ebbc0414-d14d-4f06-9fd5-6476e22130c0', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('500 MG Peppermint Dark Chocolate', 'Rich chocolate with a peppermint twist, this bar offers you the medicine you need crafted into a delicious, decadent treat. We use the highest quality 70% dark chocolate, natural peppermint oil and cannabis that is pesticide-free to ensure that patients can feel good about feeling good.

-Chocolate with 70% or more cacao has been shown to lower blood glucose levels, cholesterol and blood pressure
-Dixie Edibles are triple lab tested for consistency and quality
-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy
-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too
-INGREDIENTS: Dark Bittersweet Chocolate (Chocolate Liquor, Sugar, Cocoa Butter, Emulsifier {Soy Lecithin}, Vanilla Extract), THC Oil, Natural Flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6XXnkmxR5mXKMl2GkpEo_ff.JPG', '1a8674bb-85d1-4bb5-b015-05c0322c7088', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Birthday Cake White Chocolate Bar', 'Who thought classic vanilla cake with rainbow sprinkles could get any better? Throw in the delightful effects of a little THC and we have really upped the ante on a nostalgic classic.  Rainbow sprinkles, frosting flavors and creamy white chocolate come together with the perfect amount of THC. This bar is worth waiting a year for…or at least until you can get to your nearest dispensary.

*Also available in 200 MG per bar and 16 MG per serving in select markets*

-Dixie Edibles are triple lab tested for consistency and quality

-When you consume a Dixie edible, the THC is processed in your liver“”transforming from a Î”-9 is to a more potent 11-hydroxy

-Edibles can take longer to take effect than other methods of THC uptake, but the effects often last much longer too

INGREDIENTS: White Chocolate (Sugar, Cocoa Butter, Powdered Milk, Soy Lecithin [Emulsifier], Vanilla Extract), Non Pareils (Sugar, Dextrin, Starch, Titanium Dioxide, Confectioner‘s Glaze, Carnauba Wax, FD&C Red #40, FD&C Red #3, FD', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cyIU43hOQpSZEbzvkVNA_dd.JPG', 'b28bf7de-95cb-47bc-b4bf-51588d4ed66f', 'e4b04da6-0e63-4a40-af19-7adffdb7ec32', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kushy Punch Sativa (100mg THC) Strawberry Gummy', 'You awaken gently from your slumber on an early Saturday morning. You‘re instantly washed over by the brightness from the weekend sun, permeating through your curtains; it‘s time for Sativa. Like a warm sunny day, you‘ll feel energized, re-invigorated, and ready to take on the day. With our award winning foundation of cannabis, natural terpenes, and essential oils, you‘ll soon understand why Sativa is our best-selling flavor! The distinctive first-impression of Strawberry, provides a succulent, juiciness, reminiscent of biting into a freshly picked fruit.

Some of the main effects of SATIVA include: Stimulates Energy, Uplifting Cerebral Effect, Promotes Creativity and Focus, Fights Depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/jlqTRmlPRACGjYfxXQJg_KP-23.2b3.jpg', 'e3532f7b-d54e-4f33-a418-32422295cd70', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kushy Punch CBD (60mg CBD) Peach Gummy', 'The power of our 99.9% Pure CBD Isolate teams up with the crisp taste of Peaches. Light yet distinctive in flavor, these gummies are bursting with full-bodied fruit essence. Providing unequivocal pain relief, without the euphoric effects of THC, CBD is the next wave of alternative medicines. Throw your PILLS AWAY!

Some of the main effects of CBD include: Anti-Inflammatory, Anti-Pain, Anti-Anxiety, Anti-Psychotic, Anti-Spasm Relief', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AsJSQUvNQWuN2twXfwzT_KP-26.2b4.jpg', 'c7852358-8b83-4f86-a230-a1f1e2c36708', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kushy Punch Hybrid (100mg THC) Tropical Punch Gummy', 'At first bite, the deliciously, juicy Tropical flavor provides you with a punch of euphoria. Sit back, kick your feet up and let the deep relaxation settle in. You‘ll feel the pain radiate away as positive vibes rush in. The tropical aromatic terpenes and essential oils, collaborate with THC as they massage your neural pathways and induce a comfortable mind/body balance.

Some of the main effects of HYBRID include: Combines the effect of Indica and Sativa strains, Body Resting, Deep Relaxation, Uplifting Cerebral Effect, Fights Depression, Promotes Mind/Body Balance', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fyrMtnnkTAKORRn1mmYi_KP-13.2b2.jpg', '8a99861e-140c-4090-b35a-d9fc54305019', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kushy Punch Recover (60mg THC/ 30mg CBD) Black and Blue Raspberry Gummy', 'Let all your burdens melt away. Whether you‘ve had a long day at work or you were grinding hard in the Gym, the Blue and Black Raspberry flavor will guide you towards happiness and relief. The combination of THC+CBD, offers you the best of both worlds. In unison, these two cannabinoids collaborate to give you clarity and focus, along with reducing social anxiety. With a taste that can‘t be beat, why compromise with any other meds?

Some of the main effects of RECOVER include: CBD+THC blended together for a collective healing effect, Aid in Clarity and Focus, Improves mood, Reduces Social Anxiety', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/7rN89r41TLOFy1f4W3UR_KP-19.2b1.2b1.jpg', '33265b21-20b0-4d7a-87bc-0299efbc7e6d', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kushy Punch TKO (200mg THC) Lime Gummy', 'A citrus explosion of biblical proportions; vibrant Lime infiltrates your tastebuds to escort you towards MAXIUM HEALING POTENTIAL! Including the terpene Limonene, you‘ll jumpstart your immune system, decrease depression and anxiety, and improve your overall mood! With an 1/8ths worth of Cannabis packed into gummies, you can finally deal a Technical Knockout to PAIN!

Some of the main effects of TKO include: High Dosage THC, Best for High-Tolerance users, Severe Pain Relief', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1X9YHvpiRTm8Hm4LtDGS_KP-20.2b2.jpg', '2d79f494-858b-4222-ab13-7cd5cecae200', 'c0108aee-6b05-4caa-be4e-96ac9eb65b1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1/2 Gram Cartridge - LIV Clear Blue Cookies', 'LIV cartridges are made with the latest technology to provide the optimal vaping experience. Featuring a wickless, ceramic design, with a crystal clear shatterproof tank.

- Wickless Cartridge
- Hi-flow Mouthpiece
- Ceramic Coil
- Shatterproof Tank
- Rechargeable Battery [Not included]
- Leakproof Device', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/0TpoSfS0SgqP5Rbjswry_image_uploaded_from_ios-21.jpg', 'b4e83c4b-e8fb-4b82-a28e-4820871b6576', 'f7568095-cd17-425d-a8c2-2389149cd2a9', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1/2 Gram Cartridge - LIV Clear Khalifa Kush', 'LIV cartridges are made with the latest technology to provide the optimal vaping experience. Featuring a wickless, ceramic design, with a crystal clear shatterproof tank.

- Wickless Cartridge
- Hi-flow Mouthpiece
- Ceramic Coil
- Shatterproof Tank
- Rechargeable Battery [Not included]
- Leakproof Device', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/A5FFdpYqRdeSxteJFOiS_image_uploaded_from_ios-20.jpg', 'c2265772-4f4a-4f51-96e7-1c70b5729e6b', 'f7568095-cd17-425d-a8c2-2389149cd2a9', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1/2 Gram Cartridge - LIV Clear Sour Jack', 'LIV cartridges are made with the latest technology to provide the optimal vaping experience. Featuring a wickless, ceramic design, with a crystal clear shatterproof tank.

- Wickless Cartridge
- Hi-flow Mouthpiece
- Ceramic Coil
- Shatterproof Tank
- Rechargeable Battery [Not included]
- Leakproof Device', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/av4xZS5SsGw4oNUDEupY_image_uploaded_from_ios-24.jpg', '45e12b50-5dcf-42e7-bb5c-33386938642e', 'f7568095-cd17-425d-a8c2-2389149cd2a9', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Legion Grown Flowers', 'Full in flavor and rich in potency, our carefully selected phenotypes are chosen from only the best genetics to grow our world class offerings. Our unparalleled grading process ensures a commitment that only the best flowers make it to our patients.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wXAyvjnT8mjgnHwWccC5_Screen.2bShot.2b2017-08-24.2bat.2b1.47.20.2bPM.png', 'bd74eaa4-90d8-443d-8d2c-26ce7d036c3c', '19b5defc-296b-49fe-9edc-3e21e8b7e246', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lord Jones All-Natural Old Fashioned Gum Drops', 'Our Lord Jones All Natural Old Fashioned Gum Drops are handcrafted and microdosed to melt in your mind using five simple ingredients: Imported European fruit essences, sugar, gelatin, citric acid and the finest California-grown pure cannabis extract. Our natural flavors include: Wild Strawberry, Mango, Blueberry, Lemon, Blood Orange, Peach, Apricot and Passion Fruit. Our gum drops were recently named Best Low Dose Edible for New Users by High Times Magazine.

Available in 5mg, 10mg or 20mg individual dosage per piece. Each box holds nine gumdrops for a total THC count of 45mg, 90mg or 180mg. Also available in 5:1 CBD:THC. 10mg CBD/2mg THC per piece for a total of 90mg CBD/18mg THC per box.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QAJTIcSQEGTRyjH9BfZc_Lord.2bJones.2bGum.2bDrop.2bBox.2b5.jpeg', '918c6e8d-621c-4db6-95f4-d8b9e0fb10d5', '2f262183-cb2a-4cae-a4ee-dbdf1fbd0193', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lord Jones Dark Chocolate Espresso Chews', 'Lord Jones dark chocolate espresso chews are available in both Sativa and Indica', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1mxZ4bXQg2dGT136idqF_Chews.2b1.jpeg', '1e053228-2a56-4e5d-9db9-3e8f30b3ee13', '2f262183-cb2a-4cae-a4ee-dbdf1fbd0193', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lord Jones Dark Chocolate Sea Salt Caramel', 'Our Lord Jones Dark Chocolate Covered Sea Salt Caramels are handmade in small batches using simple ingredients: sugar, cream, pure vanilla bean and butter. Each caramel is enrobed in single-origin Ecuadorian dark chocolate and is infused with pure, California-grown cannabis extract to deliver the perfect experience, every time.

Available in 5mg, 10mg or 20mg individual dosage per piece. Each box holds four caramels for a total THC count of 20mg, 40mg or 80mg.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AjMBUtTlqJNQCZ5VNABm_lordjones-CHOCOLATEYS.jpeg', 'e810c935-855b-48b8-9350-0674e1c222c3', '2f262183-cb2a-4cae-a4ee-dbdf1fbd0193', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('THC Design XJ-13', 'XJ-13 is our most popular strain, crossbred between Jack Herer and G13 Haze. This Sativa-dominant hybrid balances high levels of THC with low levels of CBD, making it an optimal option for daytime relief. This strain is fresh with uplifting notes of lemon, tangerine, and pine', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dA7FJsUWTni5qCGoIXos_XJ-13.2bTHC.2bDESIGN.jpg', '72b0f594-84a9-4485-b196-cfa93d298e66', '5f1bd2ea-af31-480c-8853-93a881f4d0e2', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('SFV OG - By Merosity "Sun Grown"', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/LfOLlAduSqKr1tXaqpFg_IMG_0703_clipped_rev_3.png', '796c7a44-e295-4c81-bf64-e54bde49f79d', '5f1bd2ea-af31-480c-8853-93a881f4d0e2', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BloomVape', 'The BloomVape is a cannabis oil cartridge made with only cannabis oil and terpenes. The oil is free of solvents, impurities, pigments, lipids, fillers, and waxes. This allows for the strain-specific terpene profiles to shine through and produce the desired effect (and flavor) of each strain. BloomVapes are available in both half and full grams in both Washington and California.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/riVUMBREQ4C6SnMe4BVv_18011390_637087569826179_4387059546674167808_n.jpg', '90e817bf-30ad-41d6-9f89-da9e85c96bf8', 'b706b903-8bee-4a26-b292-687d74467565', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BloomOne', 'The BloomOne is a convenient disposable vaporizer that is designed with an integrated battery. The BloomOne is 300mg and uses the same oil as the BloomVape, meaning that its also available in the same 10 strains. Each BloomOne is good for close to 100 puffs.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kU5mrmZZRiyRYuVMujig_Untitled-1.jpg', '377eaf52-286e-4bb0-8b81-71a842f3bd68', 'b706b903-8bee-4a26-b292-687d74467565', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BloomDrop', 'The BloomDrop is made using the same distillate-based formula as the BloomVape with 70% THC and 12% terpenes. The BloomDrop can be used for a wide variety of applications; including dabbing, adding to joints, directly ingesting, and infusing edibles. The BloomDrop is 800mg and is available only in California.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DaKgciURpadcjLKk0iF2_drop_flowers.jpg', '5c0ff0fd-6e8d-444e-887a-0b502dfd423b', 'b706b903-8bee-4a26-b292-687d74467565', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select CBD Vaporizer Pen - Focus Vape Pen', 'Cutting edge hardware, pure CBD isolate, and Select expertise. Sharpen your wits with help from the Focus blend from Select CBD. Refreshing peppermint extract teams up with CBD for natural clarity.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/32cmcQ25Siyc4kTEkVPA_98095_focus.jpg', '9bf96cd3-d285-463b-ad60-329a8bc4280a', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BloomExtract', 'The BloomExtract is an ethanol-extracted shatter that retains the terpene profile of each individual strain. The BloomExtract is only available in small batches because each strain is chosen based on the quality of the flower available. The BloomExtract ranges from 75-85% and is only available in California.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/B1YZQXunQDqMhB1a0ZNA_weddingcake2.2bcopy.jpeg', 'a17ea33a-5369-4ea9-9064-1c8f99211a91', 'b706b903-8bee-4a26-b292-687d74467565', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Canelé', 'A small Rum and Vanilla flavored pastry with a soft custard center and thick caramelized crust', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vJWUlTvmRTyyZD0OJdsR_caneli.jpg', '812144d7-4b17-4535-82de-ff888305c7d5', 'bde837ec-7ff8-4733-8eea-a65854e4acb3', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Croissant', 'Traditional French Pastry named after its particular shape, the crescent. This flaky, buttery pastry is made of a layered yeast-leavened bread.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6gt3mrPQT2ywY43OBLCv_crois.jpg', '367230f7-a97e-4359-8a37-9e333a440cdf', 'bde837ec-7ff8-4733-8eea-a65854e4acb3', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Financiers', '1)	A small French almond cake, light and moist on the inside with a crisp egg-shell like exterior. The name "œFinancier" is said to come from it"™s shape as it resembles a bar of gold.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/lpgEAx39SpCCNhI2vPJ2_fin.jpg', '9380e487-c97a-433e-a9e7-1b58089b126f', 'bde837ec-7ff8-4733-8eea-a65854e4acb3', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Madeleines', 'Traditional French sponge cake made famous by its particular shell shape', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gZD90fMnQgCLVpTdyCKf_med.jpg', '3eb3ad63-c482-4f12-b70e-e6c800cfcc31', 'bde837ec-7ff8-4733-8eea-a65854e4acb3', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Oranais dAbricot', 'Buttery, flakey breakfast pastry made with puff pastry, pastry cream and apricots', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/N2NEGEY0Tla6kvXNHTI2_orn.jpg', '9d0a6b6c-099f-497b-b3a4-0e00e58d086a', 'bde837ec-7ff8-4733-8eea-a65854e4acb3', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BÃ»che de NoÃ«l', 'Traditional French rolled cake. Chocolate sponge cake with Espresso Italian Meringue frosting, rolled into a log and frosted with Chocolate-Espresso Italian Meringue Frosting and decorated with chocolate bark', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4BUviV7SvO064tLEOkEm_log.jpg', '7391ecb2-54ad-452b-9081-d0438f0ae7bb', 'bde837ec-7ff8-4733-8eea-a65854e4acb3', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Diesel', 'Sativa know for its deisel-like smell, known to help stress pain and depression fade away. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/W0cHvGHQShyW03JO6fhX_temple.jpg', '4105bf0c-ce41-4517-b628-f1238b338b5e', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Vanilla Kush', 'This heavy indica is known for its high potency, and deep relaxing effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/oifpSC08Q9eyIjXjrkft_temple.jpg', '56eb809c-fdd1-457e-bab9-23c6d712e458', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('White Fire', 'Hybrid in the OG family, Known for its relaxation and euphoric effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9Ft7UhAsT4WWmJ8O7rZP_temple.jpg', 'de71824e-4ad8-45a1-a828-474319038d39', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry Cough', 'Sativa strain known for its sweet fragrance, helps with social anxiety and releasing stress. its effects are uplifting and euphoric and sure to turn that frown upside down. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/NyUezR4Rlid6eETES2xw_temple.jpg', 'e3e40c28-64ba-418b-bd4e-fede56b1ba4e', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG Kush', 'This Hybrid is the where all other OGs stem from, know for relieving stress and replacing it with euphoric bliss. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/yoYu7m3uTXeHP1Xzdds1_temple.jpg', '9e77a446-abc5-4777-aa4b-7e846c91e1f9', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Platinum OG', 'One of the heaviest indica strains around, known to help with stress, pain and anxiety. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/trgYbQqSNieN3EOyix5A_temple.jpg', 'c18b32e7-084d-461f-9543-87141595ecea', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG Kush', 'This Hybrid is the where all other OGs stem from, know for relieving stress and replacing it with euphoric bliss. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/yoYu7m3uTXeHP1Xzdds1_temple.jpg', 'ce77a212-aec6-45b7-8eab-847b2bdd3898', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cupcake Hybrid Cartridge', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dk7UMtL0SxvjYK2BWVQd_TDC-CPK.2bHYB.jpg', '5da4d374-e659-4d4c-a393-9df94a91f2ea', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Platinum OG', 'One of the heaviest indica strains around, known to help with stress, pain and anxiety. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/trgYbQqSNieN3EOyix5A_temple.jpg', 'b307eebd-86f0-479f-a734-273d2dd8fe7b', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('MK Ultra', 'This indica is renowned for its hypnotic effects and is good when a strong medicine is desired. Definitely for the days when getting off the couch is not a part of the plan. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DaNjDh2ATTKhrNRthbey_temple.jpg', '81e2ee5c-4673-4cc1-b304-4e3ba804c5c1', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Northern Lights', 'A favorite Indica strain known for its relaxation effects that walk hand in hand with dreamy euphoria. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qp0HuBq4Tz2pkxHBegAP_temple.jpg', '9afb6c15-883a-490d-9214-2b14a37eebf5', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer', 'A sativa strain known for its uplifting, clear-headed and creative effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/mG6HRGkLTD23aseaoy6f_temple.jpg', '9421cfab-4252-4ed8-9372-e01e86cece11', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Durban Poison', 'A pure sativa strain known for its sweet smell and euphoric and uplifting effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YkNiqScUSVSwGODjsFxz_temple.jpg', '0f77d7fb-ce55-4a31-b82a-63a4ca135d7c', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Ed Rosenthal Super Bud', 'This Hybrid strain is known as the best balance of indica and sativa that will leave you feeling euphoric, relaxed and focused. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XFz8Fd0DTWSLmVAwTXC3_temple.jpg', '2e1351cd-5d5b-42a1-9fcb-10a55081ccc9', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fire OG', 'Hybrid strain known for being the post potent of the OG strains, the effects tend to be relaxed and euphoric. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/niQsAl6SDmt5LTEVlSRx_temple.jpg', 'bb3f473d-c623-4c55-bc8d-11c31852df46', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Game Changer', 'A 60/40 indica dominant hybrid known for reliving aches, pains and getting your mood back on track to happiness. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/NXaCXdZTiuImU48pgEag_A-temple.jpg', 'b4d2a03f-e09e-439c-a443-54407af68178', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Conspiracy Kush', 'A true indica strain that has calming relaxation effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/n5uVbCx6Q9G5hBqyT2zY_temple.jpg', '0825e44a-870b-4407-8f23-38b131d4c4fa', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Casey Jones', 'Casey Jones is a sativa strain that is known for its uplifted, euphoric and energetic effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6McRAIIQQHu8rch4YZRo_temple.jpg', 'f12bafbd-9b2c-4d27-9d4f-cf7a662a3b9c', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Candyland', 'A sativa-domanant strain and has uplifting and stimulating effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/e8YtslrwQLOyznxkqZok_temple.jpg', 'f1822cce-614c-46b2-97a0-e8e00ac42333', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cannatonic', 'Known for being a sativa dominant effects, and a High CBD strain. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/KcHFZb5dTHexePVpykfb_A-temple.jpg', '360bed58-ae61-4724-8a79-28d3cf27ca4d', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Canna-Tsu', 'Hybrid strain known for its high CBD low THC levels that are mellow with mental clarity effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QBi8FuisTCq9kJnDu4f8_A-temple.jpg', '81e07a47-7c89-452d-832f-0742d3c1b29e', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blackberry Kush', 'A indica-dominant strain known for its relaxation effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/sMOefwtWT5OlBo8jvTof_temple.jpg', '280fe1ee-6162-4d70-8642-52c5dbfaafe1', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('ACDC', 'ACDC is known for being a sativa dominant effects, and a High CBD strain. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fwiw6134QrC96MQ8eNTT_A-temple.jpg', '1f73675b-a1d4-420f-983e-36b606b61384', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('AK-47', 'AK-47 is known as a sativa dominant strain that is mellow, but leaves you alert and engaged. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vltVujpjQOyqcloayYno_A-temple.jpg', 'c5660891-6347-4f0f-9add-001828446886', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Larry OG', 'Hybrid in the ocean grown family, known for its clean smell, and relaxing effects. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/EkjnkbBHSWuafWiOV3I2_temple.jpg', '261b8bb4-0e9b-4f25-8d3e-445919cbae78', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Dream', 'A sativa-domanant strain with full body relaxation with gentle cerebral invigoration. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ueTwmYkzSXi1ijo0MvRI_A-temple.jpg', '0c15224a-e9b8-43bc-89dd-1cda7a9ace68', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Diamond OG', 'An Indica strain that will relax away muscle-spasms and pain. This heavy Indica is very much made for relaxing and sleeping and not conducive to getting work done. Our CO2 extracts are made at our in-house facility uses a unique, proprietary process of advanced Supercritical CO2 Extraction, followed by a complex series of post-processing clarifications to ensure the highest quality possible. Our products never contain any additives such as PEG (polyethylene glycol). All of our methods use food grade terpenes or familiar names such as PPG (polypropylene glycol), coconut oil, vegetable glycerin, or food grade terpenes all of which are found in many CO2 products on the market.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CPAsqymyRwiXRlupxsYC_temple.jpg', 'e79e0eb3-379f-4da0-b041-0af877fd68a5', '3a5adef1-d2d3-484e-b9d9-ab2a70c2747a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('EGO Moon Rocks', 'This is an out of this world experience as we take a crystally bud, roll it in our Co2 extracted oil, then roll it in kief to create a nug that is like no other!  All it takes is a little crumb and you will know what I am talking about.  Smoke responsibly my friend.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wCDE2ECzSed3YmtE4DzP_Moon.2bRocks.2b1.jpg', '4f810ab7-6322-4d65-bd23-c07bbaa2439a', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select CBD Vaporizer Pen - Relax Vape Pen', 'Cutting edge hardware, pure CBD isolate, and Select expertise. Soothe your brain and body with the new Relax blend from Select CBD. Calming Lavender extract pairs perfectly with CBD isolate to cool you down.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8EWZEWx4RvGVteKrgP4i_98096_relax-cbd.jpg', 'f85f6d38-3053-4cd1-85d2-5501617dfdaa', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Vapes | CBD Vape Oil | CBD Vape Juice | Organic CBD | CO2 Extracted CBD | Solvent Free CBD |', '101 CBD Vape Oil will give you that quick, effective solution youre looking for without all of the junk your body doesnt need. From the hills of Spain, our hemp is grown without herbicides and pesticides. Through our one-of-a-kind super-critical extraction process, the resulting CBD is higher concentrate and clean from solvents and debris, leaving our oil a beautiful, clean light amber color and strong as hell. This is 100% CBD so there are no psychoactive properties (i.e. it wont get you "high"). Without THC, our CBD Vape Oil addresses a vast list of health benefits. From anti-anxiety to mood enhancers, anti-inflammatory to sleep aids, pain relief to anti-seizure, CBD is quickly being recognized as one of the most effective, natural ways to heal many of the common ailments humans face each day. Give our 101 CBD Vape Oil a try. With virtually no side effects, you have nothing to lose and everything to gain!

Pricing:
Complete Vape Kit - $39
Vape Cartridge with CBD juice - $29', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xYBEaFWQfKSiy7zxk7A4_101CBD-Vape-kit.jpg', '2b3aad10-a69a-4c8e-96c7-39feb8e6f340', '9a5de623-ea63-41e2-8a8d-c8e10c1523aa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('AC/DC', 'CBD-rich

Taste: Earthy & Sweet

AC/DC is high-CBD, sativa dominant strain. With the highest CBD:THC ratio of any of our cartridges, the strain is non-psychoactive but many patients still report extreme relief from pain, inflammation, depression, anxiety and stress.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AC-DC.jpg', '0065cb07-9657-4904-a418-ade6bdde2b6a', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blackberry Kush', 'Taste: Sweet & Pungent

Blackberry Kush is a notable strain due to the sweet taste but the strong effects associated with Indica. The strong relaxation can be felt throughout the entire body and is often reported to be used for pain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Blackberry%2BKush.jpeg', 'a3390c36-36b6-40a9-aa01-ebd3dbca4426', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Dream', 'Taste: Sweet & Berry

Blue Dream is a sativa dominant hybrid of Blueberry indica and sativa Haze. Patients report swift balancing and refreshing effects, making it popular to enjoy during the day for the treatment of pain, depression, and nausea.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cb4584a60001299ea2_blue-dream-p-500.jpeg', '153add19-d6e1-4f92-8dfd-c764afbfffe5', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chem Dawg', 'Taste: Pungent & Citrusy

Chemdawg is a sharp hybrid with a pungent aroma to match. The strong hybrid is on the potent side and patients enjoy using it for a cerebral high and a full body relief.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cbb311980001637b2c_chem-dawg-p-500.jpeg', '7d570bb9-5f67-4937-a71b-dee7a7a6111d', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cherry Pie', 'Taste: Sweet & Earthy

Cherry Pie is a hybrid strain that is beloved for it’s fast acting, subtle effects. Often referred to as a light-indica, this strain is known for it calming full-body relief. Patients report enjoying Cherry Pie for
stress relief, headaches, and minor pains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cb4584a60001299ea3_cherry-pie-p-500.jpeg', '4320bddd-4009-4322-9639-e9ff6f60505a', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GSC', 'Taste: Sweet & Earthy

GSC is a hybrid of two very popular strains, OG Kush & Durban Poison. The result is euphoria paired with full-body relaxation and a cerebral high. Patients have reported that this popular strain helps with pain and nausea.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cb7cc4250001956cba_gsc-p-500.jpeg', '69f5fcc8-1732-499d-b709-182650784466', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GG#4', 'Taste: Sweet & Pungent

Blackberry Kush is a notable strain due to the sweet taste but the strong effects associated with Indica. The strong
relaxation can be felt throughout the entire body and is often reported to be used for pain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cb93744200018636e9_gorilla-glue-p-500.jpeg', '32490607-1acb-49c6-b63e-9b41a13283f8', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Grand Daddy Purp', 'Taste: Sweet & Pungent

Grand Daddy Purple (GDP) is an indica-sensory dominant strain with hints of lavender, grape, and honey sweetness. Patients report enjoying GDP for calming relief while conveying gentle mental stimulation, excellent for relaxation without overt sedation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cba298f50001130045_gdp-p-500.jpeg', 'd3074d1e-98d8-4ca8-a1de-699d05585dd4', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer', 'Taste: Citrus

Named after renowned cannabis activist and author, Jack Herer is elevating and creativity enhancing. Its stimulating and joyous sativa-sensory dominant effects set the scene for profound aromatics and flavors of citrus.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cb93744200018636ea_jack-herer-p-500.jpeg', '0c5a2b01-91bc-4c60-826a-50a12714c8f7', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG Kush', 'Taste: Earthy & Piney

OG Kush is a strong Indica strain, delivering heavy relaxation and sedative effects. The strong effects are felt throughout the entire body. Most patients report using OG Kush for sleep disorders, migraines and stress.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cca298f50001130047_og-kush-p-500.jpeg', '47bce484-8436-4a06-95ce-60b081d097be', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Diesel', 'Taste: Diesel & Pungent

Sour Diesel is an energizing sativa that gets its name from its pungent diesel-like aroma. Patients report invigorating & uplifting cerebral effects, making it great for relief when you need to be active.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a2ee6cc4584a60001299ea4_sour-diesel-p-500.jpeg', '707af121-6f61-4bb8-bbbe-b7eca6ea4170', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CENSOREDland', 'Taste: Earthy & Sweet

Strong sativa genetics give CENSOREDland uplifting and stimulating effects, making it a perfect strain for social gatherings or creative pastimes.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a736e2528223600015ac4bd_EC-CENSOREDland.jpg', 'f2003c77-f503-406b-8c48-cd37cde20fea', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Durban Sherbet', 'Taste: Earthy & Sweet

A cross between Durban and Sherbet, Durban Sherbet promotes a euphoric experience that elevates mood and relieves stress.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a3435ac716ad80001976f68_durban-sherbet.jpg', '01f21fa5-8e46-4c1d-a59a-ea227d407811', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Durban Lime', 'Taste: Earthy & Sweet

A cross between Durban and Sherbet, Durban Sherbet promotes a euphoric experience that elevates mood and relieves stress.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a3435ac2e772e0001704949_durban-lime.jpg', '3c0c193f-ecda-4cdd-b5cb-d052217dbd4b', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Omija', 'Taste: Earthy & Sweet

Offering an uplifting high, patients report reaching for Omija when looking for inspiration while remaining highly functional.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a3435ac716ad80001976f67_omija.jpg', '1e09bf78-1d0d-4a1a-ae5e-3e695ef3d79b', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pineapple Afghani', 'Taste: Sweet & Citrusy

Most patients report stress and anxiety reduction leading to a relaxed and tranquil euphoria. At higher doses, heavy sedation can be experienced for those seeking a sleep invoking and enhancing strain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5a3435ac92929500015fc005_pineapple-afghani.jpg', '7f90a0c6-5d8a-479d-99c1-6ce2a53acebc', '44085103-1ecd-4c33-b918-5d2b3576c9c4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('18:1 CBD Vape Cartridge', '18:1 CBD Whole Plant Cannabis Extract Vape Cartridge
Fast-acting, smoke free and easy to use relief. 500mg cartridges.
Ingredients: 100% Cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/quozxrDASkGIGAFeDjgJ_cbd-cartridges-18-1-web_31270909343_o.jpg', '9c042a40-0d0a-452c-8e04-2b4adae178f9', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Watermelon Canna Cubes - 100mg', 'Our popular line of micro dosed infused hard candies come in a variety of flavors and deliver a delicious and discreet way to medicate. Traditional flavors include: Blue Raspberry, Cherry, Grape, Mango, Mint and Watermellon.

Each package contains (20) 5mg cube for a total of 100mg of THC Individual servings to ensure proper dosing Absorbed through the mouth and pleasantly potent Recommend starting with (1) 5mg candy and waiting approximately 1-2 hours before consuming another Natural flavors allow for little to no cannabis taste Lab tested for quality and consistency Sold in a child-proof, resealable safety bottle', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qRJqlNsMSpO13NAYY5xa_Canna.2bCube.2bopen.jpg', '74a3638c-b415-415e-b6b3-d53023aba22e', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mint Canna Cubes - 100mg', 'Our popular line of micro dosed infused hard candies come in a variety of flavors and deliver a delicious and discreet way to medicate. Traditional flavors include: Blue Raspberry, Cherry, Grape, Mango, Mint and Watermellon.

Each package contains (20) 5mg cube for a total of 100mg of THC Individual servings to ensure proper dosing Absorbed through the mouth and pleasantly potent Recommend starting with (1) 5mg candy and waiting approximately 1-2 hours before consuming another Natural flavors allow for little to no cannabis taste Lab tested for quality and consistency Sold in a child-proof, resealable safety bottle', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qZLsB0FbTzOArKN1mE5R_Canna.2bCube.2bopen.jpg', '9c3514af-3870-4f90-9ae2-f23cd185f7e8', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mango Canna Cubes - 100mg', 'Our popular line of micro dosed infused hard candies come in a variety of flavors and deliver a delicious and discreet way to medicate. Traditional flavors include: Blue Raspberry, Cherry, Grape, Mango, Mint and Watermellon.

Each package contains (20) 5mg cube for a total of 100mg of THC Individual servings to ensure proper dosing Absorbed through the mouth and pleasantly potent Recommend starting with (1) 5mg candy and waiting approximately 1-2 hours before consuming another Natural flavors allow for little to no cannabis taste Lab tested for quality and consistency Sold in a child-proof, resealable safety bottle', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/MR2xS2ROSRaFi5onUu3u_Canna.2bCube.2bopen.jpg', 'de269d07-f79e-4edf-a450-723a41f6cbb0', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Chews/Gummies', 'Delicious Gummies that we call fruit chews so kids wont relate!  Real Fruit Puree for that natural taste...  Absolutely delicious!
Evergreen Organix Fruit Chews are never sprayed or soaked. They are 100% made from scratch with all natural premium fruit by our gourmet confection makers.  No animal products in this fine product (gelatin free).

Available in Lemon, Cherry, Mango Passion Friut, Strawberry Bannana, Blueberry, Watermelon, and other assorted flavors!

Dosed at 20mg THC per gum drop and 100mg per pack.
Be conscious when consuming cannabis infused edibles.  Hand crafted and flavor specific chews, give you the consistent taste and dose each and every time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Vk9u5PBQHGsxwMvx8ZJa_Friut.2bChews.jpg', 'b4377d88-d4c6-4bac-899f-bea06b7a24f7', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Chews/Gummies - Blueberry 100mg', 'Delicious Gummies that we call fruit chews so kids wont relate! Real Fruit Puree for that natural taste... Absolutely delicious!
Evergreen Organix Fruit Chews are never sprayed or soaked. They are 100% made from scratch with all natural premium fruit by our gourmet confection makers. No animal products in this fine product (gelatin free).

Available in Lemon, Cherry, Mango Passion Friut, Strawberry Bannana, Blueberry, Watermelon, and other assorted flavors!

Dosed at 20mg THC per gum drop and 100mg per pack.
Be conscious when consuming cannabis infused edibles. Hand crafted and flavor specific chews, give you the consistent taste and dose each and every time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DP486YOFRCu4NjUm1q3A_Friut.2bChews1.jpg', '82485294-a75c-455a-82c7-8c758ec44558', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Chews/Gummies - Lemon 100mg', 'Classic gumy square with a cannabis twist! Evergreen Organix Fruit Chews are never sprayed or soaked. They are 100% made from scratch with all natural premium fruit by our gourmet confection makers.  No animal products in this fine product (gelatin free).

Available in Lemon, Cherry, Mango Passion Friut, Strawberry Bannana, blueberry, Watermelon, and other assorted flavors!

Dosed at 20mg THC per gum drop and 100mg per pack.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QU4hPlDXQV2il3wABlej_Friut.2bChews1.jpg', '04cfbc19-035f-493f-9d84-94f7ddcbb75c', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Chews/Gummies - Mango Passion Fruit Chews - 100mg', 'Delicious Gummies that we call fruit chews so kids wont relate!  Real Fruit Puree for that natural taste...  Absolutely delicious!
Evergreen Organix Fruit Chews are never sprayed or soaked. They are 100% made from scratch with all natural premium fruit by our gourmet confection makers.  No animal products in this fine product (gelatin free).

Available in Lemon, Cherry, Mango Passion Friut, Strawberry Bannana, Blueberry, Watermelon, and other assorted flavors!

Dosed at 20mg THC per gum drop and 100mg per pack.
Be conscious when consuming cannabis infused edibles.  Hand crafted and flavor specific chews, give you the consistent taste and dose each and every time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/MiDBMgXT96NeAMqtS0Eo_Friut.2bChews1.jpg', '66a19a16-f40c-4245-9a86-b5d699f2d462', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Chews/Gummies - Peach  100mg', 'Delicious Gummies that we call fruit chews so kids wont relate! Real Fruit Puree for that natural taste... Absolutely delicious!
Evergreen Organix Fruit Chews are never sprayed or soaked. They are 100% made from scratch with all natural premium fruit by our gourmet confection makers. No animal products in this fine product (gelatin free).

Available in Lemon, Cherry, Mango Passion Friut, Strawberry Bannana, Blueberry, Watermelon, and other assorted flavors!

Dosed at 20mg THC per gum drop and 100mg per pack.
Be conscious when consuming cannabis infused edibles. Hand crafted and flavor specific chews, give you the consistent taste and dose each and every time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qSbDXrHrRBSM44GQDe2F_Friut.2bChews1.jpg', 'aeb9602c-3744-4a16-903e-5ab2774cb54a', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Chews/Gummies - Strawberry Banana 100mg', 'Delicious Gummies that we call fruit chews so kids wont relate! Real Fruit Puree for that natural taste... Absolutely delicious!
Evergreen Organix Fruit Chews are never sprayed or soaked. They are 100% made from scratch with all natural premium fruit by our gourmet confection makers. No animal products in this fine product (gelatin free).

Available in Lemon, Cherry, Mango Passion Friut, Strawberry Bannana, Blueberry, Watermelon, and other assorted flavors!

Dosed at 20mg THC per gum drop and 100mg per pack.
Be conscious when consuming cannabis infused edibles. Hand crafted and flavor specific chews, give you the consistent taste and dose each and every time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vOgHkO3wT0q4FkqDSS5s_Friut.2bChews1.jpg', '4dad4c0f-390a-4cd5-9dbe-ebe04bc4ab33', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select CBD Vaporizer Pens', 'Cutting edge hardware, pure CBD isolate, and Select expertise. Select CBD is extracted from industrial hemp. CBD is a compound that interacts with the bodys endocannabinoid system. The series of receptors regulates pain, mood, the immune system, memory, appetite, stress, and other important functions. Try all 6 of our flavors today!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kBPIk6ljTEG71W1XSfA9_product-image.jpg', '159f5c4b-7f8f-4ad6-9d6e-be834c4056b1', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruit Chews/Gummies - Watermelon 100mg', 'Delicious Gummies that we call fruit chews so kids wont relate! Real Fruit Puree for that natural taste... Absolutely delicious!
Evergreen Organix Fruit Chews are never sprayed or soaked. They are 100% made from scratch with all natural premium fruit by our gourmet confection makers. No animal products in this fine product (gelatin free).

Available in Lemon, Cherry, Mango Passion Friut, Strawberry Bannana, Blueberry, Watermelon, and other assorted flavors!

Dosed at 20mg THC per gum drop and 100mg per pack.
Be conscious when consuming cannabis infused edibles. Hand crafted and flavor specific chews, give you the consistent taste and dose each and every time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/0Z26Hh1EQGCosESIaHos_Friut.2bChews1.jpg', '22d43864-ba10-4ece-b607-475e930c5d19', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Grape Canna Cubes - 100mg', 'Our popular line of micro dosed infused hard candies come in a variety of flavors and deliver a delicious and discreet way to medicate. Traditional flavors include: Blue Raspberry, Cherry, Grape, Mango, Mint and Watermellon.

Each package contains (20) 5mg cube for a total of 100mg of THC Individual servings to ensure proper dosing Absorbed through the mouth and pleasantly potent Recommend starting with (1) 5mg candy and waiting approximately 1-2 hours before consuming another Natural flavors allow for little to no cannabis taste Lab tested for quality and consistency Sold in a child-proof, resealable safety bottle', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/KtjqjaKQhyZNpU6K5D9w_Canna.2bCube.2bopen.jpg', 'ae4623ca-1849-468e-9594-25fb39827bd0', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cherry Canna Cubes - 100mg', 'Our popular line of micro dosed infused hard candies come in a variety of flavors and deliver a delicious and discreet way to medicate. Traditional flavors include: Blue Raspberry, Cherry, Grape, Mango, Mint and Watermellon.

Each package contains (20) 5mg cube for a total of 100mg of THC Individual servings to ensure proper dosing Absorbed through the mouth and pleasantly potent Recommend starting with (1) 5mg candy and waiting approximately 1-2 hours before consuming another Natural flavors allow for little to no cannabis taste Lab tested for quality and consistency Sold in a child-proof, resealable safety bottle', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kwjWalUxQXqHtNOkmTcu_Canna.2bCube.2bopen.jpg', '2b95541e-3a76-495c-bbce-253fb6de9790', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Raspberry Canna Cubes - 100mg', 'Our popular line of micro dosed infused hard candies come in a variety of flavors and deliver a delicious and discreet way to medicate. Traditional flavors include: Blue Raspberry, Cherry, Grape, Mango, Mint and Watermellon.

Each package contains (20) 5mg cube for a total of 100mg of THC Individual servings to ensure proper dosing Absorbed through the mouth and pleasantly potent Recommend starting with (1) 5mg candy and waiting approximately 1-2 hours before consuming another Natural flavors allow for little to no cannabis taste Lab tested for quality and consistency Sold in a child-proof, resealable safety bottle', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/jVuYQy1ZSiCprdBkyeOl_044.jpg', '3b981ec7-2b53-4346-aee1-25d9d3038895', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry White Chocolate Bar', 'This bar is 24 pieces of strawberry bits, white chocolate, premium cannabis and tons of love for a strawberry lovers delight.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SbUTSdNqQLKkmoag2kcc_116.jpg', '90088ed9-dc15-4249-9817-8f9c89106c78', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Peanut Butter White Chocolate Bar', 'Creamy Peanut Butter, Peanuts, White Chocolate and Fine Cannabis make for a peanut butter lovers heaven!  All you need is a cold glass of milk.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/sId4wS78TZuRATdbdgHK_PBBar.png', '8e9e6611-0c98-4935-a32f-21bc1de10dfe', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Salted Almond Dark Chocolate', 'What more could you ask for from a chocolate craftsman?  Yes, Salted Almond and Dark Chocolate.  It gives you the salty sweet combination the world is crazy for with the wonderful flavor of toasted almonds and milky smooth creamy chocolate.   No bitter sweet here, this is an amazing combination and you deserve the best, so pick up two to go, you will be glad you did.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zjJGWJS9ObJ7aaQND0Qd_117.jpg', '54aa04be-762b-49a5-9547-1ff0dc14b612', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Milk Chocolate Bar', 'The perfect blend of ingredients for a masterful piece of chocolate.  24 individual pieces that will satisfy your discriminating taste for milk chocolate along with your desire for the perfect dose of fine chocolate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/M9el8atQTnmmC21uqOoa_EVO_ChocalteBar.jpg', 'f537f4d7-5543-4b12-97e7-92fe047a700e', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mint Chocolate Bar', 'Creme de Mint white chocolate blended with our finest chocolate to create a large version of those fun chocolate mints you get at your classy steak house!  If you love mint and have a thing for amazing chocolate, this will become your go-to edible.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/J33hOXvS9CkTBjqVwsMl_115.jpg', '7240b4eb-f447-447f-9fe3-c3f30b8e8b4c', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cookies and Cream Chocolate Bar', 'This is what happens when silky buttery white chocolate collides with crushed dark cookies!  Its a party in your mouth.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rGIcBADzRXOPQhZM6f5Q_018.jpg', '5cf23b40-0ed9-48da-bf53-06c64f3b5165', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dark Chocolate Bar', 'This is not your typical dark chocolate bar!  It does not have that big hit of bitter sweet.  Its just enough to let you know the cocoa is all natural and comes from the best regions of the world during the proper season.  This is a velvety delicious luxury.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/pUOya28TXvQvtvQg0PQK_EVO_DarkChocBar.jpg', '83329d95-b715-44a5-a87e-a4a4a4790b8f', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD 1:1 THC Dark Chocolate Bar', 'For the medical consious person in you!  Our CBD 1:1 THC bar gives you everything all in one!   We take our award winning Dark Chocolate and combine our refined CBD and THC distillate to create this lovely treat.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5ez5MNjoSrKxmW3xg2On_EVO_DarkChocBar.jpg', '9d96fd68-0846-4c03-9c0b-64600a31d423', '1e628a11-3700-4f2d-b2ff-d40ef5b7141b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Social Strawberry - Disposable Vape Pen', 'Selects Social pens contain our award winning distilled cannabis oil blended with natural strawberry extract to provides a sweet, fruity taste and smell instead of cannabis odor. Social pens contain less than 25% THC, making them the perfect way to introduce anyone to the world of cannabis. Feel at ease with this convenient, worry-free delivery system, backed by Select expertise.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AcN6lSu1R6QAcbmLHhA0_Social_strawberry_MED_GW.jpg', '0fb7e173-03fb-4c1d-834c-63addb7aab3d', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Social Vanilla - Disposable Vape Pen', 'Selects Social pens contain our award winning distilled cannabis oil blended with natural vanilla extract to provides a sweet, fruity taste and smell instead of cannabis odor. Social pens contain less than 25% THC, making them the perfect way to introduce anyone to the world of cannabis. Feel at ease with this convenient, worry-free delivery system, backed by Select expertise.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Md9NEzYoSCK3ZIBwVMsX_Social_vanilla_MED_GW.jpg', '82d838e4-9db4-4be5-bd37-15ac026b3b96', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - TROPICAL DREAM (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8sEqhhQRPuDrQtXkvWKA_THC.2bCArt.png', 'd9735fd2-3363-4331-af32-34a782e41b92', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Social Blueberry - Disposable Vape Pen', 'Selects Social pens contain our award winning distilled cannabis oil blended with natural blueberry extract to provides a sweet, fruity taste and smell instead of cannabis odor. Social pens contain less than 25% THC, making them the perfect way to introduce anyone to the world of cannabis. Feel at ease with this convenient, worry-free delivery system, backed by Select expertise.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/yjMwEKKyTMu2nB2bZxWj_Social_blueberry_MED_GW.jpg', 'c62b3a22-f989-41bf-9e81-72b9e034b148', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select CBD Vaporizer Pen - Revive Vape Pen', 'Cutting edge hardware, pure CBD isolate, and Select expertise. Bring yourself back to life with the Revive blend from Select CBD. Combine the regenerative power of grapefruit extract with the power of medical CBD to help you recover, reconnect, and regain energy. CBD Vaporizer pen of the future.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DwKlScLKQeO7rmyU3ocQ_98097_revive-cbd.jpg', '276243e6-4225-4504-a2be-9f5ccfe961e9', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Elite Vaporizer Cartridge - Hybrid Vape Pen', 'A perfect marriage of high potency, broad spectrum distillate and cannabis-derived, strain specific terpenes, housed in our revolutionary cartridge design. Select Elite Hybrids balance body and mind effects, promoting a strong sense of elation and euphoria.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/P2ig4DenRtyA1E7SCPdt_Select_Elite_MED.png', 'fa257699-fb82-4591-83a3-ea94d6c0e595', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Elite Vaporizer Cartridge - Indica Vape Pen', 'A perfect marriage of high potency, broad spectrum distillate and cannabis-derived, strain specific terpenes, housed in our revolutionary cartridge design. Enjoy a soothing, relaxing trip with Select Elite Indica.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/shefMHxKTtaJt2fmHbUx_Select_Elite_MED.png', 'faef52c0-2faf-4acf-bd9d-2f50d3b01145', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Elite Vaporizer Cartridge - Sativa Vape Pen', 'A perfect marriage of high potency, broad spectrum distillate and cannabis-derived, strain specific terpenes, housed in our revolutionary cartridge design. Stimulate your mind and awaken your senses with Select Elite Sativa.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cSWlGTX9QfOcp09YL1aw_Select_Elite_MED.png', '65d9753c-3457-4259-9db6-d3852c324512', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Social Watermelon - Disposable Vape Pen', 'Selects Social pens contain our award winning distilled cannabis oil blended with natural watermelon extract to provides a sweet, fruity taste and smell instead of cannabis odor. Social pens contain less than 25% THC, making them the perfect way to introduce anyone to the world of cannabis. Feel at ease with this convenient, worry-free delivery system, backed by Select expertise.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fPIF54mISuE60m3CGKEW_Social_watermelon_MED.png', '7498f85b-9970-4c40-8940-1144ae8d86d1', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil Dabbables Syringes - Elite Distillate Vial', 'Dabbables distillate vials contain delectable terpenes artfully combined with our highest concentration of activated THC, between 70-90%. They are easily applied to a hot nail and vaporized with a glass rig, or dripped onto a joint or bowl of flower for an extra kick of flavor and potency. Dabbables contain a distilled oil, which is fully activated and does not require heat to become effective.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DKuAOOuSjyVWHBcIlmjQ_Select_Dabbables_MED.png', '552eeefc-4fed-452e-9b70-f5a18ad59f92', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Select Oil THC-A Crystalline - THC-A Isolate', 'Select THC-A Crystalline is a flawless isolate in its cleanest form--created for a truly unique, powerfully smooth, and completely cerebral experience. THC-A is a raw chemical compound that converts to THC when exposed to excess heat, air, or light.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6NIMd0e1TWystNA7kh85_THC-A.jpg', 'bada125a-179c-4548-a86e-a92ffba2fdf4', '8daceba2-d712-4161-aef8-ab2f49199dda', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Banana Sherbet - Vapor Cartridge', 'Origin: Golden State Herb, Calaveras
Lineage: Sour Diesel x Banana Sherbet
Potency: 91.3% Total Active Cans. (83.6% THC)

This Sativa-ish strain is known for making excellent concentrates, and we can confirm that this batch tastes great! It tastes just like it sounds: sweet notes of ripe banana mixed with a bit of the classic sour. The effects are balanced: happy and uplifting without being overly stimulating.   Go Higher with HIMALAYA: Authentic Flavor. Original Terpenes. Always Pure.  All HIMALAYA cartridges are independently tested to be free of pesticides, solvents and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/PxS3ITf0RqWDuTEHcZMY_front1_1080x1080_v2.jpg', 'd539ce45-63ba-4b3e-a709-157f3a13bc21', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Diesel - Vape Cartridge', 'Potency: 89.8% total active cannabinoids (82.0% THC). This Sativa cartridge delivers the classic flavor and cerebral effects of Sour D. The full flavor is both smooth and deliciously rich. Contains the original, authentic cannabis terpenes with no added flavors or solvents. Independently lab tested for residual solvents, pesticides and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/U98B5VfZQOurWq95sse5_SD.jpg', '75d514a7-f3d3-4a9e-896e-8e0dca9e3dbc', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Grape - Vape Cartridge', 'Single Origin: Nevada City, California.  The first batch of Sour Grape tasted AMAZING! Now its back, and its still pretty killer! The taste of cartridges doesnt get any better than this. Made with 100% authentic cannabis terpenes. No added terps or fake flavors. Independently lab tested for solvents, pesticides and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/P3lDBJ9mRfleJFmCdrc7_SGR.jpg', '37eefafe-cbf1-4671-88b8-c65501cd6fd3', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tahoe OG Kush - Vape Cartridge', 'Potency: 82.3%. Single Origin: San Juan Ridge.  Tahoe OG Kush is a variant of OG Kush that combines Sativa-like euphoria with Indica-like sedation.  This batch of HIMALAYA Tahoe OG Kush has a mild flavor that matches that of the original flowers: earthy, lemon, and pine combine with the classic Kush spiciness.

HIMALAYA: Original Terpenes, Authentic Flavor, Always Pure. No solvents or added flavors. Lab tested for pesticides, solvents and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/puLJD2epQ0egKWv4osZV_TOK_1080x1080.png', 'cd7936ae-0f73-4106-ab95-43a1869eb3a1', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Tangie - Vape Cartridge', 'Potency: 77% total cannabinoids (72% total THC). Origin: Golden State Herb, Calaveras County, CA. This 80/20 Sativa is cross between two classics: Sour Diesel and Tangie. The taste is "sweet and sour": a pleasant citrus flavor with deeper Sour Diesel notes.

HIMALAYA delivers the authentic, full-spectrum cannabis terpenes with no added flavors. Independently lab tested for solvents, pesticides, and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/UeQaZzXS4mbAFfEiDo7H_STG.jpg', 'ac28ecc6-f50e-4798-b061-51b2133ca43b', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sweet Dreams - Vape Cartridge', 'Potency: 75.2% total active cannabinoids (70.3% THC)

Single Origin: Yankee Hill

Sweet Dreams is a rare indica-dominant strain known for putting users to sleep.  The taste of this batch combines tangerine flavors with a well-rounded, peppery base.

HIMALAYA: Original Terpenes, Authentic Flavor, Always Pure. No solvents, no additives and no added flavors. Lab tested for pesticides, solvents and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/7dY5TLSeRkKyqp2OV4HO_SDM_1080.jpg', '610f0452-9fba-4ee6-8cd0-cbb17d2318a5', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG Kush - Vape Cartridge', 'Single Origin: Alta Sierra. Dont think a cartridge can taste like flower? Think again! The euphoric feeling you expect from OG Kush are accompanied by a rich, earthy flavor of pine and lemon. This ultra-pure Hybrid cartridge will leave you happy and relaxed. 100% authentic cannabis terpenes. No added flavors or fake terpenes. Independently lab tested for residual solvents, pesticides, and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QyoFRpbTR5yvSKAq1QZL_OGK.jpg', '3068c3e9-72b9-4ed9-99b0-0547cae5464a', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pineapple Jack - Vape Cartridge', 'Potency: 78.9%. Single Origin: Grass Valley.  Another great season of Pineapple Jack from HIMALAYA.  The leaf smelled like pineapple going in, and you can taste it in the finished product. Pineapple Jack only comes around once a year and doesnt last long.  100% authentic cannabis terpenes. No added terps or fake flavors. Independently lab tested for solvents, pesticides and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XI3IV2sRJ4cVKf2N9PzQ_PNJ_straight.jpg', '2a2d56f6-779a-4496-8d90-f2f84b7f23dc', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG Kush - Vape Cartridge', 'Single Origin: Alta Sierra. Dont think a cartridge can taste like flower? Think again! The euphoric feeling you expect from OG Kush are accompanied by a rich, earthy flavor of pine and lemon. This ultra-pure Hybrid cartridge will leave you happy and relaxed. 100% authentic cannabis terpenes. No added flavors or fake terpenes. Independently lab tested for residual solvents, pesticides, and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QyoFRpbTR5yvSKAq1QZL_OGK.jpg', '16307bb3-93d9-4b92-a86f-368a58e4c932', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pineapple Jack - Vape Cartridge', 'Potency: 78.9%. Single Origin: Grass Valley.  Another great season of Pineapple Jack from HIMALAYA.  The leaf smelled like pineapple going in, and you can taste it in the finished product. Pineapple Jack only comes around once a year and doesnt last long.  100% authentic cannabis terpenes. No added terps or fake flavors. Independently lab tested for solvents, pesticides and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XI3IV2sRJ4cVKf2N9PzQ_PNJ_straight.jpg', 'ba73b60d-ba53-4c41-bcdf-ab2a234184da', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kashmir Kush - Vape Cartridge', 'Single Origin: Nevada City, CA. An absolutely delicious concentrate! The unique flavor from this rare strain combines vanilla and lavender with a hint of citrus. HIMALAYA sourced this gem from Big Jim, a longtime friend of the founder who operates a small garden in the Sierra foothills. 100% authentic cannabis terpenes. No added flavors or fake terpenes. Independently lab tested for residual solvents, microbiologicals and pesticides.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AgU4Bud6Rlpld7TaoTtb_KAS-front.jpg', '8afb39d4-0176-4c21-b08b-32fc63e88af2', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG #18 Private Reserve - Vape Cartridge', 'Potency: 87.9%. Single Origin: Carpenteria. OG #18 aka "Private Reserve OG" is a phenotype of OG Kush thats popular among connoisseurs. It combines the much loved taste of OG Kush with a relaxing, peaceful body high. HIMALAYAs official Tastemaster describes the taste as "A declicious, fruity mango flavor.  Smooth all the way to the finish."

HIMALAYA: Original Terpenes, Authentic Flavor, Always Pure. No solvents or added flavors. Lab tested for pesticides, solvents and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/sxgxiav7Qs2ABZk8ZTXF_OG18_1080x1080.jpg', 'f708b42e-31cf-458e-ab46-768e902b73a7', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Darth Vapor - Vape Cartridge', 'This HIMALAYA exclusive is a cross between Blackberry Kush and Mr. Nice.  The Indica runs strong in this one.  HIMALAYA delivers the authentic, full-spectrum cannabis terpenes with no added flavors. Independently lab tested for solvents, pesticides, and microbiologicals.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/mwNBhEjPQ4OgpaNCu5zA_DVP_original.jpg', '50f3d975-d4ca-4686-bfa4-ffd8887afdf0', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Atomic Northern Lights - Vape Cartridge', 'Single Origin: Alta Sierra. This ultra-pure Indica-dominant cartridge delivers a full-bodied, skunky flavor that old-school heads will enjoy. 100% authentic cannabis terpenes. No added flavors or fake terps. Independently lab tested for residual solvents, microbiologicals and pesticides.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/98ZhsWmSlq2dn7OzkGvA_ATN.jpg', 'b804b27c-045f-42d8-abdd-67b5454b2a72', 'd73bff1b-49ae-4089-892f-7cce74b91ac4', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Coffee Beans in Dark Chocolate', 'Satori Coffee Beans in Dark Chocolate
140mg THC
Serving size | 5
Servings per package | 14
THC per serving | 2mg per piece
Ingredients | Dark Chocolate (Cacao Beans, Cane Sugar, Cocoa Butter, Say Lecithin, Pure Vanilla Extract), Organic Coffee Beans, Cannabis Oil, Confectioners Sugar, Cocoa Powder, Tapioca Dextrin, Confectioners Glaze', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rhx3hKtaTPaKekoA4Fyy_satori-no-edit-1792_26997695391_o.jpg', '42a30bfd-13c7-475a-af20-5e9b61b12aaf', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Milk Chocolate Bar | 160mg', '160mg THC
Serving size | 1 piece
Servings per package | 16
THC per serving | 10mg
Ingredients | Milk chocolate (organic cacao beans, organic cane sugar, organize whole milk powder, organic cocoa butter, organic non-fat milk powder, soy lecithin, organic vanilla beans) cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/tgTDoDa8TtmGLRApeEsm_satori-no-edit-1720_26997708591_o.jpg', 'd949ef1d-44e1-40a0-b004-066eb5e06f17', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Blueberries in Dark Chocolate', 'Satori Highbush Blueberries in Dark Chocolate
140mg THC
Serving size | 5 pieces
Servings per package | 14
THC per serving | 2mg per piece
Ingredients | Dark Chocolate (Cacao Beans, Cane Sugar. Cocoa Butter, Soy lecithin, Pure Vanilla Extract), Blueberries (Dried Blueberries, Cane Sugar, Sunflower Oil). Cannabis Extract, Organic Raspberry Powder, Organic Blueberry Powder. Cocoa Powder, Confectioners Sugar, Tapioca Dextrin, Confectioners Glaze', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Eu2C6wfEQzmeLMLicTSq_satori-no-edit-1833_26997687791_o.jpg', '64d0d6f9-edb5-41f7-bc68-ab488674a3f2', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Dark Chocolate Bar | 10mg', 'Satori Dark Chocolate Bar | 10mg
10mg THC
Serving size |1 piece
Servings per package | 1
THC per serving | 10mg
Ingredients | Dark Chocolate (Cane Sugar), Cacao Beans, Organic Cacao Butter, Organic Cacao Beans, Organic Cane Sugar, Soy Lecithin, Vanilla Beans), Cannabis Oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2hym1WcQJ2KariBu6vVJ_10.2bmg.2bsatori.jpg', '749d9e26-9fc2-49b0-bcb7-6d5aec62df34', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Dark Chocolate Bar | 160mg', 'Satori Dark Chocolate Bar | 160mg
160mg THC
Serving size | 1 piece
Servings per package | 16
THC per serving | 10mg
Ingredients | Dark Chocolate (Cane Sugar), Cacao Beans, Organic Cacao Butter, Organic Cacao Beans, Organic Cane Sugar, Soy Lecithin, Vanilla Beans), Cannabis Oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vjPL6KbLSqK0ITottU6R_satori-no-edit-1704_27066055265_o.jpg', 'eb8e9916-1a6b-4a4a-825a-50597e89ad06', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Dark Chocolate Bar | 240mg', 'Satori Dark Chocolate Bar | 240mg
240mg THC
Serving size | 1 piece
Servings per package | 24
THC per serving | 10mg
Ingredients | Dark Chocolate (Cane Sugar), Cacao Beans, Organic Cacao Butter, Organic Cacao Beans, Organic Cane Sugar, Soy Lecithin, Vanilla Beans), Cannabis Oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IVQK3BETTh2f2wOyNTBX_satori-no-edit-1700_27066055665_o.jpg', 'c3b240c5-6e2c-44c1-ac74-43003c3f83bc', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Dark Chocolate Bar | 40mg', 'Satori Dark Chocolate Bar | 40mg
40mg THC
Serving size |1 piece
Servings per package | 4
THC per serving | 10mg
Dark Chocolate (Cane Sugar), Cacao Beans, Organic Cacao Butter, Organic Cacao Beans, Organic Cane Sugar, Soy Lecithin, Vanilla Beans), Cannabis Oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/hPWycZptTxg8q804UHHq_satori-pop-40mg-20count_32087199635_o.jpg', '516a0394-31f7-4276-b0d6-75bc3e47937a', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Dark Chocolate Bar | 90mg', 'Satori Dark Chocolate Bar | 90mg
90mg THC
Serving size | 1 piece
Servings per package | 9
THC per serving |10mg
Ingredients | Dark Chocolate (Cane Sugar), Cacao Beans, Organic Cacao Butter, Organic Cacao Beans, Organic Cane Sugar, Soy Lecithin, Vanilla Beans), Cannabis Oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/mTSna0rAR6efD9uiMcGF_satori-no-edit-1713_27066053785_o.jpg', '5a2a58a3-999f-4eac-b426-0f74dc4799fb', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Milk Chocolate Bar | 10mg', 'Satori Milk Chocolate Bar | 10mg
10mg THC
Serving size |1 piece
Servings per package | 1
THC per serving | 10mg
Ingredients | Milk chocolate (organic cacao beans, organic cane sugar, organize whole milk powder, organic cocoa butter, organic non-fat milk powder, soy lecithin, organic vanilla beans) cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RLRIXWQT2jhOoaW3GXw6_10.2bmg.2bsatori.2bmilk.jpg', 'ec322f60-083d-4e25-af77-49037b069ae6', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Milk Chocolate Bar | 240mg', 'Satori Milk Chocolate Bar | 240mg
240mg THC
Serving size | 1 piece
Servings per package | 16
THC per serving | 15mg
Ingredients | Milk chocolate (organic cacao beans, organic cane sugar, organize whole milk powder, organic cocoa butter, organic non-fat milk powder, soy lecithin, organic vanilla beans) cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/sNZ5CQ01SaSI2lC1EQBg_satori-no-edit-1717_27066052765_o.jpg', 'f7c2840d-3422-4844-8691-b0e0d9d2743f', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Milk Chocolate Bar | 40mg', 'Satori Milk Chocolate Bar | 40mg
40mg THC
Serving size |1 piece
Servings per package | 4
THC per serving | 10mg
Ingredients | Milk chocolate (organic cacao beans, organic cane sugar, organize whole milk powder, organic cocoa butter, organic non-fat milk powder, soy lecithin, organic vanilla beans) cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Nn3gu3UCQMqtTz00H1Sf_satori-pop-40mg-20count-light_31969271101_o.jpg', '8aa61d0a-8295-43fa-953f-652c039019f3', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Milk Chocolate Bar | 90mg', '90mg THC
Serving size | 1 piece
Servings per package | 9
THC per serving | 10mg
Ingredients | Milk chocolate (organic cacao beans, organic cane sugar, organize whole milk powder, organic cocoa butter, organic non-fat milk powder, soy lecithin, organic vanilla beans) cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/peJFouSq1BUyrKK9b2wU_satori-no-edit-1710_27066054225_o.jpg', '0fecc130-1cee-465e-b250-fafee584b42d', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Raisins in Organic Milk Chocolate', 'Satori California Raisins in Organic Milk Chocolate
140mg THC
Serving size | 10
Servings per package | 14
THC per serving | 1mg per piece
Ingredients | Organic Milk Chocolate (Organic Cacao Beans, Organic Cane Sugar, Organic Whole Milk Powder, Organic Cocoa Butter, Organic Non-Fat Milk Powder, Soy Lecithin, Organic Vanilla Beans), Raisins, Confectioners Sugar, Cocoa Powder, Cannabis Oil, Tapioca Dextrin, Confectioners Glaze', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dOx570dHSlxNo13NauMo_satori-no-edit-1830_26997688801_o.jpg', 'dd8f0dcd-8255-4c8b-a912-c6a2eedb8267', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Salted Caramel Almonds in Dark Chocolate', 'Satori Salted Caramel Almonds in Dark Chocolate
140mg THC
Serving size | 2 pieces
Servings per package | 12
THC per serving | 6mg per piece
Ingredients | Dark Chocolate (Cacao Beans, Cane Sugar, Cocoa Butter, Soy Lecithin, Pure Vanilla Extract), Almonds, Cane Sugar, Cannabis Oil, Cocoa Butter, Sea Salt, Tapioca Dextrin, Confectioners Glaze', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fN9Eh9bR3WEJlLM8A7vE_satori-no-edit-1806_27066040475_o.jpg', '849baac0-8a08-46be-812e-7bfdfe2a1ac9', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Salted Caramel Cacao Beans in Dark Chocolate', 'Satori Salted Caramel Cacao Beans in Dark Chocolate
140mg THC
Serving size | 1
Servings per package | 14
THC per serving | 10mg per piece
Ingredients | Dark Chocolate (Cacao Beans, Cane Sugar, Cocoa Butter, Soy Lecithin, Pure Vanilla Extract), Cacao Beans, Cane Sugar, Cannabis Oil, Sea Salt, Cocoa Butter, Tapioca Dextrin, Confectioners Glaze', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/UVoy7PNRHGuXLpXLWGA5_satori-no-edit-1787_26997696451_o.jpg', '7d41000c-b98e-44ba-b759-dbe6888bca42', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Strawberries in Organic Milk Chocolate', 'Satori Wild Strawberries in Organic Milk Chocolate
140mg THC
Serving size | 3 pieces
Servings per package | 15
THC per serving | 3mg per piece
Ingredients | Organic Milk Chocolate (Organic Cacao Beans, Organic Cane Sugar, Organic Whole Milk Powder, Organic Cocoa Butter, Organic Non-Fat Milk Powder, Soy Lecithin, Organic Vanilla Beans), Wild Strawberries (Dried Strawberries, Sugar, Sucrose, Lemon Juice), Cannabis Oil, Confectioners Sugar, Organic Strawberry Powder, Cocoa Powder, Tapioca Oextrin, Confectioners Glaze', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TRBXk0imQtG9dB80jFnt_satori-no-edit-1860_27032952116_o.jpg', '5e0d1f3a-350d-45a8-b521-602921579275', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Coffee Beans in Dark Chocolate', 'Satori Coffee Beans in Dark Chocolate
140mg THC
Serving size | 5
Servings per package | 14
THC per serving | 2mg per piece
Ingredients | Dark Chocolate (Cacao Beans, Cane Sugar, Cocoa Butter, Say Lecithin, Pure Vanilla Extract), Organic Coffee Beans, Cannabis Oil, Confectioners Sugar, Cocoa Powder, Tapioca Dextrin, Confectioners Glaze', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rhx3hKtaTPaKekoA4Fyy_satori-no-edit-1792_26997695391_o.jpg', 'ef79722c-8399-4630-b557-24568186c33a', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Satori Milk Chocolate Bar | 160mg', '160mg THC
Serving size | 1 piece
Servings per package | 16
THC per serving | 10mg
Ingredients | Milk chocolate (organic cacao beans, organic cane sugar, organize whole milk powder, organic cocoa butter, organic non-fat milk powder, soy lecithin, organic vanilla beans) cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/tgTDoDa8TtmGLRApeEsm_satori-no-edit-1720_26997708591_o.jpg', '44b4e0c7-bd1d-4dd0-8118-20be8ab57a8e', '90c82657-0d5e-4e7e-8721-eedb93dbcc57', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Trainwreck  (Family Strong Farms)', 'Trainwreck is a mind-bending hybrid with potent sativa effects that hit like a freight train. Mexican and Thai sativas were bred with Afghani indicas to produce this Northern California staple, passing on a sweet lemon and spicy pine aroma. Trainwreck begins its speedy hurtle through the mind with a surge of euphoria, awakening creativity and happiness. Migraines, pain, and arthritis are mowed down by Trainwrecks high THC content, and many patients also use it for relief of anxiety, ADD/ADHD, and PTSD. Trainwreck flowers finish up in early October outdoors, while indoor gardens are ready for harvest 8 weeks into flowering.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/k7eFT0DQgGlnc8VoGntw_trainwreck.jpg', 'dca3ff0b-a928-4119-b0c9-b2572bce7759', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lemon CBD Cartridge', 'FlaxRx Lemon CBD Cartridge contains 200mg of distillate hemp CBD oil. When you want a sour lemon experience while also medicating at the same time, there is no other better option than this CBD distillate cartridge. Derived from organically grown hemp and utilizing CBD for medical benefits without the psychoactive head high.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/k27wIVmLQyinqkC19jTT_Screen.2bShot.2b2017-07-19.2bat.2b11.30.49.2bAM.png', 'c1d147af-7eae-4fe6-b6a4-a69c97b20b42', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Peanut Butter Cherry Pie - Humboldt Family Strong Farms', 'Peanut Butter Cherry Pie is a proprietary strain of OG Kush crossed with Cherry Pie from Humboldt Family Strong Farms. This Indica Dominant Hybrid has a delicious taste and aroma of sweet, earthy, Lemon Cherry, and it has a deep couch-lock effect. This strains big beautiful buds are sticky and great for smoking or vaporizing. Lab test results coming soon. http://www.cblabstesting.com/test-results', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/afrYBPXxRoqRMtfZAKOK_PB.jpg', 'f693f051-5381-4b0b-963d-e52f309356a7', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Afghan Kush (Delete)', 'Afghan Kushs roots trace back to the Hindu Kush mountain range near the Afghanistan-Pakistan border. There its genotype has been perfected over centuries, making it the ultimate source for hash such as charas and the sticky black Afghani hash. White Label Seed Company, a Sensi Seeds partner from the Netherlands, made the seeds of this strain available for everyone to grow. The buds of Afghan Kush develop into massive, blunt-topped nuggets full of resin; pure indica goodness with a heavy yield. Revered for its heavy resin content and powerfully sedating effects, Afghan Kush is a top choice for anyone looking to relax after a long day.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/s0IwEAZXT4ilfpBQkB8S_kush.jpg', 'e304a542-92a4-496d-9f49-062e9a732858', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blueberry (Delete)', 'A true A-List cannabis strain. Blueberrys legendary status soared to new heights after claiming the High Times Cannabis Cup 2000 for Best Indica. The sweet flavors of fresh blueberries combine with relaxing effects to produce a long-lasting sense of euphoria. Many medical patients appreciate Blueberry for its ability to suppress pain and relieve stress, while connoisseurs and growers admire the strain for its colorful hues and high THC content. Lab Tested. SLAMM Certified. http://www.cblabstesting.com/test-results', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WfyotnnRQxmVX9kLsU3m_blue.jpg', 'fabb3134-1fd7-4ad2-bae0-3edbbd07847a', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GSC (f.k.a. Girl Scout Cookies) (Delete)', 'GSC (f.k.a. Girl Scout Cookies), or GSC, is an OG Kush and Durban Poison hybrid cross whose reputation grew too large to stay within the borders of its California homeland. With a sweet and earthy aroma, GSC (f.k.a. Girl Scout Cookies) launches you to euphorias top floor where full-body relaxation meets a time-bending cerebral space. A little goes a long way with this hybrid, whose THC heights have won GSC (f.k.a. Girl Scout Cookies) numerous Cannabis Cup awards. Patients needing a strong dose of relief, however, may look to GSC for severe pain, nausea, and appetite loss.

There are several different phenotypes of the GSC (f.k.a. Girl Scout Cookies) strain including Thin Mint and Platinum Cookies, which exhibit some variation in appearance and effect. Typically, however, GSC (f.k.a. Girl Scout Cookies) expresses its beauty in twisting green calyxes wrapped in purple leaves and fiery orange hairs. Patients and consumers looking to cultivate this cannabis staple themselves should wait 9 to 10 weeks for their in', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4kpKiFUBQDScx9jvFcrK_girl.jpg', '5f2964ae-18e1-4dcf-9aed-3ddf98ac8238', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Killer Purple - Humboldt Family (Delete)', 'An old school PNW favorite that has its roots deep in marijuana culture, the Killer Purple has been grown and favorited by old heads in the cannabis industry for decades. Her short, blocky frame screams "Indica", Killer purple defines the meaning of the word. She will weigh you down until you are forced to submit, her midnight purple flowers are a force to be reckoned with.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HYmS1lHuS1mqaA5NFDzX_Screen.2bShot.2b2017-03-15.2bat.2b5.52.12.2bPM.png', 'a409be97-668b-4fa6-a531-9e0ec5d544ec', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mr. Nice - Humboldt Family Strong Farms (Delete)', 'Mr. Nice is a cross between the legendary G13 strain and the Hash Plant. Previously unavailable since the 80s, Sensi Seed Bank has put this hybrid on the market again. He is named in honor of Howard Marks, the Oxford graduate who became one of the biggest Marijuana smugglers of our time. After his time in federal prison Howard released his autobiography entitled "Mr. Nice". This indica dominant plant has extremely dense buds with a sweet smell. Mr. Nice will creep up and provide you with a strong, mellow high.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/BeUZSNrxS8WUCmqj0YBu_mr.2bnice.jpg', 'a1b3a06e-c13d-4e65-ac40-461c7fe7eb8e', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG Kush  (Delete)', 'OG Kush makes up the genetic backbone of West Coast cannabis varieties, but in spite of its ubiquity, its genetic origins remain a mystery. Popular myth maintains that Chemdawg and Hindu Kush parented OG Kush, passing on the distinct "kush" bud structure we see in many strains today. However, we cant be sure because OG Kush first came from bag seed in the early 90s. The earliest propagators (now known as Imperial Genetics) are said to have brought the seeds out of Florida to Colorado and southern California, where it now flourishes. There are many different phenotypes of OG Kush, some of which include Tahoe OG, SFV OG, and Alpha OG.

OG Kush is cherished for its ability to crush stress under the weight of its heavy euphoria. It carries an earthy pine and sour lemon scent with woody undertones, an aroma that has become the signature of OG Kush varieties and descendants. With OG Kush, patients most commonly cite improvements in migraines, ADD/ADHD, and stress disorders.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/c749u7wHSOi2OKGjWpHc_ogk.jpg', 'f1711456-ee35-414c-8c70-f06289491d5d', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pineapple Orange Guava  (Family Strong Farms)', 'Pineapple Orange Guava is a delicious, slightly sativa dominant hybrid strain (60% sativa/40% indica) that kicks a  20+% average THC level. Pineapple Orange Guava has a mouth-watering taste and smell - a sickly sweet orange with hints of earthy pineapple, pine and of course guava! This mildly heady strain is perfect for new users and seasoned smokers alike due to the mild THC level and delicious taste and auroma. Smoking Pineapple Orange Guava will give you a creeping chill high thats characterized by an indica cerebral high with insane clarity and focus, followed by an indica warming body buzz. Be careful not to smoke too much at once - it will give you fits of giggles and make you a little more talkative than you should be in the average social situation. Because of its clarifying effects that encourage social interaction and subtle body high, this bud is perfect for treating social anxiety, stress disorders, and PTSD. Pineapple Orange Guava has sticky resinous minty green nugs of medium density that have a', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ZqZsngnQROOub7qDzvuw_pineapple.jpg', '0c1d0af6-a9c3-43e9-9c37-891fe6435d2c', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Kushberry Cannabis Distillate Cartridge', 'Kushberry is the perfect blend of two West Coast flavors, Blueberry from Oregon and the OG Kush from LA. The exotic flavor doesnt rival its strength; Kushberry is known for relieving pain, sleeplessness, and appetite loss.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/M1FafN5oTYmphvxkcepO_Lime-1024x651.jpg', 'b1dc551c-a2d5-438a-bd70-9425ab4d9a51', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Espresso, 180mg FAVORITE No reviews', 'FlavRx‘ delicious Espresso flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with chocolate, espresso beans, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/tURdgMUdRzuRrZBxpYAt_Screen.2bShot.2b2017-10-17.2bat.2b3.21.39.2bPM.png', 'eea4a765-625b-4e62-9a03-8199114011ce', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer Cannabis Distillate Cartridge', 'Jack Herer is a sativa-dominant cannabis strain that has gained as much renown as its namesake, the marijuana activist and author of The Emperor Wears No Clothes. Combining a Haze hybrid with a Northern Lights #5 and Shiva Skunk cross, Sensi Seeds created Jack Herer hoping to capture both the cerebral elevation associated with sativas and the heavy resin production of indicas. Its rich genetic background gives rise to several different variations of Jack Herer, each phenotype bearing its own unique features and effects. However, consumers typically describe this 55% sativa hybrid as blissful, clear-headed, and creative.

Jack Herer was created in the Netherlands in the mid-1990s where it was later distributed by Dutch pharmacies as a recognized medical-grade strain. Since then, the spicy, pine-scented sativa has taken home numerous awards for its quality and potency. Many breeders have attempted to cultivate this staple strain themselves in sunny or Mediterranean climates, and indoor growers should wait 50 to', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/hhslzqh4QrPnkzd5XQ6Q_62236_170605_family-strong-farms_fruity-pebbles-clear-thc-distalate-cartidge-5.jpg', '712d8912-eb7e-4afc-905e-75aeb83a6faf', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fruity Pebbles Cannabis Distillate Cartridge', 'Fruity Pebbles (AKA Fruity Pebbles OG) by Alien Genetics was a limited-time offering from the breeder. This sweet hybrid takes genetics from Green Ribbon, Granddaddy Purple, and Tahoe Alien to create a tropical, berry flavor reminiscent of the cereal. The euphoric effects will keep you happy when youre stressed and help you catch some sleep when faced with insomnia. Sit back, relax, and pour yourself a bowl of Fruity Pebbles!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9aAzlrw2TCKXOVMcx5fw_170605_family-strong-farms_fruity-pebbles-clear-thc-distalate-cartidge-1-1.jpg', 'cf472148-f53d-48ef-a125-5ec083ff0098', '1c19a2e8-4b1a-4675-a7c7-ed184ec80fa6', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Vanilla CBD Cartridge', 'FlaxRx Vanilla CBD Cartridge contains 200mg of distillate hemp CBD oil. Nothing compares to the healing power of CBD derived from hemp, with amazing properties that help alleviate pain, anxiety, inflammation, and other ailments without the psychoactive head high associated with THC. With sweet natural vanilla flavoring that makes each hit an enjoyable medicating experience, FlavRx brings flavor and relief in a whole new way.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/isujOiYReSwpnJsl5nFY_Screen.2bShot.2b2017-07-26.2bat.2b2.40.20.2bPM.png', 'cfe658dc-c076-4b6a-b419-ede04b102955', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Vanilla Kush Disposable Vape Pen', 'Looking for a quick, discreet way to medicate? FlavRx Vanilla Kush Premium Disposable Vape Pen is the easy, inconspicuous way to self-medicate. Perfect CO2 500mg extracted cannabis oil is simple for controllable dosing. Comes Vanilla Kush strain specific and effective medication.

Up tp 15- hits

500mg

CO2 Extracted SOLVENT-FREE process.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RB1pp3PTdq3rdSsPk21p_Screen.2bShot.2b2017-07-26.2bat.2b4.29.15.2bPM.png', '7c6d3460-9d4e-40f3-9d77-be7666ff653f', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tangie Black Label Tank', 'Black Label Tanks are the premium line of cartridges from FlavRx. The inhale is very sweet, while the exhale has more of a pine flavor. Additionally, the pine like exhale cleanses the palate. The scent from Black Label plumes tingle the nose with sugary notes of exotic spice.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/erH1A3l4RYuyw0ABmhbJ_Screen.2bShot.2b2017-07-26.2bat.2b4.20.08.2bPM.png', 'cab51329-809d-44e6-988e-4909c473556e', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tropical CBD Cartridge', 'FlaxRx Tropical CBD Cartridge contains 200mg of distillate hemp CBD oil. Each hit reminds you of a tropical vacation while your body reaps the benefits of CBD derived from hemp. Organically produced and infused with natural flavors that make relieving pain, anxiety, and inflammation feel like a breeze.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/mHWAyIE5S7uYnEkZdnZt_Screen.2bShot.2b2017-07-19.2bat.2b12.45.51.2bPM.png', '982c93b9-5675-4a32-b0ec-f365f80171d5', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry CBD Cartridge', 'FlaxRx Strawberry CBD Cartridge contains 200mg of distillate hemp CBD oil. Utilizing CBD from organically grown hemp, these cartridges provide natural strawberry flavors with amazing relief for pain, anxiety, inflammation, and more.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/OR3JD572QNi55yJcMRlL_Screen.2bShot.2b2017-07-19.2bat.2b11.24.43.2bAM.png', '5f712d3e-03d1-4fc5-b318-0a075ef9b838', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Orange CBD Cartridge', 'FlaxRx Orange CBD Cartridge contains 200mg of distillate hemp CBD oil. Organic. Natural. Nonpsychoactive. Medicating with effective hemp CBD and amazing flavor has never been better. Derived from hemp and utilizing CBD to provide medical relief without the "high" feeling typically associated with cannabis.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RgbBUpruT5uLCwlRn9pm_Screen.2bShot.2b2017-07-19.2bat.2b11.39.17.2bAM.png', '8471ae59-097c-4414-9e5a-b5c9b3c89ea9', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pear CBD Cartridge', 'FlaxRx Pear CBD Cartridge contains 200mg of distillate hemp CBD oil. Made with organically grown hemp and distilled into effective cannabis distillate that helps alleviate pain, anxiety, inflammation and other ailments without the psychoactive head high of THC. When youre looking for discrete and flavorful relief, turn to Pear CBD cartridge.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/oW6tu5gJQhepHRRnrJpe_Screen.2bShot.2b2017-07-19.2bat.2b12.21.58.2bPM.png', '4e119218-f26c-4bed-aaa7-77a3d09bd335', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pear Herer Disposable Vape Pen', 'Looking for a quick, discreet way to medicate? FlavRx Pear Herer Premium Disposable Vape Pen is the easy, inconspicuous way to self-medicate. Perfect CO2 500mg extracted cannabis oil is simple for controllable dosing. Comes Pear Herer strain specific and effective medication.

Up tp 15- hits

500mg

CO2 Extracted SOLVENT-FREE process.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AnX2QsmWTUmtWtw2SqQ5_Screen.2bShot.2b2017-07-26.2bat.2b4.06.36.2bPM.png', '7f3a5ae9-3d64-4802-b773-1f1a29adf61d', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Orange CBD Cartridge', 'FlaxRx Orange CBD Cartridge contains 200mg of distillate hemp CBD oil. Organic. Natural. Nonpsychoactive. Medicating with effective hemp CBD and amazing flavor has never been better. Derived from hemp and utilizing CBD to provide medical relief without the "high" feeling typically associated with cannabis.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RgbBUpruT5uLCwlRn9pm_Screen.2bShot.2b2017-07-19.2bat.2b11.39.17.2bAM.png', '79686ddb-e6a8-49c5-bc4f-afae77447531', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pear CBD Cartridge', 'FlaxRx Pear CBD Cartridge contains 200mg of distillate hemp CBD oil. Made with organically grown hemp and distilled into effective cannabis distillate that helps alleviate pain, anxiety, inflammation and other ailments without the psychoactive head high of THC. When youre looking for discrete and flavorful relief, turn to Pear CBD cartridge.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/oW6tu5gJQhepHRRnrJpe_Screen.2bShot.2b2017-07-19.2bat.2b12.21.58.2bPM.png', '5d6cc179-586d-4151-ad6c-8f4aefcbdb62', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pear Herer Disposable Vape Pen', 'Looking for a quick, discreet way to medicate? FlavRx Pear Herer Premium Disposable Vape Pen is the easy, inconspicuous way to self-medicate. Perfect CO2 500mg extracted cannabis oil is simple for controllable dosing. Comes Pear Herer strain specific and effective medication.

Up tp 15- hits

500mg

CO2 Extracted SOLVENT-FREE process.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AnX2QsmWTUmtWtw2SqQ5_Screen.2bShot.2b2017-07-26.2bat.2b4.06.36.2bPM.png', 'b38cdf5e-f768-4ed0-a473-ac653971d156', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Creamsicle CBD Cartridge', 'FlaxRx Creamsicle CBD Cartridge contains 200mg of distillate hemp CBD oil. Each cartridge contains organically made cannabis distillate oil derived from hemp. Utilizing CBD, a nonpsychoactive cannabinoid that doesnt provide the head high of THC, but helps alleviate pain, anxiety, inflammation, and other medical needs. Infused with natural creamsicle flavors to give a delightful touch to your medicating experience.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/hUXhMCWhTAWpLDAbvgnp_Screen.2bShot.2b2017-07-26.2bat.2b2.54.46.2bPM.png', '72277fd2-c69d-4940-a0a2-005aba21896b', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Premium Disposable Joint', 'For patients looking for a quick, easy and inconspicuous way to self-medicate, FlavRx CBD Premium Disposable Joint is the perfect choice! With its slender and sly design containing 300mg+ of CO2 extracted pure cannabis oil for simple and controllable dosing. This CBD/ THC provides medical relief with a slight psychoactive head high.
Grab FlavRxs Disposable Joint and take a hit of relief today.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Wumj8UkKQouqY1yC645m_Screen.2bShot.2b2017-07-26.2bat.2b3.23.11.2bPM.png', '8e1a45ff-99b7-485b-b81c-2815509ff843', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Charlottes Web CBD Disposable Pen', 'For patients looking for a quick, easy and inconspicuous way to self-medicate, FlavRx CBD Premium Disposable Joint is the perfect choice! With its slender and sly design containing 500mg of CO2 extracted pure cannabis oil for simple and controllable dosing. This CBD/ THC provides medical relief with a slight psychoactive head high.
Grab FlavRxs Disposable Joint and take a hit of relief today.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/t1cHFhkxQNGx1sRgGSPZ_Screen.2bShot.2b2017-07-26.2bat.2b3.45.58.2bPM.png', 'e336cf7f-37ee-411b-a104-89d46d288fa0', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Dream Cartridge', 'Blue Dream is a Sativa-Dominant Hybrid bred from Blueberry Indica and Sativa Haze. Blue Dream produces a sweet berry aroma and tastes like a tub of fresh, lush blueberries, with hazy, acidic undertones.

Medicinal: Blue Dream delivers swift symptom-relief, without heavy sedative effects. This makes Blue Dream a popular daytime medicine for patients treating pain relief, anxiety, depression, nausea, arthritis, glaucoma, stress and migraine headaches.

FlavRX Cartridge available in 0.5 gram and 1 gram', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/z6EIGLyMSWL6YuNU43Bw_Screen.2bShot.2b2017-07-26.2bat.2b3.58.44.2bPM.png', '65b0ed7a-c990-4ad8-adcf-5fad211b175c', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bubblegum CBD Cartridge', 'FlaxRx Bubblegum CBD Cartridge contains 200mg of distillate hemp CBD oil. Nothing compares to the sweet and flavor of bubblegum with the amazing benefits of CBD. Derived from organically grown hemp, these distillate cartridges help alleviate pain, anxiety, inflammation, and other ailments.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gC0NNgrMSbKPsqKJLPg5_Screen.2bShot.2b2017-07-19.2bat.2b11.17.38.2bAM.png', '5bc72e76-d5d4-4667-a077-8be843c69aa2', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Banana CBD Cartridge', 'FlaxRx Banana CBD Cartridge contains 200mg of distillate hemp CBD oil. When you need relief, but dont want to sacrifice flavor and efficiency, nothing beats these cartridges, containing CBD derived from hemp. Organically produced and infused with natural banana flavors, each medicating experience provides flavor and relief from pain, anxiety, inflammation, and other ailments.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zSgr77myQ8u1vVaNPYvd_Screen.2bShot.2b2017-07-26.2bat.2b2.37.02.2bPM.png', '2fd14c4f-0134-48f6-8e67-7a7c6de99b57', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blackberry CBD Cartridge', 'FlaxRx Blackberry CBD Cartridge contains 200mg of distillate hemp CBD oil. Derived from organic hemp, FlavRx utilizes CBD to provide patients effective pain relief, anti-anxiety, and other medical benefits without the psychoactive head highs associated with THC.Infused with natural blackberry flavors that make medicating a delicious, fruity experience.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1qqpdtXTIaXYRP3f4f61_Screen.2bShot.2b2017-07-26.2bat.2b2.50.55.2bPM.png', '2a235dcf-6930-4300-9f0f-3c4857794217', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blueberry Kush Cartridge', 'The sweet aromas of Blueberry Kush by FlavRX make its matching flavor and Indica effects all the sweeter. Crossed from OG Kush and Blueberry, this nighttime cartridge offers a heavy body stone coupled with complete relief from pain.FlavRXs Blueberry Kush cartridges is available in both 0.5 and 1 gram sizes.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/FXwVHqoTOwMAU1vSHBjg_Screen.2bShot.2b2017-07-12.2bat.2b3.19.09.2bPM.png', '56ca9dc8-7029-42b8-bcaf-72b8cefb0ed6', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blueberry Kush Disposable Vape Pen', 'Looking for a quick, discreet way to medicate? Flavs Blueberry Kush Premium Disposable Vape Pen is the easy, inconspicuous way to self-medicate. Perfect CO2 500mg extracted cannabis oil is simple for controllable dosing. Comes Blueberry Kush strain specific and effective medication.

Up tp 15- hits

500mg

CO2 Extracted SOLVENT-FREE process.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Mb7Za9oFSmE7PHgsmzGD_Screen.2bShot.2b2017-07-26.2bat.2b4.06.36.2bPM.png', '15e51fb6-2e1f-4a0d-b078-8c7e2d2b0863', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lemon Haze Cartridge', 'Lemon Haze is a Sativa-Dominant Hybrid of Lemon Skunk and Super Silver Haze. Super Lemon Haze smell is a trifecta combination of zest, citrus, and a lingering sweetness. As for the taste, its tart and sweet - not quite as sharp as one might expect. The effects are uniquely energetic and lively, may not be the best strain for those that are naturally wound-up tight.

Medicinal: It is a great wake-and-bake strain because of the increased focus and energy levels that come from the Sativa-Dominant THC. It may benefit those who suffer from depression, bipolar disorder, fatigue, or ADHD.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/0ezfWeZ4QOCqOOSWTqXj_Screen.2bShot.2b2017-07-19.2bat.2b11.02.58.2bAM.png', 'b6a1c5c7-917c-450c-b877-5efa6adee719', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blueberry CBD Cartridge', 'FlaxRx Blueberry CBD Cartridge contains 200mg of distillate hemp CBD oil. Made with all organic ingredients and infused with natural blueberry flavors, FlavRx CBD cartridges are perfect for patients looking to medicate without the psychoactive head high associated with THC. Helps alleviate pain, anxiety, and inflammation, along with providing relaxation and balance.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dGdU06uuSWi4FjlNxUC5_Screen.2bShot.2b2017-07-26.2bat.2b3.05.56.2bPM.png', '5f9d5bd7-2447-434d-a01d-24eba787d98a', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Blackberry, 180mg', 'FlavRx‘ delicious Blackberry flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with chocolate, toffee pieces, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Qymax1zhQ8O7IGvtxdVY_Screen.2bShot.2b2017-10-17.2bat.2b2.23.55.2bPM.png', '46ed1698-2198-4d57-bf2f-e3e3b6fd0da1', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Blueberry, 180mg', 'FlavRx‘ delicious Toffee flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with chocolate, toffee pieces, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8Y9Pfk6SoGjoS4U7Rne2_Screen.2bShot.2b2017-10-17.2bat.2b2.29.34.2bPM.png', 'c929326e-d212-44fe-9b44-e1bc59388eea', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Lemon, 180mg', 'FlavRx‘ delicious Lemon flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with white chocolate, tart lemon flavoring, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fXG7DdpTsWdsrKJ92NSg_Screen.2bShot.2b2017-10-17.2bat.2b2.38.18.2bPM.png', '3f688c66-f679-4d51-b970-3d8d998923cf', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Lemon CBD, 180mg', 'FlavRx‘ delicious Lemon flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 5mg+ of THC and 5mg+ of CBD a piece for easy, controllable dosing. Made with white chocolate, tart lemon flavoring, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Wkpxt369Tzqr1q637MPW_Screen.2bShot.2b2017-10-17.2bat.2b1.41.47.2bPM.png', '1918c5b9-a1ec-438a-9f83-1e8c1c93779f', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Mint Cookie, 180mg', 'FlavRx‘ delicious Mint Cookie flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with chocolate, mint cookie crumb, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/czgD5RxMQCW5BdlTU2ap_Screen.2bShot.2b2017-10-17.2bat.2b3.29.13.2bPM.png', 'a46c74d1-69b8-4020-8b10-af24cfc60d4d', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Mint Cookie CBD, 180mg', 'FlavRx‘ delicious Mint Cookie flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 5mg+ of THC and 5mg+ of CBD a piece for easy, controllable dosing. Made with chocolate, mint cookie crumb, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/O4hJLyU0ThqSmnRNuSQp_Screen.2bShot.2b2017-10-17.2bat.2b1.32.12.2bPM.png', 'b287905d-4afe-4f8b-8493-c4eac081214b', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Sea Salt, 180mg', 'FlavRx‘ delicious Sea Salt flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with chocolate, Fleur De Sel, Edible Silver, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CJKAm8nqRUqxU1yIeaRM_Screen.2bShot.2b2017-10-17.2bat.2b3.18.50.2bPM.png', '2831d3aa-afc8-477b-92a7-b57583223dc5', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Sea Salt CBD, 180mg', 'FlavRx‘ delicious Sea Salt flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 5mg+ of THC and 5mg+ of CBD a piece for easy, controllable dosing. Made with chocolate, Fleur De Sel, Edible Silver, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RBlDkgBTRySorBRpbaLY_Screen.2bShot.2b2017-10-17.2bat.2b2.10.58.2bPM.png', 'ce29753b-6f46-43f1-a5ac-89a05f749641', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Toffee, 180mg', 'FlavRx‘ delicious Toffee flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with chocolate, toffee pieces, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1mCLU265RfG62ORTrhN5_Screen.2bShot.2b2017-10-17.2bat.2b3.25.36.2bPM.png', 'bff5a279-b4b3-453b-8c02-6534a118d13c', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bars Toffee CBD, 180mg', 'FlavRx‘ delicious Toffee flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 5mg+ of THC and 5mg+ of CBD a piece for easy, controllable dosing. Made with chocolate, toffee pieces, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rAQR9wiTRJaEKTaCyNom_Screen.2bShot.2b2017-10-17.2bat.2b1.16.17.2bPM.png', 'efe24116-e456-49ab-81bd-2c15f82d2e3f', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bar Tangerine, 180mg', 'FlavRx‘ delicious Tangerine flavored chocolate bars bring you the ability to medicate while still giving your taste buds the rich flavor they crave. Comes in 18 pieces, each at 10mg+ of THC a piece for easy, controllable dosing. Made with chocolate, toffee pieces, cocoa butter, and cannabis oil this is another in FlavRx‘ long line of heavenly treats.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/GRDsebXR2GVJeCAyEAtQ_Screen.2bShot.2b2017-10-17.2bat.2b2.14.17.2bPM.png', '8f69e927-b0e3-40bf-b99f-808ebf0ca595', 'ccfe4fcf-72d5-42e2-94e3-645bac549234', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GNUG Strain Specific Shatter', 'The purest form of dabbing enjoyment. With its unrivaled potency and terpene profile G NUGS Shatter will not disappoint. Available in 0.5g cases.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IXfgBxvUTf25hUvyl3vZ_G-NUGS-Shatter.jpg', 'abb61108-c5b5-42bc-b072-fd4f70a5d5b7', 'bb1d7f02-fee7-4d0c-b3ac-b51d6559edf8', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Liquid Gold Cherry Cordials', 'Indulge with Liquid Gold™ chocolate-covered cherries— delicious, liquid-filled treats available in decadent milk and dark chocolate. These treats are infused with 25mg of cannabis oil for a sweet relaxing time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ZSeyHDzBSq2DtzBdpC3z_Screenshot.2b2017-04-17.2b17.40.41.png', '27b9bf34-1031-4255-a905-9585940a2991', 'bb1d7f02-fee7-4d0c-b3ac-b51d6559edf8', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Liquid Gold Chocolate Bars', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AxTO2tyeSPKjZVsivPhy_liquid-gold-cannabis-bars-milk-chocolate.jpg', '7b78b5b2-d075-4c8f-8b68-c30f8e2ba47f', 'bb1d7f02-fee7-4d0c-b3ac-b51d6559edf8', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Salted Caramel - Delta Chocolate', 'Each of our bars combines rich, smooth gourmet chocolate with 240mg of pure cannabis to deliver a sensation like no other. Each bar has preÂ­portioned sections by 60mg which gives you a consistent dosage. Choose your favorite flavor and melt away with a treat as powerful as it is delicious.

For edible dosage, we suggest taking it slow, most edibles take 2 hours to fully hit your system. Remember you can always eat more, you never can eat less.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/PkpnuTppRQGLW1PdIyDC_choc_SC_new.png', '42ded46d-ec27-4b7e-971c-ecc153acfb01', '560dc886-4ada-456f-a6b4-32ae1f1de146', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Salted Caramel - Delta Chocolate', 'Each of our bars combines rich, smooth gourmet chocolate with 240mg of pure cannabis to deliver a sensation like no other. Each bar has preÂ­portioned sections by 60mg which gives you a consistent dosage. Choose your favorite flavor and melt away with a treat as powerful as it is delicious.

For edible dosage, we suggest taking it slow, most edibles take 2 hours to fully hit your system. Remember you can always eat more, you never can eat less.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/PkpnuTppRQGLW1PdIyDC_choc_SC_new.png', '33ebf9c4-300e-42f8-b8bd-88136c20e0e6', '560dc886-4ada-456f-a6b4-32ae1f1de146', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1:1 CBD Vape Cartridge', '1:1 CBD Whole Plant Cannabis Extract Vape Cartridge
Fast-acting, smoke free and easy to use relief.
500mg cartridges.
Ingredients: 100% Cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ScoWTXMOQ3OQeMOIM5Zb_cbd-cartridges-1-1-web_32081393105_o.jpg', 'f31d1d97-5dfc-40ec-b168-3e798e3a5731', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('2:1 CBD Vape Cartridge', '2:1 CBD Whole Plant Cannabis Extract Vape Cartridge
Fast-acting, smoke free and easy to use relief.
500mg cartridges.
Ingredients: 100% Cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rNTu4RLrQmW4dbyLMj66_cbd-cartridges2-1-web_31270909403_o.jpg', '88970c1d-0883-45d9-a5d8-ae047d576025', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('4:1 CBD Vape Cartridge', '4:1 CBD Whole Plant Cannabis Extract Vape Cartridge
Fast-acting, smoke free and easy to use relief.
500mg cartridges.
Ingredients: 100% Cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6Sj8h72Q1e1ef1BCxQn7_cbd-cartridges-4-1-web_31270909743_o.jpg', '137b3f4f-aed2-40d2-ba67-84976cc82621', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('8:1 CBD Vape Cartridge', '8:1 CBD Whole Plant Cannabis Extract Vape Cartridge
Fast-acting, smoke free and easy to use relief. 500mg cartridges.
Ingredients: 100% Cannabis oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5oAoFwmETmyPfkuIYc9t_cbd-cartridges-8-1-web_32081392915_o.jpg', '693debc8-6d5a-4f93-8b69-1b573401a3b2', '344dc3bb-a3fe-4290-8269-a7ef5bdfcdfd', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Soak: Amber Moon', 'Soak your body in our pharmacological grade Epsom salts coupled with cannabis, nourishing carrier oils, and therapeutic grade essential oils for a full body, non-intoxicating effect. Enjoy our signature Amber Moon fragrance.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Soak-AmberMoon-TW.jpg', '6bf99970-081b-4f32-99f4-76627ba89a52', '4095902f-89c6-4f26-b666-01474c00b690', 'topical', 'bath soak');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Soak: Lavender', 'Soak your body in our pharmacological grade Epsom salts coupled with cannabis, nourishing carrier oils, and therapeutic grade essential oils for a full body, non-intoxicating effect. Enjoy our relaxing Lavender fragrance.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Soak-Lavender-TW.jpg', '411a2858-f7f8-486b-a3b9-da94f166d2fd', '4095902f-89c6-4f26-b666-01474c00b690', 'topical', 'bath soak');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Soak: Unscented', 'Soak your body in our pharmacological grade Epsom salts coupled with cannabis, nourishing carrier oils, and therapeutic grade essential oils for a full body, non-intoxicating effect. Enjoy our unscented fragrance for those with skin imbalances/ sensitivities.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Soak-Unscented-TW.jpg', 'f1586c43-25fc-47b9-8fee-876ebc759af7', '4095902f-89c6-4f26-b666-01474c00b690', 'topical', 'bath soak');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Rub: Amber Moon (2 oz.)', 'Rub our multi-herbal salve all over your abdomen, back, neck, legs, sore muscles, arthritic joints, and anywhere else you have pain or inflammation. Specifically formulated with a blend of analgesic and antispasmodic healing herbs, the thoughtful synergy of ingredients is what makes our balm so unique and effective. Enjoy our signature Amber Moon fragrance.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Rub%2B2%2Boz.-TW.jpg', '24f3f0d4-7c62-47c2-a8af-504478fdabb0', '4095902f-89c6-4f26-b666-01474c00b690', 'topical', 'balm');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Rub: Unscented (2 oz.)', 'Rub our multi-herbal salve all over your abdomen, back, neck, legs, sore muscles, arthritic joints, and anywhere else you have pain or inflammation. Specifically formulated with a blend of analgesic and antispasmodic healing herbs, the thoughtful synergy of ingredients is what makes our balm so unique and effective.  Enjoy our unscented fragrance for those with skin imbalances/ sensitivities.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Rub%2B2%2Boz.-TW.jpg', 'cd28bee5-91e8-447b-82d2-31302715fe3d', '4095902f-89c6-4f26-b666-01474c00b690', 'topical', 'balm');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pure BHO Wax', 'All BHO products come from top shelf indoor or greenhouse flowers, dewaxed during extraction, and purged for 96+ hours. Pure BHO premium products usually test at below 10ppm residual solvents and over 80% THCa. Fresh resin takes it one step further by running indoor, uncured, just-dried whole flowers - maximizing color, taste, and potency for the ultimate experience.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/axSAXyRuRXyFZcrsk0Sq_Shatter.2b-.2bGold.JPG', '640d1ccc-a827-4d48-bee8-54384009ec04', '7a592902-2f45-4b5c-a41a-4fb9db6925ea', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Caramels (Bullion)', 'Our rich and creamy caramels contain a manageable 20mg dose of THC. Each unit is individually wrapped for your convenience. Our edibles are medicated with kief-infused coconut oil and/or butter for a stronger effect.  Bullion are available in single 20mg or 8-piece (160mg) packagings.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/EKq2YILGTnaT1sLtHmL7_IMG_0003.JPG', 'd5a501ee-4b5c-476b-b7df-adc5ef8e7010', '7a592902-2f45-4b5c-a41a-4fb9db6925ea', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Puffins', 'The campfire classic has been reborn here at the Herbsmiths kitchen. Each Smore puff consists of a medicated marshmallow sandwiched onto a graham cookie, then dipped in chocolate once more.  Our edibles are medicated with kief-infused coconut oil and/or butter for a stronger effect.  Puffins are available in single 40mg or 4-pack (160mg) units.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/pX5aDOteTU2H8CIICCgx_puffin.jpg', '81b39994-0828-4867-93fe-5f9afd606e13', '7a592902-2f45-4b5c-a41a-4fb9db6925ea', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jewels', 'Belgian semi-sweet chocolate filled with a creamy delicate roasted peanut truffle mousse.  Our edibles are medicated with kief-infused coconut oil and/or butter for a stronger effect.  Jewels are available in single 40mg or 4-pack (160mg) units, generally as Hybrid (OG Kush) or Indica (Master OG, Bubba Kush) strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nFoB7Y7BRiyYL4JKSD7m_jewels.jpg', '05b37153-3a9a-402d-9a6a-4baa99672e61', '7a592902-2f45-4b5c-a41a-4fb9db6925ea', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crowns', 'Belgian semi-sweet chocolate filled with caramel and candied almonds inside and atop.  Our edibles are medicated with kief-infused coconut oil and/or butter for a stronger effect.  Crowns are available in single 30mg or 4-pack (120mg) units, generally as hybrid strains (Sour OG, OG Kush, Blue Dream)', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/lZBREYWiSL2GFz2iNrhL_crown.jpg', '19a3bea8-acbc-4050-8467-f887393e10f7', '7a592902-2f45-4b5c-a41a-4fb9db6925ea', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - ANIMAL COOKIES', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wW2ocOi8TS6D0mkM2eeZ_PR.2bCARTS.png', '951c71ed-ba8b-465d-929f-23efcb176319', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - BLUEBERRY DIESEL', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kfSQtAQ5SW2yXrEPmOp0_PR.2bCARTS.png', '6f33b6e7-4478-419d-b646-f6531eb9be94', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - BLUEBERRY KUSH', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/yPzy6WG9TmeKsNMl7zVF_PR.2bCARTS.png', '723ec544-0663-4086-9776-5004ec4381a9', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - FRUITY DREAM', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Po332lERSqnwY0wRKKWr_PR.2bCARTS.png', '80b66701-2a12-4cde-a4d2-8cf9dcd4f865', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - ANIMAL COOKIES', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wW2ocOi8TS6D0mkM2eeZ_PR.2bCARTS.png', '1a2756b9-0935-4c24-a497-309c4964e825', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - BLUEBERRY DIESEL', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kfSQtAQ5SW2yXrEPmOp0_PR.2bCARTS.png', '45821d91-e838-4d0a-be90-b42604e34606', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - BLUEBERRY KUSH', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/yPzy6WG9TmeKsNMl7zVF_PR.2bCARTS.png', 'c57e0249-910d-4b89-9289-2895b2587006', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PR CARTS - FRUITY DREAM', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Po332lERSqnwY0wRKKWr_PR.2bCARTS.png', '1dd795bb-4824-46b9-aed9-42563a26e149', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - KING LOUIE XIII (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/BvShRQUBQhKVawln91uS_THC.2bCArt.png', '4ab1def1-04b0-470c-9afc-3bbd0dbef2c5', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - LEMON HAZE (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Ei7RqsTT7udD4v69plhc_THC.2bCArt.png', '015926c6-cad8-4206-bbd1-8d5782de207a', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - MASTER YODA OG (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/D22Y1hZNQIWi2mqwpXVt_THC.2bCArt.png', 'b834bc79-de7a-4773-837f-953cf705ea73', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - ORANGE SORBET (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4nKqkVYR8aBoIbQcKS4Q_THC.2bCArt.png', 'bae849f1-199d-451f-ad8c-2e2b8233af17', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - PABLO ESCOBAR OG (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CALlzkd2TzakdPa6hq8X_THC.2bCArt.png', '26cfb8ae-d3f3-4a3b-9172-830d9433ca6f', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - PARIS OG (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kuQolAOpRCEa4ZD901Sh_THC.2bCArt.png', '4a627bfb-7638-4c08-b71d-6989efb512d6', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - PINEAPPLE EXPRESS (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ydnQACyRGaY5MCjESOYN_THC.2bCArt.png', '68c3f4fc-907e-4ead-9bb1-c3a9ae6c320b', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - PRESIDENTIAL OG (,5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/eCd2vjpFT7ysp7MGHYwG_THC.2bCArt.png', 'bfb73044-e1ed-49c7-9fbe-5d3688056e40', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - PURE CBD', 'CARTRIDGES - PURE CBD', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ySySbCkQSg65kazidKle_PURE.2bCBD.png', 'e1acaf10-b1e6-4cc6-9f8b-eb1de86aa4e1', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - SKYWALKER OG (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2xgF4SMSCW8YXBPw0fEj_THC.2bCArt.png', '02f12e6c-fc01-467a-a7af-ca9f1b38f083', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - SOUR DIESEL (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Rde84oXqQjCwfKom0bUr_THC.2bCArt.png', 'e419add3-1426-4d36-a0ba-74ba9080df92', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - STRAWBERRY GLUE (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/3Vba4gJSS7OHn9JeYNs9_THC.2bCArt.png', 'ed3d355c-0132-4e16-88ff-2c8c5ebd3bf7', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - TANGIE (.5/1 GRAM)', 'Interchangeable potent distillate cartridges with an amazing pull.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/q1DyGapuQ5mNUk3MANCT_THC.2bCArt.png', 'c434fc71-75f5-4ccc-9f4f-41c365796391', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CEREAL BAR - CRUNCHY CAPS 500 MG', 'Infused milk & cereal bar made with THClear solventless distillate for a high potency edible with great taste.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ebdNvEszTpmonpnNSxDk_THC-CEREAL-CRUNCH.png', 'b40e47c1-5439-441f-88c8-38382998025f', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CEREAL BAR - CRUNCHY TOAST 500 MG', 'CEREAL BAR - CRUNCHY TOAST 500 MG', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/eCypbxulTc6qB5I3e9EJ_THC.2bCrunchy.2btoast.jpg', '2d4b75a7-df14-4913-8512-f5616baa8535', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CEREAL BAR - FRUIT KRISPIES 500 MG', 'CEREAL BAR - FRUIT KRISPIES 500 MG', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/23zBgU3SC6OSe52Xid4e_THC.2bFruit.2bKrispies.2b.jpg', 'd18e46e1-ffa5-49a4-9c7d-dc0a68ae62f0', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CEREAL BAR - LOOP FRUITS 500 MG', 'CEREAL BAR - LOOP FRUITS 500 MG', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/jJ5IngfXRKGTTTWfCHr6_THC.2bLoop.2bFruits.jpg', '32c1e745-20c0-40da-9288-3cdcb3d880af', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CEREAL BAR - OG KRISPIES 500 MG', 'Infused milk & cereal bar made with THClear solventless distillate for a high potency edible with great taste.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/0JK79Q2T8aybiAzoS94g_THC.2bKrispies.png', 'b8c37e22-245a-44a8-b819-b6e859e093d4', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal - Crunchy Caps 400mg', 'Ingredients: Marshmallows, cereal, clear distillate, and coconut oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WlqNvCBlQDytOHt9v6d4_THClear-CEREAL-CRUNCHYCAPS.png', '72225a74-cfbd-413d-aba9-ee43ab7054dc', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal - Crunchy Toast 400mg', 'Ingredients: cereal, milk powder, marshmallow, clear distillate, and coconut oil.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aYDD8BkQFSKNHzIylA1E_THClear-CEREAL-CRUNCHYTOAST.png', '78cf883a-cc18-4c9b-8e12-15e566dc2380', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal - Loop Fruits 400mg', 'Tasty cereal infused with 400mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ygF2i7BfQA2hFl3thql0_THClear-CEREAL-LOOPFRUITS.png', '27778f93-d829-4850-92a5-88ccf14a9850', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crunchy Caps Cereal (400mg)', 'Crunchy Caps Cereal (400mg)', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/PJVPxft4SvgOWncgmXlp_Crunchy.2bCaps.png', 'd748d875-fb1c-4160-9117-5ecc74833007', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crunchy Toast Cereal (400mg)', 'Crunchy Toast Cereal (400mg)', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/iV9PDWKaS8Kt2hw1QBTq_Crunchy.2bToast.png', '1dfaa558-4aab-4791-b487-a2a9f27341e8', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Loop Fruits Cereal (400mg)', 'Loop Fruits Cereal (400mg)', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/s4Ku70P1REazOcs8kCmi_THClear-CEREAL-LOOPFRUITS.png', 'c2a9f939-e5e6-463b-af22-d54f2cde4061', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Blueberry 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8f34rdUS0a1CQVTkw3w6_THCLEAR-SOURBELTS-BLUERAS.png', '014055bd-3cd2-4341-a97e-1071dda7aa00', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Sour Apple 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8gz5Rn0nSOuwwVw3pCdd_THCLEAR-SOURBELTS-GRNAP.png', '99691074-5218-4a86-b2dd-6bf3b0e5f97a', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Strawberry 300 mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/no632izsSaCvIXlRyxlI_THCLEAR-SOURBELTS-VERYSTRWB.png', 'dfafe2ce-c838-4960-b509-23a1f151d6c9', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Watermelon 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HVugQGyR8KMHZocpAFdQ_THCLEAR-SOURBELTS-WTRMLN.png', '187dd138-b510-4950-89a1-574f05149ec0', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Wild Cherry 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/R0rD0qbuQLqD5fgtE5BY_THCLEAR-SOURBELTS-CHERRY.png', '920b001b-c6dc-44fb-95f7-363817cd70f6', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Blueberry 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8f34rdUS0a1CQVTkw3w6_THCLEAR-SOURBELTS-BLUERAS.png', 'cdf47be0-334f-4cb8-8f65-8c35c4851a41', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Sour Apple 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8gz5Rn0nSOuwwVw3pCdd_THCLEAR-SOURBELTS-GRNAP.png', '483a3b79-8e9d-4beb-b645-6969bb042b4b', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Strawberry 300 mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/no632izsSaCvIXlRyxlI_THCLEAR-SOURBELTS-VERYSTRWB.png', 'ea782337-1bd1-4e6c-b02b-6b66676204c6', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Watermelon 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HVugQGyR8KMHZocpAFdQ_THCLEAR-SOURBELTS-WTRMLN.png', '0c2dac98-d5ea-4032-87ec-e159ff4d2555', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Wild Cherry 300mg', 'Delicious sour belts infused with clear distillate.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/R0rD0qbuQLqD5fgtE5BY_THCLEAR-SOURBELTS-CHERRY.png', 'fde25c1b-15e7-4829-bd16-d7c003063eef', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Gummies - Blueberry', 'Delicious real fruit flavor. Gummies come in 150 or 250 mg THC. Non-gmo, non dairy, gluten free, and peanut free.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Lvgd0BhTQJDSb2CkLntq_THCLEAR-GUMMI-BLUEB-150.png', '67f6e908-1e03-45fa-beff-31d8fcdfe068', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Gummies - Mango', 'Delicious real fruit flavor. Gummies come in 150 or 250 mg THC. Non-gmo, non dairy, gluten free, and peanut free.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/k6RWq2DcROeHZjt5InkE_THCLEAR-GUMMI-MANGO-150.png', 'd44b99a2-9bc2-4bc6-9600-f6aa7025eb4a', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Gummies - Pineapple', 'Delicious real fruit flavor. Gummies come in 150 or 250 mg THC. Non-gmo, non dairy, gluten free, and peanut free.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/I1cLm0QSToG03DmYMtc9_THCLEAR-GUMMI-PINEAPPLE-150.png', 'a945e4e8-f31b-4794-8c00-468ed317170a', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Gummies - Strawberry', 'Delicious real fruit flavor. Gummies come in 150 or 250 mg THC. Non-gmo, non dairy, gluten free, and peanut free.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/G5ivBH3SMuzs7qZAYvJ9_THCLEAR-GUMMI-STRAWB-150.png', '19ccfb9c-3aca-4660-9cf5-4dfa2fa5b804', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CLEAR BAR - CHOCOLATE MINT 500 MG', 'THCLEAR DISTILLATE INFUSED HIGHLY POTENT, HANDMADE ARTISAN CHOCOLATE BAR.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WmzTIFbkTZENcEuvWTKn_CLEARBAR-1.png', '67cb5be7-aa7a-4021-ade0-b450ea668d97', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CLEAR BAR - ORANGE BLOSSOM DARK CHOCOLATE 1000 MG', 'THCLEAR DISTILLATE INFUSED HIGHLY POTENT, HANDMADE ARTISAN CHOCOLATE BAR.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/jOslFvKwTGmgNtQFFXzw_CLEARBAR-8.png', 'af723634-0c52-40ec-95eb-4b748015f348', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CLEAR BAR - RASPBERRY DARK CHOCOLATE 250 MG', 'THCLEAR DISTILLATE INFUSED HIGHLY POTENT, HANDMADE ARTISAN CHOCOLATE BAR.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IhMq3aNaS2Koj3y2MEeQ_CLEARBAR-4.png', '37a7fd24-3e29-4f8e-8c66-47eb397b5566', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Brownies - 300mg', 'Premium infused chocolate brownies that are potent as they are delicious!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6Y0MpHbSPCcJfp82e4Qq_THC-BROWNIES.png', '077f2bbd-1ac6-4091-9abe-44709fc7a6f9', 'c51e906c-a2c7-4c29-9617-7304158ebbff', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bittersweet Dark Bon Bon', 'PRODUCT INFO
72% dark chocolate creates the ultimate treat for a classic chocolate lover. Pure, bittersweet dark chocolate is blended with milk and cream for the perfect velvety chocolate flavor.

INGREDIENTS
Bittersweet chocolate, cream, milk

ACTIVE INGREDIENTS
10mg THC / 25mg THC

ALLERGEN INFORMATION
Gluten-free', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/VhXE6293TkOupLzeYVPh_BonBon_Bitter_IN_2_700x500.png', '6e81a748-8899-40e5-a06a-1a519c1eab3d', 'a5290c13-6b25-4060-b42a-c8151be600ec', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bittersweet Dark Bon Bon', 'PRODUCT INFO
72% dark chocolate creates the ultimate treat for a classic chocolate lover. Pure, bittersweet dark chocolate is blended with milk and cream for the perfect velvety chocolate flavor.

INGREDIENTS
Bittersweet chocolate, cream, milk

ACTIVE INGREDIENTS
10mg THC / 25mg THC

ALLERGEN INFORMATION
Gluten-free', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/VhXE6293TkOupLzeYVPh_BonBon_Bitter_IN_2_700x500.png', '1cdb2b5c-d44b-4a30-81d6-30dc84c91fa3', 'a5290c13-6b25-4060-b42a-c8151be600ec', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Plum Frost', 'Plum Frost is a hybrid cultivar which was bred by Exotic Genetix as Extreme Cream and selected by The Genezen Project. The parents are Mom: Extreme OG and Father: Cookies and Cream. It is considered a 70/30 Indica dominant hybrid. The name Plum Frost was given do to the light purple coloring and extremely frosty look it produces. This particular cultivar was selected because of its relaxing effects and smooth smoke as well as the high thc content which has been lab tested in the 23-26% range. From this cultivar you can expect a smooth creamy flavor that sticks to your tongue on the inhale and a subtle semi-sweet earthy flavoring upon exhale. It produces a euphoric high that will leave you feeling happy and smiling. It has a relaxing and calming effect yet will not leave you "couch locked" and unable to perform daily tasks. This cultivar is considered good for increasing appetite, pain relief and will help with depression and anxiety.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TkAFUrIESb6O9CiOwbvW_IMG_20160915_212252.jpg', 'a267ab03-6ce2-4d3f-b4bd-b3be31c90230', '4a25225f-69c7-4b9f-94aa-c3c6f3356d92', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CO2 Nectar', 'Dewaxed, decarboxylated, ultra pure, and extremely high potency.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vqCRuB4ETBOFHHc1XbvH_waxman-co2.jpg', 'c2090487-36ab-4845-a2eb-b348e208e7ee', 'f485dabf-e394-4727-88ff-222bdc0a4629', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Starcluster Superfood Cookie', '(Nut-free & Vegan)
10mg CBD per cookie/50mg per box
Like clusters of bright stars in the sky, the Star Cluster Superfood Cookie boasts clusters of superfood seeds making it a powerfully nutrient-dense edible AND an amazing anti-inflammatory. Flax seeds alone are one of the highest magnesium foods in the world which help calm the nerves, muscles and blood vessels. Infused with a 10:1 ratio of CBD whole-plant cannabis to further promote benefits of pain and anxiety relief, we"™ve created the cleanest vegan recipe trustworthy from seed to table.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1xDMYlYQQByfR3EfZUc4_star.2bcluster.jpg', '01a661ce-a9d6-4741-88c2-014d685c09a7', '8a039435-604a-47bd-8463-045fe3532fba', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pumpkin Pecan Mini Space Cakes', '10mg THC per cookie/50mg per box
This is our best version of the seasonal fall & winter flavor packed with the all the health benefits of pumpkin. Additionally, our products are specifically formulated for those with major dietary restrictions and are processed in a gluten-free facility.

Allergens: Almonds, Pecan, Coconut, Eggs', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aKkXT7hMQXONbYEn46E8_pumkin.2bspace.2bcookies.jpg', '6598caf6-c8f4-476e-905e-1236e78c3442', '8a039435-604a-47bd-8463-045fe3532fba', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Trail Mix Super Nova Cookie', '10mg THC per cookie/50mg per box
Will remind you of the taste and texture of an oatmeal raisin cookie. It"™s our NUT-FREE option, rich in superfoods like chia seeds, hemp seeds, and sunflower seeds. It"™s a great addition to your breakfast or as a snack to help you power through the day. The award winning 1st Place Best Healthy Edible. Additionally, our products are specifically formulated for those with major dietary restrictions and are processed in a gluten-free facility.

Allergens: Coconut', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/W9kWk6TfRpia09vDkDWc_trail.2bmix.jpg', '29762c8f-33a0-4fac-8e34-6f68d1c1f794', '8a039435-604a-47bd-8463-045fe3532fba', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GG (f.k.a. Gorilla Glue)', 'This award-winning strain features chunky and super-resinous buds reflective of its name. What starts out as a sativa-focused buzz, slows down to a relaxing and potent body high. Pain is alleviated while the mind remains uplifted and creative.
THC: 19.42%
CBD: 0.0%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RBXwuWRQQtWuQCp6e5LJ_AA-.2bgorilla.2bglue.jpg', 'e55b2b91-ae2c-4359-be3b-8c941a40c0b7', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mr. Nice (5103)', 'Mr. Nice avoids some of the drowsy effect produced by most cuts, and brings more of the G13 sensory enhancement to the foreground.  It still smells dense like an Afghani, and tastes like sweet earth.  Patients who want powerful body relaxation with head enhancement will gravitate to this indica.
THC: 13.97%
CBD: 0.01%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/imhfd4NlTJC7R0YTzovU_AA-.2bmr.2bnice.jpg', '56a6a6bc-84de-495d-a0cd-5095492a931d', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('C4', 'This potent strain with a citrus and pine aroma offers a deep relaxing effect that combats depression. This is no plastic explosive, this is a warm cozy blanket of comfort for your brain.
THC: 20.56%
CBD: 0.05%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/avqmKj9rTGOExwMEqSrg_AA-.2bc4.jpg', 'c1cc7f54-b350-4472-bca5-9ec43eac2960', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('5 Star', 'This original blend has been in the making over the past 25 years to produce a fantastic balance of all the great qualities of the founding strains. The dynamic head and body high will cover all of your medicinal needs, particularly mood enhancement. Youve got to try this one out!
THC: 15.92%
CBD: 0.02%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nSclUlNRE6R4DSk45EOc_AA-.2b5.2bstar.jpg', '8f784b32-df5b-43ba-94fd-98ad29617898', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Remedy CBD (1301)', 'Remedy is what it sounds like, a solution to your inflammatory problems. This rich cannabidiol strain has less than 1% THC so you can medicate without any significant psychoactive effects. This is a good option for those suffering from neurological disorders and conditions including migraine headaches.

THC: 0.59%
CBD: 15.57%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/JnykMKlKQ9qJNKlTeOFT_AA-.2bremedy.jpg', 'e8a64300-db3a-486b-bd04-e477b112b106', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cherry Kush', 'Cherry flavored kush, how could you go wrong? For kush fans, here is a fruity treat providing all the benefits of your favorite kush including appetite enhancement, pain distraction, mood elevation, and sound sleep. Also known as cherry pie, this is a favorite for many.
THC: 19.94%
CBD: 0.03%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TVDTyHV1QdCOYwrzG8cv_AA-.2bcherry.2bkush.jpg', 'bbfa9dbd-3d1d-459e-8ce6-439c041db821', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Black Cherry Soda', 'This years harvest resulted in a bright green flower lacking the dark coloration in the original phenotype. This fantastic strain has a deep black cherry aroma with earthy undertones. This THC potent and terpene rich strain provides a kaleidoscope of effects that leave the patient feeling happy, content, and relaxed. Wash your worries away for a bit and heal with this fruity treat and you wont be disappointed.
THC: 23.9%
CBD: 0.05%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cVtx4lnQOGDIYrbl14XK_AA-.2bblack.2bcherry.2bsoda.jpg', 'd83db73b-af35-4430-8056-99ba6b4cd46c', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Knight', 'This rare indica dominant strain has a burst of rich flavor including earthy tones of blueberry, chocolate, and mint. The soothing wave of euphoria washes over you right after ingestion providing a dynamic range of symptom relief including pain distraction, appetite enhancement, mood elevation, and sleep assistance.
THC: 18.85%
CBD: 0.03%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/F772JYJfTKJDoroVUg3j_AA-.2bblue.2bknight.jpg', 'd2c3ac31-7c5c-4a73-9e47-af5b5262277e', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bulk Flowers', 'Our premium sungrown cannabis is grown using time tested natural cultivation techniques. Bulk Units are available, or save yourself some work by taking advantage of our pre-pack service and recieve your flowers already packaged for retail! High CBD strains also available.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/lZ0Ac5sxR1a64VIPMzhg_AA-.2btrinity.2bsnow.jpg', 'ce3f33fe-3acf-4e44-94b3-ea95da957b75', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GSC (f.k.a. Girl Scout Cookies) (5105)', 'At the highest level of daytime pain relief, this popular strain wont knock you out (well at least not most of you), but will take care of what ails you. Bred in California, this potent hybrid featuring twisting green leaves and bright orange tendrils, launches your brain into a euphoric space, and your body into total relaxation. Excellent for severe pain, nausea, and stimulating the appetite, GSC (f.k.a. Girl Scout Cookies) is true to its name: it lends a helping hand; brings on the munchies; and leaves you baked.
THC: 27.38%
CBD: 0.05%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YIuIWb6xQmCNuRlLLIGj_AA-.2bgirl.2bscout.jpg', 'c96557b9-f1c3-441d-af22-cfd50bd1d212', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer (5203)', 'The classic strain developed by Jack Herer himself helped identify the cerebral stimulation effect now commonly associated with sativas. This great day-time strain will keep you focused while stimulated.

THC: 19.9%
CBD: 0.04%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xeiq0hkHSzW9NTDnuBT8_AA-.2bjack.2bherer.jpg', '90d1a675-bb01-490c-a753-75141281466c', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Nitrogen sealed cans', '3.5 grams of specially selected flower, in an eco-friendly, nitrogen sealed can that keeps the flower as fresh as the day it was packed. Displacing the oxygen with nitrogen extends the shelf life, and each patient is ensured a consistent experience. Also available in High CBD strains, check out all available strains on our website!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wAdEbwXbSGSMfWGfSbyu_canned.jpg', '6a94be6b-586d-43ad-9ece-1273c1fff217', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OG 103', 'The classic "Ocean Grown" strain is often a favorite by many connoisseurs of medicinal cannabis. This strain offers an unmistakable dank citrus and fuel aroma and flavor with spectacular body and mind relief. You cant miss with this one.
THC: 17.39%
CBD: 0.02%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zcNWKsSMyOYYxd7OCswN_AA-.2bOG.2b103.jpg', 'ab462553-2ce5-405c-8f23-6f65eefbd70e', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Purple Panty Dropper', 'This Humboldt Seed Company strain has reported aphrodisiac qualities and produces a groovy uplifting high great for repelling depression, insomnia, and enhancing appetite. The flowers have a pungent fruity aroma and flavor with flowers varying from deep magenta to pale lavender and bright green.
THC: 19.63%
CBD: 0.04%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/iKprVzutTxyQEygJbYQZ_AA-.2bpurple.2bpanty.2bdropper.jpg', '5cb0d88a-9955-46c9-9a74-8cced763c69a', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('SFV Afgoo', 'Combining two potent indica hybrids results in the heavy sedative effects of both strains offering maximum pain relief, appetite enhancement, sleep assistance, and the giggles.

THC: 21.99%
CBD: 0.03%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Oa8TM2dRCerzWCPaLpIn_AA-.2bsfv.2bafgoo.jpg', '137c6923-8e06-4413-8286-5a8d7650b884', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('SFV OG', 'This piney-smelling strain helps one unwind while melting away pain and tension. Although not as potent as other kushes, the well-balanced indica body effects, and sativa energy that counteracts dreaded couch-lock, eventually mellow into restful repose.
THC: 22.91%
CBD: 0.06%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SohYMnISx2K4g6qleapi_AA-.2bsfv.2bOG.jpg', 'db468f8e-683c-47a4-918b-533db27a24bd', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Trinity Snow', 'This frosty sativa hybrid is a well balanced medicinal miracle, combing cerebral stimulation with a giddy body high that keeps a smile on your face. This great all around strain will keep you moving despite your symptoms.
THC: 20.91%
CBD: 0.04%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8bZYj2N0SmmGGv3nTAAM_AA-.2btrinity.2bsnow.jpg', 'cc91e871-f734-46a1-82a0-c1ad097e5276', '277436db-eebf-4421-9b71-8e1425aeba31', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Cartridge Banana', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4bM0rcSLy7jnzeIN3QJQ_TDC-BAN.2bCBD.jpg', '5e817f64-2566-4898-93f0-147ae02a641f', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cherry Almond Tart 2.5:1 ratio', 'A healthy twist on an old classic! Our tasty cherry-almond minis are dosed with 13mgCBD & 5mgTHC. This high CBD:THC ratio is designed to provide a very subtle head change, aimed at enhancing your everyday experiences through elevating your mood, and easing away any pain or anxiety. Superfood-filled, vegan, gluten-free, soy-free, refined sugar-free. Yes, great things do come in small packages.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/pBb1n6beT8evWHADPwNm_tartette.jpg', 'fd6ff4e0-f1c5-4085-a1b3-9db7be0e7071', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cherry Almond Tarts, 4pk, 2.5:1 ratio', 'A healthy twist on an old classic! Our tasty tarts come in a 4pk, with a total dosage of 50mg CBD and 20mg THC per package (thats 5mg of THC per tart). This high CBD:THC ratio is designed to provide a very subtle head change, aimed at enhancing your everyday experiences through elevating your mood, and easing away any pain or anxieties. Superfood-filled, vegan, gluten-free, soy-free, refined sugar-free. And yes, they taste amazing too!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zHFVTdjOQJmUTci1tPwN_DSC01354.jpg', '69531feb-ffee-4968-830e-abdad6d72741', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry Rose Tart, 1:1 ratio', 'Chia seed dough filled with mouth-watering fruit goodness. Our tasty strawberry-rose tarts are dosed with 10mgCBD & 10mgTHC. This one to one ratio of CBD:THC is designed to provide maximum pain relief for patients suffering from chronic pain.  Superfood-filled, vegan, gluten-free, soy-free, refined sugar-free. Yes, great things do come in small packages.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dVF8d63TSMqvZEb1nT0x_DSC01278.jpg', 'bb1b42d8-f1ab-434a-a4db-e2f9978625e3', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry Rose Tarts, 4pk, 1:1 ratio', 'A healthy twist on an old classic! Our tasty strawberry-rose tarts come in a 4pk, with a total dosage of 40mgCBD & 40mgTHC per package (thats 10mg of THC/ tart). This 1:1 ratio of CBD:THC is designed to provide maximum pain relief for patients suffering from chronic pain. Superfood-filled, vegan, gluten-free, soy-free, refined sugar-free. And yes, they taste amazing too!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/KFIDm0iJQlOtY6PNbxx7_DSC01356.jpg', 'f5b5ae64-5dc1-4cbb-bf39-c907b0d78934', 'aee8dba8-dbef-468c-a2a0-80bc8bcd6031', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chong''s Choice - Pre-Rolls', '- .75 Grams Each
- Individually Packaged For - Freshness
- 3.75 Grams Per Pack
- Premium Blend
- Portable And Convenient
- 5 Pre-Rolls Per Package', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/chong_s%2Bchoice%2Bcannabis%2Bhybrid.jpg', '86bbb807-c3cd-4b8d-b204-b045ca6e0853', 'dae661be-8751-4226-91d0-69a5624aa76b', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chong''s Choice - 1/8th Flower Jar', '- Hand Picked Choice Strains
- Lab Certified
- Collectable Jar
- Air Tight Seal For Freshness
- Locally Grown And Sourced', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/chong_s%2Bchoice%2Beighth%2Bflower%2Bjar.jpg', '8b8d9195-612f-4a4d-8a03-ef9eba7362c8', 'dae661be-8751-4226-91d0-69a5624aa76b', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chong''s Choice - Oil Cartridge', '- Solvent Free
- High Times Winner
- .5 Gram
- All Natural Blend
- Premium Cannabis Oil', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/chong_s%2Bchoice%2Boil%2Bcartridge.jpg', '8ac853e7-65c4-4a77-8f5f-51688d6efca2', 'dae661be-8751-4226-91d0-69a5624aa76b', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chong''s Choice - THC Strips', '- 40Mg Of Pure Thc
- Portable
- Discrete
- Fresh Minty Flavor
- Sealed Mylar Bag For Freshness', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/chong_s%2Bchoice%2Bthc%2Bstrip.jpg', '82a0b4a1-f96e-46cd-ae9f-6bec4bcf100d', 'dae661be-8751-4226-91d0-69a5624aa76b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('The Highest Grade " AC/DC" Cold Pressed Extract (CBD Rich)', 'Invigorating aromas of pine and menthol combine nicely with undertones of baking cocoa and earth. The high CBD content offers a super gentle euphoria, pain relief and strongly grounding and focused effect.

17:1 CBD 58.4% CBD, 3.8% THC

Give Me Piece Of Mind

Exceptionally crafted CO2 extracted oils, made with cold-press technology that preserves the highest level of full plant intelligence and terpene content on the market. We also love that all of their cartridges are made from metal and glass without any epoxies or glues, and that they employ a ceramic wick rather than fiberglass or cotton to ensure youre inhaling nothing but clean oil. Their cold pressed technology results in record breaking terpene content, and zero additives', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/mh6NmgqBRneqpUXOKpHd_THG-cartridge-1-510x510.jpg', '60fbb585-5ff0-4286-93cd-f32c6c5d5dfb', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('The Highest Grade "Alpine Crush" Cold Pressed Extract (Sativa)', 'Super yummy earthy tones of mint mate, chocolate and cacao, create a refreshing and cooling sensation with every puff. Enjoy this extract to get those energetic party vibes flowing.

43.8% THC | 22.3% Terpenes

Exceptionally crafted CO2 extracted oils, made with cold-press technology that preserves the highest level of full plant intelligence and terpene content on the market. We also love that all of their cartridges are made from metal and glass without any epoxies or glues, and that they employ a ceramic wick rather than fiberglass or cotton to ensure youre inhaling nothing but clean oil. Their cold pressed technology results in record breaking terpene content, and zero additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YzBwDNR9TLjLDez3HqTg_THG-cartridge-1-510x510.jpg', '02b9e059-5de2-401a-a0b2-3ca8f6982bae', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('The Highest Grade "Black Lime" Cold Pressed Extract (Sativa)', 'A bright, complex and flavorful extract highlighted with pine and citrus flavors that finishes with a sweet, piquant black pepper on the back palate. Great for socializing, mood elevation and focus.
Get Focused 55.8% |14.6% Terpenes

Exceptionally crafted CO2 extracted oils, made with cold-press technology that preserves the highest level of full plant intelligence and terpene content on the market. We also love that all of their cartridges are made from metal and glass without any epoxies or glues, and that they employ a ceramic wick rather than fiberglass or cotton to ensure youre inhaling nothing but clean oil. Their cold pressed technology results in record breaking terpene content, and zero additives', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CGKuQTriTwCoT44L1QOG_THG-cartridge-1-510x510.jpg', '1f61716e-aabc-4858-845f-441101d922ef', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('The Highest Grade "Northern Lights" Cold Pressed Extract (Indica)', 'This fabulous, heritage strain offers pungent sweet and spicy resin-soaked aromas that flow into bright citrus and fresh basil. The effect settling for mind and all over body relaxation so you can get your beach bunny vibes in.

69.5% THC | 10% Terpenes ($50) Take Me To The Beach

Exceptionally crafted CO2 extracted oils, made with cold-press technology that preserves the highest level of full plant intelligence and terpene content on the market. We also love that all of their cartridges are made from metal and glass without any epoxies or glues, and that they employ a ceramic wick rather than fiberglass or cotton to ensure youre inhaling nothing but clean oil. Their cold pressed technology results in record breaking terpene content, and zero additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/P3jiHytSTWStALiyfgTV_THG-cartridge-1-510x510.jpg', '50b4ec33-2957-4d1d-861b-60e75691e802', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal Bar - Frosted Faded Flakes', 'Tasty cereal bars infused with 500mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/PBebCZTT0WreDnnyPxkQ_IMG_0396.JPG', 'e81c1463-10f4-4a1f-b283-9a75e2953e8b', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal - Chronic Toast Crunch 400mg', 'Tasty cereal infused with 400mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/05Nfr6MhQxGtxVMw4ZSv_Crue.2bIMages6184.jpg', '68d5ddc8-c9e8-416d-ab85-64df33e5623c', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('The Highest Grade "Sour Tsunami" Cold Pressed Extract (CBD Rich) 1:1', 'Uniquely balanced with fruit and spice weaves into a sensual and smooth cocoa flavor foundation. Daily worries fade as you relax into a happy bliss to ease pain and anxiety. 1:1 CBD 35% CBD, 27.5% THC
Give Me Relief

Exceptionally crafted CO2 extracted oils, made with cold-press technology that preserves the highest level of full plant intelligence and terpene content on the market. We also love that all of their cartridges are made from metal and glass without any epoxies or glues, and that they employ a ceramic wick rather than fiberglass or cotton to ensure youre inhaling nothing but clean oil. Their cold pressed technology results in record breaking terpene content, and zero additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kAmUesjgR4qRxrHCN9Un_THG-cartridge-1-510x510.jpg', '05cdb185-1937-4f1b-af8e-f87ed5c2ed0b', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('The Highest Grade "Sweet Jesus" Cold Pressed Extract (Hybrid)', 'The first taste is lightly sweet with a mouthful of pineapple and tropical fruits. Its an uplifting, upbeat and energetic high which is awesome for sativa-lovers, but may be a bit too heady for those who prefer to stay more on the ground.
43.4% THC | 31.3% Terpenes ($50) Take Me To The Clouds

Exceptionally crafted CO2 extracted oils, made with cold-press technology that preserves the highest level of full plant intelligence and terpene content on the market. We also love that all of their cartridges are made from metal and glass without any epoxies or glues, and that they employ a ceramic wick rather than fiberglass or cotton to ensure youre inhaling nothing but clean oil. Their cold pressed technology results in record breaking terpene content.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rEJbkbB9QACXvenhS3xy_THG-cartridge-1-510x510.jpg', '02846ec8-360a-4487-9376-6829b57667d6', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Aya "Awaken" Vape Oil Cartridge', 'AYA is about 100% organic, sustainably produced cannabis nectars. AYA is grown using just four ingredients: Earth, Water, Sun and Sky, with no absolutely no pesticides or chemicals. Its then carefully crafted using a proprietary low-temperature extraction process, batch-tested to ensure to unmatched quality,Â and finally hand-finished to create concentrates that deliver a consistently enjoyable, rewarding experience.

A blend of Clementine x Â Jack Herer, this popular blend is a powerful, yet gentle mental stimulant. Great for blocking out distractions and unlocking imaginations.

Aya uses organically sun grown source material, artisan CO2 extraction methods and zero additives. They are truly some of the finest vape oils on the market.

500mg oil cartridge', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TqEnJqrjSdi16xSJ4YS0_AYA-AWAKEN-CARTRIDGE-510x510.jpg', '53ddfb81-4f12-4456-be79-dcd3d37bb6bf', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Aya "Inspire" Vape Oil Cartridge', 'AYA is about 100% organic, sustainably produced cannabis nectars. AYA is grown using just four ingredients: Earth, Water, Sun and Sky, with no absolutely no pesticides or chemicals. Its then carefully crafted using a proprietary low-temperature extraction process, batch-tested to ensure to unmatched quality,Â and finally hand-finished to create concentrates that deliver a consistently enjoyable, rewarding experience.

A blend of GG (f.k.a. Gorilla Glue) x Durban Poison, this mind and body booster has nice piney, citrusy tastes packing a big, bold punch. Gets days going and conversations flowing.

Aya uses organically sun grown source material, artisan CO2 extraction methods and zero additives. They are truly some of the finest vape oils on the market.

500mg oil cartridge', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/uNUqriVeSuKEq4gCLFah_Aya-Inspire-510x510.jpg', 'a9e7aaa3-9690-49e0-a59c-22956ba5d71f', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Aya "Relax" Vape Oil Cartridge', 'AYA is about 100% organic, sustainably produced cannabis nectars. AYA is grown using just four ingredients: Earth, Water, Sun and Sky, with no absolutely no pesticides or chemicals. Its then carefully crafted using a proprietary low-temperature extraction process, batch-tested to ensure to unmatched quality,Â and finally hand-finished to create concentrates that deliver a consistently enjoyable, rewarding experience.

A blend of Sunset Sherbet x The WhiteÂ helps you unplug, unwind and unworry. Â A tasty blend of floral and citrus flavors, underpinned with a solid, slightly peaty finish, its perfect for kicking back and letting the world spend some time on its own.

Aya uses organically sun grown source material, artisan CO2 extraction methods and zero additives. They are truly some of the finest vape oils on the market.

500mg oil cartridge', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HQqHZzoUR8GBiuy1pvKl_AYA-RELAX-CARTRIDGE-510x510.jpg', 'a9fcace9-49c7-4606-9113-38bf018357db', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Aya "Slumber" Vape Oil Cartridge', 'AYA is about 100% organic, sustainably produced cannabis nectars. AYA is grown using just four ingredients: Earth, Water, Sun and Sky, with no absolutely no pesticides or chemicals. Its then carefully crafted using a proprietary low-temperature extraction process, batch-tested to ensure to unmatched quality,Â and finally hand-finished to create concentrates that deliver a consistently enjoyable, rewarding experience.

Rest easier. A blend of Sour Tsunami x Diamond OG, this dreamy delight is characterized by a rich, earthy foundation and delicate top notes. Ideal for pain relief, muscle relaxation and deeper Zs.

Aya uses organically sun grown source material, artisan CO2 extraction methods and zero additives. They are truly some of the finest vape oils on the market.

500mg oil cartridge', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/oLEFZ32vS4dtaK4CGw6K_AYA-SLUMBER-CARTRIDGE-510x510.jpg', '18c6babb-e3ad-41d8-9c9f-bdcee11b622d', '6574ed59-73a6-43d3-955a-66218e6433d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Garden Society "Bright Blooms" Fruit Gelées (5mg/pc)', 'Zesty fruit and herb gelées infused with the uplifting attributes of cannabis to energize mind and body.

Tasting Notes:  Bright Blooms help you stay mindful and in the moment when life is at its most stressful and hectic. Beautiful gelées made from a blend of zesty fruits and herbs, and infused with a Sativa hybrid cannabis strain, Bright Blooms are the perfect way to improve a stress-filled day.

Chef-inspired, low dose cannabis confections, Sonoma County, CA.

5 mg/THC per serving, 40 mg/THC per package High THCA

Crafted from locally grown, organic ingredients and responsibly farmed cannabis.

Ingredients
Sugar, Blackberries, Pear Puree, Yuzu Juice, Apple Puree, 100% Organic Apple Juice, Glucose Syrup, Apple Pectin, Citric Acid, Decarboxylated Cannabis Extract', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IaKjmkWKTQWKedOXQQ0v_Garden-Society-Gelee-510x510.jpg', '32d0298a-0b5c-45a5-9654-d327923b52f0', '6574ed59-73a6-43d3-955a-66218e6433d5', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sugar Sap', '“œSugar“ is the word used to describe shatter that has begun to resemble the consistency of wet sand while not completely drying out into crumble. Our Sugar Sap cannabis concentrate is known for being one of the top cannabis concentrates on the market. Some use a a metal device to pick up the Sap and then drip the sap onto the dabbing device, joint or even on-top of a fresh bong hit. The concentrate is easily applied to any bowl for an extra bit of medication. This marijuana concentrate is strong and known for knocking the user on their feet, immediately after ingesting.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gqwk9Z5PTHicMdhgwpwS__MG_6881.jpg', 'ebcc2e95-61ab-46fa-9ad4-dbc1657de95b', '575f652a-31ed-4ff2-a8c0-ae0e09ce3ea1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal - Capn Munch 400mg', 'Tasty cereal infused with 400mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/r9rCKxJmRB62hGSl1VyA_Crue.2bIMages6186.jpg', '47e101ef-5bd4-43c7-8487-d265692adf80', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Garden Society "Bliss Blossoms" Milk Chocolate (10mg/pc)', 'Luscious milk chocolate infused with passion flower and the calming attributes of cannabis to relax mind and body.

Tasting Notes: Bliss Blossoms help you relax after a stressful day, and to get a good night‘s rest.  If you are looking for something to bring you a sense of calm and relief, these squares of luscious milk chocolate are designed to help you naturally do just that.  Bliss Blossoms are infused with passion flower,  a calming herb believed to relieve anxiety and insomnia, and an Indica hybrid cannabis strain to help relax your mind and body.

Chef-inspired, low dose cannabis confections, Sonoma County, CA.

10 mg/THC per serving, 80 mg/THC per package  1:1 Indica High CBD

Crafted from locally grown, organic ingredients and responsibly farmed cannabis.

Ingredients
Milk Chocolate 36%, Food Coloring (Water, Glycerine, FD&C Red #40, Citric Acid, Sodium Benzoate [As Preservative]), Passionflower, Decarboxylated Cannibis Extract, Cocoa Beans', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qDOXAjDShKJAIB6sxgvw_Garden-Society-Choc-510x510.jpg', '1269a492-a445-4411-b713-5954750e8dac', '6574ed59-73a6-43d3-955a-66218e6433d5', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Session | Daybreak', 'Find your session. These classy cartridges are the essence of cannabis refined with flavors so tasty you simply cant resist an extra pull. Weve crafted experiences catered to any and every moment with all-natural cold-pressed CO2 and cannabis-derived terpenes that pack a punch in potency.

Daybreak (Sativa): Start or re-start the day with this citrus zinger. If youre not a morning person, we get it, and we got you.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wfhL74ghTcWuWyGSXUk1_Caliva_Product.2bShots-15.jpg', 'e41d93ba-1737-4df9-89d1-9d109cbc5703', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Session | Kiss the Sky', 'Find your session. These classy cartridges are the essence of cannabis refined with flavors so tasty you simply cant resist an extra pull. Weve crafted experiences catered to any and every moment with all-natural cold-pressed CO2 and cannabis-derived terpenes that pack a punch in potency.

Kiss the Sky (Sativa-Hybrid): For when you want to play a guitar with your teeth. Notes of candy apple and lime keep your head in the clouds and your feet on the ground.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wa1hkicTSwKMNGpUDhr0_Caliva_Product.2bShots-17.jpg', 'bad26806-c603-48ae-aa27-71ae09fcff83', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sessions | Afternoon Delight', 'Find your session. These classy cartridges are the essence of cannabis refined with flavors so tasty you simply cant resist an extra pull. Weve crafted experiences catered to any and every moment with all-natural cold-pressed CO2 and cannabis-derived terpenes that pack a punch in potency.

Afternoon Delight (Indica-Hybrid): Not quite quitting time, but almost. Sweet, earthy, satisfying and chill…like happy hour…with your shoes off.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ll64pmaLRyUBuv8j4q9O_Caliva_Product.2bShots-16.jpg', 'a4074def-301c-4baa-8572-ae4e48cbf525', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sessions | Pillow Talk', 'Find your session. These classy cartridges are the essence of cannabis refined with flavors so tasty you simply cant resist an extra pull. Weve crafted experiences catered to any and every moment with all-natural cold-pressed CO2 and cannabis-derived terpenes that pack a punch in potency.

 Pillow Talk (Indica): Its like a hovering purple bean bag filled with quicksand. Berry and cola flavors make for the sweetest of dreams.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/T7gElpABSz2S0IvAy9Xy_Caliva_Product.2bShots-7.jpg', 'cc238ce8-913e-4f39-8656-513ddeeb2b05', '248408b7-2c93-4cb1-8a92-ed81595409b0', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sweet Tooth Live Sap', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/c2HdKR5NR4GrAtRMymLP_17201118_10208501873255541_2073590712336563501_n.jpg', 'ac1da630-3a03-4154-bd7e-b8e1383f1418', 'be6e8cce-a790-42a2-9b16-3a8a4db9ff35', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Altitude Extracts', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AqKwaqzQNqXFUveBeMbg_image1.2bcopy.JPG', '6113263e-0c20-4eec-9200-81919f95fed4', 'be6e8cce-a790-42a2-9b16-3a8a4db9ff35', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Biscotti', 'Connected Cannabis Co. Powered By Cookies. Biscotti is Gelato #25 Crossed with South Florida OG.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/lpCk5etbTcO6nm8hp2CY_biscottigrow1watermark.jpg', '8ae3b6d8-85c9-4c67-84dd-4ea326856d5c', '748c6a1a-5a9d-46fb-a732-3b6318fad9c9', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Gelato #41', 'Connected Cannabis Co. Powered By Cookies.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XeDONUt3REaHYU5cNhtT_gelato41-5watermark.jpg', '286f4189-ec49-4d4b-9423-30e7a2cd2d58', '748c6a1a-5a9d-46fb-a732-3b6318fad9c9', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Smarties', 'The newest genetic to drop from Connected Cannabis Co. Powered by Cookies!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gNohDCZvQG2irLbLY2n6_smarties7watermark.jpg', '84527ad5-36d2-4351-b083-812b8e4e2be6', '748c6a1a-5a9d-46fb-a732-3b6318fad9c9', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Berners Cookies', 'Connected Cannabis Co. Powered By Cookies. The creator of the Girls Scout Cookies', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TurCDyR5SmmGqLkvB1oz_bernerscooks1awatermark.jpg', '84aa60c8-d27c-43ef-8edf-c9064d2af8f8', '748c6a1a-5a9d-46fb-a732-3b6318fad9c9', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Gelato #25', 'Connected Cannabis Co. Powered By Cookies.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ckYB0soQZOTmIQAIjoyg_gelato25watermark.jpg', '8194f0d9-7741-4444-a0f4-a08920376332', '748c6a1a-5a9d-46fb-a732-3b6318fad9c9', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Now & Later', 'Connected Cannabis Co. Powered By Cookies.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/H4TQ3HCgRMmqVpl3p1RJ_nowlater.jpg', '4cf39391-3aa4-44e2-b6e8-47569fd609d4', '748c6a1a-5a9d-46fb-a732-3b6318fad9c9', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Full-spectrum CBD Softgels', '• 25mg of CBD per softgel
• 31.5mg of total cannabinoids
• 30 softgels per bottle
• Full Spectrum Hemp Extract
• Rich in phytocannabinoids
• Gluten-free, dairy free and non-GMO
• Free of pesticides, heavy metals and residual solvents
• Cultivated in EU and Made in the USA

Relief from stress, anxiety and pain. Are you a professional with a stressful job? A mom balancing children and a million other things? An athlete experiencing muscle pain? Or someone with a chronic disease? Whatever life is tossing your way, our CBD softgels can help you stay calm and focused while providing relief, so you can concentrate on the things that matter most. Full-spectrum relief from from pain, anxiety, and chronic conditions from a powerful, natural plant.

Optimized formula. Our full spectrum softgels are CO2-extracted and carefully processed to preserve and optimize all of the natural phytocannabinoids and terpenes found in the hemp plant. Our CBD oils are pure and 100% free of heavy metals, additives, solvents, and pesticid', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/bottle_fb%2B%281%29.jpg', 'b1948ab7-46c1-47c5-b048-a95cc9bcd16b', '0cb2135f-039d-489b-8791-1961fdb778dc', 'edible', 'capsule');
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Vaporizer Cartridge', 'Our vaporizer formulation is fully decarboxylated to convert cannabinoids like THC and CBD into their active states, maximizing their delivery during vaporization.

This produces medication rich in cannabinoids and terpenes, with viscosity (flow) perfect for reliable vaping.

Brite cartridges fit most 510-threaded vaporizer batteries and deliver, on average, 100+ uses.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QAOdVGZQ5mevrByWhdiC_brite.2blabs.jpg', 'b3cb31cb-6841-48bb-8649-5068d56dd511', 'abb41639-40f0-4542-a129-87fa98644f51', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal Bar - Berries Crunch 500mg', 'Tasty cereal bars infused with 500mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aH0M8fQERnGhxILPPtPc_IMG_0398.JPG', 'edee4fc9-25c9-4bda-981a-89ea35008a77', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal Bar - Chronic Toast Crunch 500mg', 'Tasty cereal bars infused with 500mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YBPGCImsRxm3Zvcuf9tT_IMG_0399.JPG', '358a66ea-a548-4688-9565-1459c2ca5f7e', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cereal - Frooty Loopys 400mg', 'Tasty cereal infused with 400mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2ak4cbl7QqilMV5GxjQX_Crue.2bIMages6188.jpg', 'c930492f-e888-4371-95d0-bc59b295cd09', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Blueberry 300mg', 'Tasty blueberry sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9XvMf6NkRXqEQOniz5Nd_Crue.2bIMages6404.jpg', '7fa41a2a-876e-4ce5-a813-0ccc7c662d82', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Sour Apple 300mg', 'Tasty sour apple sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vXx7fGO7RKqbEh11w12R_Crue.2bIMages6406.jpg', 'b5ac6e0e-f3c9-4cc0-a998-aff9149a205d', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Strawberry 300mg', 'Tasty strawberry sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ftCDX0KpQpORVnPbFFTm_Crue.2bIMages6400.jpg', '2822778e-80d1-46e6-ad4e-0da5f3a7a8da', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Watermelon 300mg', 'Tasty watermelon sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zexJLifRp2igOmzKI2vw_Crue.2bIMages6402.jpg', 'a5c04ce4-af58-485d-aae0-59df374fdc38', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Wild Cherry 300mg', 'Tasty wild cherry sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gbr7vSa4Rx23YcvBpnbY_Crue.2bIMages6402.jpg', 'eaa92577-0ee2-46ed-bdf8-33a01195af2b', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Blueberry 300mg', 'Tasty blueberry sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9XvMf6NkRXqEQOniz5Nd_Crue.2bIMages6404.jpg', 'aa581e8e-bd11-44bd-a2ac-42c6f7997a3d', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Sour Apple 300mg', 'Tasty sour apple sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vXx7fGO7RKqbEh11w12R_Crue.2bIMages6406.jpg', '1500cfbc-e8c6-4dce-bc7e-65bf6cd5e748', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Strawberry 300mg', 'Tasty strawberry sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ftCDX0KpQpORVnPbFFTm_Crue.2bIMages6400.jpg', 'f945acc2-93d0-4095-9419-e3ecaba855d3', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Watermelon 300mg', 'Tasty watermelon sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zexJLifRp2igOmzKI2vw_Crue.2bIMages6402.jpg', 'fba6bc93-8d03-4f79-9f2d-4ba124ba2c1e', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Belts - Wild Cherry 300mg', 'Tasty wild cherry sour belts infused with 300mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gbr7vSa4Rx23YcvBpnbY_Crue.2bIMages6402.jpg', 'd4b93c21-9825-4553-80ab-81edf8acfd56', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jolly Rocker - Strawberry 60mg', 'JOLLY ROCKER STRAWBERRY 60 MG', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/p759jEbSG60pybzUVLBD_JR.2bSTrawberry.png', '79fb3630-62fd-4ba9-b830-75e8af0644f9', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jolly Rocker - Watermelon 60mg', 'JOLLY ROCKER WATERMELON 60  MG', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wjQTGi7sS9qsCsAWNRsc_JR.2bWatermelon.png', '10bb4b61-1295-49cb-93de-a1bae145b52f', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jolly Rocker - Green Apple 60mg', 'JOLLY ROCKER GREEN APPLE 60 MG', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/pVG49xYWTC6xyuCZXiti_JR.2bApple.png', '7ac34e22-3cd4-45c2-b395-f9bda8432c50', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jolly Rocker - Pineapple 60mg', 'JOLLY ROCKER PINEAPPLE 60 MG', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HLbjp4uTFONt9i8QIB11_JR.2bPineapple.2b.png', '746f2c4f-35c0-4b86-9ee0-2de04d134a75', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Orange 100mg', 'Tasty orange gummy candy infused with 100mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fhwecr3kTl2XG9dO5KSq_LOL-DOOB-100MG-ORANGE.png', '558c8929-d787-44b8-9f7c-2d5ab1506ac4', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Orange 200mg', 'Tastyorange gummy candy infused with 200mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/3TxZeVgOQWOHvUvOZhIi_LOL-DOOB-200MG-ORANGE.png', '4a99d2d8-c2d7-4289-831e-46e9e674894c', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Raspberry 100mg', 'Tasty raspberry gummy candy infused with 100mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/uEE8PNmgSCeMTdNHvQYs_LOL-DOOB-100MG-RASPBERRY.png', 'd832e4cc-2dd4-4816-b0b0-272004469a96', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Raspberry 200mg', 'Tasty raspberry gummy candy infused with 200mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/suctCcU1TEyuzRMp2e7v_LOL-DOOB-200MG-RASPBERRY.png', '5d1e220b-59cb-429b-8a2d-d1a878901da3', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Strawberry 100mg', 'Tasty strawberry gummy candy infused with 100mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dKjLmxvwQaiNtpzPGdRB_LOL-DOOB-100MG-STRAWBERRY.png', '81a21a9f-d231-4b3c-933b-adb7fc2775ad', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Strawberry 200mg', 'Tasty strawberry gummy candy infused with 200mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Hka2SvcfR6qOPzCsvvvv_LOL-DOOB-200MG-STRAWBERRY.png', '8a80a06e-4f89-459f-8a9f-32ad5f9d640b', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Blueberry 100mg', 'Tasty blueberry gummy candy infused with 100mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6Kc52crJT5iS1itvIFRp_LOL-DOOB-100MG-BLUEBERRY.png', '90cad047-c37a-47d8-ac98-c690a6d6f17a', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Blueberry 200mg', 'Tasty blueberry gummy candy infused with 200mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ozENbmzKSBCfQbD01nHN_LOL-DOOB-200MG-BLUEBERRY.png', '0a57644a-8483-42a6-8d07-fe854457898f', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Grape 100mg', 'Tasty grape gummy candy infused with 100mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/sSXXNN3sScCatZqTctIY_LOL-DOOB-100MG-GRAPE.png', 'fec52ae7-cb5f-46e8-9fd6-91cdbdeb22b1', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Doob Cube - Grape 200mg', 'Tasty grape gummy candy infused with 200mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cyKW26WOSreyrIT7pEtF_LOL-DOOB-200MG-GRAPE.png', 'e30c91d1-fb8c-48fa-9409-7d94ea48a396', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bar - G-bar 1000mg', 'Tasty chocolate candy bar infused with 1000mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Z0B4bWI9RUKs8UrWYDPX_Crue.2bIMages6201.jpg', '12bc6a8f-d8e8-42bc-b0e8-c5db93f7d9b3', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bar - G-bar 250mg', 'Tasty chocolate candy bar infused with 250mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/R3laOZwzSo2cMXbknKWg_Crue.2bIMages6200.jpg', 'bfafdf1c-c31a-491c-a9a3-fa1e59718ce6', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Chocolate Bar - G-bar 500mg', 'Tasty chocolate candy bar infused with 500mg of THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XeHZoMGQtGzB7ijTR6FA_Crue.2bIMages6199.jpg', 'a870a2a5-414e-43e7-8e85-74e68b727402', '6ac976a1-2f75-45cc-9144-4525d4c72853', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('White Widow Indica Cartridge', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8fI00Fz7RJW1ReEnsfpw_TDC-WHW.2bIND.jpg', '3a281d7a-42a4-4c9c-bdde-c8fc9bb10069', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Stawberry Kush Cartridge', 'Strawberry Kush is a heavy hitting oil cartridge, 70% THC that leaves users feeling incredibly uplifted and buzzing with energy. This concentrate is enjoyed by many for its natural effects that relieve stress, pain and depression.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/54QGBiDReeiqUIEtOEjF_TDC-STR.2bHYB.jpg', '49db0896-1feb-4d4d-9dd4-bd7865cab6fd', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pina Sativa Cartridge', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ce5hrR6XSQ2UQErBzZsR_TDC-PIN.2bSAT.jpg', 'fd73d9ca-72d3-4ea8-8058-318aa4b7a736', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pina Sativa Cartridge', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ce5hrR6XSQ2UQErBzZsR_TDC-PIN.2bSAT.jpg', 'cc34a74c-8dc3-4804-b68b-1891509077dc', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Cartridge Bubble Gum', 'Not too sweet, our Bubblegum cartridge is a delicious treat. Soothing and calming at the same time, perfect for anyone experiencing pain, stress or in need of a sweet treat.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ZlQRsQ8dTBye7blc8E9w_TDC-GUM.2bCBD.jpg', 'a535083b-f63f-4910-b77f-bcf9033b7deb', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Cartridge Pina', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Zhq6AJNKTVKhgCbe3kHE_TDC-PIN.2bCBD.jpg', '94499f7e-39dd-4a64-9390-daf83e6bbf37', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Cartridge Strawberry Kush', 'Perfect for those seeking symptom relief without the psychoactive properties of THC. Our CBD Cartridge relieves discomfort associated with chronic pain, anxiety, and depression and leaves patients with a heightened sense of well-being.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/N2VoZYzcSAuO51ZTm5Mw_TDC-STR.2bCBD.jpg', '7a6b878e-cd03-43c6-81f9-cf76a4fd51a2', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Cupcake Cartridge', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5B7k26PgTUahDn5RdlhF_TDC-CPK.2bCBD.jpg', '15621ccb-1745-49a5-b484-43614111457c', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Dream Sativa Cartridge', 'Our Blue Dream Cartridge packs blueberry, happiness, and pain relief into a tiny punch.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QfnvPDgqQ9GKUNolZ6YJ_TDC-BLD.2bSAT.jpg', 'ea82f181-caa9-41ce-bcc8-96b6dcf03110', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bubble Gum Sativa Cartridge', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2rA8u9scQXCqpRubVGYc_TDC-GUM.2bSAT.jpg', '2981b7b0-2d3f-4764-84cd-e81dbaba1d0a', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Cali OG Cartridge', 'Cali OG is an oil cartridge containing 70% THC. With just a few hits, even the most uncomfortable and restless person is now relaxed, free of body pain and lingering anxiety. Highly recommended for concentrate-lovers who have muscle spasms and difficulty unwinding.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9ZTkrv6JSLqsngVgG5rp_TDC-COG.2bIND.jpg', '911bebbf-de49-4c53-953b-2e0d18045417', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Banana Indica Cartridge', 'Our Banana Indica Cartridge tastes like the most perfectly ripened banana while still packed with Indica. Relaxing effects, delicious taste, what more can you ask for.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Sg4o3BAKTvS7JEq2pyHr_TDC-BAN.2bIND.jpg', '27e0b3fd-76b4-41b1-8d20-c1daec1b04d4', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('A.K 47 Hybrid Cartridge', 'Our A.K. 47 Cartridge may be a Hybrid, but its effects lean well into Indicas territory. Sour and earthy tones create complex flavors, this cartridge will take relaxation to the next level.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ClnLDH9iTQebUdcdv7nN_TDC-AK4.2bHYB.jpg', '07869656-dc46-4c56-871b-e3cb79ea5071', '7239ff1d-9007-4158-b0e8-045d3b0c1e4f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Maple Wreck', 'Maple Wreck has a rich aroma of maple syrup mixed with woody bark. After exhaling this tasty strain, the exquisite flavor lingers on your palate. The effects of this Trainwreck hybrid are mostly cerebral and euphoric with a light, calming body effect.
Average THC 22.87%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cV25DHLxSZ6rN6uGEGoO_Maple-01.jpg', 'cf630c37-1b04-4052-89a4-94640a15b1f4', '6357010e-8192-4b93-b354-51d5f00e798d', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sage N Sour', 'Sage N Sour is a sativa dominant strain that unites the sharply pungent "Sour Diesel" and "Sage" hybrid. With an aroma that closely matches the subtle herbal notes of Sage, delivering a perfect balance of euphoria, energy and happiness to the most discerning connoisseur.
Average THC 24.55%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fF270R4HSwmqeUw9cY7t_SageNSour1-01.jpg', 'fc4b2f57-0231-4285-b980-530002dabc73', '6357010e-8192-4b93-b354-51d5f00e798d', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Silver Haze', '2014 High Times Cannabis Cup Sativa - Silver Haze is a light colored flower with dark orange pistils, coated in trichomes. Silver Haze has a distinctive cheese-funk-grass sweetness. The cerebral effects of this potent sativa are uplifting and euphoric, yet functional.
Average THC 25.93%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/MhJkrzjnQnkoxrJwdNLv_Silver-Haze-01.jpg', 'fd9bfc58-e77c-401f-9a4d-73e46453573e', '6357010e-8192-4b93-b354-51d5f00e798d', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sumatra Kush', 'Sumatra Kush is a potent indica dominate hybrid that delivers heavy-handed euphoria and relaxation. Its chunky, resin-covered flowers fill the room with pungent earthy, sour aromas inherited from its parent strains. This hybrid produces a smooth smoke with minimal cough. From the first taste onward Sumatra Kush provides superb relaxation and bliss.
Average THC 23.27%', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/m27PwlRTVOdNqoY4hMXD_Sumatra1-01.jpg', '05ccfd39-f4da-4727-81f3-d684aaa87ad1', '6357010e-8192-4b93-b354-51d5f00e798d', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dutchy Oil', 'Dutchy concenrtrates provide WA state consumers with a smooth and reliable cartridge experience.  Perfect for a summer BBQ or before you head into the stadium, this oil boasts a taste and perfectly measured amount of THC that begs to be shared among your friends.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/eRkfkMq8Tg2aNDcB3mB9_Cartridges.jpg', 'd096dc09-e61a-4af6-8d91-325208c12749', 'c21e5742-5b5a-4a45-a38e-3943bfeee1e0', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Last Man Standing - Willie''s Reserve', 'Crisp · Sweet · Berries', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '1c776faa-7867-43c8-8b26-4aa6ccc569c5', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Pineapple 17.87%THC', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', 'afff6b73-a26d-473b-a2da-80b221bcdc3c', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry Lemonade 17.80% THC', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '7723c4b6-7ece-4bb2-a02c-eb1ed4ab2919', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Black Lime 22.9%THC', 'Earl Gray Tea · Sweet · Citrus', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '227a6cc3-e067-4b7b-a266-0c7c0d1fddd9', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Coyote Blue', 'Sweet · Vanilla · Plum', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '31c97d05-e52b-4758-a377-1440395575d6', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sangria', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '4bc2f2f8-e974-4798-9690-4f7700e6d84e', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lady Benbow THC 7.3% CBD 10.1%', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '022a9f64-3bcf-45ed-a029-6468b7e90365', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Rising Pines THC 8.56 % CBD 11.53%', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', 'b41d9155-5e83-4757-a70c-bd3d0c6c0ca4', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Frosta Mon 21.67% THC', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '0299388e-98ba-4a86-8829-b1e40ca4f2c7', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fire OG 28.95% THC', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Flow%2BKana%2BLogo.jpeg', '3885c243-52c2-45da-8985-df3eecb8ff91', '7bfe55f7-6f33-4e4c-86f1-aa3a7fc3867a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Dark Chocolate', 'This semi-sweet chocolate bar is CBD infused and enjoyable. Our cannabis bar of healing brings relief to patients by providing a strong, delectable, smooth dark chocolate taste.  It‘s smooth, it‘s tasty, it‘s medicinal.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XjY1crkFTaCkpWSVQGhM_CBD.jpg', 'ef49b518-584a-4239-aae1-3fd451c45813', 'ce44b0c8-092c-4d8f-abce-eb4d014ff2b8', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('IndigoPro 500mg Cartridge - Sativa', 'IndigoPros innovative Sativa 500 mg ceramic cartridges are pre-filled with high-potency artisanal CO2-extracted sativa oil, created with the finest craft cannabis from The Farm in Boulder, Colorado.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HHe7MAETRw6NC0oqysx8_sativa.jpg', '9b1d4e5e-41f9-49f0-bcbc-0ab95e821eff', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('MOONSTONE KUSH', 'This strain redefines "mellow" for the needs and desires of the 21st-century cannabis consumer. Tight, round, bright-green nuggets covered in bright orange-red hairs are frosted with trichomes that emit hints of this strains Humboldt County home: pine, earth, and wood. A pleasantly smooth and mild smoke relaxes muscles tightened by hours at the office or the stress of home as your mind unwinds into a state of contended peacefulness. Experienced users will enjoy the feeling of mindful calm that doesnt deaden the senses, while sporadic cannabis users may find enough peace to slip easily into sleep. Recommended for anxiety/depression and mild pain. Type: Indica Dom', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/f3IbRgZLSUKGrPkYsecq_flowertin-text_moonstone.jpg', '7d81e90d-e278-4592-b1b9-bcfeb9f2b6b6', 'f05c84a2-8aa9-43de-b622-9c68a2442cf4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('SAPPHIRE KUSH', 'For the positive thinkers, Sapphire Kush is a mix of purples, greens, red hair and lush layers of trichomes that offer a deeply euphoric and open effect. A classic Kush texture and quality, this strain is a true smokers delight, perfect for daytime pain relief without the lethargy. Sapphire Kush has energetic and extroverted effects for those seeking such qualities.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dnfRGVFtTGSXr75qyIaF_flowertin-text_sapphire.jpg', '92dfad36-c006-47ef-8145-47e8962fd6a6', 'f05c84a2-8aa9-43de-b622-9c68a2442cf4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('TITAN OG', 'The crown jewel of the Northern Emerald family, the TITAN OG is our most potently luxurious Indica-dominant strain. A dense lime green bud with orange hairs and white frosted crystals, the strain has the smell and essence of earthy pine with relaxing properties strong enough to handle insomnia/anxiety or just deeply soothing nighttime vibes.
For the serious connoisseur, TITAN OG stands out.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/bcXQNNNGR52aZ6zgh0tP_flowertin-text_titan.jpg', 'c67df4f0-4c4c-4f2a-85ca-edd801d0f777', 'f05c84a2-8aa9-43de-b622-9c68a2442cf4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CaraMellower', 'Our CaraMellower uses only five simple ingredients. Our signature, clean-tasting cannabutter, cream, sugar, refined cane syrup and locally sourced Bittermans Flake sea salt. We lovingly cut and wrap the caramels by hand before placing them in child-safe packaging. We use the highest quality, natural ingredients, with no added preservatives. The CaraMellower is the easiest way to start your journey.

1 Caramel
10mg THC', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/GyN9T62GQgCwC1EfTIfb_LittleHouseFoods_Caramel-5.jpg', 'a846e804-ba05-4e82-975c-67b54ccfbb1f', 'c8a9ba26-9bfe-42c9-ac8d-dd8abec61a2e', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tangie', 'This Sativa will leave you feeling energized and creative with a refreshing sweet citrus flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/neK36eyiTXSjJr4TjpXI_side.2bby.2bside2.png', '77c2474f-6f2e-4a02-a429-d3d6d47725f3', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Faced Alien OG', 'This Indica heavy strain is the perfect dab for a restful night.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4R0JDoEEReecXc403JYj_side.2bby.2bside2.png', 'cf7f593b-7d81-4d10-9db2-8464a67d920b', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Ringos Gift (CBD)', 'Ringo‘s Gift is a high-CBD strain that crosses Harle-Tsu and ACDC. It is named for the late Lawrence Ringo, a cannabis activist and CBD pioneer. The CBD/THC ratio of our concentrate is 12:1 with a fruity earthy flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/EDJtPGjNR3epinj8UPkn_side.2bby.2bside2.png', 'dabdac6a-6ef9-471e-acaf-c7c2e45a73ae', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Outlaw OG', 'Outlaw OG is a cross between Fire OG and Sour Faced Alien. This is a hybrid strain. You get the best of both worlds.  You feel refreshed and ready to go but you are in no hurry to get there.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ZwZ7PA0cQWW78593bMyG_side.2bby.2bside2.png', '8789ac98-28aa-4c96-affd-a3d36ae166e5', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Green Crack', 'The perfect daytime strain. Give yourself a jolt of energy and a mood boost with this Sativa dominant strain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/GFRm8EDShCwLCAaKDFN6_side.2bby.2bside2.png', '81b886cf-d2d8-490c-8e00-725a27c965e2', '8384e7a2-39c3-42cb-95eb-f531af91d737', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (CBD 1:1 - Cannatonic)', 'Balance and recover with a perfect 1:1 ratio of CBD and THC in this coveted Cannatonic strain. Recommended for relief from anxiety, pain, muscle spasms and a variety of physical symptoms.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/0JI2K8KUTreWolJctwsy_Island_PAX_ERA_Cannatonic_Menu.jpg', '07d618d4-8ff2-4c2a-a120-e81013c7e567', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (Hybrid - Tangie Sap)', 'Escape to a citrus paradise with this hybrid fruit cocktail. This flavorful hybrid strain will leave you feeling happy and relaxed, along with relief from any body or muscle pain you might be experiencing.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Ky2vYlKaT1aw363E2RcP_Island_PAX_ERA_Tangie_Sap_Menu.jpg', '77ff7a53-225b-43ce-a39d-90de6a064c90', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (Indica - Blackberry OG)', 'Kick back with a tangy twist on this potent OG classic. This indica favorite will help you unwind and relieve body aches and pains.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/crwZ4zuURomKOGRs5eXC_Island_PAX_ERA_Blackberry_OG_Menu.jpg', '7a43e8c3-f213-4a83-99df-4d68cec2ac33', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Gold CBD Veda Chews', 'The Gold CBD Veda Chews contain a minimally psychoactive 1:1 ratio of CBD to THC, and are excellent for treating a wide range of symptoms, including pain, inflammation, and anxiety. Sugar free, Gluten Free, Vegan, Non-GMO, Soy Free.

Per Chew: 10 mg CBD, 10 mg THC
Per Package: 40 mg CBD, 40 mg THC


Ingredients:
Soluble Corn Fiber, Coconut Milk, Erythritol, Xylitol, Cocoa Powder, Cocoa Butter, Sunflower Lecithin, Fractionated Coconut Oil, Natural Flavors, Sea Salt.

Contains no known allergens.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/JWACfI4QnOQPyoQtKlOg_VedaChews_ByAvedica_VerticalLogo.png', '037910d1-025f-40fc-844f-265687de4070', 'ceb9853f-9206-4b44-9aea-749dd4c156bd', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (Sativa - Lemon Wreck)', 'Elevate your day with this sweet-and-sour Sativa. If relaxation is what youre after, this strains cerebral effects are a perfect match.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CQxFiRScQuevaVm9yivS_Island_PAX_ERA_Lemon_Wreck_Menu.jpg', '4159e3ce-3fc4-4c7f-b2be-c2c9fddc7c58', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (CBD 1:1 - Cannatonic)', 'Balance and recover with a perfect 1:1 ratio of CBD and THC in this coveted Cannatonic strain. Recommended for relief from anxiety, pain, muscle spasms and a variety of physical symptoms.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/0JI2K8KUTreWolJctwsy_Island_PAX_ERA_Cannatonic_Menu.jpg', 'ac46fa63-db55-496b-91d5-38d9a4f62696', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (Hybrid - Tangie Sap)', 'Escape to a citrus paradise with this hybrid fruit cocktail. This flavorful hybrid strain will leave you feeling happy and relaxed, along with relief from any body or muscle pain you might be experiencing.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Ky2vYlKaT1aw363E2RcP_Island_PAX_ERA_Tangie_Sap_Menu.jpg', 'dd568018-7b1c-4f74-88cf-2169df962881', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (Indica - Blackberry OG)', 'Kick back with a tangy twist on this potent OG classic. This indica favorite will help you unwind and relieve body aches and pains.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/crwZ4zuURomKOGRs5eXC_Island_PAX_ERA_Blackberry_OG_Menu.jpg', '5e22d7a3-aef3-4039-bace-0fd8d21993a0', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PAX Era Pod (Sativa - Lemon Wreck)', 'Elevate your day with this sweet-and-sour Sativa. If relaxation is what youre after, this strains cerebral effects are a perfect match.

ISLANDs master extractors are proud to bring you the purest expression of strain-specific cannabis distillate on the market today. Each strain is hand-selected from our network of organic farms for its specific flavor profile, which is exemplified in the industry-leading PAX ERA vaporizer device.

-Strain-Specific, 100% natural cannabis oil and terpenes
-Proprietary hydrocarbon extraction process
-Winterized at sub-zero temperatures for maximum purity
-Double-distilled and completely solvent free
-4x longer purification process produces some of the cleanest, clearest oil available today', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CQxFiRScQuevaVm9yivS_Island_PAX_ERA_Lemon_Wreck_Menu.jpg', 'fdc9bc1d-5039-4ddc-832d-c9e3e21f6660', '3cd7db31-f7e7-46c6-b753-6f936d9112a1', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Silver CBD Veda Chews', 'Top Seller! The Silver CBD Chews contain a 3:1 ratio of CBD to THC, and are an excellent option for patients who prefer non-psychoactive relief.  Great for overall pain relief, chronic migraines, dyskinesia, tremors, and depression. Sugar Free, Gluten Free, Vegan, Non-GMO, Soy Free.

Per Chew: 15 mg CBD, 5 mg THC
Per Package: 60 mg CBD, 20 mg THC

Ingredients:
Soluble Corn Fiber, Coconut Milk, Erythritol, Xylitol, Coconut Flour, Cocoa Butter, Coconut Milk Powder, Sunflower Lecithin, Fractionated Coconut Oil, Natural Flavors, Sea Salt.

Contains no known allergens.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zYxpYtMKRGvYSLYFgpup_VedaChews_ByAvedica_VerticalLogo.png', '3719fd64-d550-4603-a379-1550a07a9f35', 'ceb9853f-9206-4b44-9aea-749dd4c156bd', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Silver CBD Veda Chews', 'Top Seller! The Silver CBD Chews contain a 3:1 ratio of CBD to THC, and are an excellent option for patients who prefer non-psychoactive relief.  Great for overall pain relief, chronic migraines, dyskinesia, tremors, and depression. Sugar Free, Gluten Free, Vegan, Non-GMO, Soy Free.

Per Chew: 15 mg CBD, 5 mg THC
Per Package: 60 mg CBD, 20 mg THC

Ingredients:
Soluble Corn Fiber, Coconut Milk, Erythritol, Xylitol, Coconut Flour, Cocoa Butter, Coconut Milk Powder, Sunflower Lecithin, Fractionated Coconut Oil, Natural Flavors, Sea Salt.

Contains no known allergens.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zYxpYtMKRGvYSLYFgpup_VedaChews_ByAvedica_VerticalLogo.png', '4f50d844-82c3-499d-a794-2d7cf6201a28', 'ceb9853f-9206-4b44-9aea-749dd4c156bd', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mega Hybrid Veda Chews', 'At triple the strength of their counterpart, the Mega Hybrid Veda Chews are a very cost-effective option for patients seeking larger doses of cannabinoids. Sugar Free, Gluten Free, Vegan, Non-GMO, Soy Free.

Per Chew: 4.5 mg CBD, 52.5 mg THC
Per Package: 18 mg CBD, 210 mg THC', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Tg9yHcPwSX7BuIsx1rgh_VedaChews_ByAvedica_VerticalLogo.png', '7fc6876b-752a-4f9a-a8f8-27077ab6cdf4', 'ceb9853f-9206-4b44-9aea-749dd4c156bd', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hybrid Veda Chews', 'The Hybrid Veda Chews are an excellent option for balanced relief. They provide full-body relaxation and help to combat elevated stress levels. Sugar Free, Gluten Free, Vegan, Non-GMO, Soy Free.

Per Chew: 1.5 mg CBD, 17.5 mg THC
Per Package: 6 mg CBD, 70 mg THC', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/j2JquIXNRYqnvV65r20k_VedaChews_ByAvedica_VerticalLogo.png', 'cf32d340-bb56-4e01-b170-28097384a5dc', 'ceb9853f-9206-4b44-9aea-749dd4c156bd', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Veda Chews', 'The Indica Veda Chews are great for insomnia and chronic pain. Their higher concentration of cannabinoids create a stronger, more sedative effect. Sugar Free, Gluten Free, Vegan, Non-GMO, Soy Free.

Per Chew: 1.5 mg CBD, 17.5 THC
Per Package: 6 mg CBD, 70 mg THC', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/361faSx2QhWNsAYR5VNF_VedaChews_ByAvedica_VerticalLogo.png', 'ccd5a71e-e24c-4bbe-9bd8-42953bdcc28c', 'ceb9853f-9206-4b44-9aea-749dd4c156bd', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('C. Banana Packaged 1/8th', 'The C. Banana has been a Utopia signature flower since the companys inception. Consistently testing 29-34% THC,  the strain is known for its powerful and immediate effects. With a surprisingly smooth and balanced onset, the experience is uplifting and energizing. C. Banana has an aroma of fruity, fresh bananas that is countered by organic, earthy notes. This sativa-dominant hybrid has dense, dark-green growth and light-green finished flowers that are coated in sparkly trichomes and yellow-orange hairs.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/t04A88a9SiNGPaNJYC0A_Utopia_July_17_LOW_RES-49.jpg', '93935598-9ad9-487c-bf27-501ba07df2d9', '353d517f-8807-467b-bd28-719de8ce065b', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lambsbread Packaged 1/8th', 'Lambsbread is a flavorful Jamaican land-race strain that is known to be Bob Marleys favorite. Typically testing between 20% - 25% THC, the effects are uplifting and motivating, inspiring creativity and inducing waves of euphoria. The unique and pungent aroma is remniscient of cheese and fruit with flowery notes. This sativa grows tall, sturdy branches with pointy flowers that finish bright green with colorful orange hairs.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XyzqzaiDRn2GhW8w9O8i_Utopia_July_17_LOW_RES-50.jpg', 'f1fb434e-b154-4e0c-b0f3-85e3e46bfd39', '353d517f-8807-467b-bd28-719de8ce065b', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Assorted Gold Label Extracts (0.5 g)', 'Utopia manufactures pure, potent and flavorful extracts. Each batchs unique profile is captured via our refined extraction methods, resulting in cannabinoid and terpene levels as high as 97% and 16% respectively. All extracts are guaranteed below 50 ppm and free of microbioligical contaminants and pesticides to ensure an unadulterated, clean product. Produced and packaged in laboratory conditions using compliant closed-loop technology, medical-grade solvents and food-safe handling techniques, each batch is tracked and tested through SC Labs for quality assurance and transparency.  All flowers are sourced from Utopia‘s own garden or from fully inspected and certified greenhouses and indoor farms in Santa Cruz and Mendocino counties. Each batch is single-source meaning product is never blended from different gardens or harvests. These exquisite extracts are perfect for the connoisseur consumer looking to experience the full flavor and effect of pure cannabis.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/19BRXNC0SZsSFN8rP1lv_Utopia_Studio_Work_LOW_RES-19.jpg', '51c62336-742e-4ee0-b8fc-02d9f89aaebb', '353d517f-8807-467b-bd28-719de8ce065b', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Assorted Silver Label Extract (0.5 g)', 'Utopia manufactures pure, potent and flavorful extracts. Each batchs unique profile is captured via our refined extraction methods, resulting in cannabinoid and terpene levels as high as 97% and 16% respectively. All extracts are guaranteed below 50 ppm and free of microbioligical contaminants and pesticides to ensure an unadulterated, clean product. Produced and packaged in laboratory conditions using compliant closed-loop technology, medical-grade solvents and food-safe handling techniques, each batch is tracked and tested through SC Labs for quality assurance and transparency.  All flowers are sourced from Utopia‘s own garden or from fully inspected and certified greenhouses and indoor farms in Santa Cruz and Mendocino counties. Each batch is single-source meaning product is never blended from different gardens or harvests. These exquisite extracts are perfect for the connoisseur consumer looking to experience the full flavor and effect of pure cannabis.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/W6IlEkBRJSjSyjVuv1iQ_Utopia_July_17_HIGH_RES-52.jpg', 'bb619f83-71af-4f54-bd13-34894e4cea60', '353d517f-8807-467b-bd28-719de8ce065b', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Medicated Organic Chocolate', 'Our chocolate is smooth and dark. At 75% Cacao you will find its richness to be everything you need in a moment. 20 mg squares make it easy to medicate in doses.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/m0T5YGzeRMKAoFWs4hXw_chocolates.PNG', '52de2433-0f99-4a0e-b0d6-a56e9b24df24', 'c6d1feaf-8194-4883-8b71-e9f3935863ad', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GG5 (fka Gorilla Glue 5) / New Glue', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/483sVQMHTuyaY1Ww8kLJ_screenshot-www.instagram.com.2b2016-09-01.2b12-18-14.png', 'e6cb99d3-22ee-4176-9098-84b0f44958f4', '59b10e8c-06dd-49fe-a6e9-c37ae7031524', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('GG4 (fka Gorilla Glue #4) / Original Glue', 'GG4 (f.k.a. Gorilla Glue 4) by GG Strains is a potent hybrid strain that delivers heavy euphoria and relaxation, leaving you feeling "glued" to the couch. Its chunky, resin-covered buds fill the room with pungent earthy and sour aromas, inherited from his parents strains. GG4 was created by crossing with the following strains, Chems Sister, Sour Dubb, and Chocolate Diesel.

Achievements: GG4 has taking first place in the both the Michigan and Los Angeles 2014 High Times Cannabis Cups, as well first place in the 2015 Cannabis High Times World Cup in Jamaica, this hybrids supremacy is no longer a secret, and consumers will search far and wide to get their hands sticky with the real certified GG4 (f.k.a. Gorilla Glue 4) by GG Strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9UHGaHfMSenKudmu4Qr0_01bcfaf45443d3c6a1bdf4150c0eb15b3afa2ef9b2.jpg', '37edf99d-f619-42c5-83df-63342cdeb344', '59b10e8c-06dd-49fe-a6e9-c37ae7031524', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Purple Glue', 'The taste is really unique and has a taste of More on the Kush side but by crossing it with GG4 added a lot more yield to the plant. Finishing time is day 60.

Exclusive with Phat Panda & GG Strains LLC', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/x41LuLRaTsGvL3CTql3h_4.png', '690741f9-8d55-4e47-93a4-9497242c4783', '59b10e8c-06dd-49fe-a6e9-c37ae7031524', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('IndigoPro 500mg Cartridge - Night Rider - Indica', 'IndigoPros innovative Night Rider Indica 500 mg ceramic cartridges are pre-filled with high-potency, naturally-flavored artisanal CO2-extracted indica oil, made with the finest craft cannabis from The Farm in Boulder, Colorado.

Flavor: Sugar Plum', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/KjL28mXNT8WWB7nf8TgD_night_rider.jpg', 'fd668619-a3ff-49ec-a4ba-bea63d19e138', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('IndigoPro 500mg Cartridge - Indica', 'IndigoPros innovative Indica 500 mg ceramic cartridges are pre-filled with high-potency artisanal CO2-extracted indica oil, created with the finest craft cannabis from The Farm in Boulder, Colorado.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nwZGghU7SM2dtP8Ib8tQ_indica.jpg', '14d2e0b7-3d0b-4a3f-a9a4-2bdb65f0b787', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('IndigoPro 500mg Cartridge - Hybrid', 'IndigoPros innovative Hybrid 500 mg ceramic cartridges are pre-filled with high-potency artisanal CO2-extracted hybrid oil, created with the finest craft cannabis from The Farm in Boulder, Colorado.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4sO3NbsoRSWFkXP5CtkG_hybrid.jpg', 'c7b287a5-ccbd-4d28-800c-668ae46ab00b', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('IndigoPro 500mg Cartridge - Mountain Mist - Hybrid', 'IndigoPros innovative Mountain Mist Hybrid 500 mg ceramic cartridges are pre-filled with high-potency, naturally-flavored artisanal CO2-extracted hybrid oil, made with the finest craft cannabis from The Farm in Boulder, Colorado.

Flavor: Cool Mint', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/OAKI5GnUTHWtzCMNNW9u_mountain_mist.jpg', '2ca1e799-3dde-4abe-bb2b-9144de5e5072', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('IndigoPro 500mg Cartridge - Dragon Spice - Hybrid', 'IndigoPros innovative Dragon Spice Hybrid 500 mg ceramic cartridges are pre-filled with high-potency, naturally-flavored artisanal CO2-extracted hybrid oil, made with the finest craft cannabis from The Farm in Boulder, Colorado.

Flavor: Cinnamon Stick', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fkusFLnUShqsqImC9OsU_dragon_spice.jpg', '5aeec0d3-8aff-4c71-90e8-6a76124a4bb7', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('IndigoPro 500mg Cartridge - Sumatran Sunrise - Sativa', 'IndigoPros innovative Sumatran Sunrise Sativa 500 mg ceramic cartridges are pre-filled with high-potency, naturally-flavored artisanal CO2-extracted sativa oil, made with the finest craft cannabis from The Farm in Boulder, Colorado.

Flavor: Blood Orange', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/PmrXhAksTrWHLxAVCqg1_sumatran_sunrise.jpg', '5b98037e-103b-40f2-988d-ea624fb001a2', '85755afa-a01f-4b46-8040-ff6488f3eafa', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Diesel Sativa 1G Premium Oil POD Refill', 'Experience a revolutionary way to vape cannabis concentrates. The W Vaporizer produces consistent, full-bodied flavor with robust clouds of vapor. W award winning strain specific oil is designed to be vaped with our high tech pods. W Vaporizers are perfect for use wherever, whenever with our sleek and slim design, they feel good in the hand and fit nicely in the pocket. The W Brand industry leading manufacturing and laboratories created the perfect pod system that frees users from dealing with sticky, drippy oils. Each one of our products is made with the same attention to detail that you come to expect from the W Brand.

- W Oil is designed to provide full-bodied flavor in high tech pods
- Low maintenance, perfect for beginners and advanced users
- Easy view pod window
- Pods available in various strains
- Available in: 1 gram

We are Purists, plain and simple. We believe that the mission of the extraction process is to preserve and amplify the authentic soul of each cannabis strain. The vaping experience sh', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/EZ7ngQm8QqeDk7EhlI2h_10.2b25.2bW.2bVApes16715.png', '47241a6b-a7b2-46eb-af45-92555d5dca74', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tangie Sativa 1G Premium Oil POD Refill', 'Experience a revolutionary way to vape cannabis concentrates. The W Vaporizer produces consistent, full-bodied flavor with robust clouds of vapor. W award winning strain specific oil is designed to be vaped with our high tech pods. W Vaporizers are perfect for use wherever, whenever with our sleek and slim design, they feel good in the hand and fit nicely in the pocket. The W Brand industry leading manufacturing and laboratories created the perfect pod system that frees users from dealing with sticky, drippy oils. Each one of our products is made with the same attention to detail that you come to expect from the W Brand.

- W Oil is designed to provide full-bodied flavor in high tech pods
- Low maintenance, perfect for beginners and advanced users
- Easy view pod window
- Pods available in various strains
- Available in: 1 gram

We are Purists, plain and simple. We believe that the mission of the extraction process is to preserve and amplify the authentic soul of each cannabis strain. The vaping experience sh', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/M0wl8WNBSqWvsFBnpagY_Tangie_1GPodRefill.png', 'ceb6684b-c910-4ada-bc6f-30798269eccc', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Diamond OG Indica 1G Premium Oil POD Refill', 'Experience a revolutionary way to vape cannabis concentrates. The W Vaporizer produces consistent, full-bodied flavor with robust clouds of vapor. W award winning strain specific oil is designed to be vaped with our high tech pods. W Vaporizers are perfect for use wherever, whenever with our sleek and slim design, they feel good in the hand and fit nicely in the pocket. The W Brand industry leading manufacturing and laboratories created the perfect pod system that frees users from dealing with sticky, drippy oils. Each one of our products is made with the same attention to detail that you come to expect from the W Brand.

- W Oil is designed to provide full-bodied flavor in high tech pods
- Low maintenance, perfect for beginners and advanced users
- Easy view pod window
- Pods available in various strains
- Available in: 1 gram

We are Purists, plain and simple. We believe that the mission of the extraction process is to preserve and amplify the authentic soul of each cannabis strain. The vaping experien', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/uloVL9rQNycJ3fNldeFw_DiamondOG_1GPodRefill.png', '2b060cdf-4bb9-4291-9da6-ac8e31c5f77f', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Fire OG Hybrid Premium Cartridge', 'We are Purists, plain and simple. We believe that the mission of the extraction process is to preserve and amplify the authentic soul of each cannabis strain. The vaping experience should be the inhalation of the concentrated soul of a plant, with no additives, synthetics, flavorings, or adulterants in the mix. That is why we do small-batch, single-origin, strain-specific extraction of certified and lab-tested, pesticide-free, potency-proven cannabis flowers.

See why the California Chalice Cup named W Vapes one of the "Best Vape Cartridges" of 2016!  W Vapes premium cannabis oil is available in 300mg, 500mg, and 1G  pre-filled cartridges. Available in a variety of strain-specific seasonal Indica, Sativa, and Hybrid options, every cartridge contains locally-sourced, pesticide-free cannabis oil refined using a clean supercritical CO2 extraction process that preserves the flavor, character, and beneficial terpene compounds necessary for good medicine. Each cartridge contains oil derived solely from the specifi', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SObugL2AQASieydhwQJu_HYBRID-iso2-2.png', '003d1360-9ed4-4cb0-b547-1d69499593be', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Fire OG Indica 1G Premium Oil POD Refill', 'Experience a revolutionary way to vape cannabis concentrates. The W Vaporizer produces consistent, full-bodied flavor with robust clouds of vapor. W award winning strain specific oil is designed to be vaped with our high tech pods. W Vaporizers are perfect for use wherever, whenever with our sleek and slim design, they feel good in the hand and fit nicely in the pocket. The W Brand industry leading manufacturing and laboratories created the perfect pod system that frees users from dealing with sticky, drippy oils. Each one of our products is made with the same attention to detail that you come to expect from the W Brand.

‰ Õ W Oil is designed to provide full-bodied flavor in high tech pods
‰ Õ Low maintenance, perfect for beginners and advanced users
‰ Õ Easy view pod window
‰ Õ Pods available in various strains
‰ Õ Available in: 1 gram

We are Purists, plain and simple. We believe that the mission of the extraction process is to preserve and amplify the authentic soul of each cannabis strain. The vaping exp', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/iIfavNK6TKcZ2zclt9oa_BluefireOG_1GPodRefill.png', '9ccbb18c-8978-4f6e-8663-ff37888ebb3f', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Animal Cookies Hybrid 1G Premium Oil POD Refill', 'Experience a revolutionary way to vape cannabis concentrates. The W Vaporizer produces consistent, full-bodied flavor with robust clouds of vapor. W award winning strain specific oil is designed to be vaped with our high tech pods. W Vaporizers are perfect for use wherever, whenever with our sleek and slim design, they feel good in the hand and fit nicely in the pocket. The W Brand industry leading manufacturing and laboratories created the perfect pod system that frees users from dealing with sticky, drippy oils. Each one of our products is made with the same attention to detail that you come to expect from the W Brand.

- W Oil is designed to provide full-bodied flavor in high tech pods
- Low maintenance, perfect for beginners and advanced users
- Easy view pod window
- Pods available in various strains
- Available in: 1 gram

We are Purists, plain and simple. We believe that the mission of the extraction process is to preserve and amplify the authentic soul of each cannabis strain. The vaping experience sh', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ogES2GYQ5STzfbJ0nQyz_AnimalCookies_1GPodRefill.png', 'fbd919ec-8d4a-480f-80e0-ef3a02352aaf', '9e60564e-b5d3-45ce-8a38-43b440cf837a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD Kush', 'From the collaborative efforts of CBD Crew and Dutch Passion comes CBD Kush, a hybrid strain with equal parts THC and CBD. Bred from Kandy Kush and an unnamed high-CBD variety, CBD Kush typically tests around 7% in both THC and CBD, which may benefit consumers with a low tolerance or those treating conditions such as pain, inflammation, or anxiety. Its psychoactive effects are subtle, offering a tame experience that eases the muscles into relaxation without too much mental cloudiness.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YV44Uh2TRampjGCi1BcA_A2F7FF39-D916-4BD3-8133-A9C75412280E-23776-0000199FC33AADAB.jpeg', 'd34a4577-29da-4b74-bc4c-e185c232195b', 'f07d61b1-bc61-444d-932f-dddf2f2af72a', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa Green Crack CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Sativa:
1. Feelings of well-being and at-ease
2. Up-lifting and cerebral thoughts
3. Stimulates and energizes
4. Increases focus and creativity
5. Fights depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WCboXlChQ5uKhbQscDfi_green_crack.jpg', 'b48e5ca6-2435-4957-86d9-0bfe21141d4b', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa Jack Herer CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Sativa:
1. Feelings of well-being and at-ease
2. Up-lifting and cerebral thoughts
3. Stimulates and energizes
4. Increases focus and creativity
5. Fights depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/getvP2cBSaWpdaBk4Bwy_jack.jpg', 'eb9aa087-5c9f-46a1-940a-8c39617e8cbd', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa - Jack Herer PureONE CO2 Cartridge', 'At Pure Vape we are a team of perfectionists. While creating Pure One our mission was to deliver an experience that would raise the bar and establish the highest standard on the market. Today we are excited to announce that the search for the ideal cartridge is over. Please meet the One, the only … Pure One.

Features:

 -Triple Distilled Oil

 -10x more vapor

- Next generation ceramic cartriges

- Healthiest vaporizing technology

- no oil to coil burning

- Full Terpene Profile

- Extreme Potency

-`Solvent-Free

- Superior taste

- 9 strains

Our upgraded award winning triple distilled oil is made with pride. It is more clear, transparent and yes more THC potent than ever before. Free of glycol, glycerin or solvents we offer the true cannabis taste of full bodied terpene profile strains to enhance and compliment the therapeutic effects of cannabis while ensuring patient safety and satisfaction .

Our new ceramic technology eliminates burnt taste of the dinosaur days of "oil to metal coil". It captures th', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/pMKmN72WRr6J9t12TtIr_jeckherer.jpg', '3e74cd7d-facb-41af-847b-13be51ac3687', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa - Lemon Haze PureONE CO2 Cartridge', 'At Pure Vape we are a team of perfectionists. While creating Pure One our mission was to deliver an experience that would raise the bar and establish the highest standard on the market. Today we are excited to announce that the search for the ideal cartridge is over. Please meet the One, the only … Pure One.



Features:

 -Triple Distilled Oil

 -10x more vapor

- Next generation ceramic cartriges

- Healthiest vaporizing teschnology

- no oil to coil burning

- Full Terpene Profile

- Extreme Potency

-`Solvent-Free

- Superior taste

- 9 strains

Our upgraded award winning triple distilled oil is made with pride. It is more clear, transparent and yes more THC potent than ever before. Free of glycol, glycerin or solvents we offer the true cannabis taste of full bodied terpene profile strains to enhance and compliment the therapeutic effects of cannabis while ensuring patient safety and satisfaction .

Our new ceramic technology eliminates burnt taste of the dinosaur days of "oil to metal coil". It capture', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/kvdMLXomRz6MLbNKor91_lemonhaze.jpg', 'c86c3b8e-fc6b-4491-affe-664aa044a0e8', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa Maui Waui CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Sativa:
1. Feelings of well-being and at-ease
2. Up-lifting and cerebral thoughts
3. Stimulates and energizes
4. Increases focus and creativity
5. Fights depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/VrYdAj4cR5SNQ9yJgO14_maui_waui.jpg', 'bf2a0cf3-3a33-4745-9644-dcccd733bca0', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa Sour Diesel CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Sativa:
1. Feelings of well-being and at-ease
2. Up-lifting and cerebral thoughts
3. Stimulates and energizes
4. Increases focus and creativity
5. Fights depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WAbWgOMtRvqAUfLt8HdW_sour_diesel.jpg', 'de74245c-d4bf-4075-bbe2-0fb77e32c011', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa Super Blue Dream CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Sativa:
1. Feelings of well-being and at-ease
2. Up-lifting and cerebral thoughts
3. Stimulates and energizes
4. Increases focus and creativity
5. Fights depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qHZaFihxR8u2Tx8xub78_blue.jpg', '5904f1ce-9adf-446a-a6b2-512a500c10ed', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa Super Silver Haze CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Sativa:
1. Feelings of well-being and at-ease
2. Up-lifting and cerebral thoughts
3. Stimulates and energizes
4. Increases focus and creativity
5. Fights depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/MGvTTfL4Q06tDf2SyLzx_silverhaze.jpg', '69120ea2-a21e-46ce-b0cc-a23839137b08', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa Tangie CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Sativa:
1. Feelings of well-being and at-ease
2. Up-lifting and cerebral thoughts
3. Stimulates and energizes
4. Increases focus and creativity
5. Fights depression', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dcZnjyjJRuOdtNdXARLM_tangie.jpg', '67234c33-3817-4869-a8fe-8f67a31ee49d', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sativa - Tangie PureONE CO2 Cartridge', 'At Pure Vape we are a team of perfectionists. While creating Pure One our mission was to deliver an experience that would raise the bar and establish the highest standard on the market. Today we are excited to announce that the search for the ideal cartridge is over. Please meet the One, the only … Pure One.

Features:

-Triple Distilled Oil

-10x more vapor

- Next generation ceramic cartriges

- Healthiest vaporizing technology

- no oil to coil burning

- Full Terpene Profile

- Extreme Potency

-`Solvent-Free

- Superior taste

- 9 strains

Our upgraded award winning triple distilled oil is made with pride. It is more clear, transparent and yes more THC potent than ever before. Free of glycol, glycerin or solvents we offer the true cannabis taste of full bodied terpene profile strains to enhance and compliment the therapeutic effects of cannabis while ensuring patient safety and satisfaction .

Our new ceramic technology eliminates burnt taste of the dinosaur days of "oil to metal coil". It captures the ', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/QyGVcoVQ2yxA0cFpPZmK_tangie.jpg', '72cd01a5-2b97-4afb-8287-30d14d868c69', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hybrid Master Yoda CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Hybrid strains are a cross of two or more strains of cannabis, allowing the patient to get the desired effects of both Indica and Sativa strains in one Hybrid strain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TUoJIfKwRBq8UIslsJth_master_yoda.jpg', '8e0a0d5f-9d4f-4222-8cd9-5d16d41e42e6', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hybrid Pineapple Express CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Hybrid strains are a cross of two or more strains of cannabis, allowing the patient to get the desired effects of both Indica and Sativa strains in one Hybrid strain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dLfK39MSqC0grZXGkLxW_pineapple_express.jpg', '29b2b308-e767-4436-921f-97718700d68d', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hybrid - Pineapple Express PureONE CO2 Cartridge.', 'At Pure Vape we are a team of perfectionists. While creating Pure One our mission was to deliver an experience that would raise the bar and establish the highest standard on the market. Today we are excited to announce that the search for the ideal cartridge is over. Please meet the One, the only … Pure One.

Features:

 -Triple Distilled Oil

 -10x more vapor

- Next generation ceramic cartriges

- Healthiest vaporizing technology

- no oil to coil burning

- Full Terpene Profile

- Extreme Potency

-`Solvent-Free

- Superior taste

- 9 strains

Our upgraded award winning triple distilled oil is made with pride. It is more clear, transparent and yes more THC potent than ever before. Free of glycol, glycerin or solvents we offer the true cannabis taste of full bodied terpene profile strains to enhance and compliment the therapeutic effects of cannabis while ensuring patient safety and satisfaction .

Our new ceramic technology eliminates burnt taste of the dinosaur days of "oil to metal coil". It captures th', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/XpIYVeQeuIedewIL6nqw_pineappleexpress.jpg', '0e14e1aa-a47d-46fa-a03a-3a3ac642a5a9', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Critical Kush CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aoTPwV3gSEeqOgLT2TcG_critical.jpg', '0c1752fe-7b80-4b8e-8593-3b9fd91065b7', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Hardcore OG CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/06SBYt6Tqe18dy8uBuJ6_hardcore.jpg', '80cfb54b-6295-46d0-9fc7-c716d32c77ae', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica King Kush CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WzJwI6hDSaW4jtiNFinm_king.jpg', 'f9acd2db-1ad8-46cc-9703-f64d4a24aea0', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica LA Confidential CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YHyyal8ZRWePuT8agpk6_la_con.jpg', '1731a29e-ea22-4e70-94e3-6c3ec502b0fa', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Louis XIII CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9ictKvpTuSyFxjViPvHa_lui13.jpg', '0f10fe38-62e0-4d55-911f-93771c79f45f', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Northern Lights CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/lRzQR6FRGmlw1yYllTsw_north.jpg', '99fd59c8-68b7-4b11-9322-d144162a47b7', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica - Paris OG PureONE CO2 Cartridge.', 'Features:

 -Triple Distilled Oil

 -10x more vapor

- Next generation ceramic cartriges

- Healthiest vaporizing technology

- no oil to coil burning

- Full Terpene Profile

- Extreme Potency

-`Solvent-Free

- Superior taste

- 9 strains

Our upgraded award winning triple distilled oil is made with pride. It is more clear, transparent and yes more THC potent than ever before. Free of glycol, glycerin or solvents we offer the true cannabis taste of full bodied terpene profile strains to enhance and compliment the therapeutic effects of cannabis while ensuring patient safety and satisfaction .

Our new ceramic technology eliminates burnt taste of the dinosaur days of "oil to metal coil". It captures the best our oil has to offer, evenly heating it across a smooth ceramic basin with vapor delivered to your lips by a porcelain ceramic mouthpiece.

It is with these advancements, we bring to you an unparalleled vaping experience with higher vapor volume and Pure cannabis taste. Making it easy to see why its th', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Um5QwWNZTKCgD0Yzv9JK_parisog.jpg', '19de6a9a-29d2-4785-8332-593504e51780', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Private Reserve CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9QEzEPyTyyTmWFStYah9_privit.jpg', '407ec7eb-0156-4078-ab63-a11a2e50f25f', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Skywalker CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cT1ZVnfZTxLeDx8b32PQ_sky.jpg', 'c1d5bcd2-efb7-4b20-a340-9cf5028e6b95', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica - Skywalker OG PureONE CO2 Cartridge.', 'At Pure Vape we are a team of perfectionists. While creating Pure One our mission was to deliver an experience that would raise the bar and establish the highest standard on the market. Today we are excited to announce that the search for the ideal cartridge is over. Please meet the One, the only… Pure One.

Features:

 -Triple Distilled Oil

 -10x more vapor

- Next generation ceramic cartriges

- Healthiest vaporizing technology

- no oil to coil burning

- Full Terpene Profile

- Extreme Potency

-`Solvent-Free

- Superior taste

- 9 strains

Our upgraded award winning triple distilled oil is made with pride. It is more clear, transparent and yes more THC potent than ever before. Free of glycol, glycerin or solvents we offer the true cannabis taste of full bodied terpene profile strains to enhance and compliment the therapeutic effects of cannabis while ensuring patient safety and satisfaction .

Our new ceramic technology eliminates burnt taste of the dinosaur days of "oil to metal coil". It captures the', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/AEpWhlkPTLlRTRzscW5v_skywalkerog.jpg', 'a4434f94-3c0c-4bf2-900b-ff6a07f6536b', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Wiz Khalifa OG CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/9ovMPIdAQqKpK10IOvl8_s_l.jpg', '88b8de7b-6de8-427a-9320-4e8035c90b53', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hybrid Cali Kush CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Hybrid strains are a cross of two or more strains of cannabis, allowing the patient to get the desired effects of both Indica and Sativa strains in one Hybrid strain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IVLyLea5QmC513qcpIrq_cali_kush.jpg', 'cca4d451-7ea1-4f99-b45e-929375dfd964', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hybrid Platinum OG CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Hybrid strains are a cross of two or more strains of cannabis, allowing the patient to get the desired effects of both Indica and Sativa strains in one Hybrid strain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aPilflQGR66uQqLlIbqo_platinum_og.jpg', 'b8634c93-b2eb-4fb7-b266-4e937dec8cfc', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica Paris OG CO2 Cartridges', 'Our oil is one of the most potent on the market. Unlike many other brands that give you the results of raw oil that they then dilute, at Pure what you see is what you vape. Our Lab tests for each batch are printed on the package and most batches test well over 70% THC. Additionally, due to our natural process in which we use the terpenes found naturally in the flower, the flavor and draw from our cartridges is exceptionally smooth.

Benefits of Indica:
1. Relieves body pain
2. Relaxes muscles
3. Relieves spasms, reduces seizures
4. Relieves headaches and migraines
5. Relieves anxiety or stress', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nVwADrwT4CNlp7dwrDCr_paris.jpg', '542285ed-ca20-44e1-b6f2-e3e467fa1490', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica - Wiz Khalifa OG PureONE CO2 Cartridge.', 'At Pure Vape we are a team of perfectionists. While creating Pure One our mission was to deliver an experience that would raise the bar and establish the highest standard on the market. Today we are excited to announce that the search for the ideal cartridge is over. Please meet the One, the only… Pure One.

Features:

 -Triple Distilled Oil

 -10x more vapor

- Next generation ceramic cartriges

- Healthiest vaporizing technology

- no oil to coil burning

- Full Terpene Profile

- Extreme Potency

-`Solvent-Free

- Superior taste

- 9 strains

Our upgraded award winning triple distilled oil is made with pride. It is more clear, transparent and yes more THC potent than ever before. Free of glycol, glycerin or solvents we offer the true cannabis taste of full bodied terpene profile strains to enhance and compliment the therapeutic effects of cannabis while ensuring patient safety and satisfaction .

Our new ceramic technology eliminates burnt taste of the dinosaur days of "oil to metal coil". It captures the', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rPB1biaRk6GOTVTn25eX_wizkhalifaog.jpg', '19fd34f5-5d51-44ec-9450-b8ac48af9626', '62152838-604f-4b36-8b54-3c29499fae2f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Calyxir - Golden Goat Wax', 'Calyxir is our line of specialty Calyx Elixirs from Calyx Garden in Humboldt County, California.
Our Golden Goat - Isobutane Honeycomb Wax is carefully heat purged for 5 days leaving non-detectable residual solvents. You won‘t find a more aromatic and flavorful concentrate on the market!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/FPG5OYXlTJG1TAnfvvMA_cylixr.jpg', '98e5f2b6-c6a5-40b3-933a-4603b5266cea', 'd7fc6634-8d8f-4446-8d4e-2b0672f7089f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Eel River Organics Nectars 500 mg Vape Pen Cartridges', 'Grown naturally in the sun of Humboldt County with sustainable farming practices.  Pesticide free.  100% nug run with 100% cannabis oil extracted using   super critical CO2 distillate process.  The dry farming cultivation produces a plant with high terpenes, higher THC, and incomparable flavor.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/SMt1mapR1SeHxs2dLRjL_nectar.PNG', '63ccd726-1714-4d3d-97f4-85e64480fe4f', '08f5de46-f0d1-4bec-8a50-45f25f10be26', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1 Gram Clear Glass Applicator', 'Eureka now offers 1g of the finest clear oil to refill your own tank or dab on your favorite rig. Featuring our finest Thin Film Molecularly Separated Multi Cannabinoid CO2 extract, this oil is available in multiple Sativa, Indica, and Hybrid strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RFMgbssvRoSB1Rbj3WMV_clear_refill.png', '1c7f6720-56d3-467a-ab54-f8439a34362c', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1 Gram Amber Cartridge', 'The Eureka Amber cartridge is 100% natural and additive free, CO2 extracted cannabis oil. Refined over 4 times, Enjoy the purest cannabis oil, available in multiple Sativa, Indica, and Hybrid strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/yc4E0KIPQz24Y8d8yqOZ_amber_tank_1.png', '99c916bc-d88a-43a6-a7cd-37cb04e48df4', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1 Gram Amber Glass Applicator', 'Eurekas classic amber formula is now available as a 1g all glass applicator. Whether youre refilling our own tank, glazing your favorite joint or dabbing off your rig, Eureka has you covered. Featuring our signature CO2 extracted oil, this refill is available in multiple Sativa, Indica, and Hybrid strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fXO0ytw3SnWCDvlo3nF5_amber_refill.png', 'cd7166f6-d205-4932-8c5c-c3132a25aba6', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('300 mg Amber Disposable', 'The Eureka Amber Disposable comes in 300mgs of your favorite Sativa, Indica, and Hybrid CO2 oil. This discreet vape is never cut with any chemical additives and is perfect for on the go enjoyment!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6SWis9DCSLeoOvKz4cNH_amber_disposable.2b1.png', '27508085-b4d4-4b38-80c3-d672cad74990', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('500 mg Amber Cartridge', 'The Eureka Amber cartridge is 100% natural and additive free, CO2 extracted cannabis oil. Refined over 4 times for the smoothest vaping experience, this classic is available in multiple Sativa, Indica, and Hybrid strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/FVoDtlkYSjm3Sd6xHak3_amber_tank_co.png', 'aac60e50-a7ed-443c-9b5f-c6e734bc6093', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('500 mg Clear Cartridge', 'If youre looking for the highest cannabinoid levels and purest cannabis oil on the market, the Eureka Clear cartridge features 500mg of just that. 100% natural and solvent-free, this thin film molecularly separated multi-cannabinoid CO2 extracted oil is available in multiple Sativa, Indica, and Hybrid strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/N0doCxfpQjJ1VUb5sCeq_clear_tank_co.png', 'f02c9dfb-23d5-4db0-bf97-49c78fe179ae', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('300 mg Clear Disposable', 'The Eureka Clear Disposable is 300 mg of the finest thin film molecularly separated multi-cannabinoid oil. Available in Sativa, Indica, and Hybrid strains this small, discreet pen is perfect for anywhere you go!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/UNss3gZiQSmQibxGTmhs_clear_disposable.2b1.png', 'f3c79a3b-d26d-4c05-b106-79df36bfc43e', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1 Gram Clear Cartridge', 'If youre looking for the highest THC level and purest cannabis oil on the market, the Eureka Clear cartridge features 1g of just that. 100% natural and solvent-free, this Thin Film Molecularly Separated Multi Cannabinoid CO2 extracted oil is available in multiple Sativa, Indica, and Hybrid strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/iR8b2oVKQnCwuDvw8DQN_clear_tank.png', 'c6322ef2-56ad-41b9-b304-c4594f1218d1', '00c34f8e-3da9-4b3f-b108-25d4c917768d', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Blueberry', 'A true A-List cannabis strain. Blueberrys legendary status soared to new heights after claiming the High Times Cannabis Cup 2000 for Best Indica. The long history of the strain is traced back to the late 1970s when American breeder DJ Short was working with a variety of exotic landrace strains. However, throughout the decades of Blueberrys cultivation the genetics have been passed around, due in large part to DJ Short working with multiple seed banks and breeders. The sweet flavors of fresh blueberries combine with relaxing effects to produce a long-lasting sense of euphoria. Many medical patients appreciate Blueberry for its ability to suppress pain and relieve stress, while connoisseurs and growers admire the strain for its colorful hues and high THC content.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DmSlFMy2QKqhqxmrA6px_crafted-cannabis_blueberry_v2_1.jpg', 'b9615e2b-51d5-49ad-8ab5-3c84f7dfac40', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - SKYWALKER OG', 'Cartridges come in gold, white gold, and rose gold. Premium pure solventless oil with no additional additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8x9CRRmtQy6n8kxwdsIh_VVS_CARTRIDGE-CHROME.png', 'f100b7a9-f719-48d9-beaf-d500085a9ade', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - GG (f.k.a. Gorilla Glue)', 'Gorilla Glue #4, developed by GG Strains, is a potent hybrid strain that delivers heavy-handed euphoria and relaxation, leaving you feeling "glued" to the couch. Its chunky, resin-covered buds fill the room with pungent earthy and sour aromas inherited from its parent strains, Chems Sister, Sour Dubb, and Chocolate Diesel. Taking first place in both the Michigan and Los Angeles 2014 Cannabis Cups as well as the High Times Jamaican World Cup, this multiple award-winning hybrids supremacy is no longer a secret, and consumers will search far and wide to get their hands sticky with Gorilla Glue #4.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/WqQh6i4ERwW7jl4wE50n_Gorilla-Glue.jpg', '31dccf6c-12ff-49f8-9318-804f419de7db', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - GSC (f.k.a. Girl Scout Cookies)', 'GSC (f.k.a. Girl Scout Cookies), or GSC, is an OG Kush and Durban Poison hybrid cross whose reputation grew too large to stay within the borders of its California homeland. With a sweet and earthy aroma, GSC (f.k.a. Girl Scout Cookies) launches you to euphorias top floor where full-body relaxation meets a time-bending cerebral space. A little goes a long way with this hybrid, whose THC heights have won GSC (f.k.a. Girl Scout Cookies) numerous Cannabis Cup awards. Patients needing a strong dose of relief, however, may look to GSC for severe pain, nausea, and appetite loss.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/bxhRTqaeT4K53dtmuAg6_Girl-Scout-Cookies.jpg', '3fb6ed1b-33e6-4ec7-b61a-0975943f374e', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Jack Herer', 'Jack Herer is a sativa-dominant cannabis strain that has gained as much renown as its namesake, the marijuana activist and author of The Emperor Wears No Clothes. Combining a Haze hybrid with a Northern Lights #5 and Shiva Skunk cross, Sensi Seeds created Jack Herer hoping to capture both the cerebral elevation associated with sativas and the heavy resin production of indicas. Its rich genetic background gives rise to several different variations of Jack Herer, each phenotype bearing its own unique features and effects. However, consumers typically describe this 55% sativa hybrid as blissful, clear-headed, and creative.

Jack Herer was created in the Netherlands in the mid-1990s, where it was later distributed by Dutch pharmacies as a recognized medical-grade strain. Since then, the spicy, pine-scented sativa has taken home numerous awards for its quality and potency. Many breeders have attempted to cultivate this staple strain themselves in sunny or Mediterranean climates, and indoor growers should wait 50 t', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aLyeamBNQkO5EQQluM59_Jack-Herer.jpg', '2bd96a1e-b3c6-4485-90b5-8eb2d90c206c', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Northern Lights', 'Northern Lights stands among the most famous strains of all time, a pure indica cherished for its resinous buds, fast flowering, and resilience during growth. Itself a descendant of indigenous Afghani and Thai landrace strains, Northern Lights has given rise to famous hybrids like Shiva Skunk and Super Silver Haze. Rumor has it that Northern Lights first sprouted near Seattle, Washington, but was propagated out of Holland after 1985 at what is now Sensi Seeds.

Pungently sweet, spicy aromas radiate from the crystal-coated buds, which sometimes reveal themselves in hues of purple. Northern Lights psychoactive effects settle in firmly throughout the body, relaxing muscles and pacifying the mind in dreamy euphoria. Comfortable laziness allows patients to relieve pain and sleeplessness, while its mellow contentment roots out depression and stress. Several different Northern Lights phenotypes circulate the market, but Sensi Seeds recommends a general indoor flowering time of 45 to 50 days.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/uqTT9690QTiD580n9dua_Northern-Lights-Box-Mockup.jpg', 'f1fabb01-fcf4-4c9d-b42d-66ccc82f431c', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - OG Kush', 'OG Kush makes up the genetic backbone of West Coast cannabis varieties, but in spite of its ubiquity, its genetic origins remain a mystery. Popular myth maintains that Chemdawg and Hindu Kush parented OG Kush, passing on the distinct "kush" bud structure we see in many strains today. However, we cant be sure because OG Kush first came from bag seed in the early 90s. The earliest propagators (now known as Imperial Genetics) are said to have brought the seeds out of Florida to Colorado and southern California, where it now flourishes. There are many different phenotypes of OG Kush, some of which include Tahoe OG, SFV OG, and Alpha OG.

OG Kush is cherished for its ability to crush stress under the weight of its heavy euphoria. It carries an earthy pine and sour lemon scent with woody undertones, an aroma that has become the signature of OG Kush varieties and descendants. With OG Kush, patients most commonly cite improvements in migraines, ADD/ADHD, and stress disorders.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Cg7fmIl9T7iItJjqbhH8_crafted-cannabis_og-kush_v2_1.jpg', 'a7150749-bbe6-47bf-b2a6-a8823a38eb0e', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Pink Champagne', 'The flavor profile modeled after some of the finest Roses in the world the NOSE :Rounded yet delicate aromas of red fruits (red currants, raspberries and pomegranate) combine with blood orange and grapefruit. This is followed by hints of nuts, brioche, honey and caramel.

PALATE:

The attack is lively and fresh, yet rounded. The palate is intense, generous and powerful, yet delicate, with purity of fruit, great finesse and a long, lingering finish.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/GxvKS0SHTbKn18uxkJwz_Pink-Champagne.jpg', '7970f52a-4fd6-4925-a764-d07684086da8', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Sour Diesel', 'Sour Diesel, sometimes called Sour D, is an invigorating Sativa-dominant strain named after its pungent, diesel-like aroma. This fast-acting strain delivers energizing, dreamy cerebral effects that have pushed Sour Diesel to its legendary status. Stress, pain, and depression fade away in long-lasting relief that makes Sour Diesel a top choice among medical patients. This strain took root in the early 90s, and it is believed to have descended from Chemdawg 91 and Super Skunk.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Rle6oRQhSqCq4l6RFekB_Sour-Diesel.jpg', 'bad111f4-7ee0-4aaf-8915-6950066e9c2e', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Super Lemon Haze', 'A sativa-dominant hybrid of Lemon Skunk and Super Silver Haze and two time Cannabis Cup winner from Green House Seeds. Super Lemon Haze is a kief-caked multi-colored wonder. As the name states this strain has real lemony characteristics. The smell is zesty, citrusy, and a little sweet. As for the taste, its everything one would expect from the namesake; tart and sweet like lemonheads candy - not quite as sharp as one might expect. The effects are uniquely energetic and lively, may not be the best strain for those of us that are naturally wound-up tight.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DjfPRtgWTlq03AnJoCrH_SLH--.jpg', '222f226a-a134-4ba3-9558-4526c8938bcf', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - SOUR DIESEL', 'Cartridges come in gold, white gold, and rose gold. Premium pure solventless oil with no additional additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Q8ruOQzSYqtSK9F9v9gD_VVS_CARTRIDGE-CHROME.png', '634777c6-e859-45e6-be07-048da1e5df53', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - SUPER LEMON HAZE', 'Cartridges come in gold, white gold, and rose gold. Premium pure solventless oil with no additional additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/7Cvd1OwlRY2bcAoepUyv_VVS_CARTRIDGE-CHROME.png', 'c961e248-193d-464b-a157-d2a0e74994b6', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Tropical Haze', 'Heir to the GSC (f.k.a. Girl Scout Cookies) throne is Sunset Sherbet (or Tropical Haze), an indica-leaning hybrid with intoxicatingly potent effects. Sunset Sherbet inherits the genetic lineage of its GSC (f.k.a. Girl Scout Cookies) parent, whose ancestors include the famed OG Kush, Cherry Pie, and Durban Poison. Crossed with an indica known as Pink Panties, Sunset Sherbet exhibits powerful full-body effects elevated by a jolt of cerebral energy. A complex aroma colors Sunset Sherbet with notes of skunky citrus, sweet berry, and that candy-like smell redolent of its GSC (f.k.a. Girl Scout Cookies) parent. Stress, tension, and sour moods melt away with the carefree mindset and physical relaxation that comes with this rich hybrid.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8cGKuPicSf28tFEws3tn_Tropical-Haze.jpg', '49017097-1a0d-445f-b3f4-b8434d33655b', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Watermelon', 'Watermelon is an 80% indica strain. Its large, dense buds are valued for their high THC content and relaxing effects, useful as a sleeping aid or appetite stimulant. As the name suggests, this strain has a distinct fruity watermelon flavor profile, reminiscent of grape with hashy undertones. Watermelon is prized by growers for its high yield and potency, requiring 55 to 60 days flowering time.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2qnLykmpQwSnH3VOQuZI_Watermelon.jpg', '1e8b5aee-b4fe-4fca-8687-0a7c74e6d5b8', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Hemp & CBD Co. - Blueberry', 'Wild Blueberry CBD packs a sweet, berry taste that lingers long after the last exhale. This strain will calm your senses and put your mind at ease.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1dWgsXD2T2WPk6VXjU9K_wild_blueberry_cbd-edit-3.jpg', '68889393-327e-4e1e-9530-f103297efd86', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Hemp & CBD Co. - Mojito', 'Introducing Mojito, true A-Lister among CBD-rich cannabis strains. Take this flavor anywhere you feel like bringing vacation vibes with you. Perfect for relaxation, anxiety and anti-nausea.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/s4kiQc0QrSgdaXcSS7Vw_mojito_cbd-edit-2.jpg', '74b569b0-b162-4495-b14f-e7287b515aff', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Hemp & CBD Co. - Orange Cream', 'Orange Cream CBD is the ultimate flavor for awakening your senses with a burst of citrus flavors perfect for centering your focus and getting the day started. Whether youre on the road or at home, rejuvenate your senses and/or spark your creativity with some Orange Cream CBD!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/2f3BuhNSuCtAtiI6sN5I_orange_cream_cbd-edit-2.jpg', 'e91dbecc-42c1-4fc3-8023-b6ccad93c7d6', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crafted Cannabis Co. - Blue Dream', 'Blue Dream, a sativa-dominant hybrid originating in California, has achieved legendary status among West Coast strains. Crossing a Blueberry indica with the sativa Haze, Blue Dream balances full-body relaxation with gentle cerebral invigoration. Novice and veteran consumers alike enjoy the level effects of Blue Dream, which ease you gently into a calm euphoria. Some Blue Dream phenotypes express a more indica-like look and feel, but the sativa-leaning variety remains most prevalent.

With a sweet berry aroma redolent of its Blueberry parent, Blue Dream delivers swift symptom relief without heavy sedative effects. This makes Blue Dream a popular daytime medicine for patients treating pain, depression, nausea, and other ailments requiring a high THC strain.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8YuG1hcuTNWS6MwhxNGA_Blue-Dream.jpg', '4f96a66f-6f57-499a-9de0-30afc34c2910', 'f9644eb7-ccb3-44cc-a828-d0d7deae88d5', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Unwind Disposable Cartridge', 'Featuring notes of strawberry and banana, this strain is enhanced by a Limonene forward terpene blend, known for its calming and pain relieving effects. Kick back and relax. Each Aces cartridge is filled with carefully crafted cannabis distillate, an exceptional tasting, smooth drawing product resulting from a proprietary extract and filtration method.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/eQujiVS0RGqh0eZFvVRF_cb1.2bpink.2bunwind.jpg', '495f4442-ce44-4287-b0ff-158ec76d6c10', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Uplift Disposable Cartridge', 'Derived from Super Lemon Haze, the zesty lemon flavor is accompanied by a Beta-Caryophyllene forward terpene blend, known for its happy and uplifting effects.  Best enjoyed with friends. Each Aces cartridge is filled with carefully crafted cannabis distillate, an exceptional tasting, smooth drawing product resulting from a proprietary extract and filtration method.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/drxmWew9TneA6n0rB9oh_cb1.2bred.2bcart.2bpackage.jpg', 'ce44a7e5-d570-425f-ac17-aed7fda6e0e5', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Inspire Disposable Cartridge', 'Featuring notes of orange and citrus, this sweet-smelling strain is accompanied by a Myrcene forward terpene blend, known to stimulate your mind and arouse your curiosity. Each Aces cartridge is filled with carefully crafted cannabis distillate, an exceptional tasting, smooth drawing product resulting from a proprietary extract and filtration method.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YTwQ8shRdyXHcQfwMQkD_cb1.2bgreen.2bpen.2bcart.2bpackage.jpg', 'b31499f3-ecbb-4e7d-a379-3e3a8418c24b', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Energize Disposable Cartridge', 'Known for its sweet smell and flavor notes of pine and sage, this strain is complimented by an invigorating Terpinolene forward terpene blend.  The perfect way to get you through a long day. Each Aces cartridge is filled with carefully crafted cannabis distillate, an exceptional tasting, smooth drawing product resulting from a proprietary extract and filtration method.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wWPeNwQZSFGB5fHwaYbB_cb1.2bblack.2benergize.jpg', '985d40a2-0808-4fa3-b155-d779045e9db8', 'a9061aa7-5c75-4324-8073-f0733b66063a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('50mg Chocolate Fruit & Nut Snack Bar', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/HCRLsLYGQruDrFPP3WzQ_IMG_6602.JPG', '45787be7-6923-479b-a390-f6b378791583', '4aa30ac3-fdd2-4e21-973f-7a688023fe09', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('100mg Coconut Almond Candy Bars', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/VAQlfcxySpqwr9bnkVak_IMG_5790.JPG', '317416b5-7765-445e-91ad-cb7a3498d326', '4aa30ac3-fdd2-4e21-973f-7a688023fe09', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('100mg Pecan Caramel Turtles', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Z9R8eRRSYrXreMxbBoWQ_IMG_5794.JPG', 'dd7e4709-10c6-408a-8537-54a08adfaed4', '4aa30ac3-fdd2-4e21-973f-7a688023fe09', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('100mg Smores Crunch Bar', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xDbQlfDSSJ3PbYUezNcQ_IMG_5802.JPG', '9bae30c6-3a39-49a3-9a7f-1f831614536c', '4aa30ac3-fdd2-4e21-973f-7a688023fe09', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('100mg Smores Crunch Bar', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xDbQlfDSSJ3PbYUezNcQ_IMG_5802.JPG', '904190d4-47c5-4902-9b48-f6fd9abfbfe4', '4aa30ac3-fdd2-4e21-973f-7a688023fe09', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - KING LOUIE XIII', 'Cartridges come in gold, white gold, and rose gold. Premium pure solventless oil with no additional additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/55rhtI0SI6xdb8EeA6Gy_VVS_CARTRIDGE-CHROME.png', 'e2ded3ef-ece5-4dd1-95c5-f7ea63b1eabc', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - MASTER YODA OG', 'Cartridges come in gold, white gold, and rose gold. Premium pure solventless oil with no additional additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Jkp7CHyCQMK75idObkzT_VVS_CARTRIDGE-CHROME.png', 'bdd2524b-1457-44fd-9fbf-4f256c2597f2', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - PRESIDENTIAL OG', 'Cartridges come in gold, white gold, and rose gold. Premium pure solventless oil with no additional additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Bxl6c7PnT279qmaQQhg1_VVS_CARTRIDGE-CHROME.png', '47abf0bd-ece4-4bae-a614-34407c491020', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CARTRIDGES - TANGIE', 'Cartridges come in gold, white gold, and rose gold. Premium pure solventless oil with no additional additives.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Me17b0KQm6k6te5usVbK_VVS_CARTRIDGE-CHROME.png', '0637da15-2b95-4916-ab16-92be5530fbd1', '1e2e7e19-95b7-4c3a-bfd3-34f88c866dbb', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Petra Eucalyptus Mints', 'A precise blend of CA grown cannabis, green tea matcha and eucalyptus oil, our refreshing Eucalyptus Petra is perfect for clearing the senses. All Petra flavors are sugar free and contain the natural, plant-derived sweetener xylitol.
At 2.5 MG THC per mint, Petra gives you the ability to titrate your dose in precise increments. This accuracy allow you to integrate Petra more easily into your active lifestyle.

All Natural Ingredients: Xylitol, Matcha Tea, Dextrin, Natural Flavors, Rebiana (Stevia), Cannabis Extract, Magnesium Stearate, Silicon Dioxide.

*Available exclusively in California.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/gcVGvWVSmuVgURPNUGII_Petra_tin_with_mints_Eucalyptus.jpg', '4e089844-c67c-427b-992c-3ed9bdf115bd', '4ed6b674-9e03-4a47-992c-9019ee7dc026', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Petra Moroccan Mints', 'A precise blend of CA grown cannabis, green tea matcha and peppermint extract, our Moroccan Mint Petra has a refreshing peppermint taste with light notes of Tahitian vanilla. All Petra flavors are sugar free and contain the natural, plant-derived sweetener xylitol.
At 2.5 MG THC per mint, Petra gives you the ability to titrate your dose in precise increments. This accuracy allow you to integrate Petra more easily into your active lifestyle.

All Natural Ingredients: Xylitol, Matcha Tea, Dextrin, Natural Flavors, Rebiana (Stevia), Cannabis Extract, Magnesium Stearate, Silicon Dioxide.

*Available exclusively in California.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fSza09eiR6yzEb4EetQg_Petra_tin_with_mints_Mint.jpg', '964d5eba-5fd4-41ab-a4fa-300f0e584e11', '4ed6b674-9e03-4a47-992c-9019ee7dc026', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mint Irish Cream Bar', 'This crowd-pleasing flavor starts with the blending of refreshing mint into our creamy milk chocolate. Next, we add honey and a wee bit of Irish whiskey flavor to make the Mint Irish Cream taste as good as anything you can order in your local pub.

Potencies:
California, Arizona- 180mg/Bar
Nevada, Illinois- 100mg/Bar

All Natural Ingredients: Milk Chocolate (Sugar, Cocoa Butter, Milk, Unsweetened Chocolate, Sunflower Lecithin, Vanilla), Cannabis Extract, Natural Flavors.
Allergy Warning: Contains Milk. May Contain Traces of Nuts.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/VQQB5AycRkyG4nyjh5bq_220893_MlkChocDuo_180_Mint_Silo_FD.2bHERO.jpg', '637f8a69-7fde-4dcd-a943-9693809c8326', '4ed6b674-9e03-4a47-992c-9019ee7dc026', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blackberry Dark Chocolate Bar', 'A blend of fresh blackberries and toasty cannabis come together in our dark chocolate to create a unique flavor that lingers on your
palate. Let the tart berry aroma mingle with the 54% cacao and savor this superb culinary combination.

Potencies:
California, Arizona- 180mg/Bar
Nevada, Illinois- 100mg/Bar

All Natural Ingredients: Semi-sweet Chocolate (Sugar, Unsweetened Chocolate, Cocoa Butter, Potassium Carbonate, Sunflower Lecithin, Vanilla), Cannabis Extract, Natural Flavors.

Allergy Warning: May Contain Traces of Nuts and Milk.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YpA4NORvOdhauTWJqKqQ_220893_DkChocDuo_180_Blkbry_Silo_FD-HERO.jpg', '6d4f22c1-d6c6-432f-a383-824b20d58e1a', '4ed6b674-9e03-4a47-992c-9019ee7dc026', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tangerine Bar', 'The clean, bright aroma of fresh tangerines compliments the earthy characteristics of cannabis and brings out a zing in our dark chocolate. With a zesty tang and creamy body, our Tangerine flavor strikes a tasty balance between citrus and chocolate.

Potencies:
California, Arizona- 180mg/Bar
Nevada- 100mg/Bar

All Natural Ingredients: Semi-sweet Chocolate (Sugar, Unsweetened Chocolate, Cocoa Butter, Potassium Carbonate, Sunflower Lecithin, Vanilla), Cannabis Extract, Natural Flavors.
Allergy Warning: May Contain Traces of Nuts and Milk.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/r7QaLpPsQK2WH1h5xreM_220893_DkChocDuo_180_Tang_Silo_FD.2bHERO.jpg', '74411298-c585-442b-9faa-c75be6455366', '4ed6b674-9e03-4a47-992c-9019ee7dc026', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Mint Irish Cream Bar', 'This crowd-pleasing flavor starts with the blending of refreshing mint into our creamy milk chocolate. Next, we add honey and a wee bit of Irish whiskey flavor to make the Mint Irish Cream taste as good as anything you can order in your local pub.

Potencies:
California, Arizona- 180mg/Bar
Nevada, Illinois- 100mg/Bar

All Natural Ingredients: Milk Chocolate (Sugar, Cocoa Butter, Milk, Unsweetened Chocolate, Sunflower Lecithin, Vanilla), Cannabis Extract, Natural Flavors.
Allergy Warning: Contains Milk. May Contain Traces of Nuts.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/VQQB5AycRkyG4nyjh5bq_220893_MlkChocDuo_180_Mint_Silo_FD.2bHERO.jpg', '2480da84-5a73-44d1-861e-145a37b2c794', '4ed6b674-9e03-4a47-992c-9019ee7dc026', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blackberry Dark Chocolate Bar', 'A blend of fresh blackberries and toasty cannabis come together in our dark chocolate to create a unique flavor that lingers on your
palate. Let the tart berry aroma mingle with the 54% cacao and savor this superb culinary combination.

Potencies:
California, Arizona- 180mg/Bar
Nevada, Illinois- 100mg/Bar

All Natural Ingredients: Semi-sweet Chocolate (Sugar, Unsweetened Chocolate, Cocoa Butter, Potassium Carbonate, Sunflower Lecithin, Vanilla), Cannabis Extract, Natural Flavors.

Allergy Warning: May Contain Traces of Nuts and Milk.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/YpA4NORvOdhauTWJqKqQ_220893_DkChocDuo_180_Blkbry_Silo_FD-HERO.jpg', '8dd76942-b0eb-4e3f-ac61-fee7c1f4b3d7', '4ed6b674-9e03-4a47-992c-9019ee7dc026', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer Cartridge', 'Humboldt Golds Jack Herer Cartridge is an easy and convenient way to medicate, this smooth concentrate provides all the awesome Sativa forward effects of this landmark strain. Named after iconic activist Jack Herer, this baby will energize your mind and calm your anxiety for a perfect daytime buzz.

Available in 500/1000 MG Cartridge', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zT5cMmd5QXahwymGZpRx_HG_Cart_1000_side.jpg', 'beac4edd-1d55-48ad-b9a7-6eb235ce12e7', '80600697-efca-418d-bd60-ffe738468a3a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blue Diamond Cartridge', 'When youre in the mood for something sweet, try Humboldt Golds Blue Diamond Cartridge, the Indica heavy effects of Blue Diamond are perfectly encapsulated in a cartridge thats compatible with most battery types. Take a pull and feel the euphoria and relaxation wash over you while tempting your taste buds with a earthy sweet profile.

 Available in 500/1000 MG Cartridge', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8TjtwBmGTsKG1OfWcY7U_HG_Cart_1000_side.jpg', 'a6a980ea-2da1-41d7-9cbf-52fda8b326f7', '80600697-efca-418d-bd60-ffe738468a3a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blackberry Cartridge', 'Earthy and sweet, Humboldt Golds Blackberry Cartridge delivers a wonderful flavor with every toke and the euphoric effects soak in with every puff. Humboldt Gold offers this Hybrid concentrate for those seeking a sweet oil cartridge that delivers energy, stress relief and focus.


Available in 500/1000 MG Cartridge', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/pLqn1Cl8RV6O8qYtSlIw_HG_Cart_1000_side.jpg', '13b9b8c7-fc6f-4a47-a457-71572c045915', '80600697-efca-418d-bd60-ffe738468a3a', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OilStix ULTRA Cartridge (Keef Brands)', 'Pure- strain specific Co2 cannabis extract. Industry leading wickless & ceramic cartridge technology. Visit or call your local OilStix retailer for current strains!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/61KJy4w5Tsa2OA46jMCt_Leafly.2bOilStix.2bULTRA.2bProdcut.2bPhoto-01.jpg', '4cb80207-8cf4-4144-9280-d5c756f4453d', '78c5d260-8775-46ec-861d-902a023b2167', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OilStix ULTRA Cartridge (Keef Brands)', 'Pure- strain specific Co2 cannabis extract. Industry leading wickless & ceramic cartridge technology. Visit or call your local OilStix retailer for current strains!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/61KJy4w5Tsa2OA46jMCt_Leafly.2bOilStix.2bULTRA.2bProdcut.2bPhoto-01.jpg', '54172f95-d531-403d-bbea-b42df934289a', '78c5d260-8775-46ec-861d-902a023b2167', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('OilStix Syringe (Keef Brands)', 'Pure- strain specific Co2 cannabis extract. Ergonomically designed glass syringe - perfect for dabbing. Visit or call your local OilStix retailer for current strains.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vcF4HzS1R6WEexCdtYQQ_Leafly.2bOilStix.2bSyringe.2bProdcut.2bPhoto-01.jpg', '77a2f4a9-382a-4a3b-8040-49e4d79f55d9', '78c5d260-8775-46ec-861d-902a023b2167', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PunchBar 225mg', '225mg chocolate bar available in 10 milk & dark flavors', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/M7Z2zv1T2qDz1qBHt0KW_Studio.2bSession.2b-.2bPunch-092.jpg', 'a966e260-fea5-4ace-86c6-bb9e3ecce7b2', 'a05f9fb7-b804-4ea2-9aa3-eaecc7aa7850', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('PunchBar Cream 225mg', 'The PunchBar Cream line has 5 white chocolate flavors at 225mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/7mEWTlQXQoC22eMvW2mk_Studio.2bSession.2b-.2bPunch-128.jpg', '279c598c-acfa-4176-bf96-c7fa2bf635ab', 'a05f9fb7-b804-4ea2-9aa3-eaecc7aa7850', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Punch C-90', 'The Punch C-90 is our CBD bar. 0% Thc and 90mg of Cbd. Available in 2 flavors', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6E6zuhAMRrovh3FpGpK2_Studio.2bSession.2b-.2bPunch-123.jpg', 'f9b901ce-5739-4b3b-a245-5cf670a1d0ee', 'a05f9fb7-b804-4ea2-9aa3-eaecc7aa7850', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD infused chocolate', 'Human Grade (yes, you can eat them especially if youre lovely furry baby is eating them)

Gluten-Free, NO Wheat, NO Corn, NO Soy, NO Artificial Preservatives, No Food Dyes or Flavorings, NO Hormones, NO Pesticides, No Added Sugars or Sodium

Contains 1 mg CBD per biscuit.

Feeding Guideline:  2 biscuits per day. Start with one biscuit and observe dog‘s comfort level over a 6 to 8 hour period before offering another biscuit. CBD is cumulative and may take 2 to 3 days to take effect.

Inactive Ingredients (Gluten-Free.  No wheat, corn, soy.) Finely Ground:
Organic Lentils, Organic Split Peas, Organic Whole Fresh Eggs, Organic Quinoa, Organic Pumpkin, Organic Amaranth, Organic Coconut Oil (Pure, Non-GMO, Cold-Pressed), Organic Wheatgrass Powder, Bone Meal Powder (Pure, Sterile), Organic Chia Seeds, Organic Flaxseeds, Lecithin (Sunflower), Sea Vegetables (Kelp, Iceland Waters Origin, Hand Harvested), Vitamin E (Non-GMO Sunflower Oil), Agricultural Industrial Hemp, Sufficient  Purified Water Added for Processing.
', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/P6BULfETPuRmWJahkTIw_chocolate.2bbox.png', '158fa062-4961-40ca-ac4c-3acdc426723e', '0f70b3f1-7f71-42b5-a8f1-39649ed8c922', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Indica THC Patented Lozenge', 'Pure Ratios introduces a new kind of patented sustained-release delivery Lozenges that rewrites how cannabis-based compounds will be administered more efficiently by mouth. The small soft lozenge is designed to slowly dissolve in the mouth (about 30 to 45 minutes). During that time the lozenge continuously delivers a steady stream of cannabinoids to the oral mucosa. Available in 10 and 25 mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/80XiwPCSQYORljEpqMsx_indica.2blozenge.2b25mg.png', '52de3373-3106-4b09-b674-47c530a2991d', '893111d3-6962-4cc2-8576-bc6b1dc1668b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('1:1 CBD:THC Patented Lozenges', 'Pure Ratios introduces a new kind of patented sustained-release delivery Lozenges that rewrites how cannabis-based compounds will be administered more efficiently by mouth. The small soft lozenge is designed to slowly dissolve in the mouth (about 30 to 45 minutes). During that time the lozenge continuously delivers a steady stream of cannabinoids to the oral mucosa.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/7iKnS7jQTJO2lUmzkVxB_1to1.2blozenge.png', '993a5d2c-dff6-4721-996e-0d9567739a37', '893111d3-6962-4cc2-8576-bc6b1dc1668b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('4:1 CBD:THC Patented Lozenges', 'Pure Ratios introduces a new kind of patented sustained-release delivery Lozenges that rewrites how cannabis-based compounds will be administered more efficiently by mouth. The small soft lozenge is designed to slowly dissolve in the mouth (about 30 to 45 minutes). During that time the lozenge continuously delivers a steady stream of cannabinoids to the oral mucosa.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/85sFameSve7pmQlGcdRg_4to1.2blozenge.png', '962c459d-3e19-4c4c-b0a8-ded087089780', '893111d3-6962-4cc2-8576-bc6b1dc1668b', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Harlequin', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IzkXNIBbT6uxzfoSsqgt_Harlequin-01.jpg', '9c36b30b-5d14-45e2-be61-eb20c7542603', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Blueberry Bomb', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TuWUbQvS4ilUAcdq35qV_Blueberry.2bBomb-01.jpg', '98eabbc1-1c51-4fc5-a360-c658128d6fbc', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bright Fire', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/58nltt3oSE7FJnqE4RMn_Bright.2bFire-01.jpg', '964c2abb-3f00-474e-af46-fa2461335245', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Earthshaker OG', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/S1SzvO9AQ9GPHhq7Jjvx_Earthshaker.2bOG-01.jpg', '1f647411-cddc-4d42-b075-ae2ee07aae17', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Electric Lemonade', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CsnCXxvGQVqS73TkOTFG_Electric.2bLemonade-01.jpg', '64a2c207-afda-41d6-8e61-b1b5500cc0b8', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Galactica OG', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Oi6POhCfR0qBYIkEwgcG_Galactica-01.jpg', '67cc1f6e-94da-4cd1-a056-85af22c78826', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Pennywise', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/3N7F0m5SdyffFoqlK3Pp_Pennywise-01.jpg', '4ff09e9a-6280-4397-a34f-36b8839845c4', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Professor Chaos', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/hMgRyzQWKSA8eCjJOUbg_Professor.2bChaos-01.jpg', '9f37391a-adbf-49b3-81f6-9eb9830008e7', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Saturn OG', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/3YQmqCPTQAqSGEwj4cPc_Saturn.2bOG-01.jpg', '1229fc31-d602-460d-b547-26f9ce701af9', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tangie Sunrise', 'No description', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/20XmtyJgQUeihWxc2X43_Tangie.2bSunrise-01.jpg', 'adae8e23-8cd3-4c79-b60e-d3a8e7982a24', '1160c17a-f575-48ae-b4f0-ee304abe6db4', 'flower', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Bears Sour Gummies', 'Hemp Infused Gummies.
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Supplement Facts
Serving Size: 15 Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xRiZjUyPRh2jSgd7CS6r_gummie.2bbears.2bContainer.2bclear.jpg', '856528e3-d36f-47dd-83fa-0e07932c5dc6', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Fruits Shape Sour Gummies', 'Hemp Infused Gummies.
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Supplement Facts
Serving Size: 18 Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wqxmEtZSRizEA2IreWGA_tutti.2bfrutti.2bContainer.2bclear.jpg', 'd37a9a59-62b9-4ae1-a341-1b710ea63cbe', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Pufflettes Sour Gummies', 'Hemp Infused Gummies.
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Supplement Facts
Serving Size: 12 Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/28BFcznYQQCXhsCFXxT6_sour.2bdrops.2bContainer.2bclear.jpg', '7d2bcd3d-bfd9-4626-9835-5e374e9ed75a', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Rainbow Sour Gummies Kosher', 'Hemp Gummy
*Packed in child proof bottle*
*Kosher*
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Improve your overall lifestyle with our Elite products!

Supplement Facts
Serving Size: 17 Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/fjM5LQyTsuttOKhJfls0_sour.2brainbow.2bContainer.2bclear.jpg', 'b3e30f24-eb38-4ed0-a495-c08bcc748db4', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Sour Gummies', 'Hemp Infused Gummies.
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Supplement Facts
Serving Size: 17 Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zuDX3IGnTua8T5wPYy2e_sour.2bgummies.2bContainer.2bclear.jpg', 'ef4aadae-20cb-4366-a02b-b3d91ba97da9', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Star Sour Gummies Kosher', 'Hemp Gummy
*Packed in child proof bottle*
*kosher*
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Improve your overall lifestyle with our Elite products!

Supplement Facts
Serving Size: 8 Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/agDFn1fXQei6pkPs8rlc_star_gummy.jpg', '0f9a4ff2-64dc-45d4-a51b-579cce3a8508', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Watermelon Sour Gummies', 'Hemp Infused Gummies.
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Supplement Facts
Serving Size: 13 Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1fPG8V29Q86ZqKXCIzcG_sour.2bwater.2bmelon.2b.2bContainer.2bclear.jpg', 'c3e0db75-30d2-46d7-8f3a-6f3928dd62a0', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Hemp Based Worm Sour Gummies', 'Hemp Gummy
*Packed in child proof bottle*
Recommended intake: 1-2 per hour

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Improve your overall lifestyle with our Elite products!

Supplement Facts
Serving Size: 10  Gummies
1.7oz (46g)

Must be 21 and over to purchase this product.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5rbwMxC5SQC3HGE6aZOd_Sour_Neon_Worms.jpg', '92dbd6f8-b83e-4bb6-8de1-aee982292aa2', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Crystal Pops Hemp Infused Lollipops (Variety)', 'Hemp Infused Rock Candy
Recommended intake: 1 a day

Relax Now, Feel Great.
Extreme Mood Enhancer.
Made in USA.

Supplement Facts
Serving Size: 3 Lollipops
1.9 oz (54g)

Must be 21 and over to purchase this product.

Variety', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/19yG9VnHQxireNrE8DDq_471273_1ec68d62ab5845feae1f9d4509a6e8ef_mv2_d_1450_3328_s_2.png', 'bac01c31-1aac-496d-b71b-1e9901dc7ef9', '1a241391-4051-48e8-8417-29fbcc0b7c9f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Watermelon Gummies, Indica 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/1xc4bFp4QW2FWbZxrSMI_WM-320-I.png', 'a04e355b-4634-4243-b476-d2b56b7b909f', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Watermelon Gummies, Sativa 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/xgOg2DKiR1aqvxOuOoqw_WM-160-S.png', 'fe8f5dc8-f68d-4c4b-b7aa-821d870450ef', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Watermelon Gummies, Sativa 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ytWYJOxHRNqkcspiHvAU_WM-320-S.png', 'f1976659-b1c4-402c-89ec-91648b7963f0', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Watermelon Gummies, Indica 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dOMF5uFFRSiTRhmyAQye_WM-160-I.png', '907b5e8c-587a-44ab-9bbb-40bd80a8399d', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sweet Bear Gummies, Indica 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/H4hNqLhPSHCGownpF0mz_SwB-160-I.png', '101686b1-96b5-40f6-8979-3e78fde263e1', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sweet Bear Gummies, Indica 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/Fjn3gKCfSbKAl2aIkS5C_SwB-320-I.png', '830bf577-b4b5-4ecd-8638-4fb402f2b6e6', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sweet Bear Gummies, Sativa 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TVOJ28VjSoiBHytqCKAe_SwB-160-S.png', '54b34178-ef06-4e24-ae11-c1554dd5006a', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sweet Bear Gummies, Sativa 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RGWIOTXsRJCkOe4hHs5k_SwB-320-S.png', '941e8aeb-5a33-448a-af27-0ce473a6a7b3', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Indica 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/W2fp5fKzR4OSJgnRpk7x_SrB-160-I.png', '7c3609ef-3072-40dc-8309-3b580bca642b', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Indica 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RBAARghRle8dvAiuwt8w_SrB-320-I.png', '923adc57-c2a4-4f34-8839-d9671d1bf311', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Sativa 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/NAiq07m1SmSMxJHkh5gu_SrB-160-S.png', '3c67f34d-eb28-4f90-a942-0b435afbbe94', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Sativa 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nCt4Y8qQDOzqCzzWjWid_SrB-320-S.png', '02751eb2-35fa-4a1c-8ade-83091a29162e', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Indica 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/W2fp5fKzR4OSJgnRpk7x_SrB-160-I.png', 'f89e875b-0ace-45a5-943c-b7fe27db06bf', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Indica 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/RBAARghRle8dvAiuwt8w_SrB-320-I.png', '9dfb96d2-fa20-444f-8eec-c00bd395ab87', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Sativa 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/NAiq07m1SmSMxJHkh5gu_SrB-160-S.png', 'f8118f72-8d20-41c6-8b8e-d7cb30f75d6b', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Sour Bear Gummies, Sativa 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nCt4Y8qQDOzqCzzWjWid_SrB-320-S.png', '0abf14f3-d002-42d9-85a1-2034eac0d4b5', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Juicy Peach Gummies, Indica 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/X0UG0xihRA2UImzOITJj_JP-160-I.png', '9b101e25-58de-4219-8e7b-9527cd3139ae', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Juicy Peach Gummies, Indica 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/s0L91pcQSsWy8c2RGyTC_JP-320-I.png', 'c4c9b9d3-ffac-4e2c-8e73-56cdea4009f6', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Juicy Peach Gummies, Sativa 160mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/NH6nE5uTjWT8pKmm9szi_JP-160-S.png', 'bf94df73-dcc4-45c4-a226-348d76ac9620', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Juicy Peach Gummies, Sativa 320mg THC', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ycTSNkz9SWJdRYam21we_JP-320-S.png', '8f6c1736-5264-4103-88e7-668e66598580', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD 1:1 Sweet Bear Gummies, 200mg', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/jKeEa2EWTA1Pi3JlZDDQ_CBD-SwB-200.png', 'cd8e6076-f75d-4ee8-9f39-2f769d1affb5', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('CBD 1:1 Watermelon Gummies, 200mg', 'Our Live Resin is made in the spirit of the Napalese Shaman from fresh plants and never using any harmful fillers or solvent. The resulting high level of terpenes and cannabinoids are called the "entourage effect" and makes Everest the highest you can get!', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/zdeByz1TCCMcb9EQcyIE_CBD-WM-200.png', '80dbaea8-7d42-40f9-94df-e80bd05c22d4', 'a36b38ff-eb23-4be6-b5d5-7468a5ff832a', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('2:1 CBD Dark Chocolate 4.20 Bar', 'Research indicates that CBD provides a range of therapeutic benefits and helps relieve anxiety sometimes associated with THC. Fair Trade 61% Cacao. Vegan, Gluten-Free, All-Natural

Cannabinoid Content: 120mg CBD : 60mg THC
6 segments per bar, each segment = 20mg CBD : 10mg THC

Ingredients: Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Soy Lecithin, Natural Vanilla Flavor), Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/MhiA3ZUR4Scf2kco11Qy_vcc-420-bar-cbd.png', '3a47b87c-6885-4969-bbcd-d23a5dcfad66', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('2:1 Ratio CBD Dark Chocolate 4.20 Bar Mini', 'Semi-sweet dark chocolate with 120mg CBD and 60mg THC (2:1 ratio). Research indicates that CBD provides a range of therapeutic benefits and helps relieve anxiety sometimes associated with THC. Fair Trade 61% Cacao. Vegan, Gluten-Free, All-Natural

Ingredients: Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Sunflower Lecithin, Vanilla Beans), and Cannabis Oil. VEGAN, GLUTEN-FREE

CBD Content: 20mg

THC Content: 10mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rhyDFAxbRnKHMxZTUA3J_420.2bBar-MINI-CBD-1200x1200.jpg', '5beec3c0-3c1a-47d0-8476-0580fe4d084f', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Agave-Sweetened Raw Vegan Chocolate Pyramid', 'THC Content= 30mg

Ingredients:  Agave, Cacao Powder, Cacao Butter, Soy Lecithin, Vanilla, Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aNYRrI7yTeGEAvyy7QiZ_vcc-agave-raw-vegan-chocolate-pyramid.png', 'b744f42c-9aab-4cab-9dcd-0451536b4df3', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('White Chocolate Cookies n Cream 4.20 Bar', 'The newest member of the 4.20 Bar collection. We took smooth, creamy white chocolate and folded in chocolate sandwich-cookie crumbles for a textural two-step. This marriage of creamy and crunch is a match made in heaven.

Cannabinoid Content: 200mg THC
Serving Size: 1 Segment (40 mg THC)
Servings Per: 5

Ingredients: 31% White Chocolate (Pure Cane Sugar, Cacao Butter, Full Cream Milk, Lactose, Sunflower Lecithin, Vanilla Beans), Chocolate Sandwich Cookies [Unbleached Enriched Flour (Wheat Flour, Niacin, Reduced Iron, Thiamine, Mononitrate (Vitamin B1)(, Riboflavin (Vitamin B2), Folic Acid), Sugar, Palm, and/or Canola Oil, Cocoa (Processed with Alkali), High Fructose Corn Syrup, Leavening (Baking Soda, and/or Calcium Phosphate), Cornstarch, Salt, Soy Lecithin, Vanillin (an artificial flavor), Chocolate], and Cannabis Oil.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aHFCLMW0T5qFwrf5kfgz_420.2bBar-CNC-1200x1200.jpg', '7d23c7f7-404d-43a2-b0d4-10f8ce3a4470', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lemon Kush 1g Refill Cartridge', 'Did someone ask for more limonene? This robust citrus profile is a tasty delight. An amazing daytime blend that is said to help ease pain & anxiety while boosting appetite & relaxation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/DrzbPFBvQ9O2XlIxzPXm_Silver-Lemon-Cart.png', 'a4ba0784-3a91-4960-8c1e-d43e5a3e6b81', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Milk Chocolate 4.20 Bar Mini', 'Smooth, creamy, classic milk chocolate. Great for making 4.20 s‘mores! Fair Trade 38% Cacao. Gluten-Free, All-Natural.

Ingredients: Milk Chocolate (38% Cacao Beans, Pure Cane Sugar, Full Cream Milk, Cocoa Butter, Sunflower Lecithin, Vanilla Beans), and Cannabis Oil.

(CONTAINS MILK). GLUTEN-FREE.

THC Content: 30mg THC', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/tDe3sZ1QtiBZJO22XfAj_420.2bBar-MINI-MILK-1200x1200.jpg', '7110ad9e-091a-4364-9bd7-513ded741c49', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Milk Chocolate + HempCrunch 4.20 Bar', 'THC Content= 200mg
6 - 40mg segments per bar

Ingredients:  Milk Chocolate (38% Cacao Beans, Pure Cane Sugar, Full Cream Milk, Cocoa Butter, Soy Lecithin, Vanilla Beans,) Hemp Hearts, Crisped Rice, Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/wZ3KJHYkTLmS4zCj1Go6_vcc-420-bar-hempcrunch.png', '5e6cf8a9-ea74-43e3-8b3e-ae383540b008', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Milk Chocolate + HempCrunch 4.20 Bar Mini', 'Milk chocolate with crisped rice and hemp hearts (an excellent source of heart-healthy omegas). Fair Trade 38% Cacao. Gluten-Free, All-Natural.

Ingredients: Milk Chocolate (38% Cacao Beans, Pure Cane Sugar, Full Cream Milk, Cocoa Butter, Sunflower Lecithin, Vanilla Beans), Hemp Hearts, Crisped Rice, and Cannabis Oil.

(CONTAINS MILK). GLUTEN-FREE.

THC Content: 30mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CZFVA7f1RoyTS2Z66VZn_420.2bBar-MINI-HEMP-1200x1200.jpg', '3392e9b9-3ef1-4ecc-ae62-08b489d113eb', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Milk Chocolate + Toffee 4.20 Bar', 'THC Content= 200mg
6 - 40mg segments per bar

Ingredients: Milk Chocolate (38% Cacao Beans, Pure Cane Sugar, Full Cream Milk, Cocoa Butter, Soy Lecithin, Vanilla Beans), Toffee (Sugar, Palm Oil, Dairy Butter Milk, Almonds, Artificial Flavor), Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/FmnrkkvnTkaihk154mNE_420Bar-Toffee-NEW.jpg', 'd17c2d30-fd46-4a63-be13-4152293e152f', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Milk Chocolate + Toffee 4.20 Bar Mini', 'Decadent milk chocolate blended with crunchy toffee bits. Fair Trade 38% Cacao. Gluten-Free.

Milk Chocolate (38% Cacao Beans, Pure Cane Sugar, Full Cream Milk, Cocoa Butter, Sunflower Lecithin, Vanilla Beans), Toffee (Sugar, Palm Oil, Sunflower Oil, Dairy Butter, Almonds, Contains 2% or Less of: Salt, Soy Lecithin), and Cannabis Oil.

(CONTAINS MILK, NUTS, SOY). GLUTEN-FREE

THC Content: 30mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/IFm0rD0NSbK12ooGHAsR_420.2bBar-MINI-TOFFEE-1200x1200.jpg', 'e1037063-a7cc-475a-b7ce-438a328623bb', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dark Chocolate + Popping Blackberry 4.20 Bar', 'THC Content= 200mg
6- 40mg segments per bar

Ingredients:  Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Soya Lecithin, Vanilla Beans), Popping Candy ( Sugar, Lactose [Milk and Sugar], Corn Syrup, Processed With Carbon Dioxide), Natural Blackberry Flavor, Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/bEZKFD51TEmjDwmpXUFe_vcc-420-bar-popping-blackberry.png', 'b33b3941-f4ee-4918-8c3d-39546f499f36', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dark Chocolate + Popping Blackberry 4.20 Bar Mini', 'Blackberry-infused dark chocolate with popping candy. Let the chocolate melt in your mouth while the fireworks begin! Fair Trade 61% Cacao. Gluten-Free.

Ingredients: Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Sunflower Lecithin, Vanilla Beans), Popping Candy (Sugar, Lactose [Milk and Sugar], Corn Syrup, Processed with Carbon Dioxide), Natural Blackberry Flavor, and Cannabis Oil.

(CONTAINS MILK). GLUTEN-FREE.

THC Content: 30mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/vNecYVkVQ3umvQLf8Dq3_420.2bBar-MINI-POPPING-1200x1200.jpg', '65302c3d-d2ed-4606-b82f-774c7942f31b', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dark Chocolate + Sea Salt 4.20 Bar', 'THC Content= 200mg
6- 40mg segments per bar

Ingredients:  Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Soy Lecithin, Natural Vanilla Flavor), Sea Salt, Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nE54T8qWRKmTzRDpqgnn_vcc-420-bar-dark-sea-salt.png', '418da1c0-cbe8-42dd-8ff6-d30a565c4778', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dark Chocolate + Sea Salt 4.20 Bar Mini', 'Gourmet dark chocolate with a hint of sea salt. Fair Trade 61% Cacao. Vegan, Gluten-Free, All-Natural.

Ingredients: Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Sunflower Lecithin, Vanilla Beans), Cannabis Oil, and Sea Salt.

VEGAN, GLUTEN-FREE

THC Content: 30 mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qr73doRxWJw9X3Y57Wtw_420.2bBar-MINI-SEASALT-1200x1200.jpg', '722928f3-faff-4d22-b931-1abb280155ad', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Milk Chocolate 4.20 Bar', 'THC Content= 200mg
6- 40mg segments per bar

Ingredients: Milk Chocolate (38% Cacao Beans, Pure Cane Sugar, Full Cream Milk, Cocoa Butter, Soy Lecithin, Vanilla Beans), Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/8CzJE4BVQG6qfzLdeBFv_vcc-420-bar-milk.png', 'f20343a5-60bf-46a1-97a4-7d279f63f709', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dark Chocolate + Peppermint Patty by 4.20 Bar — 180mg', 'THC Content = 180mg

Ingredients: Dark Chocolate, Sugar, Heavy Cream, Corn Syrup, Peppermint Extract Salt, Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/KFxBGDeROWV7rCD7hclo_vcc-420-bar-peppermint-patty-180mg.2b1.png', 'a13cc212-2589-43aa-b120-f5f6e3674c6a', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dark Chocolate + Peppermint Patty by 4.20 Bar — 60mg', 'THC Content= 60mg

Ingredients:  Dark Chocolate, Sugar, Heavy Cream, Corn Syrup, Peppermint Extract Salt, Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/7tzYxv7vRIywsAEAas8j_vcc-420-bar-peppermint-patty-60mg.png', '5542bc9e-eec9-4714-9dff-9b7ee20c4417', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('2:1 CBD Dark Chocolate 4.20 Bar', 'Research indicates that CBD provides a range of therapeutic benefits and helps relieve anxiety sometimes associated with THC. Fair Trade 61% Cacao. Vegan, Gluten-Free, All-Natural

Cannabinoid Content: 120mg CBD : 60mg THC
6 segments per bar, each segment = 20mg CBD : 10mg THC

Ingredients: Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Soy Lecithin, Natural Vanilla Flavor), Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/MhiA3ZUR4Scf2kco11Qy_vcc-420-bar-cbd.png', 'ed243247-e4b0-48ea-b366-5b8d19be5805', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('2:1 Ratio CBD Dark Chocolate 4.20 Bar Mini', 'Semi-sweet dark chocolate with 120mg CBD and 60mg THC (2:1 ratio). Research indicates that CBD provides a range of therapeutic benefits and helps relieve anxiety sometimes associated with THC. Fair Trade 61% Cacao. Vegan, Gluten-Free, All-Natural

Ingredients: Dark Chocolate (61% Cacao Beans, Pure Cane Sugar, Cocoa Butter, Sunflower Lecithin, Vanilla Beans), and Cannabis Oil. VEGAN, GLUTEN-FREE

CBD Content: 20mg

THC Content: 10mg', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rhyDFAxbRnKHMxZTUA3J_420.2bBar-MINI-CBD-1200x1200.jpg', '3fbcfa77-1817-4cdb-8482-b973a5093337', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Agave-Sweetened Raw Vegan Chocolate Pyramid', 'THC Content= 30mg

Ingredients:  Agave, Cacao Powder, Cacao Butter, Soy Lecithin, Vanilla, Cannabis', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aNYRrI7yTeGEAvyy7QiZ_vcc-agave-raw-vegan-chocolate-pyramid.png', '1326ba21-78eb-4029-92d7-b20867ca8110', '0984d06f-cce1-445e-8486-9f176652c145', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Caramel Bite 33mg THC', 'Chewy, buttery and delicious, our Caramel Bites are a tasty way to medicate. Each Caramel Bite contains 33mg THC (approximately 1-2 doses). We handcraft our caramels with premium cannabis oil and our time-tested recipes. For an extra uplifting sweet treat, try our Killer Caramel Bites with 100mg THC.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rQvFZiRxTL6JCCAYnfkk_LR-0021.jpg', '645e11a0-d7f2-4760-a138-5e311320529d', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Drop Candy 25mg THC', 'If youre looking for an on-the-go THC treat thats easy to enjoy anywhere, you want want to miss these drop candies. One of our biggest sellers, these candies are an excellent way to discreetly medicate. Each contains at 25 mg THC (approximately 1-2 doses for the average patient). We handcraft these with natural fruit flavors and premium cannabis oil to create an uplifting anytime snack.

They come in assorted fruit flavors including Blueberry, Cherry, Grape, Green Apple, Orange, Pina Colada, Strawberry, Raspberry and Watermelon.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TAVYkEaCS1C4aW45Ug0g_LR-0030.jpg', 'b6dd7bd3-6030-4305-abfd-bc4bf81f8a31', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Gummy Yummy 30mg THC', 'Made with real fruit flavor and premium cannabis oil, our Gummy Yummy candies promote uplifting relief from pain, anxiety and insomnia as well as aiding in mood enhancement and relaxation. Each jumbo bear contains 30mg THC (approximately 2 doses for the average patient).', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/6l2DL1SP6mtlfm0zqeUQ_LR-0014.jpg', '4170a756-f8c8-40f3-9c5c-0f4ecebedd2f', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Killer Caramel Bite 100 mg THC', 'Medicate deliciously with our chewy Killer Caramel Bites packed with 100 mg THC. Each caramel contains approximately 4 doses. We use our time-tested recipe and premium cannabis oil to handcraft these chewy, buttery and sinfully delicious caramels. Enjoy them plain or try melting them in your coffee or over ice cream for an uplifting sweet treat.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/sUEB1XSHT9SVSAUgnrUw_photo1.jpg', '9d99bf64-7971-40b3-a6a7-276a1666d9a0', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Killer Gummy Yummy 105 mg THC', 'If you love gummy candies then try our Killer Gummy Yummy. Handcrafted with real fruit flavor and premium solvent-free cannabis oil, our Gummy Yummy bears pack a punch with 105mg THC. All of our products are tested and can be used for relief from pain, insomnia and anxiety as well as aiding in mood enhancement and relaxation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ef14TjQAQFuWCwaBMbIG_LR-0017.jpg', 'c2219c86-dfe4-4791-9c7f-fb54e773cccc', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Killer Lollipop 90mg THC', 'A long-time patient favorite, our Killer Lollipops pack a punch. We handcraft our lollipops with real fruit flavor and premium cannabis oil to create an uplifting treat that tastes as good as it feels to eat. Each lollipop contains 90 mg THC (approximately 3 doses for an average patient). Our Killer Lollipops are available in Black Cherry, Berry-Berry, Green Apple and Grape.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/atvY8gOSQ5aK4MEN0Jc9_Killer.2bLollipop.jpg', 'e7870edd-dbf4-4192-96cc-48f742e0c78a', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Lemon Bite 30mg THC', 'Packed with citrus and 30mg THC, our Lemon Bites will make you want to pucker up for more. These tasty THC treats are handmade with real fruit flavor and premium cannabis oil. Each candy has 30mg THC (approximately 1-2 doses for the average patient). Youll love the taste and strength of this sour and sweet cannabis snack.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/A8TQTXCcQtWKyP56NS1h_LR-0033.jpg', '43ddff0f-e6de-446c-8df2-91a60d69ad82', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('BaKed Lollipop 25mg THC', 'Satisfy your sweet tooth with our deliciously medicated lollipops. We handcraft all of our candies using premium cannabis oil and real fruit flavor. Each lollipop has 25mg THC (approximately 1-2 doses for most patients). Want to up your THC intake? Try one of our Killer Lollipops with 90mg THC. Both are available in 10 uplifting fruit flavor combinations.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CLcOHgASuLwO9ctsIq5g_20170724_091902-01.jpeg', '2f3f44da-e0a5-4df0-b7d4-91cb1452101c', 'a7c65efe-3c39-4bd7-8f68-2043d530bc1f', 'edible', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Dantes Fire 1 ML', 'Good Vybes - Dantes Fire 1 ML', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rSyNdYwiSpsWgWgR5227_1mlDanteCartPack.jpg', '538d0353-3bbb-4036-a7ab-066f776cb926', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Dantes Fire .5 ML', '.5 ml Dantes fire Indica', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aiBIk6zkTV2ijPJQY6Xo_5mlDanteCartPack.jpg', '36ba155f-1c0c-4584-b2a0-3f6a5f170f72', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Donna OG 1 ml', 'Spliffin PURE - Donna OG 1 ml', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/CfegXH78TCuafchDdqBR_1mlDonnaCartPack.jpg', 'e1c548b7-3190-40e3-a939-5cdec8601d54', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Donna OG .5 ml', 'Spliffin PURE - Donna OG .5 ml', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/rChhorLzT3e0dlRbDgDx_5mlDonnaCartPack.jpg', 'a4daaa83-e737-4737-9622-2590fd8da16c', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Jack Herer 1ML', 'Spliffin PURE - Jack Herer 1ML', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/mJJ08qXtQOCDi3xkra49_1mlJackCartPack.jpg', '93c05baa-ec3e-4dfd-acd5-b12ec3222f9c', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Jack Herer .5ML', 'Spliffin PURE - Jack Herer .5ML', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/NpduUMySnGPSgi1l9VHL_5mlJackCartPack.jpg', 'a1611795-c1fb-472a-b672-0e9c23a7e4f2', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Spliffin OG 1ml', 'Spliffin Pure - Spliffin OG 1ml', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/nvc0v7ZMT02KXiTuTBxC_1mlCartPackSpliffinOG.jpg', '71cd9063-31d2-421f-afe5-ba090468f436', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Spliffin OG .5 ml', 'Spliffin PURE - Spliffin OG .5 ml', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/5GPZcn8DT7u0nIn1E4w2_5mlCartPackSpliffinOG.jpg', '9faf4b74-3cf5-4823-ae78-e20b95486ddd', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Tangie 1 ml', 'Spliffin PURE - Tangie 1 ml', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/aw03sA5R6iWnLhgiXutp_1mlCartPackTangie.jpg', 'a6de8dae-aba9-42cf-abb9-4928c7e7d161', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Spliffin PURE - Tangie .5 ml', 'Spliffin PURE - Tangie .5 ml', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/KudCfm3gS9W6V0JmJlYY_5mlCartPackTangie.jpg', 'c38720ef-b7dc-4ccb-b743-ca38a29319d4', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Quattro "QT"', 'Pre-filled +75% vaporizer with .25 ml PURE concentrate and natural terpenes
Indica Blend | Sativa Blend', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/4Tn8qdcrR6OxvJWsysZ1_PenHorizontal_web.jpg', '9e6633fb-0b4d-47cd-b49b-e81328d3ddce', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('DUB', 'Pre-filled THC cartridge with .5 ml of premium concentrate blend and natural terpenes
Indica Blend | Sativa Blend', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/l702fnWDQ5C9BEH79hHJ_DubIndicaSide_web.jpg', '8d6612fc-578d-44eb-96ad-1c41d15c83e8', '69db2851-8347-4dd9-8ead-0b5b7f3520e7', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Lemon Kush 1g Kit', 'Did someone ask for more limonene? This robust citrus profile is a tasty delight. An amazing daytime blend that is said to help ease pain & anxiety while boosting appetite & relaxation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/jJd8NjpLQo2XIugPeTx6_Silver-Lemon-Kit.png', '0ea846c6-b10c-4fbf-ad07-ff9981a7096d', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bubba² 1g Kit', 'The classic bubba kush. One hit will send you into nostalgia overload. Great for nighttime use, Bubba2 is said to help ease depression & pain while boosting focus & creativity.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/lwI8AmqYS1WOyIGhvTyK_Bubba-Kit.png', 'b291a8dd-38de-4f1c-92f1-ca4541a55898', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tropical Trainwreck 1g Refill Cartridge', 'Aloha! Trainwreck is an epic sativa strain which we have boosted with other tropical terpenes. This blend has hints of pineapple, citrus, and other tropical flavors that are sure to make you think youre sitting on a beach in Hawaii. Battery not included.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/VvqrZ8PYQAStwT1dOmPP_2017.09.13_Orchid_CA_Products_CART_White_TropTrain_SH.png', '3f801501-83a9-4225-bf6e-00b3b5f194a8', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dutch Treat 1g Refill Cartridge', 'Our Dutch Treat is a true terpene treat. With a delightful terpene profile, this is a great nighttime hybrid that is said to help ease stress & anxiety while boosting happiness & relaxation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/ozEgCIRRTvaQXePQTPgl_White-Dutch-Cart.png', '54029068-048b-4cf2-a877-4b3a0b213f21', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Bubba² 1g Refill Cartridge', 'The classic bubba kush. One hit will send you into nostalgia overload. Great for nighttime use, Bubba2 is said to help ease depression & pain while boosting focus & creativity.  Battery not included', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/cRKcjhYCSqmD26xy7NLf_Bubba-Cart.png', '85f7bcbc-bf35-477d-af20-bf1f2b27a108', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry Cough 1g Refill Cartridge', 'This inspired blend is a flavorful sensation. Great for daytime use, this classic is said to help ease stress & pain while boosting happiness & relaxation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/l4K4dQ5tRKd771VUyfi9_White-Strawberry-Cart.png', '0c33d445-b126-4b9c-960f-d2e67e091105', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Dutch Treat 1g Kit', 'Our Dutch Treat is a true terpene treat. With a delightful terpene profile, this is a great nighttime hybrid that is said to help ease stress & anxiety while boosting happiness & relaxation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/qA1vKTO7TXqyWtSzNNJK_White-Dutch-Kit.png', '1979b206-bac4-47e2-9ed1-7e249e540e76', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer 1g Refill Cartridge', 'Need we say more? This inspirational terpene profile makes this an awesome daytime favorite that is said to help ease depression & pain while boosting focus & energy.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/dEw6fdxnR584eAo72d9h_White-Jack-Cart.png', '5f28b4b9-d18f-4085-8e4e-a8b7561c1606', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Strawberry Cough 1g Kit', 'This inspired blend is a flavorful sensation. Great for daytime use, this classic is said to help ease stress & pain while boosting happiness & relaxation.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/a5cmOVzOT6KJuS45XtdL_White-Strawberry-Kit.png', '911c185f-a514-4c15-83f5-02c89f1c0439', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Jack Herer 1g Kit', 'Need we say more? This inspirational terpene profile makes this an awesome daytime favorite that is said to help ease depression & pain while boosting focus & energy.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/iDihdLbSJTp92HLV9AwE_White-Jack-Kit.png', 'f6898013-d3b0-4260-b41d-f87137b3ff51', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);
INSERT INTO public.product (name, description, image, id, business_id, category, sub_category) VALUES ('Tropical Trainwreck 1g Kit', 'Aloha! Trainwreck is an epic sativa strain which we have boosted with other tropical terpenes. This blend has hints of pineapple, citrus, and other tropical flavors that are sure to make you think youre sitting on a beach in Hawaii.', 'https://greentap-images-dev.s3.us-west-1.amazonaws.com/TBDbIftQ6WWYVmsf3mfm_White-Tropical-Kit.png', '3c765aee-b372-4fbc-9d1f-e5b723faa526', 'a09f62b4-b320-41ec-986c-0b11836a643f', 'concentrate', NULL);


--
-- Data for Name: product_pricing; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('fdab2d71-3e45-40c0-9ae4-22f4a1685da6', 'unit', 1400, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('9fa60cc0-c984-4262-a4e3-0c421f486c3b', 'unit', 1200, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('a3438500-92ed-4f63-b83a-259f1f308a35', 'unit', 1200, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('6a8184cb-799d-453b-95a4-12fb9bbd4818', 'unit', 1200, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('eb647ff7-cf52-46cf-95fd-d5814cd616ee', 'unit', 1400, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('6bf99970-081b-4f32-99f4-76627ba89a52', 'unit', 750, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('411a2858-f7f8-486b-a3b9-da94f166d2fd', 'unit', 750, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('f1586c43-25fc-47b9-8fee-876ebc759af7', 'unit', 750, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('24f3f0d4-7c62-47c2-a8af-504478fdabb0', 'unit', 1250, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('cd28bee5-91e8-447b-82d2-31302715fe3d', 'unit', 1250, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('b1948ab7-46c1-47c5-b048-a95cc9bcd16b', 'unit', 6599, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('1c776faa-7867-43c8-8b26-4aa6ccc569c5', '1/8 oz', 3500, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('afff6b73-a26d-473b-a2da-80b221bcdc3c', '1/8 oz', 3000, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('7723c4b6-7ece-4bb2-a02c-eb1ed4ab2919', '1/8 oz', 3000, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('227a6cc3-e067-4b7b-a266-0c7c0d1fddd9', '1/8 oz', 3000, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('31c97d05-e52b-4758-a377-1440395575d6', '1/8 oz', 3000, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('4bc2f2f8-e974-4798-9690-4f7700e6d84e', '1/8 oz', 3000, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('022a9f64-3bcf-45ed-a029-6468b7e90365', '1/8 oz', 3000, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('b41d9155-5e83-4757-a70c-bd3d0c6c0ca4', '1/8 oz', 3000, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('0299388e-98ba-4a86-8829-b1e40ca4f2c7', 'unit', 1400, 1);
INSERT INTO public.product_pricing (product_id, unit_count_type, unit_price, unit_count) VALUES ('3885c243-52c2-45da-8985-df3eecb8ff91', 'unit', 1400, 1);


--
-- Data for Name: reset_password_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.reset_password_request (email, token, "timestamp", used) VALUES ('arjunglobal09@gmail.com', '880eef0194d4938cb937bb3010693db8a89160ae9dd728f69d7be576ed7aaf78', '2020-03-17 01:42:56.18454+00', false);


--
-- Data for Name: topical; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.topical (product_id, business_id) VALUES ('db80f713-d4c7-4003-885e-3786f6250df4', '3cd0f7b6-aa1a-4b1a-9667-5c86764e4880');
INSERT INTO public.topical (product_id, business_id) VALUES ('6bf99970-081b-4f32-99f4-76627ba89a52', '4095902f-89c6-4f26-b666-01474c00b690');
INSERT INTO public.topical (product_id, business_id) VALUES ('411a2858-f7f8-486b-a3b9-da94f166d2fd', '4095902f-89c6-4f26-b666-01474c00b690');
INSERT INTO public.topical (product_id, business_id) VALUES ('f1586c43-25fc-47b9-8fee-876ebc759af7', '4095902f-89c6-4f26-b666-01474c00b690');
INSERT INTO public.topical (product_id, business_id) VALUES ('24f3f0d4-7c62-47c2-a8af-504478fdabb0', '4095902f-89c6-4f26-b666-01474c00b690');
INSERT INTO public.topical (product_id, business_id) VALUES ('cd28bee5-91e8-447b-82d2-31302715fe3d', '4095902f-89c6-4f26-b666-01474c00b690');


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('District Edibles', '$2b$10$ppeGqXF2.98ar2PwSCqZ4e6JCG4e/Le..g.0jx4cLpBUuCTwjuSAC', 'district-edibles@R8NX5IAMO70V.com', 'District Edibles', 'seller', false, '855acf4b-6095-4516-8fc9-00802b71d1d3');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Shepherds Meadow Farm', '$2b$10$WP/vzcCRYyP.LY2KOIRNe.k3JxqjU8sO8YhVtlJUKnJnulA6lj6pO', 'shepherds-meadow-farm@ST56NT1BNW5J.com', 'Shepherds Meadow Farm', 'seller', false, '717a40c4-ee8a-4546-aa5a-a3304c50e99c');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Lola Lola', '$2b$10$9Pmw2Bj5cN9fRioDcS1n.OSOYWJpWqA7rdsjpqEvWhjX/9CcdgI4i', 'lola-lola@LH896MHTYRFS.com', 'Lola Lola', 'seller', false, 'bfd6268a-02b2-4dd0-88c1-d451b2bdc913');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Flurish Group', '$2b$10$kNR86Fq5lD1fs2hFLk6DNuq99wDdnnR01HpkpzNTtpcHdZ4ycG0Mq', 'flurish-group@QCZ58CRNSBCH.com', 'Flurish Group', 'seller', false, '22d827e3-6f35-413a-9a51-037ab44f91f0');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('PureCure', '$2b$10$P2Oia9IQfZIq7gAp2A.Dr.YqnFZMyNijvBSzlTZQ6Xq44w53pujuK', 'purecure@1C4W1257YH1I.com', 'PureCure', 'seller', false, 'd579a85a-3072-4157-bf30-1d3183a16cbc');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Upside Edibles', '$2b$10$6gb5oGv/beAfGgqSg6.zlOum0coifMjV4yynmmWdJMlCOleFPe03K', 'upside-edibles@1TACUG8JZ8XH.com', 'Upside Edibles', 'seller', false, '4de210b9-ace9-429d-a462-81d78f1690c3');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Marley Natural', '$2b$10$gVREUU.uLR/JJJWuSN5GMeBjU9jyN9KSLcdcXHnW2oGnu89Xwy0HK', 'marley-natural@L3DMZ3O382NG.com', 'Marley Natural', 'seller', false, '59b7100a-355c-412f-82f7-8fc05c813dac');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Dixie Elixirs & Edibles', '$2b$10$od1G9gSOy7qloMwS.Rifq.FomoDDhahZktbVsquuhEtXXcJLxaygm', 'dixie-elixirs-edibles@VZN1HWTXIBJ8.com', 'Dixie Elixirs & Edibles', 'seller', false, '6aa53d14-d4ad-4e34-8aed-a25783572a2f');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Kushy Punch', '$2b$10$uQdY/V6wIQC/WmS7JJiYx.oH.fKEUpXwFXNW/NojAiXXOQ18rlqJ.', 'kushy-punch@4THD24KHK0UM.com', 'Kushy Punch', 'seller', false, '727f7d47-b30f-4689-a239-f2ea3fc384f6');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('LIV', '$2b$10$MJykrKhzFDbOO3xlgvwU3eLWobgt0T8nOVo544BuOPIh2S2e3.bzO', 'liv@C2M6AU6NALH9.com', 'LIV', 'seller', false, 'a6715176-f535-488c-8fdf-581a64089bca');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Legion of Bloom', '$2b$10$ZxiCwP7sVGO0hZrzBrRHuOwWKJ0kd5sFGzRw6gvkj2qVH.U.1ahyi', 'legion-of-bloom@K0TZNAOB2WI2.com', 'Legion of Bloom', 'seller', false, 'db2d498c-4b19-43a8-9278-3b608f4aaa45');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Lord Jones', '$2b$10$.uHqkzhXvZ4vwIEOG2gbW.FqbSAspCoMi0SkNunTUvODoETsjZZPi', 'lord-jones@4FBR8HHD8JEA.com', 'Lord Jones', 'seller', false, '8288af89-5b9f-48e2-bd05-b9289a667dae');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Merosity Distribution', '$2b$10$qNe6AiQvZjFJMDEM5cQ1JuBpcXvmNzCrKEhPO/oDJuwV1tTU.8oZS', 'merosity-distribution@E9XIJ0OYYJB3.com', 'Merosity Distribution', 'seller', false, 'c0d9ee6b-72d8-4b57-a26d-845f0375b552');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Speakeasy 710', '$2b$10$WCQUO1DTxhFIqd/g3Dgp4ejk5B7CcUrydB4jUSB1DSGtUM7RCEe.W', 'speakeasy-710@ASPX2UCWVEFI.com', 'Speakeasy 710', 'seller', false, '046d12a6-16de-402b-9cbc-a4f2066e2a28');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('The Bloom Brand', '$2b$10$rxnc/HJMesv7QGhLjC08QesH7fw.Ozy7Vw0okk9jZ1RC1acYXRo7S', 'the-bloom-brand@387T62HAMV0K.com', 'The Bloom Brand', 'seller', false, 'ce08150b-3f53-4d1b-817e-b83513a3a00c');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Cafe Herbier', '$2b$10$p4HP8/Ltklv5luz0SZVWxuD8OOG7ZGo9RpJyU56uaxM9nUcFaiCDq', 'cafe-herbier@D5CTUGUYRUYE.com', 'Cafe Herbier', 'seller', false, 'c7889a78-7cc9-4872-9a94-d97a263cb78b');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Temple Extracts', '$2b$10$cZIqns9r3e4YsHT5dKfXeOwFhzMd34Ubd9pWwC7.XVmazZQdKx11e', 'temple-extracts@8J0UY1ZL0ZRK.com', 'Temple Extracts', 'seller', false, '9135b077-4e29-48b5-abae-8dd68ac197aa');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('101 CBD', '$2b$10$I6SvgXSAn2Irg9XX6J8XvOGEsG/kUNR3/Y46tt4MhpgigyCkNJKQG', '101-cbd@ZQML9KK4XA86.com', '101 CBD', 'seller', false, '3ef122d5-45fa-4080-851c-8500bd6e97cc');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('AbsoluteXtracts', '$2b$10$t9o44U9QKg9oKX1.wNIxruFqCRs8coGIJgNTPga6tbEfSU/SOVx6q', 'absolutextracts@LZDEL7RR0UZX.com', 'AbsoluteXtracts', 'seller', false, '49e2cfcc-c382-4dfa-99e6-f511e285a693');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Evergreen Organix', '$2b$10$R6f5UKxTXUSryTl/lgXlv.J11UYZJbPtdMutMxlC/Xmeb.3.MkGCC', 'evergreen-organix@Q49KK197D5SV.com', 'Evergreen Organix', 'seller', false, '4a4a1b93-9587-4b60-a757-1a555cb95ac3');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('The Green Cacao Company', '$2b$10$ec27r3S2v2.SqGc5isr10.66VKj7kL1VLclmiRVGxUT4TTHa/URlW', 'the-green-cacao-company@OCFQQ1W9MWAJ.com', 'The Green Cacao Company', 'seller', false, 'f5d0c385-c482-4dfc-8a31-edcdef762c8a');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Select Oil', '$2b$10$ILJgz9p2XKCTczHu8n.IQ.3vFWQxZCCIoglWey/HJNCUWTeaJC1mW', 'select-oil@5C198YHIAAGJ.com', 'Select Oil', 'seller', false, '4634c035-96d4-4fcc-b3b4-be3ac5bb75ba');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('HIMALAYA Vapor Distilled', '$2b$10$tJy7HHXktBJXnY2Xwq/okOXXV0HoMXKBU/9B.8WE/0FdH75UVv6wm', 'himalaya-vapor-distilled@ZHXPNIFNDIJY.com', 'HIMALAYA Vapor Distilled', 'seller', false, '1bca1746-a154-468d-90b8-453bd7ff5fbc');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Satori Chocolates', '$2b$10$9AvPrAvm7qOSUAgLNQKyqeBN8QhpoMlBeBYFM7qNJ7l7ef7B0/M9C', 'satori-chocolates@3X3S9MNU23TT.com', 'Satori Chocolates', 'seller', false, '94e78573-5577-484b-969c-a8c39ae43331');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Healing Light Bodega', '$2b$10$7rb0hWCE0DKTEDTG.xwS.O4vpTsHhrjpbJ8vE0AsGKngKAQBi/EZ2', 'healing-light-bodega@HB290TBWED0W.com', 'Healing Light Bodega', 'seller', false, 'd72e6540-84ba-4c6f-9690-593ab0792264');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Flav', '$2b$10$cdfmbtNfxB8W7eM19S.fN.5AXlJ0Nzi.krAoQjaxzTxtiqVsAyza.', 'flav@2Y5S4ZBQ4BIM.com', 'Flav', 'seller', false, 'bd62ce2b-39d3-4d57-b6eb-10a9f305cca6');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('GFarmaLabs', '$2b$10$idTBcoKyb8Y.JDJzN8atXumjYqR85.OQWxzDGn5MP9ovNUKCe2see', 'gfarmalabs@H30HL1JT1Y92.com', 'GFarmaLabs', 'seller', false, 'a87b5bb9-f186-48fe-bae1-d2b59bad79d1');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Delta9', '$2b$10$xkBLjn9mwzdz/qaGpUtfBe8pyJ/i/IYICs5ezJAGk8B7YJCn1NTrm', 'delta9@BT53I9NPQOT3.com', 'Delta9', 'seller', false, '26d9e896-390f-4392-bf90-558dd1a713b4');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Care By Design', '$2b$10$B739jZVtDmBRTCrchvBFCewKl4r.IhTiC.VGZEazQgcmQJkrRcecW', 'care-by-design@WJ92J9Y6636X.com', 'Care By Design', 'seller', false, '4e703475-f2f7-48c0-a429-131b79e038c3');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Whoopi & Maya', '$2b$10$LH1vjESVeDSBerRPNHEqKOptdpnsN2GVAFkd/QnGaqEhoNxnQFOLe', 'whoopi-maya@OFNJ0RZHR2CS.com', 'Whoopi & Maya', 'seller', false, 'ee43b1bd-502d-45bd-b50c-0b1732120b04');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('The Herbsmith', '$2b$10$cK6yNFpt2y5ddFOeAa85x.lJWf/GGdmmR59IR53PxP9PAjHN11aMK', 'the-herbsmith@4AFA5LV31SEZ.com', 'The Herbsmith', 'seller', false, '1880d23c-e666-483c-8b99-8f48a9688c27');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('THClear', '$2b$10$J5/VBMYJVI9XBxuNU1p6e.3lg68Dn1IXOJWErnBTVamyYwscJVSPS', 'thclear@H5F9X7M22GOA.com', 'THClear', 'seller', false, '123c13a1-a98f-4f18-bac7-3c58093e993b');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Altai', '$2b$10$mtxPvfknHdyhUWzt518esu5.ROWuFc4I4QJMrFynuJ29gA6Oz0MuC', 'altai@3AONF65FEF7K.com', 'Altai', 'seller', false, 'ffa8ac8b-3831-48bb-a23b-c5b469d476b8');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('The Genezen Project', '$2b$10$qa6ISGcEET8dyN/JFEgt4u33PYH8p/J9MiOxqd/y9uYXMzhWWgr8a', 'the-genezen-project@1AAT35P31GR7.com', 'The Genezen Project', 'seller', false, 'ebc2a00c-0bcb-4649-b456-4c0c50d01e4e');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Waxman Concentrates', '$2b$10$8u6rrmDkqhTTtLEVN.GBX.wHRlaybIh/I9MVJFF8K6Md7.xlXgQMG', 'waxman-concentrates@JM9HZYPSLMXO.com', 'Waxman Concentrates', 'seller', false, 'd0569d64-fdda-4a22-84f0-fee1b7987e6e');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Moon Mans Mistress', '$2b$10$dJxlNzBuhJ1vMDYWN5QTbey51x0tso4YZNP23Xm9x2yNxlrvZdtmG', 'moon-mans-mistress@ACH425D8F7OI.com', 'Moon Mans Mistress', 'seller', false, 'bc0d8245-5150-4b79-8fc6-0f98c31e0859');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('True Humboldt', '$2b$10$jLHrthSfeeCFT2RCo0lvpeVFSOnVlNYjaGf42GyLp6819atBVJ9aO', 'true-humboldt@IZ580F6A0ZEW.com', 'True Humboldt', 'seller', false, '02acfac6-7c6b-4bac-803d-f240ed6e6db5');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Treat Yourself', '$2b$10$gcoGXomaamCZBoi7JRvIkeh4mn8c1dsFcCDiqXuHhXfrUBJmBbNNm', 'treat-yourself@KB9RCA2BRQAJ.com', 'Treat Yourself', 'seller', false, 'cc798a17-a3fc-42b9-9d78-49cf83015e63');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Chong''s Choice', '$2b$10$VGROanRq0oK6WNtI0zrguuCJn1PvajFXN9QP5iN4NvuB6gdXnL2CK', 'chong-s-choice@PHLP013TROS7.com', 'Chong''s Choice', 'seller', false, 'd912110e-8734-4d2e-a69d-a51753c70707');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('HerbaBuena', '$2b$10$6qloARYOfqzAPhvV7kFsEeXgB//iQ6oG2lfFxLRXefnU9Xprq5MHC', 'herbabuena@E4HHOLSTJIL1.com', 'HerbaBuena', 'seller', false, '15db6274-8390-40e3-9546-aeaf7f25eab0');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Caliva', '$2b$10$fZ8zGfjGYw3pFfF0acpEhe.RuYeozGjLx5g54dFO8RkO5AEiF4AnO', 'caliva@WGHTIIQ01B0L.com', 'Caliva', 'seller', false, '7dbd0f37-34f4-40de-9e09-82eabd34e2cb');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Hemp Hope Group', '$2b$10$eH0ueHDofGgI0.ycAu9/E.Z.pKeRfWj1qszMMIR60MZG93.lN9KYu', 'hemp-hope-group@FDXOIV18BZTK.com', 'Hemp Hope Group', 'seller', false, 'ba878b78-ac9d-4f8e-ab1c-a9e2683d9397');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Connected Cannabis Co.', '$2b$10$FAx10Hoj7Wh4lFb3Gi0cP.3UkvJ6.Js5kVOzpkL9EdOtmk2BQ0sQu', 'connected-cannabis-co@49J7BE66CSXI.com', 'Connected Cannabis Co.', 'seller', false, '031a556f-3ee8-41ba-8239-7fd860a3aa03');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Farmacy Bliss', '$2b$10$ysDOb2ADUF50XBDYlqWZHeTzzsMMrZEurNhMkfT.2TESHU4QLYPMG', 'farmacy-bliss@W4D7VS6MADY5.com', 'Farmacy Bliss', 'seller', false, '24b426d7-66c5-4c03-b397-15efe2846e4b');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Brite Labs', '$2b$10$DeD41SfQHg.A9wEnVUJuv.lzKBEXEwhsLBsmxAs4ieUgJvMVI79Qa', 'brite-labs@OCDZLJEGV8IS.com', 'Brite Labs', 'seller', false, 'd72d7507-9489-4872-814a-fd54be82b886');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Ganja Gold', '$2b$10$29x64QjOkQwvuSBvMzket.7BzcbcpzSo/YHs8vmNd0KI0Xc/1QMgu', 'ganja-gold@2434M7FWAZPV.com', 'Ganja Gold', 'seller', false, '1913119e-db20-4d4b-be04-0a6c50f6728a');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('LOL Edibles', '$2b$10$nUa9AafzCkcLyVI2SHtwAeZ/lEU6ae.XoLtM7VDNTYZEvH10IxBgW', 'lol-edibles@GS48Q769L72Q.com', 'LOL Edibles', 'seller', false, '4316c6e1-1a1a-4e18-b8ee-d25c47306130');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Tokin', '$2b$10$0xiftq4Q/Bzsn2U149.eku9m43QZ9bVkot6s3..TVAJpJbSRSiZlS', 'tokin@9JCQ9XCW0AJV.com', 'Tokin', 'seller', false, 'bc5df233-4113-4899-971c-47296bfd0c72');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Frosted Flowers', '$2b$10$lhUAEIbM3Elg5qdaRjIt.uVRLWJRAso38JNom7I0B1qwQ2H9zfhr2', 'frosted-flowers@1JMBQQUQ7PV1.com', 'Frosted Flowers', 'seller', false, 'd4ab19f2-2fea-4895-b28f-657371bd6748');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Dutchy', '$2b$10$5dL2X8BLZNfbHxYn.oEDXOjfrlGEiPfZwv22H37F765G9GW8fUAUK', 'dutchy@0VN87VOAG4K5.com', 'Dutchy', 'seller', false, '00aff001-dc9f-4db6-93db-1c47cf40c93a');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Flow Kana', '$2b$10$rH3MZDmgnhStCDZqGimu/O/BLH7FYeiAPpRx5Cuog0PzMyQ8e4Mg6', 'flow-kana@OF3KTWDVC2II.com', 'Flow Kana', 'seller', false, '47ebd383-18a8-4be5-8af1-e6eaa7aa2200');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('HI-FI Edibles', '$2b$10$mFuzFDFnb2/5tgi7fr1IG.wQQLIt/lzDYJIh2TOil5RJ6Hq1IU8Ba', 'hi-fi-edibles@R5Z92BZMGF0H.com', 'HI-FI Edibles', 'seller', false, '13f8669a-3bf9-4664-9fb4-7d90702cfbc1');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Northern Emeralds', '$2b$10$dr5WHfy2Go41N6LzkM79/OWCvnuppx9ayFJV77TDjdeWcJa1eMgXO', 'northern-emeralds@YK21C4T22WHG.com', 'Northern Emeralds', 'seller', false, '1877d0d2-86d5-4172-bacb-82295b491197');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Little House Foods', '$2b$10$P5Pm.UlJH3fsFVZAuy/p3.QguXN8q3D0CBTVOS0.2RFwhS83637IS', 'little-house-foods@MLNUUFTTNYI0.com', 'Little House Foods', 'seller', false, 'd32e621e-b66d-435d-b203-3557a4f599ab');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Humboldt Marijuana Co', '$2b$10$SksbesCK7vOD8tgTaW1/GOILG8P.0vx0rnryoGzObPVYubW00GZv.', 'humboldt-marijuana-co@O0HW5IBIKKQN.com', 'Humboldt Marijuana Co', 'seller', false, 'e5b06676-97b0-4018-a156-be9cb7f50ee9');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('ISLAND', '$2b$10$XENb9WY4LeSC.RiJ4F4AwO9afxo2RS.655HoljLvyntcXUKyWClj6', 'island@FTW8M23U8RZQ.com', 'ISLAND', 'seller', false, '8d512c9b-ab87-4471-ada1-53425bc143e6');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Veda Chews', '$2b$10$qc687ToDmS2evXgXon54a.dJarn1XAnalpSVG0.UYKHNIaTMZKNyS', 'veda-chews@QBEBERZ9CM0V.com', 'Veda Chews', 'seller', false, '7b519da0-9a69-44f1-b1a3-89b4ba844c05');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Utopia', '$2b$10$xMGlKzdypy7ofPk6CKVzs.dZbiO.8j0RJKj/4MIKfVHxXHmgENtZe', 'utopia@0EQ5T23YHA6Y.com', 'Utopia', 'seller', false, 'a9945fc2-5fa0-436d-b65b-301f7951243f');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Foreman Farms', '$2b$10$/Yn4vomfJbKIimm9LOFRKONtOLYs4wJeH5G4sBW8d8mr8UenUJyDy', 'foreman-farms@2WVV6S2AWJD8.com', 'Foreman Farms', 'seller', false, '554966ae-10d1-4be8-9b31-32f9f8fe8ced');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('GG Strains LLC', '$2b$10$wK7uxCFnSZAO8PdHLspzhO3zitNzIImB0GCcvAQnCMwAc0y.b6.uu', 'gg-strains-llc@IXDL2B5IFESV.com', 'GG Strains LLC', 'seller', false, '1a9f7f7f-6677-48ce-b7c4-fc3adc4a5a94');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('IndigoPro', '$2b$10$xFcfH7.ffqyItn20g/HTJeqp2hR6CTe/X3/Eo7Rx.7wbCWJWf4GPy', 'indigopro@4WOOGB1LOCLT.com', 'IndigoPro', 'seller', false, 'ec1bfe0c-71ff-401c-b55d-84761744d2c8');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('W Vapes', '$2b$10$bnbRqeHpdsCNAluXkQZosedhSmjoz50taOW95zZED9gz7exJkWuJe', 'w-vapes@G0HLR49KTHZ4.com', 'W Vapes', 'seller', false, '657522b8-0a4c-4593-ac32-efe39373ea88');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Herbalogics', '$2b$10$mtscApu.sYo5U4vrKmDVZegBXs3zPmx3eITB0IKZY1B3biJEY0Sai', 'herbalogics@13Q1F8K9EK64.com', 'Herbalogics', 'seller', false, '158911e8-703b-4d9a-8d74-aee6cf386cd5');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Pure Vape', '$2b$10$eXvuC4H0zdxaV/UjQU0v2up2lmmjyh/v2swUTpx9fMNkymTXI88Ei', 'pure-vape@W9VF49AHRGHI.com', 'Pure Vape', 'seller', false, 'a648dc2c-957f-4c73-8b79-6ff15a56d14f');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Calyx Garden', '$2b$10$Suxol3DQkXjiQlHI/6NF7ulQdn37hE3eJ6MXEaaEeGhT.KijvROy.', 'calyx-garden@7E9ZPCY9I9ME.com', 'Calyx Garden', 'seller', false, '90e2f6f4-367a-4110-9328-3f392729a330');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Eel River Organics', '$2b$10$vEDuaTUNh9Ulo5z6TYMoCOMyBW71j8VYkH7DqL4ziufoVPAy0WVzq', 'eel-river-organics@XKCQMFYIKVCK.com', 'Eel River Organics', 'seller', false, '3c23bc96-a444-489a-8731-7edcaa466ae6');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Eureka Vapor', '$2b$10$6P1sDJ5.K/42fNRAw/Fw/.LG10wRkYdmCvwe2UsduHxUFpqRGLlYO', 'eureka-vapor@VP49RTISUS5A.com', 'Eureka Vapor', 'seller', false, '6c06734c-4438-4f75-add2-fcd02fe17632');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Crafted Extracts', '$2b$10$AQFadJuVNEzf6nYmr2UkkezHmWEMNXPAOV7yPB.HMWkzVckCI86cC', 'crafted-extracts@ONK4EFM3GB8S.com', 'Crafted Extracts', 'seller', false, '33ab029a-df02-494f-8424-edd4ada0d6f2');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Aces Extracts', '$2b$10$5g6ZnZ/nOEMdHFLlwQFFJez9MeYqOK7XYsDPaDAcHM7ZNNTW9CNG6', 'aces-extracts@5DPINHY4XI4L.com', 'Aces Extracts', 'seller', false, 'b140e82e-eb34-493e-be90-3b8690ab0dce');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Lucy Goosey Edibles', '$2b$10$MyrA2rKHz8wrIhpFL.XmHeQd0D7YKXNnOxvL38xBQPSKKXWQKrzYe', 'lucy-goosey-edibles@LG6LQ1YRI9KB.com', 'Lucy Goosey Edibles', 'seller', false, '702f8787-75a3-44d7-bd89-430b745b1078');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('VVS Pens', '$2b$10$5ie2t3yhRzg/8zlMSguxf.SSP1qkW2RX2ZtN8T9SwIAx26vyU5McG', 'vvs-pens@8YTPLJQ44YEK.com', 'VVS Pens', 'seller', false, '74696318-f888-4d77-b193-d1307b51608b');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Kiva Confections', '$2b$10$aK/dGIqpPYFpWDAFFrtTgeU3RfYPy5RnRUblVOlmYIS5K/akhbPgu', 'kiva-confections@VKRAM690NGL1.com', 'Kiva Confections', 'seller', false, '3399587c-028b-465e-9907-31dbb7695fb4');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Humboldt Gold', '$2b$10$Sc3Ipp39dQjOb6qfwtyXkOd3g/M/z6RD6/oCjpDCNM4hfyrLgNILO', 'humboldt-gold@7TRBNGJP2OZT.com', 'Humboldt Gold', 'seller', false, 'c5aec149-9542-4bf1-8d5e-f9c2a25a41d3');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Keef Brands', '$2b$10$bXGqk5vOIP6DPmkguKERy.v4bc7tM51069YdspgF.bu1lg6w0z.Fa', 'keef-brands@J2SU5BPU8PVW.com', 'Keef Brands', 'seller', false, 'baea47e4-260c-462b-a1a2-7836077b530b');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Punch Edibles', '$2b$10$dwokmEE3JEyQCboHbZJJmOA6Ft7Rs9enR1jnJ5lUmgHkHdz3kuY8C', 'punch-edibles@154K9J513W1M.com', 'Punch Edibles', 'seller', false, '35a8b50e-d19f-4843-993e-eec9a821ac2b');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Enliven Essentials', '$2b$10$269PFHSqpLMB2KFXh8/OVuHV77AJU/838qL.8KoSKSRs7tLQC8xSG', 'enliven-essentials@GCK80GS0TLG6.com', 'Enliven Essentials', 'seller', false, '66c15b19-fc90-48ac-88ab-9911505b9cbc');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Pure Ratios', '$2b$10$d/v1rRcQG4CgVE7MUdYofugVjM6MgTQDaLB1pQ7Eqv9PXh4olTvYG', 'pure-ratios@VNJOAC2C68OT.com', 'Pure Ratios', 'seller', false, 'a3ae1212-c0e1-4247-9eb1-26b01eb20bf7');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Palomar Craft Cannabis', '$2b$10$ipe.UZW8q4bmookh5m6dhejzNrCRYdq/nVTqvZhuaWerL495rBAZy', 'palomar-craft-cannabis@FNYY4BAHQV58.com', 'Palomar Craft Cannabis', 'seller', false, '7cee460d-4754-4d44-8b31-7fd13dc17537');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Elite Hemp Products', '$2b$10$Pumgt3fvDVDqARHCeRCcs.Ai/qAPnFhxVn6/b9M4nXOm5anzbyINi', 'elite-hemp-products@ZLPBFBQ95GLN.com', 'Elite Hemp Products', 'seller', false, '685667b8-c10d-4acf-9e3d-abf12a31bbf3');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Everest Live Resin', '$2b$10$1MNVbVxB.9GXhlLGZv6KBeVWlG/lrwFNFT5rSOWme.ySVUTChcOya', 'everest-live-resin@RNHK7MOK2A7B.com', 'Everest Live Resin', 'seller', false, 'a4562c05-58bc-437f-924b-7a5772c2e8fc');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('4.20Bar CA', '$2b$10$lIUK5w33Y7cuJnvM84nd8en4HuTUfT5oiwDUy8hEa5lWAe.iP4IWW', '4-20bar-ca@RPHATD52QMFD.com', '4.20Bar CA', 'seller', false, '424a6f31-ed81-48ea-b279-94fd7d6c1061');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('BaKed', '$2b$10$d/ExR/fv6ckAHgBQy0ng0OQPIXZWbzpFvFEzy5LkjnqoZJ3gjBlcu', 'baked@ENSSVT4TD0DG.com', 'BaKed', 'seller', false, '845a3fa7-2dc2-407d-a728-784ac2b68140');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Spliffin', '$2b$10$gkjMXmvPXr1ix6zWpgXHcO8tXvGBF9l6CpTNz6yckOqbZz3n124Im', 'spliffin@QSEBZEBR3VQZ.com', 'Spliffin', 'seller', false, '2af011af-da25-4ec9-ab94-8799918692e7');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Orchid Essentials', '$2b$10$aRuIK.VRsq2thmAwFGuKLu3Ay48RqgHzafINKMgeyTFW2qV6nU8hK', 'orchid-essentials@GG9DURC18NVL.com', 'Orchid Essentials', 'seller', false, '0ec5faa9-956d-4c7a-bab8-cd1ce6236412');
INSERT INTO public."user" (first_name, password, email, last_name, business_type, verified, id) VALUES ('Arjun', '$2b$10$8SE0PjlnP9phUavTCP7pbulF.KLxNZywhc5elA5.hvc2ZeEBdFyW.', 'arjunglobal09@gmail.com', 'Nayak', 'buyer', false, '52eeac2e-e0b9-4278-bc99-9c47fab6f506');


--
-- Data for Name: user_verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_verification (email, token) VALUES ('district-edibles@R8NX5IAMO70V.com', '62e3813d5b9dcc5b17a377a8df497431645df4f64cb20108a49cfd5ed2b0dc37');
INSERT INTO public.user_verification (email, token) VALUES ('shepherds-meadow-farm@ST56NT1BNW5J.com', '2eab84d17827114d194df13c9453550392893ea0ede857356a78aafb134fca6f');
INSERT INTO public.user_verification (email, token) VALUES ('lola-lola@LH896MHTYRFS.com', '2594948c8090e33abe33931db4572d70e0e906ade3d746fb7e4cf2fe9da2e062');
INSERT INTO public.user_verification (email, token) VALUES ('flurish-group@QCZ58CRNSBCH.com', 'cc30671589a7de26a6b68085cb6d36524b8e93137e9115f91d9532ab7e4a5aed');
INSERT INTO public.user_verification (email, token) VALUES ('purecure@1C4W1257YH1I.com', '291a6dc13282e5081259234ebb7a9cd938956bdebbd988776ec7bf3b8733214f');
INSERT INTO public.user_verification (email, token) VALUES ('upside-edibles@1TACUG8JZ8XH.com', '9848c320e07341d9faf9208ea28af248854540b5ff72c20e44bea0ef445c1102');
INSERT INTO public.user_verification (email, token) VALUES ('marley-natural@L3DMZ3O382NG.com', '44ce3ce9b1d6b14acd2c9776c24a190ba786a1cf36c2add442dbc93b1f6a5eff');
INSERT INTO public.user_verification (email, token) VALUES ('dixie-elixirs-edibles@VZN1HWTXIBJ8.com', '84a1b1aafe2f035c6f3efe515ee3a71699a8148666fe9f868099a712cba63119');
INSERT INTO public.user_verification (email, token) VALUES ('kushy-punch@4THD24KHK0UM.com', '39c008420ff54535ed457fce49d057d83e68a612d577eba5cbf4ee46426cae1f');
INSERT INTO public.user_verification (email, token) VALUES ('liv@C2M6AU6NALH9.com', '80de4b45acd15c71f8e7ba751f0eb9357c950cec90c2997801e6814602b85367');
INSERT INTO public.user_verification (email, token) VALUES ('legion-of-bloom@K0TZNAOB2WI2.com', '80f99bb79e92b708899de307399fe7c197af6611699c60dfec0db20fa85f9fca');
INSERT INTO public.user_verification (email, token) VALUES ('lord-jones@4FBR8HHD8JEA.com', '824f69d48c0418390e52ff24d1e2e6df7f44d73e0fb184dc50318ea7edaac1f9');
INSERT INTO public.user_verification (email, token) VALUES ('merosity-distribution@E9XIJ0OYYJB3.com', '6de4297659395f9cd17901b5104f18e452c6061524c2db4bf8306600b6493e34');
INSERT INTO public.user_verification (email, token) VALUES ('speakeasy-710@ASPX2UCWVEFI.com', 'd2b331bb9142c96b966d33a44be4c79b10632e83753a7afe185eff01503072ff');
INSERT INTO public.user_verification (email, token) VALUES ('the-bloom-brand@387T62HAMV0K.com', 'c0a6e8655ad82ee0660f7d60ce05647de1c7da3aace7c46661f887724f031c32');
INSERT INTO public.user_verification (email, token) VALUES ('cafe-herbier@D5CTUGUYRUYE.com', 'c07f15e03ca43ad1dbdf2daf0f0c2a8433d3cf968f14107846217b0ec5b3a3f5');
INSERT INTO public.user_verification (email, token) VALUES ('temple-extracts@8J0UY1ZL0ZRK.com', '7ee34f247cf6a2f6893a69d121d3b22cc3ae0fa9ebf2252d0e5a2e4eadde31f8');
INSERT INTO public.user_verification (email, token) VALUES ('101-cbd@ZQML9KK4XA86.com', '33b5cb7308511dcaa68bbbf3b51dd404b322352fdbad50d5ec8678eced10a34b');
INSERT INTO public.user_verification (email, token) VALUES ('absolutextracts@LZDEL7RR0UZX.com', '2c8a49bc318c289b5368d6f897fa040f77b0da60d78977e3ffe1d796d5686fe1');
INSERT INTO public.user_verification (email, token) VALUES ('evergreen-organix@Q49KK197D5SV.com', 'd617520ff60da11f2210750264e170ae9a2e477f0afefc2c7b5377e26b329f4e');
INSERT INTO public.user_verification (email, token) VALUES ('the-green-cacao-company@OCFQQ1W9MWAJ.com', '80a46e44bd9a70732231bface2483afa756100885cce5b985ff1736628a2f0ee');
INSERT INTO public.user_verification (email, token) VALUES ('select-oil@5C198YHIAAGJ.com', '7d97509ff5f0426fa31d3bc27966712a44672825db6a9a7d2d230bd5b78c0b77');
INSERT INTO public.user_verification (email, token) VALUES ('himalaya-vapor-distilled@ZHXPNIFNDIJY.com', 'b8189a24d3e80e325920ea98680882d018d737381d629189028cfd8a15b342f1');
INSERT INTO public.user_verification (email, token) VALUES ('satori-chocolates@3X3S9MNU23TT.com', '43617e84b66627a46bedb1fca124fe99899750140443e677f884bdb4680d3035');
INSERT INTO public.user_verification (email, token) VALUES ('healing-light-bodega@HB290TBWED0W.com', 'e0610d3a0812ca4db2ec3e30d986716a550027027e7edf30a48588bbd14e1906');
INSERT INTO public.user_verification (email, token) VALUES ('flav@2Y5S4ZBQ4BIM.com', 'a23ebb868a23aa5cffe0f096b1430db0aa708da0f9b263adc8712f569434fb83');
INSERT INTO public.user_verification (email, token) VALUES ('gfarmalabs@H30HL1JT1Y92.com', '00d7ad841c3e839b32d22989bfc84e2f55c80f66614b10ef6ac1ecb0e5f67096');
INSERT INTO public.user_verification (email, token) VALUES ('delta9@BT53I9NPQOT3.com', 'e5c8f01e457f77ed185850bff06f1758294c3eb5662c3e4b3b4c307aa3e6946a');
INSERT INTO public.user_verification (email, token) VALUES ('care-by-design@WJ92J9Y6636X.com', 'c6d4cbcadc3bdb8a550abb8a89cf1b9ff4d05d357afb77dc097a9cad0d781e1f');
INSERT INTO public.user_verification (email, token) VALUES ('whoopi-maya@OFNJ0RZHR2CS.com', 'dc254b58d6c50fe31d235e8607840abf8fb3b1c25ef19a39261bfe0c6150a4f9');
INSERT INTO public.user_verification (email, token) VALUES ('the-herbsmith@4AFA5LV31SEZ.com', '3f0788db80f2d0067abaf090f82a6cba7f4c681bffd3d8294a1f6dc836dbd458');
INSERT INTO public.user_verification (email, token) VALUES ('thclear@H5F9X7M22GOA.com', 'c0558dac64d5844fd13c510c5ac4a8776ed7615a09f1e00cc41065cf80911e41');
INSERT INTO public.user_verification (email, token) VALUES ('altai@3AONF65FEF7K.com', 'be12c99c94c14a165c6d45e18fe07d61ebc2c7b17a6f36f715845efff9549bd4');
INSERT INTO public.user_verification (email, token) VALUES ('the-genezen-project@1AAT35P31GR7.com', 'cac3ea364ec4c161b8737ebcb5f1b375b681aca73b1a86f815e039cedfc8e4f6');
INSERT INTO public.user_verification (email, token) VALUES ('waxman-concentrates@JM9HZYPSLMXO.com', 'f4e9a2555a2ca7d37ce9b3e30c65afc197d6a1ddf6b92b6f89a2dbb0957ba3d8');
INSERT INTO public.user_verification (email, token) VALUES ('moon-mans-mistress@ACH425D8F7OI.com', 'a49ad14b2505402adf04c1fd87ec6f01963c9bbfc3959f213d303eee9e770322');
INSERT INTO public.user_verification (email, token) VALUES ('true-humboldt@IZ580F6A0ZEW.com', '135168ba515c310b44bcd110cf43e77202c22dbd4c724b39679f91a2c85d649f');
INSERT INTO public.user_verification (email, token) VALUES ('treat-yourself@KB9RCA2BRQAJ.com', '888afd406700c2918f68ee3cf673e22396cc7f8202f5c600ed691a1d247076f9');
INSERT INTO public.user_verification (email, token) VALUES ('chong-s-choice@PHLP013TROS7.com', 'c44bbeb08f505773eada522fc6abe817118f04cc30a7631973280ba77766fbec');
INSERT INTO public.user_verification (email, token) VALUES ('herbabuena@E4HHOLSTJIL1.com', '18c00249e6a016a8a290195207694f48655ac0acbc7c5196e05eff7898355d0c');
INSERT INTO public.user_verification (email, token) VALUES ('caliva@WGHTIIQ01B0L.com', '9d4d698120272a6922002f3fe75fd45507328b2c5d62bb6c0e24848d07f0a2ad');
INSERT INTO public.user_verification (email, token) VALUES ('hemp-hope-group@FDXOIV18BZTK.com', 'e50cf3188c3bb14bb3786561d85941998dee77c4894bcea777af05d0f96aab5c');
INSERT INTO public.user_verification (email, token) VALUES ('connected-cannabis-co@49J7BE66CSXI.com', '445c6d007cc6f3339f6a2b0bf225f034ffff4424369ccee11f2a59e090434036');
INSERT INTO public.user_verification (email, token) VALUES ('farmacy-bliss@W4D7VS6MADY5.com', '2b56cd517045af07869264abb98437c7c293d8a3422439c8f7e41561475f4814');
INSERT INTO public.user_verification (email, token) VALUES ('brite-labs@OCDZLJEGV8IS.com', '184d27fd4477d17a324141586887343c2e2c788c24e4dfeec6a2c7a8dfdba8a5');
INSERT INTO public.user_verification (email, token) VALUES ('ganja-gold@2434M7FWAZPV.com', 'ecf4165dfc6c3393ff45e05949c6bc3327ff859b08df81c47bcd6f3c94edc1bb');
INSERT INTO public.user_verification (email, token) VALUES ('lol-edibles@GS48Q769L72Q.com', '0a28c532e8f459d3c26b4676e503bafd12ca8964283d6c3b35c53e294be2c9ee');
INSERT INTO public.user_verification (email, token) VALUES ('tokin@9JCQ9XCW0AJV.com', 'b6aa73cdd3b3eecd750fde1a9aaf6d8c618c86e8ca778e42428d4fa5bcad232c');
INSERT INTO public.user_verification (email, token) VALUES ('frosted-flowers@1JMBQQUQ7PV1.com', 'f97db289d2527b6bf2af895057b79165c51759ad9c9ec411b05a55727d8f2b57');
INSERT INTO public.user_verification (email, token) VALUES ('dutchy@0VN87VOAG4K5.com', '5359b8b72e9d0478d846fcda9bfe12e975bb391be4e830a07ff7e1ddbe572470');
INSERT INTO public.user_verification (email, token) VALUES ('flow-kana@OF3KTWDVC2II.com', 'bdea7c100f794c9d40d6ea1ad671966ccd5577a3c414292e1fddfbb41847de85');
INSERT INTO public.user_verification (email, token) VALUES ('hi-fi-edibles@R5Z92BZMGF0H.com', '6f84766dfefc84c71fdcd4d920c81f0582a241182dc08f348b65f86665308eca');
INSERT INTO public.user_verification (email, token) VALUES ('northern-emeralds@YK21C4T22WHG.com', 'e3c7e83867ab4b2248717e573da829f2e9a6bba9aaee33187d6985a4837301bc');
INSERT INTO public.user_verification (email, token) VALUES ('little-house-foods@MLNUUFTTNYI0.com', 'dc1383f661566990e538c1ee90a6b706ce1333a54b8b1d1bbc8016bc14265775');
INSERT INTO public.user_verification (email, token) VALUES ('humboldt-marijuana-co@O0HW5IBIKKQN.com', '88f1a366ae2c8871f4b932ad702ade13529ff2ae3fee9542a7437eb25aff1daa');
INSERT INTO public.user_verification (email, token) VALUES ('island@FTW8M23U8RZQ.com', 'd3bd4136e5ac579de6d48dc0073a54ac72845614d56d3e5511cd9b7e74061131');
INSERT INTO public.user_verification (email, token) VALUES ('veda-chews@QBEBERZ9CM0V.com', '0f4828967c5b987a5285ecaaca07ab703f07a3d3630332d22d74ffd8ecf59f71');
INSERT INTO public.user_verification (email, token) VALUES ('utopia@0EQ5T23YHA6Y.com', 'd3859e615eea248d79a72c2afd0f402576c0c5495f8f12d55458b16a6f6d6528');
INSERT INTO public.user_verification (email, token) VALUES ('foreman-farms@2WVV6S2AWJD8.com', '4f2a586bb273fb6f3b456c667f0cc0c3365ac95b5314a1bb5749bc642a22a90d');
INSERT INTO public.user_verification (email, token) VALUES ('gg-strains-llc@IXDL2B5IFESV.com', 'bc2aab61d3ab30a40e5d9687acb512fe5e4f08837fe32b02f302ad0f670a42b5');
INSERT INTO public.user_verification (email, token) VALUES ('indigopro@4WOOGB1LOCLT.com', '1c97c3cb03dfd2f88254806cb0bfb27d41490b55a26d0107bf2f636174a02195');
INSERT INTO public.user_verification (email, token) VALUES ('w-vapes@G0HLR49KTHZ4.com', '4adf33835a2f2ec52c373c0b85c6f9ee3fe3b189fba202db176138454b1673bd');
INSERT INTO public.user_verification (email, token) VALUES ('herbalogics@13Q1F8K9EK64.com', '4ca5e70936ca86fd20d44cbd90b39338c9bcc351a28a00339b271239a3a32771');
INSERT INTO public.user_verification (email, token) VALUES ('pure-vape@W9VF49AHRGHI.com', '166db16ba310207a158978439fa8a2a8a34b3ae7f6894335ab0e8b7393b75549');
INSERT INTO public.user_verification (email, token) VALUES ('calyx-garden@7E9ZPCY9I9ME.com', 'bb279b173e21a8f5cc34478d4451e93e369f090075814fd945746f597c7a7b77');
INSERT INTO public.user_verification (email, token) VALUES ('eel-river-organics@XKCQMFYIKVCK.com', 'c9346c05944965a6e5d430f2bafdb81e4ba2df53c2349fd2521520af14c33984');
INSERT INTO public.user_verification (email, token) VALUES ('eureka-vapor@VP49RTISUS5A.com', '33b3ad8118f05be8983ddf5925f33fa655ca73a15c24f51797cf303e47eb0833');
INSERT INTO public.user_verification (email, token) VALUES ('crafted-extracts@ONK4EFM3GB8S.com', '25a8f03a4730f6695c73160d419013efa644c15ff717375e7fac50da75554107');
INSERT INTO public.user_verification (email, token) VALUES ('aces-extracts@5DPINHY4XI4L.com', '7ef2ddf5ac3d442d2c51ccf36d8ff0815dc715d0c97e2cb6ab5d74a0193d18e1');
INSERT INTO public.user_verification (email, token) VALUES ('lucy-goosey-edibles@LG6LQ1YRI9KB.com', '36ed7c28cedf8ce7d6b54f77a54303b3c76ee78f0c3fa27495e9e8515ae40bab');
INSERT INTO public.user_verification (email, token) VALUES ('vvs-pens@8YTPLJQ44YEK.com', '6dea8a21058680b9422ec1aae316d67bc6d9fdb854b756695deb7180919fdde2');
INSERT INTO public.user_verification (email, token) VALUES ('kiva-confections@VKRAM690NGL1.com', '284f80e9eba1f27e80a4040299c9d4b1ab750422d69c994fc839de04a857ae88');
INSERT INTO public.user_verification (email, token) VALUES ('humboldt-gold@7TRBNGJP2OZT.com', '1450a62a249a3f3e5d5cf5abd5618049eaf7b70b67fc52bbc38ce7f956afcb74');
INSERT INTO public.user_verification (email, token) VALUES ('keef-brands@J2SU5BPU8PVW.com', 'f04c93eec5ed917274f3f2f33af0d7a017588cecdd7d54e42ebdbb6ada058217');
INSERT INTO public.user_verification (email, token) VALUES ('punch-edibles@154K9J513W1M.com', '4de0ceff88e0626a35e75faaf384e201d1ccc07542da9e921d2c344d0dbbad10');
INSERT INTO public.user_verification (email, token) VALUES ('enliven-essentials@GCK80GS0TLG6.com', '78155f438802cf5908388189d8e05a4c8995286bc1781e6599eff9a0cafe1c2e');
INSERT INTO public.user_verification (email, token) VALUES ('pure-ratios@VNJOAC2C68OT.com', '253c1fbd144b340f7ea1c415f5fb7aae83aaf7b1642c1026357920fbe1ddaeba');
INSERT INTO public.user_verification (email, token) VALUES ('palomar-craft-cannabis@FNYY4BAHQV58.com', '97ced0583216a965427aac735012832065582e27ee620a0df8638a9955851369');
INSERT INTO public.user_verification (email, token) VALUES ('elite-hemp-products@ZLPBFBQ95GLN.com', 'b7ea4ceeb935a25dd737bbc6f47c4c4def4c981b77cc8c14dc0b6509884164a9');
INSERT INTO public.user_verification (email, token) VALUES ('everest-live-resin@RNHK7MOK2A7B.com', '63bb4139d7da88160222f0a0bb9c27b603cd28f61a181c8d2f26128ff76d40e4');
INSERT INTO public.user_verification (email, token) VALUES ('4-20bar-ca@RPHATD52QMFD.com', '68e23d4bea3ebb779c100f4cdead941d0ef76773d892772c61634c7bd2a9fe1c');
INSERT INTO public.user_verification (email, token) VALUES ('baked@ENSSVT4TD0DG.com', 'd2c506c127a2849c5ae318ab6a1e4c857bd239e1b303b2fc638a153829bbbd96');
INSERT INTO public.user_verification (email, token) VALUES ('spliffin@QSEBZEBR3VQZ.com', '0478f450ddc683070bd31e103e129e3b97b39395b5b93906cdc1aa8042abe1f5');
INSERT INTO public.user_verification (email, token) VALUES ('orchid-essentials@GG9DURC18NVL.com', '6bf9ad9e555ea9345e35b324778e7f8f5ebdbc42ae78f1a1e5d71ad054cace44');
INSERT INTO public.user_verification (email, token) VALUES ('arjunglobal09@gmail.com', '97564aa8608aa1c345da53ace2dc1576b3a4db889120a0b78eeb3cac5e694c3c');


--
-- Name: additional_license additional_license_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.additional_license
    ADD CONSTRAINT additional_license_pkey PRIMARY KEY (id);


--
-- Name: business business_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business
    ADD CONSTRAINT business_pkey PRIMARY KEY (id);


--
-- Name: concentrate concentrate_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.concentrate
    ADD CONSTRAINT concentrate_pkey PRIMARY KEY (product_id);


--
-- Name: flower flower_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flower
    ADD CONSTRAINT flower_pkey PRIMARY KEY (product_id);


--
-- Name: inquiry inquiry_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_pkey PRIMARY KEY (id);


--
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- Name: reset_password_request token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_password_request
    ADD CONSTRAINT token_pkey PRIMARY KEY (token);


--
-- Name: user user_id_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_id_unique UNIQUE (id);


--
-- Name: user user_pkey1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey1 PRIMARY KEY (email);


--
-- Name: user_verification user_verification_token_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_token_pkey PRIMARY KEY (token);


--
-- Name: edible business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edible
    ADD CONSTRAINT business_fkey FOREIGN KEY (business_id) REFERENCES public.business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product business_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT business_product_fkey FOREIGN KEY (business_id) REFERENCES public.business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: business business_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.business
    ADD CONSTRAINT business_user_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: concentrate concentrate_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.concentrate
    ADD CONSTRAINT concentrate_business_fkey FOREIGN KEY (business_id) REFERENCES public.business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: concentrate concentrate_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.concentrate
    ADD CONSTRAINT concentrate_product_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flower flower_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flower
    ADD CONSTRAINT flower_business_fkey FOREIGN KEY (business_id) REFERENCES public.business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: flower flower_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.flower
    ADD CONSTRAINT flower_product_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: inquiry inquiry_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_business_fkey FOREIGN KEY (seller_business_id) REFERENCES public.business(id) ON UPDATE CASCADE;


--
-- Name: inquiry inquiry_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_product_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE;


--
-- Name: inquiry inquiry_user_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.inquiry
    ADD CONSTRAINT inquiry_user_fkey FOREIGN KEY (buyer_user_id) REFERENCES public."user"(id) ON UPDATE CASCADE;


--
-- Name: edible product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edible
    ADD CONSTRAINT product_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: product_pricing product_pricing_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product_pricing
    ADD CONSTRAINT product_pricing_product_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: reset_password_request reset_password_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reset_password_request
    ADD CONSTRAINT reset_password_user_email_fkey FOREIGN KEY (email) REFERENCES public."user"(email) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- Name: topical topical_business_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topical
    ADD CONSTRAINT topical_business_fkey FOREIGN KEY (business_id) REFERENCES public.business(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: topical topical_product_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.topical
    ADD CONSTRAINT topical_product_fkey FOREIGN KEY (product_id) REFERENCES public.product(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: user_verification user_verification_user_email_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_verification
    ADD CONSTRAINT user_verification_user_email_fkey FOREIGN KEY (email) REFERENCES public."user"(email) ON UPDATE RESTRICT ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--
