CREATE TABLE IF NOT EXISTS reference.ref_currency
(
    id              bigint               NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version"       integer DEFAULT 0    NOT NULL,
    alphabetic_code varchar(3)           NOT NULL,
    numeric_code    varchar(3)           NOT NULL,
    name            varchar(255)         NOT NULL,
    decimals        smallint             NOT NULL,
    is_active       boolean DEFAULT TRUE NOT NULL,
    CONSTRAINT pk_ref_currency PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS status.invoice_status
(
    id        bigint               NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version" integer DEFAULT 0    NOT NULL,
    code      varchar(128)         NOT NULL,
    name      varchar(255)         NOT NULL,
    is_active boolean DEFAULT TRUE NOT NULL,
    CONSTRAINT pk_invoice_status PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS status.merchant_status
(
    id                 bigint                NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version"          integer DEFAULT 0     NOT NULL,
    code               varchar(128)          NOT NULL,
    name               varchar(128)          NOT NULL,
    is_active          boolean DEFAULT TRUE  NOT NULL,
    CONSTRAINT pk_merchant_status PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS type.commission_type
(
    id        bigint               NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version" integer DEFAULT 0    NOT NULL,
    code      varchar(32)          NOT NULL,
    name      varchar(255)         NOT NULL,
    is_active boolean DEFAULT TRUE NOT NULL,
    CONSTRAINT pk_commission_type PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS core.merchant
(
    id         bigint                                NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version"  integer     DEFAULT 0                 NOT NULL,
    name       varchar(128)                          NOT NULL,
    email      varchar(255)                          NOT NULL,
    status_id  bigint                                NOT NULL,
    created_at timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active  boolean     DEFAULT TRUE              NOT NULL,
    CONSTRAINT pk_merchant PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS core.commission
(
    id          bigint                                NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version"   integer     DEFAULT 0                 NOT NULL,
    merchant_id bigint                                NOT NULL,
    type_id     bigint                                NOT NULL,
    fee_value   decimal(10, 2)                        NOT NULL,
    created_at  timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active   boolean     DEFAULT TRUE              NOT NULL,
    CONSTRAINT pk_commission PRIMARY KEY (id)
);

CREATE INDEX idx_commission_merchant_date ON core.commission (merchant_id, created_at DESC);

CREATE TABLE IF NOT EXISTS core.invoice
(
    id          bigint                                NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version"   integer     DEFAULT 0                 NOT NULL,
    merchant_id bigint                                NOT NULL,
    status_id   bigint                                NOT NULL,
    amount      decimal(10, 2)                        NOT NULL,
    currency_id bigint                                NOT NULL,
    paid_at     timestamptz,
    created_at  timestamptz DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active   boolean     DEFAULT TRUE              NOT NULL,
    CONSTRAINT pk_invoice PRIMARY KEY (id)
);

CREATE INDEX idx_invoices_merchant_created ON core.invoice (merchant_id, created_at DESC);

CREATE TABLE IF NOT EXISTS core.commission_calc
(
    id                 bigint                                   NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version"          integer        DEFAULT 0                 NOT NULL,
    invoice_id         bigint                                   NOT NULL,
    commission_id      bigint                                   NOT NULL,
    commission_amount  decimal(10, 2)                           NOT NULL,
    created_at         timestamptz    DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active          boolean        DEFAULT TRUE              NOT NULL,
    CONSTRAINT pk_commission_calc PRIMARY KEY (id)
);

ALTER TABLE core.merchant
    ADD CONSTRAINT fk_merchant_merchant_status FOREIGN KEY (status_id) REFERENCES status.merchant_status (id);

ALTER TABLE core.commission
    ADD CONSTRAINT fk_commission_merchant FOREIGN KEY (merchant_id) REFERENCES core.merchant (id) ON DELETE RESTRICT;

ALTER TABLE core.commission
    ADD CONSTRAINT fk_commission_commission_type FOREIGN KEY (type_id) REFERENCES type.commission_type (id);

ALTER TABLE core.invoice
    ADD CONSTRAINT fk_invoice_merchant FOREIGN KEY (merchant_id) REFERENCES core.merchant (id) ON DELETE RESTRICT;

ALTER TABLE core.invoice
    ADD CONSTRAINT fk_invoice_invoice_status FOREIGN KEY (status_id) REFERENCES status.invoice_status (id);

ALTER TABLE core.invoice
    ADD CONSTRAINT fk_invoice_ref_currency FOREIGN KEY (currency_id) REFERENCES reference.ref_currency (id);

ALTER TABLE core.commission_calc
    ADD CONSTRAINT fk_commission_calc_invoice FOREIGN KEY (invoice_id) REFERENCES core.invoice (id);

ALTER TABLE core.commission_calc
    ADD CONSTRAINT fk_commission_calc_commission FOREIGN KEY (commission_id) REFERENCES core.commission (id);