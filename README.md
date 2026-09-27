# 🚀 Oracle DB Quick Starter (Dockerized)

Готовый к работе шаблон инфраструктуры для быстрого развертывания **Oracle Database** с заполненной структурой данных (банкинг/финтех домен) с помощью одной команды.

## 🛠 Технологии

* **Docker & Docker Compose**

* **Oracle Database (Free Edition / XE)**

* **SQL (DDL / DML)**

## 📋 Требования

Установите на вашем компьютере:

* [Docker Desktop](https://www.docker.com/products/docker-desktop/?utm_source=gemini)

* [Docker Compose](https://docs.docker.com/compose/?utm_source=gemini)

*(Обратите внимание: для запуска Oracle в Docker рекомендуется выделить не менее 2 ГБ оперативной памяти).*

## ⏱️ Как запустить проект за 1 минуту

1. **Клонируйте репозиторий:**

   ```
   git clone https://github.com/Mier-eng/oracle-docker-starter.git
   cd oracle-docker-starter
   
   ```

2. **Запустите контейнер:**

   ```
   docker compose up -d
   
   ```

   *Первый запуск займет 1–2 минуты, пока Oracle инициализирует внутреннюю структуру и выполнит скрипты из папки `init-scripts`.*

3. **Проверьте статус:**

   ```
   docker logs -f oracle_portfolio_db
   
   ```

## 🔌 Параметры подключения

В проекте настроено разделение прав на административные учетные записи и изолированного пользователя для работы с приложением. При первом запуске скрипты автоматически выполняют настройку схемы:

```
-- 1. Подключаемся к плагинной базе данных 
ALTER SESSION SET CONTAINER = FREEPDB1;

-- 2. Создаем отдельного пользователя-владельца схемы
CREATE USER portfolio IDENTIFIED BY PortfolioPassword123;

-- 3. Выдаем ему права на подключение и создание таблиц
GRANT CONNECT, RESOURCE TO portfolio;
ALTER USER portfolio QUOTA UNLIMITED ON USERS;

-- 4. Переключаем сессию на созданного пользователя
CONNECT portfolio/PortfolioPassword123@FREEPDB1;

```

### Вариант А: Подключение под администратором (для управления)

* **Host:** `localhost`

* **Port:** `1521`

* **Service Name:** `FREEPDB1`

* **Username:** `SYS` или `SYSTEM`

* **Password:** Значение переменной `ORACLE_PASSWORD` из вашего файла `.env` (по умолчанию: `AdminPassword123`)

### Вариант Б: Подключение под рабочей учетной записью приложения (Рекомендуется)

Скрипт инициализации автоматически создает отдельную схему для изоляции данных:

* **Host:** `localhost`

* **Port:** `1521`

* **Service Name:** `FREEPDB1`

* **Username:** `portfolio`

* **Password:** `PortfolioPassword123`

## 📊 Что внутри?

При первом запуске автоматически создаются три связанных таблицы:

* `CLIENTS` — клиенты системы.

* `ACCOUNTS` — счета клиентов (связь с `CLIENTS`).

* `TRANSACTIONS` — история транзакций (связь с `ACCOUNTS`).
  А также заполняются базовыми тестовыми данными (`seed data`) для немедленного написания запросов и тестирования приложений.