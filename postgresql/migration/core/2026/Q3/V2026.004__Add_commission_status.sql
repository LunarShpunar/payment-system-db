CREATE TABLE IF NOT EXISTS status.commission_status
(
    id        bigint               NOT NULL GENERATED ALWAYS AS IDENTITY,
    "version" integer DEFAULT 0    NOT NULL,
    code      varchar(128)         NOT NULL,
    name      varchar(128)         NOT NULL,
    is_active boolean DEFAULT TRUE NOT NULL,
    CONSTRAINT pk_commission_status PRIMARY KEY (id)
);

INSERT INTO status.commission_status (code, name, is_active)
VALUES ('ACTIVE', 'Активен', TRUE),
       ('INACTIVE', 'Неактивен', TRUE);

ALTER TABLE core.commission
    ADD COLUMN IF NOT EXISTS status_id bigint;

UPDATE core.commission
SET status_id = (SELECT id FROM status.commission_status WHERE code = 'ACTIVE')
WHERE status_id IS NULL;

ALTER TABLE core.commission
    ALTER COLUMN status_id SET NOT NULL;

ALTER TABLE core.commission
    ADD CONSTRAINT fk_commission_commission_status FOREIGN KEY (status_id) REFERENCES status.commission_status (id);