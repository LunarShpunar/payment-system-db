ALTER TABLE core.invoice
    ADD COLUMN retry_count INT NOT NULL DEFAULT 0;

INSERT INTO status.invoice_status (code, name, is_active)
VALUES ('CALCULATION_FAILED', 'Ошибка расчета комиссии', TRUE);