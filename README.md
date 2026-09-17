## Сабмодуль базы: `payment-system-db/README.md`

```markdown
Payment System DB
```
Репозиторий базы данных проекта. Подключается как Git Submodule.

## Структура
- `postgresql/create/` — скрипты начальной инициализации для Docker (создание пользователя и базы).
- `postgresql/migration/core.2026.Q3/` — миграции Flyway:
    - `V2026.000__Create_objects.sql` — создание таблиц, связей и индексов.
    - `V2026.001__Fill_status_tables.sql` — наполнение статусов инвойсов и мерчантов.
    - `V2026.002__Fill_type_tables.sql` — наполнение типов комиссий.
    - `V2026.003__Fill_ref_tables.sql` — наполнение справочника валют.
