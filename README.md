# 🗄️ Kartik Industries Database – SQL Project
## 📌 Overview

This SQL project demonstrates the design and implementation of a relational database for Kartik Industries. It covers database creation, table relationships, data manipulation, and advanced SQL concepts such as views, stored procedures, functions, and window functions.

## 🎯 Objectives

Design a structured relational database

Establish relationships using foreign keys

Perform CRUD operations

Implement advanced SQL features

Analyze employee and project data

## 🏗️ Database Structure

The database consists of the following tables:

### 🔹 Departments

Stores department details

department_id (Primary Key)

department_name

### 🔹 Employees

Stores employee information

employee_id (Primary Key)

Name, Email, Hire Date

Salary (with validation)

department_id (Foreign Key)

### 🔹 Projects

Stores project details

project_id (Primary Key)

Project Name

Start Date & End Date

### 🔹 Employee_Project

Manages many-to-many relationship

employee_id

project_id

Hours Worked

## 🔗 Relationships

One department → many employees

One employee → many projects (via junction table)

One project → many employees

## ⚙️ Features Implemented
### ✅ Database & Table Creation

Created database and structured tables with constraints

Applied PRIMARY KEY, FOREIGN KEY, and CHECK constraints

### ✅ Data Manipulation

Inserted sample data for departments, employees, and projects

Updated salaries (10% increase for IT department)

Deleted employees with low salary

### ✅ Queries & Analysis

Employees hired after a specific date

Average salary by department

Total hours worked per project

Highest-paid employee per department

Employees not assigned to any project

### ✅ Joins

INNER JOIN for employee-department mapping

LEFT JOIN to find unassigned employees

### ✅ Views

department_salary_expense → Total salary by department

high_salary_employees → Employees earning above average

### ✅ Stored Procedures

Get employees by department

Increase salary by percentage

### ✅ Functions

annual_salary() → Calculates yearly salary

### ✅ Indexing

Index created on salary column for performance optimization

### ✅ Window Functions

Rank employees by salary within department

Find second highest salary

Running total of salaries

## 🛠️ Technologies Used

MySQL / SQL

Relational Database Design

Advanced SQL (Views, Procedures, Functions, Window Functions)

## 🚀 How to Run

Open MySQL Workbench / any SQL environment

Import or copy the SQL script

Execute the script step-by-step

Run queries to analyze the data

## 📊 Key Learnings

Designing normalized relational databases

Using constraints to maintain data integrity

Writing complex SQL queries

Implementing real-world business logic using SQL

Working with advanced SQL concepts

## 📁 File Structure
kartikindustries.sql   # Complete SQL project script
README.md              # Project documentation
## 🔄 Future Improvements

Add triggers for automation

Implement role-based access control

Expand dataset for real-world scalability

Integrate with frontend/dashboard tools

## 🙏 Thank You

Thank you for reviewing this SQL project!

Your feedback is highly appreciated. This project reflects practical database design and SQL skills, and I’m continuously working to improve and expand my knowledge.
