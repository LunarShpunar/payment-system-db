\connect payment_system_db;

CREATE SCHEMA IF NOT EXISTS core AUTHORIZATION payment_app_user;
CREATE SCHEMA IF NOT EXISTS status AUTHORIZATION payment_app_user;
CREATE SCHEMA IF NOT EXISTS type AUTHORIZATION payment_app_user;
CREATE SCHEMA IF NOT EXISTS reference AUTHORIZATION payment_app_user;