-- 1. Подключаемся к плагинной базе данных 
ALTER SESSION SET CONTAINER = FREEPDB1;

-- 2. Создаем отдельного пользователя-владельца схемы
CREATE USER portfolio IDENTIFIED BY PortfolioPassword123;

-- 3. Выдаем ему права на подключение и создание таблиц
GRANT CONNECT, RESOURCE TO portfolio;
ALTER USER portfolio QUOTA UNLIMITED ON USERS;

-- 4. Переключаем сессию на созданного пользователя
CONNECT portfolio/PortfolioPassword123@FREEPDB1;

CREATE TABLE clients (
    client_id    INTEGER PRIMARY KEY,
    full_name    VARCHAR2(100) NOT NULL,
    email        VARCHAR2(100) NOT NULL,
    created_at   TIMESTAMP
);



CREATE TABLE accounts (
    account_id  INTEGER PRIMARY KEY,
    client_id    INTEGER,
    balance      NUMBER(12, 2) NOT NULL,
    currency     VARCHAR2(3) NOT NULL
);



CREATE TABLE transactions (
    tx_id        INTEGER PRIMARY KEY,
    account_id   NUMBER,
    amount       NUMBER(12, 2) NOT NULL,
    tx_type      VARCHAR2(10),
    tx_date      TIMESTAMP
); 



-- Вставляем клиентов с явным указанием ID
INSERT INTO clients (client_id, full_name, email, created_at) 
VALUES (1, 'Иван Петров', 'ivan.petrov@example.com', CURRENT_TIMESTAMP);

INSERT INTO clients (client_id, full_name, email, created_at) 
VALUES (2, 'Анна Смирнова', 'anna.smirnova@example.com', CURRENT_TIMESTAMP);

-- Вставляем счета, ссылаясь на существующие client_id
INSERT INTO accounts (account_id, client_id, balance, currency) 
VALUES (101, 1, 1500.50, 'USD');

INSERT INTO accounts (account_id, client_id, balance, currency) 
VALUES (102, 2, 54000.00, 'EUR');

-- Вставляем транзакции
INSERT INTO transactions (tx_id, account_id, amount, tx_type, tx_date) 
VALUES (1001, 101, 1500.50, 'DEPOSIT', CURRENT_TIMESTAMP);

COMMIT;