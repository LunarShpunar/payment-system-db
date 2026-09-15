CREATE TABLE ref_schema.ref_currency (
    id SERIAL PRIMARY KEY,
    alphabetic_code VARCHAR(3) NOT NULL UNIQUE,
    numeric_code VARCHAR(3) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    decimals SMALLINT DEFAULT 2 NOT NULL,
    is_active BOOLEAN DEFAULT TRUE NOT NULL
);
