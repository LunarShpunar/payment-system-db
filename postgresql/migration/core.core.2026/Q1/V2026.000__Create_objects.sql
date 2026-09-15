CREATE TABLE core_schema.merchant (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    status_id INTEGER NOT NULL REFERENCES status_schema.merchant_status(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE core_schema.invoice (
    id BIGSERIAL PRIMARY KEY,
    merchant_id BIGINT NOT NULL REFERENCES core_schema.merchant(id),
    status_id INTEGER NOT NULL REFERENCES status_schema.invoice_status(id),
    amount NUMERIC(18, 4) NOT NULL,
    currency_id INTEGER NOT NULL REFERENCES ref_schema.ref_currency(id),
    paid_at TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE core_schema.commission (
    id BIGSERIAL PRIMARY KEY,
    merchant_id BIGINT NOT NULL REFERENCES core_schema.merchant(id),
    type_id INTEGER NOT NULL REFERENCES type_schema.commission_type(id),
    fee_value NUMERIC(10, 4) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL
);

CREATE TABLE core_schema.commission_calc (
    id BIGSERIAL PRIMARY KEY,
    invoice_id BIGINT NOT NULL REFERENCES core_schema.invoice(id),
    commission_id BIGINT NOT NULL REFERENCES core_schema.commission(id),
    commission_amount NUMERIC(18, 4) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL,
    processed_at TIMESTAMP WITH TIME ZONE
);