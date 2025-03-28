

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


CREATE EXTENSION IF NOT EXISTS "pgsodium";






COMMENT ON SCHEMA "public" IS 'standard public schema';



CREATE EXTENSION IF NOT EXISTS "pg_graphql" WITH SCHEMA "graphql";






CREATE EXTENSION IF NOT EXISTS "pg_stat_statements" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgcrypto" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "pgjwt" WITH SCHEMA "extensions";






CREATE EXTENSION IF NOT EXISTS "supabase_vault" WITH SCHEMA "vault";






CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA "extensions";





SET default_tablespace = '';

SET default_table_access_method = "heap";


CREATE TABLE IF NOT EXISTS "public"."concentration_requirements" (
    "requirement_index" integer NOT NULL,
    "concentration_id" integer NOT NULL,
    "id" integer NOT NULL,
    "requirement_id" integer NOT NULL,
    "note" "text"
);


ALTER TABLE "public"."concentration_requirements" OWNER TO "postgres";


ALTER TABLE "public"."concentration_requirements" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."concentration_requirements_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."concentrations" (
    "name" "text",
    "note" "text",
    "id" integer NOT NULL,
    "degree_id" integer NOT NULL,
    "description" "text"
);


ALTER TABLE "public"."concentrations" OWNER TO "postgres";


ALTER TABLE "public"."concentrations" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."concentrations_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."courses" (
    "id" "text" NOT NULL,
    "title" "text" NOT NULL,
    "description" "text",
    "requirements" "text",
    "professors" "text"[],
    "distributions" "text"[],
    "flags" "text"[],
    "credits" numeric NOT NULL,
    "term" "text" NOT NULL,
    "is_colsem" boolean,
    "is_fysem" boolean,
    "is_sysem" boolean,
    "codes" "text"[],
    "seasons" "text"[]
);


ALTER TABLE "public"."courses" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."degrees" (
    "type" "text" NOT NULL,
    "id" integer NOT NULL,
    "program_id" integer NOT NULL,
    "note" "text"
);


ALTER TABLE "public"."degrees" OWNER TO "postgres";


ALTER TABLE "public"."degrees" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."degrees_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."fyp" (
    "id" bigint NOT NULL,
    "name" "text",
    "language_placement" "text",
    "term_arrangement" "text"
);


ALTER TABLE "public"."fyp" OWNER TO "postgres";


ALTER TABLE "public"."fyp" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."fyp_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."options" (
    "option_course_id" "text",
    "elective_range" "text",
    "is_any_okay" boolean DEFAULT false,
    "flags" "text"[],
    "id" integer NOT NULL,
    "note" "text"
);


ALTER TABLE "public"."options" OWNER TO "postgres";


ALTER TABLE "public"."options" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."options_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."programs" (
    "name" "text" NOT NULL,
    "student_count" smallint,
    "website_link" "text",
    "catalog_link" "text",
    "id" integer NOT NULL,
    "abbreviation" "text" NOT NULL
);


ALTER TABLE "public"."programs" OWNER TO "postgres";


ALTER TABLE "public"."programs" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."programs_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."requirement_subrequirements" (
    "subrequirement_index" smallint,
    "note" "text",
    "requirement_id" integer NOT NULL,
    "id" integer NOT NULL,
    "subrequirement_id" integer NOT NULL
);


ALTER TABLE "public"."requirement_subrequirements" OWNER TO "postgres";


ALTER TABLE "public"."requirement_subrequirements" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."requirement_subrequirements_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."requirements" (
    "name" "text" NOT NULL,
    "description" "text",
    "courses_required_count" integer DEFAULT 0 NOT NULL,
    "subreqs_required_count" integer DEFAULT 0 NOT NULL,
    "checkbox" boolean DEFAULT false NOT NULL,
    "note" "text",
    "id" integer NOT NULL
);


ALTER TABLE "public"."requirements" OWNER TO "postgres";


ALTER TABLE "public"."requirements" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."requirements_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."student_courses" (
    "id" "uuid" DEFAULT "gen_random_uuid"() NOT NULL,
    "course_id" "text" NOT NULL,
    "term" "text" NOT NULL,
    "status" "text" NOT NULL,
    "result" "text" NOT NULL,
    "fyp_id" bigint
);


ALTER TABLE "public"."student_courses" OWNER TO "postgres";


CREATE TABLE IF NOT EXISTS "public"."subrequirement_options" (
    "option_index" smallint,
    "note" "text",
    "subrequirement_id" integer NOT NULL,
    "option_id" integer NOT NULL,
    "id" integer NOT NULL
);


ALTER TABLE "public"."subrequirement_options" OWNER TO "postgres";


ALTER TABLE "public"."subrequirement_options" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."subrequirement_options_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."subrequirements" (
    "name" "text",
    "description" "text",
    "courses_required_count" integer DEFAULT 0 NOT NULL,
    "id" integer NOT NULL,
    "note" "text"
);


ALTER TABLE "public"."subrequirements" OWNER TO "postgres";


ALTER TABLE "public"."subrequirements" ALTER COLUMN "id" ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME "public"."subrequirements_id_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);



CREATE TABLE IF NOT EXISTS "public"."users" (
    "name" "text",
    "id" "uuid" NOT NULL,
    "net_id" "text" NOT NULL
);


ALTER TABLE "public"."users" OWNER TO "postgres";


COMMENT ON TABLE "public"."users" IS 'Core data about each Yale Student';



ALTER TABLE ONLY "public"."concentration_requirements"
    ADD CONSTRAINT "concentration_requirements_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."concentration_requirements"
    ADD CONSTRAINT "concentration_requirements_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."concentrations"
    ADD CONSTRAINT "concentrations_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."concentrations"
    ADD CONSTRAINT "concentrations_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."courses"
    ADD CONSTRAINT "courses_course_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."courses"
    ADD CONSTRAINT "courses_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."degrees"
    ADD CONSTRAINT "degrees_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."degrees"
    ADD CONSTRAINT "degrees_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."fyp"
    ADD CONSTRAINT "fyp_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."options"
    ADD CONSTRAINT "options_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."options"
    ADD CONSTRAINT "options_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."programs"
    ADD CONSTRAINT "programs_abbreviation_key" UNIQUE ("abbreviation");



ALTER TABLE ONLY "public"."programs"
    ADD CONSTRAINT "programs_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."programs"
    ADD CONSTRAINT "programs_name_key" UNIQUE ("name");



ALTER TABLE ONLY "public"."programs"
    ADD CONSTRAINT "programs_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."requirement_subrequirements"
    ADD CONSTRAINT "requirement_subrequirements_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."requirement_subrequirements"
    ADD CONSTRAINT "requirement_subrequirements_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."requirements"
    ADD CONSTRAINT "requirements_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."requirements"
    ADD CONSTRAINT "requirements_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."student_courses"
    ADD CONSTRAINT "student_courses_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."subrequirement_options"
    ADD CONSTRAINT "subrequirement_options_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."subrequirement_options"
    ADD CONSTRAINT "subrequirement_options_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."subrequirements"
    ADD CONSTRAINT "subrequirements_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."subrequirements"
    ADD CONSTRAINT "subrequirements_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_id_key" UNIQUE ("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_net_id_key" UNIQUE ("net_id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_pkey" PRIMARY KEY ("id");



ALTER TABLE ONLY "public"."concentration_requirements"
    ADD CONSTRAINT "concentration_requirements_concentration_id_fkey" FOREIGN KEY ("concentration_id") REFERENCES "public"."concentrations"("id");



ALTER TABLE ONLY "public"."concentration_requirements"
    ADD CONSTRAINT "concentration_requirements_requirement_id_fkey" FOREIGN KEY ("requirement_id") REFERENCES "public"."requirements"("id");



ALTER TABLE ONLY "public"."concentrations"
    ADD CONSTRAINT "concentrations_degree_id_fkey" FOREIGN KEY ("degree_id") REFERENCES "public"."degrees"("id");



ALTER TABLE ONLY "public"."degrees"
    ADD CONSTRAINT "degrees_program_id_fkey" FOREIGN KEY ("program_id") REFERENCES "public"."programs"("id");



ALTER TABLE ONLY "public"."requirement_subrequirements"
    ADD CONSTRAINT "requirement_subrequirements_requirement_id_fkey" FOREIGN KEY ("requirement_id") REFERENCES "public"."requirements"("id");



ALTER TABLE ONLY "public"."requirement_subrequirements"
    ADD CONSTRAINT "requirement_subrequirements_subrequirement_id_fkey" FOREIGN KEY ("subrequirement_id") REFERENCES "public"."subrequirements"("id");



ALTER TABLE ONLY "public"."student_courses"
    ADD CONSTRAINT "student_courses_course_id_fkey" FOREIGN KEY ("course_id") REFERENCES "public"."courses"("id");



ALTER TABLE ONLY "public"."student_courses"
    ADD CONSTRAINT "student_courses_fyp_id_fkey" FOREIGN KEY ("fyp_id") REFERENCES "public"."fyp"("id");



ALTER TABLE ONLY "public"."options"
    ADD CONSTRAINT "subreq_course_options_option_course_id_fkey" FOREIGN KEY ("option_course_id") REFERENCES "public"."courses"("id");



ALTER TABLE ONLY "public"."subrequirement_options"
    ADD CONSTRAINT "subrequirement_options_option_id_fkey" FOREIGN KEY ("option_id") REFERENCES "public"."options"("id");



ALTER TABLE ONLY "public"."subrequirement_options"
    ADD CONSTRAINT "subrequirement_options_subrequirement_id_fkey" FOREIGN KEY ("subrequirement_id") REFERENCES "public"."subrequirements"("id");



ALTER TABLE ONLY "public"."users"
    ADD CONSTRAINT "users_id_fkey" FOREIGN KEY ("id") REFERENCES "auth"."users"("id");



CREATE POLICY "FetchUsers" ON "public"."users" FOR SELECT USING (true);



CREATE POLICY "InsertUsersInfo" ON "public"."users" FOR INSERT WITH CHECK (true);



ALTER TABLE "public"."concentration_requirements" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."concentrations" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."courses" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."degrees" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."fyp" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."options" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."programs" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."requirement_subrequirements" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."requirements" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."student_courses" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."subrequirement_options" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."subrequirements" ENABLE ROW LEVEL SECURITY;


ALTER TABLE "public"."users" ENABLE ROW LEVEL SECURITY;




ALTER PUBLICATION "supabase_realtime" OWNER TO "postgres";


GRANT USAGE ON SCHEMA "public" TO "postgres";
GRANT USAGE ON SCHEMA "public" TO "anon";
GRANT USAGE ON SCHEMA "public" TO "authenticated";
GRANT USAGE ON SCHEMA "public" TO "service_role";



































































































































































































GRANT ALL ON TABLE "public"."concentration_requirements" TO "anon";
GRANT ALL ON TABLE "public"."concentration_requirements" TO "authenticated";
GRANT ALL ON TABLE "public"."concentration_requirements" TO "service_role";



GRANT ALL ON SEQUENCE "public"."concentration_requirements_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."concentration_requirements_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."concentration_requirements_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."concentrations" TO "anon";
GRANT ALL ON TABLE "public"."concentrations" TO "authenticated";
GRANT ALL ON TABLE "public"."concentrations" TO "service_role";



GRANT ALL ON SEQUENCE "public"."concentrations_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."concentrations_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."concentrations_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."courses" TO "anon";
GRANT ALL ON TABLE "public"."courses" TO "authenticated";
GRANT ALL ON TABLE "public"."courses" TO "service_role";



GRANT ALL ON TABLE "public"."degrees" TO "anon";
GRANT ALL ON TABLE "public"."degrees" TO "authenticated";
GRANT ALL ON TABLE "public"."degrees" TO "service_role";



GRANT ALL ON SEQUENCE "public"."degrees_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."degrees_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."degrees_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."fyp" TO "anon";
GRANT ALL ON TABLE "public"."fyp" TO "authenticated";
GRANT ALL ON TABLE "public"."fyp" TO "service_role";



GRANT ALL ON SEQUENCE "public"."fyp_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."fyp_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."fyp_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."options" TO "anon";
GRANT ALL ON TABLE "public"."options" TO "authenticated";
GRANT ALL ON TABLE "public"."options" TO "service_role";



GRANT ALL ON SEQUENCE "public"."options_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."options_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."options_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."programs" TO "anon";
GRANT ALL ON TABLE "public"."programs" TO "authenticated";
GRANT ALL ON TABLE "public"."programs" TO "service_role";



GRANT ALL ON SEQUENCE "public"."programs_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."programs_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."programs_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."requirement_subrequirements" TO "anon";
GRANT ALL ON TABLE "public"."requirement_subrequirements" TO "authenticated";
GRANT ALL ON TABLE "public"."requirement_subrequirements" TO "service_role";



GRANT ALL ON SEQUENCE "public"."requirement_subrequirements_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."requirement_subrequirements_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."requirement_subrequirements_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."requirements" TO "anon";
GRANT ALL ON TABLE "public"."requirements" TO "authenticated";
GRANT ALL ON TABLE "public"."requirements" TO "service_role";



GRANT ALL ON SEQUENCE "public"."requirements_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."requirements_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."requirements_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."student_courses" TO "anon";
GRANT ALL ON TABLE "public"."student_courses" TO "authenticated";
GRANT ALL ON TABLE "public"."student_courses" TO "service_role";



GRANT ALL ON TABLE "public"."subrequirement_options" TO "anon";
GRANT ALL ON TABLE "public"."subrequirement_options" TO "authenticated";
GRANT ALL ON TABLE "public"."subrequirement_options" TO "service_role";



GRANT ALL ON SEQUENCE "public"."subrequirement_options_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."subrequirement_options_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."subrequirement_options_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."subrequirements" TO "anon";
GRANT ALL ON TABLE "public"."subrequirements" TO "authenticated";
GRANT ALL ON TABLE "public"."subrequirements" TO "service_role";



GRANT ALL ON SEQUENCE "public"."subrequirements_id_seq" TO "anon";
GRANT ALL ON SEQUENCE "public"."subrequirements_id_seq" TO "authenticated";
GRANT ALL ON SEQUENCE "public"."subrequirements_id_seq" TO "service_role";



GRANT ALL ON TABLE "public"."users" TO "anon";
GRANT ALL ON TABLE "public"."users" TO "authenticated";
GRANT ALL ON TABLE "public"."users" TO "service_role";



ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON SEQUENCES  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON FUNCTIONS  TO "service_role";






ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "postgres";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "anon";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "authenticated";
ALTER DEFAULT PRIVILEGES FOR ROLE "postgres" IN SCHEMA "public" GRANT ALL ON TABLES  TO "service_role";






























RESET ALL;
