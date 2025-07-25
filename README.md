# 💰 Personal Finance Tracker (SQL-Based)

A simple SQL-based personal finance tracking system that allows users to manage their income, expenses, and view monthly financial reports. This project can serve as the backend of a budgeting app or be used as a standalone finance tracker.

---

## 📌 Project Overview

This project helps users:
- Record their income and categorize it
- Track expenses by category (Rent, Groceries, etc.)
- Get monthly summaries and balance reports
- Export CSV reports for analysis

---

## 🛠 Tools & Technologies Used

- **Database**: MySQL / SQLite
- **Interface**: DBeaver / MySQL Workbench / DB Browser for SQLite
- **Languages**: SQL
- **Report Export**: CSV / Excel

---

## 🗃 Database Schema

- `Users` – Stores user information
- `Income` – Records income transactions
- `Expenses` – Stores expenses with date, category, and amount
- `Categories` – Lists different types of expenses

### 🔗 Relationships
- One user ➝ Many income and expense records
- One expense ➝ One category

