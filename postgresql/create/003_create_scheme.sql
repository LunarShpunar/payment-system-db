\connect payment_hub_db;

CREATE SCHEMA IF NOT EXISTS core_schema AUTHORIZATION payment_app_user;
CREATE SCHEMA IF NOT EXISTS status_schema AUTHORIZATION payment_app_user;
CREATE SCHEMA IF NOT EXISTS type_schema AUTHORIZATION payment_app_user;
CREATE SCHEMA IF NOT EXISTS ref_schema AUTHORIZATION payment_app_user;