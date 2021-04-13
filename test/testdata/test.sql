--
-- PostgreSQL database dump
--
-- Dumped from database version 12.4
-- Dumped by pg_dump version 12.6 (Debian 12.6-1.pgdg100+1)
SET statement_timeout = 0;

SET lock_timeout = 0;

SET idle_in_transaction_session_timeout = 0;

SET client_encoding = 'UTF8';

SET standard_conforming_strings = ON;

SELECT
    pg_catalog.set_config('search_path', '', FALSE);

SET check_function_bodies = FALSE;

SET xmloption = content;

SET client_min_messages = warning;

SET row_security = OFF;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--
CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;

--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--
COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';

--
-- Name: provider_type; Type: TYPE; Schema: public; Owner: dbuser
--
CREATE TYPE public.provider_type AS ENUM (
    'fcm',
    'apn'
);

ALTER TYPE public.provider_type OWNER TO dbuser;

--
-- Name: user_scope; Type: TYPE; Schema: public; Owner: dbuser
--
CREATE TYPE public.user_scope AS ENUM (
    'app',
    'cms'
);

ALTER TYPE public.user_scope OWNER TO dbuser;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: access_tokens; Type: TABLE; Schema: public; Owner: dbuser
--
CREATE TABLE public.access_tokens (
    token uuid DEFAULT public.uuid_generate_v4 () NOT NULL,
    valid_until timestamp with time zone NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);

ALTER TABLE public.access_tokens OWNER TO dbuser;

--
-- Name: app_user_profiles; Type: TABLE; Schema: public; Owner: dbuser
--
CREATE TABLE public.app_user_profiles (
    user_id uuid NOT NULL,
    legal_accepted_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);

ALTER TABLE public.app_user_profiles OWNER TO dbuser;

--
-- Name: migrations; Type: TABLE; Schema: public; Owner: dbuser
--
CREATE TABLE public.migrations (
    id text NOT NULL,
    applied_at timestamp with time zone
);

ALTER TABLE public.migrations OWNER TO dbuser;

--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: dbuser
--
CREATE TABLE public.password_reset_tokens (
    token uuid DEFAULT public.uuid_generate_v4 () NOT NULL,
    valid_until timestamp with time zone NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);

ALTER TABLE public.password_reset_tokens OWNER TO dbuser;

--
-- Name: push_tokens; Type: TABLE; Schema: public; Owner: dbuser
--
CREATE TABLE public.push_tokens (
    id uuid DEFAULT public.uuid_generate_v4 () NOT NULL,
    token text NOT NULL,
    provider public.provider_type NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);

ALTER TABLE public.push_tokens OWNER TO dbuser;

--
-- Name: refresh_tokens; Type: TABLE; Schema: public; Owner: dbuser
--
CREATE TABLE public.refresh_tokens (
    token uuid DEFAULT public.uuid_generate_v4 () NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);

ALTER TABLE public.refresh_tokens OWNER TO dbuser;

--
-- Name: seq_health; Type: SEQUENCE; Schema: public; Owner: dbuser
--
CREATE SEQUENCE public.seq_health
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE public.seq_health OWNER TO dbuser;

--
-- Name: users; Type: TABLE; Schema: public; Owner: dbuser
--
CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4 () NOT NULL,
    username character varying(255),
    password text,
    is_active boolean NOT NULL,
    scopes text[] NOT NULL,
    last_authenticated_at timestamp with time zone,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);

ALTER TABLE public.users OWNER TO dbuser;

--
-- Data for Name: access_tokens; Type: TABLE DATA; Schema: public; Owner: dbuser
--
INSERT INTO public.access_tokens
    VALUES ('75d30fde-8931-4116-8617-35b12c5a9f5f', '2021-04-10 06:16:24.283203+00', '14c3dd26-93aa-4ec7-b213-196f5598772b', '2021-04-09 06:16:24.283204+00', '2021-04-09 06:16:24.283204+00');

--
-- Data for Name: app_user_profiles; Type: TABLE DATA; Schema: public; Owner: dbuser
--
INSERT INTO public.app_user_profiles
    VALUES ('14c3dd26-93aa-4ec7-b213-196f5598772b', NULL, '2021-04-09 06:16:24.282701+00', '2021-04-09 06:16:24.282701+00');

--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: dbuser
--
INSERT INTO public.migrations
    VALUES ('20200428064736-install-extension-uuid.sql', '2021-04-09 06:16:19.338365+00');

INSERT INTO public.migrations
    VALUES ('20200428064802-create-user-scope-enum.sql', '2021-04-09 06:16:19.338949+00');

INSERT INTO public.migrations
    VALUES ('20200428072232-create-users.sql', '2021-04-09 06:16:19.340139+00');

INSERT INTO public.migrations
    VALUES ('20200428072359-create-app-user-profiles.sql', '2021-04-09 06:16:19.341379+00');

INSERT INTO public.migrations
    VALUES ('20200428072541-create-access-tokens.sql', '2021-04-09 06:16:19.342429+00');

INSERT INTO public.migrations
    VALUES ('20200428072639-create-refresh-tokens.sql', '2021-04-09 06:16:19.343426+00');

INSERT INTO public.migrations
    VALUES ('20200428072651-create-password-reset-tokens.sql', '2021-04-09 06:16:19.344428+00');

INSERT INTO public.migrations
    VALUES ('20200529112509-create-push-token.sql', '2021-04-09 06:16:19.346173+00');

INSERT INTO public.migrations
    VALUES ('20200811180414-create-health-sequence.sql', '2021-04-09 06:16:19.346643+00');

--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: dbuser
--
--
-- Data for Name: push_tokens; Type: TABLE DATA; Schema: public; Owner: dbuser
--
--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: public; Owner: dbuser
--
INSERT INTO public.refresh_tokens
    VALUES ('f6539fdf-f939-4377-8168-7b8568688e19', '14c3dd26-93aa-4ec7-b213-196f5598772b', '2021-04-09 06:16:24.283661+00', '2021-04-09 06:16:24.283661+00');

--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dbuser
--
INSERT INTO public.users
    VALUES ('14c3dd26-93aa-4ec7-b213-196f5598772b', 'user@example.com', '$argon2id$v=19$m=65536,t=1,p=4$SwfpZS9ZGJ56MfR79EH8gw$7CsaEQIOA6Y3QLgT9Wi42gUIShY1y6gtLDraiil9N2M', TRUE, '{app}', '2021-04-09 06:16:24.281958+00', '2021-04-09 06:16:24.28196+00', '2021-04-09 06:16:24.28196+00');

--
-- Name: seq_health; Type: SEQUENCE SET; Schema: public; Owner: dbuser
--
SELECT
    pg_catalog.setval('public.seq_health', 1, FALSE);

--
-- Name: access_tokens access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_pkey PRIMARY KEY (token);

--
-- Name: app_user_profiles app_user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.app_user_profiles
    ADD CONSTRAINT app_user_profiles_pkey PRIMARY KEY (user_id);

--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);

--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (token);

--
-- Name: push_tokens push_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.push_tokens
    ADD CONSTRAINT push_tokens_pkey PRIMARY KEY (id);

--
-- Name: push_tokens push_tokens_token_key; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.push_tokens
    ADD CONSTRAINT push_tokens_token_key UNIQUE (token);

--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (token);

--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

--
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);

--
-- Name: idx_access_tokens_fk_user_uid; Type: INDEX; Schema: public; Owner: dbuser
--
CREATE INDEX idx_access_tokens_fk_user_uid ON public.access_tokens USING btree (user_id);

--
-- Name: idx_password_reset_tokens_fk_user_uid; Type: INDEX; Schema: public; Owner: dbuser
--
CREATE INDEX idx_password_reset_tokens_fk_user_uid ON public.password_reset_tokens USING btree (user_id);

--
-- Name: idx_push_tokens_fk_user_id; Type: INDEX; Schema: public; Owner: dbuser
--
CREATE INDEX idx_push_tokens_fk_user_id ON public.push_tokens USING btree (user_id);

--
-- Name: idx_push_tokens_token; Type: INDEX; Schema: public; Owner: dbuser
--
CREATE INDEX idx_push_tokens_token ON public.push_tokens USING btree (token);

--
-- Name: idx_refresh_tokens_fk_user_uid; Type: INDEX; Schema: public; Owner: dbuser
--
CREATE INDEX idx_refresh_tokens_fk_user_uid ON public.refresh_tokens USING btree (user_id);

--
-- Name: access_tokens access_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.access_tokens
    ADD CONSTRAINT access_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (id) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Name: app_user_profiles app_user_profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.app_user_profiles
    ADD CONSTRAINT app_user_profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (id) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Name: password_reset_tokens password_reset_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (id) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Name: push_tokens push_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.push_tokens
    ADD CONSTRAINT push_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (id) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- Name: refresh_tokens refresh_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: dbuser
--
ALTER TABLE ONLY public.refresh_tokens
    ADD CONSTRAINT refresh_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users (id) ON UPDATE CASCADE ON DELETE CASCADE;

--
-- PostgreSQL database dump complete
--
