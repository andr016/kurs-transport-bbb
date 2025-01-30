-- public.route definition

-- Drop table

-- DROP TABLE public.route;

CREATE TABLE public.route (
	route_id bpchar(18) NOT NULL,
	"name" varchar(20) NULL,
	CONSTRAINT route_pkey PRIMARY KEY (route_id)
);


-- public.tariff definition

-- Drop table

-- DROP TABLE public.tariff;

CREATE TABLE public.tariff (
	tariff_id bpchar(18) NOT NULL,
	city varchar(20) NULL,
	transport_type varchar(20) NULL,
	amount int4 NULL,
	CONSTRAINT tariff_pkey PRIMARY KEY (tariff_id)
);


-- public.ticket definition

-- Drop table

-- DROP TABLE public.ticket;

CREATE TABLE public.ticket (
	ticket_id bpchar(18) NOT NULL,
	card_id int4 NULL,
	expiry_date date NULL,
	ticket_type varchar(20) NULL,
	payment_system varchar(20) NULL,
	privilege int4 NULL,
	CONSTRAINT ticket_pkey PRIMARY KEY (ticket_id)
);


-- public."zone" definition

-- Drop table

-- DROP TABLE public."zone";

CREATE TABLE public."zone" (
	zone_id bpchar(18) NOT NULL,
	tariff_id bpchar(18) NULL,
	route_id bpchar(18) NOT NULL,
	CONSTRAINT zone_pkey PRIMARY KEY (zone_id, route_id),
	CONSTRAINT zone_route_id_fkey FOREIGN KEY (route_id) REFERENCES public.route(route_id) ON DELETE CASCADE,
	CONSTRAINT zone_tariff_id_fkey FOREIGN KEY (tariff_id) REFERENCES public.tariff(tariff_id)
);


-- public.station definition

-- Drop table

-- DROP TABLE public.station;

CREATE TABLE public.station (
	station_id bpchar(18) NOT NULL,
	"name" varchar(20) NULL,
	zone_id bpchar(18) NULL,
	route_id bpchar(18) NULL,
	no_in_route int4 NULL,
	CONSTRAINT station_pkey PRIMARY KEY (station_id),
	CONSTRAINT station_zone_id_route_id_fkey FOREIGN KEY (zone_id,route_id) REFERENCES public."zone"(zone_id,route_id)
);


-- public.enter definition

-- Drop table

-- DROP TABLE public.enter;

CREATE TABLE public.enter (
	enter_id bpchar(18) NOT NULL,
	datetime timestamp NULL,
	ticket_id bpchar(18) NULL,
	station_id bpchar(18) NULL,
	CONSTRAINT enter_pkey PRIMARY KEY (enter_id),
	CONSTRAINT enter_station_id_fkey FOREIGN KEY (station_id) REFERENCES public.station(station_id),
	CONSTRAINT enter_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.ticket(ticket_id)
);


-- public."exit" definition

-- Drop table

-- DROP TABLE public."exit";

CREATE TABLE public."exit" (
	exit_id bpchar(18) NOT NULL,
	datetime timestamp NULL,
	enter_id bpchar(18) NULL,
	station_id bpchar(18) NULL,
	CONSTRAINT exit_pkey PRIMARY KEY (exit_id),
	CONSTRAINT exit_enter_id_fkey FOREIGN KEY (enter_id) REFERENCES public.enter(enter_id) ON DELETE CASCADE,
	CONSTRAINT exit_station_id_fkey FOREIGN KEY (station_id) REFERENCES public.station(station_id)
);