CREATE SCHEMA IF NOT EXISTS core_schema;

CREATE  TABLE IF NOT EXISTS core_schema.merchant ( 
	id                   bigint  NOT NULL  ,
	name                 varchar(128)  NOT NULL  ,
	email                varchar(255)  NOT NULL  ,
	status_id            bigint  NOT NULL  ,
	created_at           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_merchant PRIMARY KEY ( id )
 );

CREATE  TABLE IF NOT EXISTS core_schema.commission ( 
	id                   bigint  NOT NULL  ,
	merchant_id          bigint  NOT NULL  ,
	type_id              bigint  NOT NULL  ,
	fee_value            decimal(10,2)  NOT NULL  ,
	created_at           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_commission PRIMARY KEY ( id )
 );

CREATE INDEX idx_commission_merchant_date ON core_schema.commission  ( merchant_id, created_at  DESC   );

CREATE  TABLE IF NOT EXISTS core_schema.invoice ( 
	id                   bigint  NOT NULL GENERATED ALWAYS  AS IDENTITY ( ) ,
	merchant_id          bigint  NOT NULL  ,
	status_id            bigint  NOT NULL  ,
	amount               decimal(10,2)  NOT NULL  ,
	currency_id          bigint  NOT NULL  ,
	paid_at              timestamptz    ,
	created_at           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_invoice PRIMARY KEY ( id )
 );

CREATE INDEX idx_invoices_merchant_created ON core_schema.invoice  ( merchant_id, created_at  DESC   );

CREATE  TABLE IF NOT EXISTS core_schema.commission_calc ( 
	id                   bigint  NOT NULL  ,
	commission_calc_id   bigint  NOT NULL  ,
	invoidce_id          bigint  NOT NULL  ,
	commission_id        bigint  NOT NULL  ,
	commission_amount    decimal(10,2) DEFAULT 0.00 NOT NULL  ,
	created_at           timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL  ,
	processed_at         timestamptz    ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_commission_calc PRIMARY KEY ( id )
 );

ALTER TABLE core_schema.commission ADD CONSTRAINT fk_commission_merchant FOREIGN KEY ( merchant_id ) REFERENCES core_schema.merchant( id ) ON DELETE RESTRICT;

ALTER TABLE core_schema.commission_calc ADD CONSTRAINT fk_commission_calc_invoice FOREIGN KEY ( invoidce_id ) REFERENCES core_schema.invoice( id );

ALTER TABLE core_schema.commission_calc ADD CONSTRAINT fk_commission_calc_commission FOREIGN KEY ( commission_id ) REFERENCES core_schema.commission( id );

ALTER TABLE core_schema.invoice ADD CONSTRAINT fk_invoice_merchant FOREIGN KEY ( merchant_id ) REFERENCES core_schema.merchant( id ) ON DELETE RESTRICT;

CREATE SCHEMA IF NOT EXISTS ref_schema;

CREATE  TABLE IF NOT EXISTS ref_schema.ref_currency ( 
	id                   bigint  NOT NULL  ,
	alphabetic_code      varchar(3)  NOT NULL  ,
	numeric_code         varchar(3)  NOT NULL  ,
	name                 varchar(255)  NOT NULL  ,
	decimals             smallint  NOT NULL  ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_ref_currency PRIMARY KEY ( id )
 );

CREATE SCHEMA IF NOT EXISTS status_schema;

CREATE  TABLE IF NOT EXISTS status_schema.invoice_status ( 
	id                   bigint  NOT NULL  ,
	code                 varchar(128)  NOT NULL  ,
	name                 varchar(255)  NOT NULL  ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_invoice_status PRIMARY KEY ( id )
 );

CREATE  TABLE IF NOT EXISTS status_schema.merchant_status ( 
	id                   bigint  NOT NULL  ,
	code                 varchar(128)  NOT NULL  ,
	name                 varchar(128)  NOT NULL  ,
	can_accept_payment   boolean DEFAULT FALSE NOT NULL  ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_merchant_status PRIMARY KEY ( id )
 );

CREATE SCHEMA IF NOT EXISTS type_schema;

CREATE  TABLE IF NOT EXISTS type_schema.commission_type ( 
	id                   bigint  NOT NULL  ,
	code                 varchar(32)  NOT NULL  ,
	name                 varchar(255)  NOT NULL  ,
	is_active            boolean DEFAULT TRUE NOT NULL  ,
	CONSTRAINT pk_commission_type PRIMARY KEY ( id )
 );

ALTER TABLE core_schema.commission ADD CONSTRAINT fk_commission_commission_type FOREIGN KEY ( type_id ) REFERENCES type_schema.commission_type( id );

ALTER TABLE core_schema.invoice ADD CONSTRAINT fk_invoice_invoice_status FOREIGN KEY ( status_id ) REFERENCES status_schema.invoice_status( id );

ALTER TABLE core_schema.invoice ADD CONSTRAINT fk_invoice_ref_currency FOREIGN KEY ( currency_id ) REFERENCES ref_schema.ref_currency( id );

ALTER TABLE core_schema.merchant ADD CONSTRAINT fk_merchant_merchant_status FOREIGN KEY ( status_id ) REFERENCES status_schema.merchant_status( id );