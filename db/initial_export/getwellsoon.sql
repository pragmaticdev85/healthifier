CREATE TYPE "user_type" AS ENUM (
  'PHYSIOTHERAPIST',
  'NURSE',
  'QUALIFIED_DOCTOR',
  'REG_MED_PRACTITIONER',
  'PATIENT',
  'PORTAL_USER',
  'ADMIN',
  'LAB_TECHNICIAN'
);

CREATE TYPE "test_type" AS ENUM (
  'BLOOD',
  'URINE',
  'OTHER'
);

CREATE TYPE "yes_or_no_option" AS ENUM (
  'YES',
  'NO'
);

CREATE TYPE "country" AS ENUM (
  'INDIA'
);

CREATE TYPE "currency" AS ENUM (
  'INR',
  'USD',
  'AED',
  'GBP'
);

CREATE TYPE "city" AS ENUM (
  'BENGALURU',
  'MUMBAI',
  'DELHI',
  'HYDERABAD',
  'NOIDA',
  'GURUGRAM'
);

CREATE TYPE "consultation_status" AS ENUM (
  'REGISTERED',
  'IN_PROGRESS',
  'COMPLETED',
  'RESCHEDULED',
  'CANCELLED'
);

CREATE TABLE "User" (
  "id" integer PRIMARY KEY,
  "fname" varchar(64) NOT NULL,
  "lname" varchar(64) NOT NULL,
  "user_type" user_type NOT NULL,
  "email_address" varchar(128) NOT NULL,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Test" (
  "id" integer PRIMARY KEY,
  "name" varchar(64) NOT NULL,
  "description" varchar(255) NOT NULL,
  "type" test_type,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Region" (
  "id" integer PRIMARY KEY,
  "name" varchar(64) NOT NULL,
  "city" city,
  "country" country,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Test_Region_XRef" (
  "id" integer PRIMARY KEY,
  "health_test_id" integer,
  "region_id" integer,
  "price_currency" currency,
  "price_value" float,
  "prescription_required" yes_or_no_option,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Package" (
  "id" integer PRIMARY KEY,
  "name" varchar(64) NOT NULL,
  "description" varchar(255) NOT NULL,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Package_Test_Region_XRef" (
  "id" integer PRIMARY KEY,
  "package_id" integer,
  "test_region_xref_id" integer,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Role" (
  "id" integer PRIMARY KEY,
  "name" varchar(64) NOT NULL,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "User_Role_XRef" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "role_id" integer,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Consultation" (
  "id" integer PRIMARY KEY,
  "user_id" integer,
  "scheduled_time" timestamp,
  "status" consultation_status,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Action" (
  "id" integer PRIMARY KEY,
  "name" varchar(128) NOT NULL,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

CREATE TABLE "Role_Action_XRef" (
  "id" integer PRIMARY KEY,
  "action_id" integer NOT NULL,
  "role_id" integer NOT NULL,
  "created_at" timestamp NOT NULL,
  "created_by" integer NOT NULL,
  "updated_at" timestamp NOT NULL,
  "updated_by" integer NOT NULL
);

ALTER TABLE "Test_Region_XRef" ADD FOREIGN KEY ("health_test_id") REFERENCES "Test" ("id");
ALTER TABLE "Test_Region_XRef" ADD FOREIGN KEY ("region_id") REFERENCES "Region" ("id");
ALTER TABLE "Package_Test_Region_XRef" ADD FOREIGN KEY ("test_region_xref_id") REFERENCES "Test_Region_XRef" ("id");
ALTER TABLE "Package_Test_Region_XRef" ADD FOREIGN KEY ("package_id") REFERENCES "Package" ("id");
ALTER TABLE "Test" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Test" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Package" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Package" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Region" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Region" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Test_Region_XRef" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Test_Region_XRef" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Package_Test_Region_XRef" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Package_Test_Region_XRef" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Role" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Role" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "User_Role_XRef" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "User_Role_XRef" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "User_Role_XRef" ADD FOREIGN KEY ("role_id") REFERENCES "Role" ("id");
ALTER TABLE "User_Role_XRef" ADD FOREIGN KEY ("user_id") REFERENCES "User" ("id");
ALTER TABLE "Consultation" ADD FOREIGN KEY ("user_id") REFERENCES "User" ("id");
ALTER TABLE "Consultation" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Consultation" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "User" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "User" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Action" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Action" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Role_Action_XRef" ADD FOREIGN KEY ("created_by") REFERENCES "User" ("id");
ALTER TABLE "Role_Action_XRef" ADD FOREIGN KEY ("updated_by") REFERENCES "User" ("id");
ALTER TABLE "Role_Action_XRef" ADD FOREIGN KEY ("action_id") REFERENCES "Action" ("id");
ALTER TABLE "Role_Action_XRef" ADD FOREIGN KEY ("role_id") REFERENCES "Role" ("id");