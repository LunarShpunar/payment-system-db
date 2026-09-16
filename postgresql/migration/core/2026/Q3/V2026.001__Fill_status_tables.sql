INSERT INTO status_schema.invoice_status (code, name, is_active)
VALUES ('NEW', 'Создан, ожидает оплаты', TRUE),
       ('PAID', 'Оплачен клиентом', TRUE),
       ('COMPLETED', 'Обработан (комиссия удержана)', TRUE),
       ('FAILED', 'Отклонен / Ошибка оплаты', TRUE),
       ('CANCELLED', 'Отменен', TRUE);

INSERT INTO status_schema.merchant_status (code, name, can_accept_payment, is_active)
VALUES ('ONBOARDING', 'На верификации', FALSE, TRUE),
       ('ACTIVE', 'Активен', TRUE, TRUE),
       ('SUSPENDED', 'Временно приостановлен', FALSE, TRUE),
       ('FROZEN', 'Заморожен СБ (фрод/жалобы)', FALSE, TRUE),
       ('TERMINATED', 'Расторгнут / Заблокирован', FALSE, TRUE);