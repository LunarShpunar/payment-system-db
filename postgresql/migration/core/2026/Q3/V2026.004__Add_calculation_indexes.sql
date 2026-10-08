CREATE UNIQUE INDEX uq_commission_merchant_active
    ON core.commission (merchant_id)
    WHERE is_active = TRUE;

CREATE UNIQUE INDEX uq_commission_calc_invoice_active
    ON core.commission_calc (invoice_id)
    WHERE is_active = TRUE;

CREATE INDEX idx_invoice_status_active_created
    ON core.invoice (status_id, created_at)
    WHERE is_active = TRUE;