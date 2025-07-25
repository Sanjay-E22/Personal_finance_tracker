CREATE DATABASE Finance;
use Finance;
-- Schema Creation for MySQL

CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE Categories (
    category_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE Income (
    income_id INT PRIMARY KEY,
    user_id INT,
    amount DECIMAL(10,2),
    source VARCHAR(100),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Expenses (
    expense_id INT PRIMARY KEY,
    user_id INT,
    category_id INT,
    amount DECIMAL(10,2),
    description VARCHAR(255),
    date DATE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (category_id) REFERENCES Categories(category_id)
);

-- Dummy Data

INSERT INTO Users (user_id, name, email) VALUES
(1, 'Arul', 'arul@example.com'),
(2, 'Bala', 'bala@example.com');

INSERT INTO Categories (category_id, name) VALUES
(1, 'Groceries'),
(2, 'Rent'),
(3, 'Utilities'),
(4, 'Entertainment'),
(5, 'Transport');

INSERT INTO Income (income_id, user_id, amount, source, date) VALUES
(1, 1, 5000.00, 'Salary', '2025-07-01'),
(2, 2, 4000.00, 'Salary', '2025-07-01');

INSERT INTO Expenses (expense_id, user_id, category_id, amount, description, date) VALUES
(1, 1, 1, 200.00, 'Groceries shopping', '2025-07-03'),
(2, 1, 2, 1500.00, 'Monthly rent', '2025-07-01'),
(3, 1, 3, 300.00, 'Electricity bill', '2025-07-05'),
(4, 1, 4, 100.00, 'Movie night', '2025-07-06'),
(5, 1, 5, 80.00, 'Bus pass', '2025-07-02');

-- Monthly Expenses Summary
SELECT 
    user_id,
    DATE_FORMAT(date, '%Y-%m') AS month,
    SUM(amount) AS total_expenses
FROM Expenses
GROUP BY user_id, month;

-- Category-wise Spending
SELECT 
    u.name,
    c.name AS category,
    SUM(e.amount) AS total_spent
FROM Expenses e
JOIN Users u ON u.user_id = e.user_id
JOIN Categories c ON c.category_id = e.category_id
GROUP BY u.name, c.name;

-- Monthly Balance View

CREATE VIEW MonthlyBalance AS
SELECT
    i_summary.user_id,
    i_summary.month,
    i_summary.total_income,
    IFNULL(e_summary.total_expenses, 0) AS total_expenses,
    (i_summary.total_income - IFNULL(e_summary.total_expenses, 0)) AS balance
FROM
    (
        SELECT
            user_id,
            DATE_FORMAT(date, '%Y-%m') AS month,
            SUM(amount) AS total_income
        FROM Income
        GROUP BY user_id, DATE_FORMAT(date, '%Y-%m')
    ) AS i_summary
LEFT JOIN
    (
        SELECT
            user_id,
            DATE_FORMAT(date, '%Y-%m') AS month,
            SUM(amount) AS total_expenses
        FROM Expenses
        GROUP BY user_id, DATE_FORMAT(date, '%Y-%m')
    ) AS e_summary
ON i_summary.user_id = e_summary.user_id AND i_summary.month = e_summary.month;


-- Export Report
SELECT * FROM MonthlyBalance;