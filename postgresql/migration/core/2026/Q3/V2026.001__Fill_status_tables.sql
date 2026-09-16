INSERT INTO status.invoice_status (code, name, is_active)
VALUES ('NEW', 'Создан, ожидает оплаты', TRUE),
       ('PAID', 'Оплачен клиентом', TRUE),
       ('COMPLETED', 'Обработан (комиссия удержана)', TRUE),
       ('FAILED', 'Отклонен / Ошибка оплаты', TRUE),
       ('CANCELLED', 'Отменен', TRUE);

INSERT INTO status.merchant_status (code, name, is_active)
VALUES ('ACTIVE', 'Активен', TRUE),
       ('BLOCKED', 'Заблокирован', TRUE);