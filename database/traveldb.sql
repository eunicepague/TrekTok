--
-- PostgreSQL database dump
--

\restrict lH6XSs7mH7Gne38uMKTIOXc1ezpI0bcDOLGW1zMGkweotVQYr9JLqR6ZoWiMx2P

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bookings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.bookings (
    booking_id integer NOT NULL,
    user_id integer NOT NULL,
    package_id integer NOT NULL,
    booking_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    comments character varying(255),
    status character varying(20) DEFAULT 'CONFIRMED'::character varying,
    travel_date date,
    traveler_count integer DEFAULT 1,
    option_id integer
);


ALTER TABLE public.bookings OWNER TO postgres;

--
-- Name: bookings_booking_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.bookings_booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.bookings_booking_id_seq OWNER TO postgres;

--
-- Name: bookings_booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.bookings_booking_id_seq OWNED BY public.bookings.booking_id;


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.feedback (
    feedback_id integer NOT NULL,
    user_id integer NOT NULL,
    email character varying(100) NOT NULL,
    contact_no character varying(20),
    message character varying(255) NOT NULL,
    rating integer,
    feedback_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    admin_remarks character varying(255),
    status character varying(20) DEFAULT 'PENDING'::character varying,
    booking_id integer,
    package_name character varying(100)
);


ALTER TABLE public.feedback OWNER TO postgres;

--
-- Name: feedback_feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.feedback_feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_feedback_id_seq OWNER TO postgres;

--
-- Name: feedback_feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.feedback_feedback_id_seq OWNED BY public.feedback.feedback_id;


--
-- Name: nearby_places; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nearby_places (
    place_id integer NOT NULL,
    package_id integer NOT NULL,
    place_name character varying(100) NOT NULL,
    category character varying(50) NOT NULL,
    address character varying(255),
    distance_km numeric(5,2),
    map_link character varying(500),
    latitude numeric(10,7),
    longitude numeric(10,7)
);


ALTER TABLE public.nearby_places OWNER TO postgres;

--
-- Name: nearby_places_place_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nearby_places_place_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nearby_places_place_id_seq OWNER TO postgres;

--
-- Name: nearby_places_place_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nearby_places_place_id_seq OWNED BY public.nearby_places.place_id;


--
-- Name: package_option; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_option (
    option_id integer NOT NULL,
    package_id integer NOT NULL,
    option_name character varying(100) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    max_pax integer NOT NULL,
    available_slots integer NOT NULL
);


ALTER TABLE public.package_option OWNER TO postgres;

--
-- Name: package_option_option_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_option_option_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.package_option_option_id_seq OWNER TO postgres;

--
-- Name: package_option_option_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_option_option_id_seq OWNED BY public.package_option.option_id;


--
-- Name: package_schedule; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.package_schedule (
    schedule_id integer NOT NULL,
    package_id integer NOT NULL,
    travel_date date NOT NULL,
    available_slots integer NOT NULL
);


ALTER TABLE public.package_schedule OWNER TO postgres;

--
-- Name: package_schedule_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.package_schedule_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.package_schedule_schedule_id_seq OWNER TO postgres;

--
-- Name: package_schedule_schedule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.package_schedule_schedule_id_seq OWNED BY public.package_schedule.schedule_id;


--
-- Name: packages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.packages (
    package_id integer NOT NULL,
    package_name character varying(100) NOT NULL,
    description text,
    price numeric(10,2) NOT NULL,
    available_slots integer NOT NULL,
    destination character varying(100),
    duration character varying(100),
    image_name character varying(255),
    weather_info character varying(255),
    latitude numeric(10,7),
    longitude numeric(10,7),
    package_type character varying(50)
);


ALTER TABLE public.packages OWNER TO postgres;

--
-- Name: packages_package_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.packages_package_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.packages_package_id_seq OWNER TO postgres;

--
-- Name: packages_package_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.packages_package_id_seq OWNED BY public.packages.package_id;


--
-- Name: payments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.payments (
    payment_id integer NOT NULL,
    booking_id integer NOT NULL,
    card_name character varying(100) NOT NULL,
    card_number character varying(20) NOT NULL,
    payment_type character varying(20) NOT NULL,
    amount numeric(10,2) NOT NULL,
    payment_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(20) DEFAULT 'PAID'::character varying
);


ALTER TABLE public.payments OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.payments_payment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.payments_payment_id_seq OWNER TO postgres;

--
-- Name: payments_payment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.payments_payment_id_seq OWNED BY public.payments.payment_id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    user_id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password character varying(100) NOT NULL,
    contact_no character varying(20),
    is_verified boolean DEFAULT false,
    verification_code character varying(20),
    role character varying(20) DEFAULT 'CUSTOMER'::character varying,
    account_status character varying(20) DEFAULT 'ACTIVE'::character varying,
    reset_code character varying(10),
    reset_code_expiry timestamp without time zone
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_user_id_seq OWNER TO postgres;

--
-- Name: users_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_user_id_seq OWNED BY public.users.user_id;


--
-- Name: bookings booking_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings ALTER COLUMN booking_id SET DEFAULT nextval('public.bookings_booking_id_seq'::regclass);


--
-- Name: feedback feedback_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback ALTER COLUMN feedback_id SET DEFAULT nextval('public.feedback_feedback_id_seq'::regclass);


--
-- Name: nearby_places place_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nearby_places ALTER COLUMN place_id SET DEFAULT nextval('public.nearby_places_place_id_seq'::regclass);


--
-- Name: package_option option_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_option ALTER COLUMN option_id SET DEFAULT nextval('public.package_option_option_id_seq'::regclass);


--
-- Name: package_schedule schedule_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_schedule ALTER COLUMN schedule_id SET DEFAULT nextval('public.package_schedule_schedule_id_seq'::regclass);


--
-- Name: packages package_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.packages ALTER COLUMN package_id SET DEFAULT nextval('public.packages_package_id_seq'::regclass);


--
-- Name: payments payment_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments ALTER COLUMN payment_id SET DEFAULT nextval('public.payments_payment_id_seq'::regclass);


--
-- Name: users user_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN user_id SET DEFAULT nextval('public.users_user_id_seq'::regclass);


--
-- Data for Name: bookings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.bookings (booking_id, user_id, package_id, booking_date, comments, status, travel_date, traveler_count, option_id) FROM stdin;
1	4	10	2026-04-15 09:46:41.624187		CONFIRMED	2026-04-25	1	38
2	4	9	2026-04-16 07:16:04.837211		CONFIRMED	2026-04-25	1	34
3	4	7	2026-04-16 07:32:04.240173		CONFIRMED	2026-04-30	1	26
4	4	16	2026-04-16 07:36:51.71028		CANCELLED	2026-05-03	1	53
5	4	13	2026-04-16 07:37:30.307944		REJECTED	2026-05-03	1	49
6	5	17	2026-04-16 07:49:06.114342		CONFIRMED	2026-04-17	1	54
7	5	8	2026-04-16 07:58:38.054159		CONFIRMED	2026-04-25	1	30
8	6	20	2026-04-16 12:06:03.756415		CONFIRMED	2026-04-25	1	56
9	7	11	2026-04-16 15:21:22.911006	Lets go YOLO	CONFIRMED	2026-04-25	1	41
10	7	13	2026-04-16 15:27:03.009465	Lets go <3	CANCELLED	2026-04-20	1	49
11	7	12	2026-04-16 15:28:00.28048		REJECTED	2026-05-03	1	48
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.feedback (feedback_id, user_id, email, contact_no, message, rating, feedback_date, admin_remarks, status, booking_id, package_name) FROM stdin;
1	5	vowebe9301@spotshops.com	09107234599	Very nice!!!	5	2026-04-16 07:51:57.953347	Thank you!	RESOLVED	6	Tagaytay Quick Escape
2	5	vowebe9301@spotshops.com	09107234599	Very nice island	4	2026-04-16 08:02:50.253209	\N	PENDING	7	Camiguin Island Journey
3	6	widad55010@spotshops.com	09107234591	Superb hotel!! will go back next time!	5	2026-04-16 12:10:54.354089	Thank you for choosing us! <3	RESOLVED	8	Camayan Beach Resort Package
4	7	joteyis452@sixoplus.com	09107234592	I want to try this again!!!!	5	2026-04-16 15:25:46.678092	Thanks for coming!	RESOLVED	9	Sagada Highland Journey
\.


--
-- Data for Name: nearby_places; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nearby_places (place_id, package_id, place_name, category, address, distance_km, map_link, latitude, longitude) FROM stdin;
2	1	Bantay Bell Tower	Historical Site	Bantay, Ilocos Sur	\N	https://maps.google.com/?q=Bantay+Bell+Tower+Ilocos+Sur	17.5825000	120.3901000
3	1	Hotel Luna	Hotel	Currimao, Ilocos Norte	\N	https://www.google.com/maps/place/Sitio+Remedios+Heritage+Village/@17.998924,120.4973101,17.25z/data=!4m9!3m8!1s0x338e94e15fde9edf:0x11bf9679310a7243!5m2!4m1!1i2!8m2!3d17.9989394!4d120.4992671!16s%2Fg%2F1thktszn?entry=ttu&g_ep=EgoyMDI2MDQxMi4wIKXMDSoASAFQAw%3D%3D	17.5707000	120.3873000
1	1	Calle Crisologo	Tourist Spot	Vigan City, Ilocs Sur	\N	https://maps.google.com/?q=Calle+Crisologo+Vigan+City+Ilocos+Sur	17.5749000	120.3864000
\.


--
-- Data for Name: package_option; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_option (option_id, package_id, option_name, description, price, max_pax, available_slots) FROM stdin;
1	1	Solo	Perfect for 1 traveler seeking a relaxing and memorable heritage adventure in Ilocos.	5000.00	1	10
3	1	Family	Best for families of up to 4 who want to create unforgettable memories through cultural tours, scenic spots, and quality bonding time in Ilocos.	17500.00	6	10
4	1	Barkada	Perfect for groups of friends who want a fun-filled Ilocos adventure with heritage tours, beautiful views, and unforgettable travel moments together.	32000.00	12	10
2	1	Couple	Ideal for 2 travelers who want to enjoy a romantic and exciting getaway while exploring the beauty and history of Ilocos together.	9000.00	2	10
5	2	Solo	Perfect for 1 traveler looking for a peaceful and scenic island adventure in Coron while enjoying nature, beaches, and relaxing escapes.	8500.00	1	10
32	8	Barkada	Perfect for groups of friends who want a fuller Camiguin trip with road trips, swimming spots, and enough time to enjoy the island without packing everything into a short stay.	59800.00	12	10
6	2	Couple	Ideal for 2 travelers who want a romantic and memorable tropical getaway while exploring the beautiful lagoons and island views of Coron together.	16500.00	2	10
7	2	Family	Best for families of up to 4 who want to enjoy quality bonding time through island hopping, beach activities, and unforgettable sightseeing moments in Coron.	35000.00	6	10
8	2	Barkada	Perfect for groups of friends who want a fun-filled Coron adventure with stunning ocean views, exciting boat tours, and memorable travel experiences together.	63000.00	12	10
9	3	Solo	Perfect for 1 traveler looking for a peaceful and enjoyable escape while discovering the scenic countryside and relaxing attractions of Bohol.	6500.00	1	10
10	3	Couple	Ideal for 2 travelers who want a romantic and memorable getaway while exploring the natural wonders and charming spots of Bohol together.	12000.00	2	10
11	3	Family	Best for families of up to 4 who want to create unforgettable memories through countryside tours, river cruises, and relaxing beach moments in Bohol.	18500.00	6	10
12	3	Barkada	Perfect for groups of friends who want a fun-filled Bohol adventure with sightseeing, nature trips, and exciting travel experiences together.	25000.00	12	10
13	4	Solo	Perfect for 1 traveler looking for a refreshing and peaceful island adventure while enjoying the relaxing atmosphere and natural beauty of Siargao.	5500.00	1	10
14	4	Couple	Ideal for 2 travelers who want a romantic and memorable tropical getaway while exploring the beautiful beaches and island attractions of Siargao together.	12499.98	2	10
15	4	Family	Best for families of up to 4 who want to enjoy quality bonding time through island hopping, sightseeing, and relaxing beach moments in Siargao.	21000.00	6	10
16	4	Barkada	Perfect for groups of friends who want a fun-filled Siargao adventure with beach trips, island tours, and unforgettable travel memories together.	38000.00	12	10
17	5	Solo	Perfect for 1 traveler looking for a quick and peaceful beach escape in Batangas while enjoying the relaxing coastal atmosphere.	5500.00	1	10
18	5	Couple	Ideal for 2 travelers who want a romantic and memorable seaside getaway while enjoying the beaches and relaxing views of Batangas together.	11500.01	2	10
19	5	Family	Best for families of up to 4 who want to enjoy quality bonding time through beach activities, resort relaxation, and fun shore adventures in Batangas.	15000.00	6	10
20	5	Barkada	Perfect for groups of friends who want a fun-filled Batangas getaway with beach outings, laughter, and unforgettable travel memories together.	23000.00	12	10
21	6	Solo	Perfect for 1 traveler looking for a peaceful and scenic escape while enjoying the breathtaking landscapes and relaxing atmosphere of Batanes.	12000.00	1	10
22	6	Couple	Ideal for 2 travelers who want a romantic and unforgettable getaway while exploring the beautiful hills, coastlines, and charming sights of Batanes together.	22000.00	2	10
23	6	Family	Best for families of up to 4 who want to create unforgettable memories through sightseeing, cultural exploration, and relaxing island moments in Batanes.	32000.00	6	10
24	6	Barkada	Perfect for groups of friends who want a fun and scenic Batanes adventure with breathtaking views, cultural spots, and unforgettable travel experiences together.	52000.00	12	10
25	7	Solo	Perfect for 1 traveler who wants a quiet island break with scenic views, peaceful beaches, and enough time to enjoy Siquijor at a relaxed pace.	6200.00	1	10
27	7	Family	Best for families of up to 4 who want a light and enjoyable island trip filled with beach time, sightseeing, and memorable bonding moments.	22500.00	6	10
28	7	Barkada	Perfect for groups of friends who want a fun but laid-back island adventure with road trips, swimming spots, and unforgettable Siquijor memories together.	39500.00	12	10
29	8	Solo	A good fit for 1 traveler who wants a relaxed island trip with enough time to enjoy Camiguin’s springs, shoreline views, and quiet atmosphere.	9800.00	1	10
31	8	Family	Best for families of up to 4 who want a comfortable and enjoyable island trip with sightseeing, nature stops, and time to rest in between activities.	33800.00	6	10
33	9	Solo	A good fit for 1 traveler who wants enough time to see Siargao beyond the usual photo stops, while still keeping the trip light, flexible, and easy.	9800.00	1	10
35	9	Family	Best for families of up to 4 who want a balanced island vacation with scenic tours, relaxed pacing, and time to enjoy Siargao without rushing from one stop to another.	34800.00	6	10
36	9	Barkada	Perfect for groups of friends who want a fuller Siargao trip with island hopping, road trips, beach time, and enough breathing room to actually enjoy the island vibe.	62799.98	12	10
37	10	Solo	A good fit for 1 traveler who wants a comfortable beach getaway with enough time to enjoy Boracay at a relaxed pace.	9800.00	1	10
34	9	Couple	Ideal for 2 travelers who want a laid-back island trip with room for both activities and quiet downtime, from boat tours to slow evenings by the shore.	18200.00	2	9
26	7	Couple	Ideal for 2 travelers who want a calm and intimate island getaway with coastal views, waterfall visits, and sunset moments in Siquijor.	11799.98	2	9
30	8	Couple	Ideal for 2 travelers who want a laid-back island holiday with scenic stops, slower mornings, and more time to enjoy the island together.	17800.00	2	9
39	10	Family	Best for families of up to 4 who want a smooth and enjoyable Boracay trip with space for both beach activities and downtime.	36800.00	6	10
40	10	Barkada	Perfect for groups of friends who want a lively Boracay trip with island fun, beachside evenings, and enough time to enjoy the island without squeezing everything into a short stay.	66800.00	12	10
42	11	Couple	Ideal for 2 travelers who want a quiet and memorable highland trip with cool weather, scenic stops, and time to enjoy Sagada together.	9600.00	2	10
44	11	Barkada	Perfect for groups of friends who want a fun Sagada trip with road views, shared adventures, and enough time to enjoy the place without rushing the itinerary.	32800.00	12	10
43	11	Family	Best for families of up to 4 who want a comfortable countryside trip with sightseeing, local culture, and a relaxed pace across the stay.	18200.00	6	10
45	12	Solo	A good fit for 1 traveler who wants a calm island trip with enough time to enjoy Romblon’s beaches, local scenery, and slower pace.	7600.00	1	10
46	12	Couple	Ideal for 2 travelers who want a relaxed island holiday with quieter shores, scenic boat rides, and time to enjoy Romblon together.	14500.00	2	10
47	12	Family	Best for families of up to 4 who want a comfortable seaside trip with light activities, island views, and a more peaceful travel atmosphere.	27600.00	6	10
48	12	Barkada	Perfect for groups of friends who want a fun but easygoing island trip with beach time, island hopping, and enough room to enjoy Romblon without rushing from stop to stop.	49199.99	12	10
49	13	Couple	Ideal for 2 guests who want a more refined Boracay getaway with beach time, sunset walks, and a relaxing hotel stay.	18800.00	2	3
50	14	Couple	Ideal for 2 guests who want a practical but polished Cebu city getaway.	9800.00	2	5
51	15	Family	Best for families of up to 4 who want a relaxed Coron hotel package with a comfortable base near town.	31500.00	6	3
52	15	Barkada	Great for groups of friends who want a well-balanced Coron trip with island adventure and a stylish hotel stay.	54800.00	12	3
53	16	Couple	Ideal for 2 guests who want a cool-weather hotel getaway in a more peaceful part of Baguio.	11200.00	2	5
38	10	Couple	Ideal for 2 travelers who want a well-paced island holiday with beach time, sunset views, and a more polished resort experience together.	18800.00	2	9
55	18	Barkada	This package is designed for travelers who want convenient and hassle-free transportation while visiting Bohol’s top attractions.	3500.00	12	3
54	17	Solo	Includes: People’s Park, Sky Ranch, Taal viewing spots	850.00	1	9
56	20	Family	This package is perfect for travelers looking for a relaxing beach vacation with comfortable accommodations, swimming, and quality time with family, friends, or loved ones.	12300.00	6	4
41	11	Solo	A good fit for 1 traveler who wants a mountain break with enough time for sightseeing, short treks, and slow mornings in Sagada.	5200.00	1	9
\.


--
-- Data for Name: package_schedule; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.package_schedule (schedule_id, package_id, travel_date, available_slots) FROM stdin;
\.


--
-- Data for Name: packages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.packages (package_id, package_name, description, price, available_slots, destination, duration, image_name, weather_info, latitude, longitude, package_type) FROM stdin;
5	Batangas Shore Escape	Enjoy a refreshing seaside getaway in Batangas with beautiful beaches, clear waters, scenic shorelines, and relaxing coastal views. This trip is perfect for travelers who want a quick escape with beach relaxation, light water activities, and memorable moments.\r\n2 days and 1 night	5500.00	40	Batangas	2 days and 1 night	batangas.jpg	\N	14.0746824	120.6253682	TRAVEL_PACKAGE
12	Romblon Island Discovery	Enjoy a slower island escape in Romblon with clear waters, uncrowded shores, scenic coastal views, and a laid-back atmosphere. This trip is perfect for travelers who want sea views, soft adventure, and a more relaxed island experience.\r\n4 days and 3 nights	7600.00	40	Romblon 	4 days and 3 nights	romblon.jpg	\N	12.5305601	122.2880536	TRAVEL_PACKAGE
6	Batanes Scenic Retreat	Experience the peaceful beauty of Batanes with rolling hills, breathtaking cliffs, stone houses, historic churches, and stunning ocean views. This trip is perfect for travelers who love nature, culture, quiet escapes, and scenic adventures.\r\n5 days and 4 nights	12000.00	40	Batanes	5 days and 4 nights	batanes.jpg	\N	20.4659661	121.9647408	TRAVEL_PACKAGE
7	Siquijor Island Serenity	Slow down and enjoy the quieter side of island travel with sunsets by the shore, clear turquoise waters, old churches, hidden waterfalls, and scenic coastal drives. This trip is perfect for travelers who want nature, charm, and calm without the crowds.\r\n3 days and 2 nights	6200.00	40	Siquijor	3 days and 2 nights	siquijor.jpg	\N	9.0992387	123.6050614	TRAVEL_PACKAGE
4	Siargao Island Adventure	Discover the laid-back charm of Siargao with stunning beaches, crystal-clear lagoons, coconut-lined roads, island hopping tours, and its relaxing surfer vibe. This trip is perfect for travelers who enjoy beach adventures, scenic views, and unforgettable island experiences.\r\n3 days and 2 nights	5500.00	40	Siargao	3 days and 2 nights	siargao.jpg		9.7831249	126.1567993	\N
8	Camiguin Island Journey	Camiguin Island Journey\r\nEnjoy a slow and scenic escape in Camiguin with beaches, cold springs, waterfalls, and coastal drives. This trip is perfect for travelers who want rest, beautiful views, and light adventure at a relaxed pace.\r\n4 days and 3 nights	9800.00	40	Camiguin	4 days and 3 nights	camiguin.jpg	\N	18.9499028	121.9241418	TRAVEL_PACKAGE
9	Siargao Island Drift	Enjoy the easy rhythm of Siargao with island hopping, coconut-lined roads, coastal views, and slow days in General Luna. This trip is perfect for travelers who want a mix of beach adventure, relaxation, and unhurried island living.\r\n4 days and 3 nights	9800.00	40	Siargao	4 days and 3 nights	siargao1.jpg	\N	9.7628898	126.1272698	TRAVEL_PACKAGE
2	Coron Island Escape	Experience the breathtaking beauty of Coron with crystal-clear lagoons, limestone cliffs, white sand beaches, and vibrant marine life. This trip is perfect for travelers who love island hopping, snorkeling, relaxing by the sea, and tropical adventures.\r\n3 days and 2 nights	8500.00	40	Palawan	3 days and 2 nights	palawan.jpg	\N	11.9989345	120.2022371	TRAVEL_PACKAGE
10	Boracay White Beach Holiday	Settle into the easy rhythm of Boracay with long walks on White Beach, slow mornings by the water, sunset dinners, and time for island activities or pure relaxation. This trip is perfect for travelers who want comfort, scenery, and a beach escape enjoyed at a relaxed pace.\r\n4 days and 3 nights	9800.00	39	Boracay	4 days and 3 nights	boracay.jpg	\N	11.9694067	121.9200677	TRAVEL_PACKAGE
11	Sagada Highland Journey	Leave the beaches behind and enjoy the cooler, quieter beauty of Sagada with mountain air, caves, hanging coffins, and peaceful surroundings. This trip is perfect for travelers who enjoy cool weather, light adventure, mountain scenery, and a reflective getaway.\r\n3 days and 2 nights	5200.00	40	Sagada	3 days and 2 nights	sagada.jpg	\N	17.0816845	120.9057536	TRAVEL_PACKAGE
3	Bohol Countryside Adventure	Experience the natural beauty and cultural charm of Bohol with this unforgettable countryside getaway. Visit the world-famous Chocolate Hills, meet the adorable tarsiers, cruise along the scenic Loboc River, and enjoy the relaxing beauty of white sand beaches and peaceful island views. Perfect for travelers who love nature, family-friendly adventures, cultural attractions, and memorable sightseeing in one exciting trip.\r\n3 days and 2 nights	6500.00	40	Bohol	3 days and 2 nights	bohol.jpg	\N	9.7906098	124.1578620	TRAVEL_PACKAGE
15	The Funny Lion Coron Hotel Package	The Funny Lion Coron\r\n\r\nThis package is for travelers who want a more boutique-style stay while exploring Coron. It fits guests who like island activities during the day but still want a quiet, stylish hotel to return to after tours, boat rides, and long outdoor excursions.\r\n4 days and 3 nights	31500.00	6	Palawan	4 days and 3 nights	lion.jpg	\N	12.0040435	120.1923888	HOTEL
13	Henann Boracay Hotel Package	Enjoy a comfortable Boracay stay with convenient beach access, nearby dining spots, and a polished hotel experience near White Beach. This package is perfect for travelers who want comfort, convenience, and a relaxed island escape.\r\n4 days and 3 nights	18800.00	3	Boracay	4 days and 3 nights	henann.jpg	\N	11.9719244	121.9179447	HOTEL
20	Camayan Beach Resort Package	Enjoy a relaxing beach getaway in Subic with scenic coastal views, fresh sea breeze, and fun outdoor activities. This package is perfect for travelers who want a quick escape filled with beachside leisure, water adventures, and memorable moments with family or friends.	12300.00	0	Subic	2 days and 1 night	camayan.jpg	\N	14.8622944	120.2371381	HOTEL
21	UNWND Calatagan Hotel Package	Enjoy relaxing in the beautiful views of Batangas beaches.	6000.00	0	Batangas 	2 days and 1 night	unwind.jpeg	\N	13.8599258	120.6234310	TRAVEL_PACKAGE
14	Seda Ayala Cebu Hotel Package	This package suits travelers who want a hotel-based city trip with comfort, convenience, and quick access to shopping, dining, and business areas. It works well for guests who prefer a smooth urban stay rather than a resort-style vacation, while still keeping the trip enjoyable and relaxed.\r\n3 days and 2 nights	9800.00	5	Cebu	3 days and 2 nights	seda.jpeg	\N	10.3178279	123.9069510	\N
1	Ilocos Heritage Trip	Step into the rich history and timeless beauty of Ilocos with centuries-old churches, iconic landmarks, cobblestone streets, and scenic coastal views. This trip is perfect for travelers who love culture, history, local delicacies, and memorable adventures. \r\n3 days and 2 nights	5000.00	40	Ilocos	3 days and 2 nights	ilocos.jpg	\N	17.5747000	120.3869000	TRAVEL_PACKAGE
19	Cebu City to Moalboal Tourist Van Service	Travel comfortably from Cebu City to Moalboal with this tourist van transfer service, ideal for travelers heading to beaches, resorts, and diving spots in the southwest part of Cebu.	6500.00	0	Cebu to Moalboal	1 Day	cebu-van-service.jpg	\N	\N	\N	TRANSPORT
18	Bohol Countryside Day Tour Van Rental	Enjoy a comfortable full-day countryside trip around Bohol with a private van service perfect for families, couples, or small groups.	3500.00	3	Bohol	1	bohol-countryside.jpg	\N	\N	\N	TRANSPORT
17	Tagaytay Quick Escape	Includes: People’s Park, Sky Ranch, Taal viewing spots	850.00	10	Tagaytay	1 Day	tagaytay.jpg	\N	14.1172301	120.9617934	DESTINATION
16	The Manor Baguio Hotel Package	This package is a good fit for travelers who want cool weather, pine-tree surroundings, and a more classic Baguio hotel experience. It works especially well for guests who want rest, food trips, and slow sightseeing rather than a packed activity-heavy itinerary.\r\n3 days and 2 nights	11200.00	5	Baguio	3 days and 2 nights	manor.jpg	\N	16.4007943	120.6176332	HOTEL
\.


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.payments (payment_id, booking_id, card_name, card_number, payment_type, amount, payment_date, status) FROM stdin;
1	1	BDO	1234123412341234	CREDIT CARD	18800.00	2026-04-15 09:48:04.972962	PAID
2	3	BDO	1234123412341234	CREDIT CARD	11799.98	2026-04-16 07:35:17.897545	PAID
3	6	BDO	1234123412341234	CREDIT CARD	850.00	2026-04-16 07:50:06.642374	PAID
4	7	BDO	1234123412341234	CREDIT CARD	17800.00	2026-04-16 07:59:54.829689	PAID
5	8	BDO	1234123412341234	CREDIT CARD	12300.00	2026-04-16 12:09:13.28787	PAID
6	9	BDO	1234123412341234	DEBIT CARD	5200.00	2026-04-16 15:24:34.159289	PAID
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (user_id, first_name, last_name, email, password, contact_no, is_verified, verification_code, role, account_status, reset_code, reset_code_expiry) FROM stdin;
1	Admin	Eunice	admin@gmail.com	admin2255	09166457858	t	\N	SUPER_ADMIN	ACTIVE	\N	\N
2	Eunice	Pague	eunicegracepague@gmail.com	P@ssw0rd2255	09166457858	t	753944	ADMIN	ACTIVE	\N	\N
3	Customer	One	fadeh72440@lealking.com	P@ssw0rd2255	09107234587	t	304174	CUSTOMER	ACTIVE	\N	\N
4	Peds	Pogi	kikape6312@nazisat.com	P@ssw0rd1234	09107234588	t	395188	CUSTOMER	ACTIVE	\N	\N
5	Jose	Rizal	vowebe9301@spotshops.com	P@ssw0rd1234	09107234599	t	473809	CUSTOMER	ACTIVE	296899	2026-04-16 10:21:29.044427
6	Juan	Luna	widad55010@spotshops.com	P@ssw0rd1234	09107234591	t	752087	CUSTOMER	ACTIVE	\N	\N
7	Maria	Clara	joteyis452@sixoplus.com	P@ssw0rd2255	09107234592	t	170255	CUSTOMER	ACTIVE	\N	\N
\.


--
-- Name: bookings_booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.bookings_booking_id_seq', 11, true);


--
-- Name: feedback_feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.feedback_feedback_id_seq', 4, true);


--
-- Name: nearby_places_place_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nearby_places_place_id_seq', 3, true);


--
-- Name: package_option_option_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_option_option_id_seq', 57, true);


--
-- Name: package_schedule_schedule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.package_schedule_schedule_id_seq', 1, false);


--
-- Name: packages_package_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.packages_package_id_seq', 21, true);


--
-- Name: payments_payment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.payments_payment_id_seq', 6, true);


--
-- Name: users_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_user_id_seq', 7, true);


--
-- Name: bookings bookings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT bookings_pkey PRIMARY KEY (booking_id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (feedback_id);


--
-- Name: nearby_places nearby_places_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nearby_places
    ADD CONSTRAINT nearby_places_pkey PRIMARY KEY (place_id);


--
-- Name: package_option package_option_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_option
    ADD CONSTRAINT package_option_pkey PRIMARY KEY (option_id);


--
-- Name: package_schedule package_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_schedule
    ADD CONSTRAINT package_schedule_pkey PRIMARY KEY (schedule_id);


--
-- Name: packages packages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.packages
    ADD CONSTRAINT packages_pkey PRIMARY KEY (package_id);


--
-- Name: payments payments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (payment_id);


--
-- Name: users users_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: bookings fk_booking_option; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_booking_option FOREIGN KEY (option_id) REFERENCES public.package_option(option_id);


--
-- Name: bookings fk_booking_package; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_booking_package FOREIGN KEY (package_id) REFERENCES public.packages(package_id);


--
-- Name: bookings fk_booking_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.bookings
    ADD CONSTRAINT fk_booking_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: feedback fk_feedback_booking; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_feedback_booking FOREIGN KEY (booking_id) REFERENCES public.bookings(booking_id);


--
-- Name: feedback fk_feedback_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_feedback_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: package_option fk_option_package; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_option
    ADD CONSTRAINT fk_option_package FOREIGN KEY (package_id) REFERENCES public.packages(package_id);


--
-- Name: payments fk_payment_booking; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.payments
    ADD CONSTRAINT fk_payment_booking FOREIGN KEY (booking_id) REFERENCES public.bookings(booking_id);


--
-- Name: package_schedule fk_schedule_package; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.package_schedule
    ADD CONSTRAINT fk_schedule_package FOREIGN KEY (package_id) REFERENCES public.packages(package_id);


--
-- PostgreSQL database dump complete
--

\unrestrict lH6XSs7mH7Gne38uMKTIOXc1ezpI0bcDOLGW1zMGkweotVQYr9JLqR6ZoWiMx2P

