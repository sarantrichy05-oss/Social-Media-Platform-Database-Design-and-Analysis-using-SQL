#  Social Media Platform Database Design and Analysis (SQL)

A SQL-based project that designs and analyzes a relational database system simulating a social media platform. The project focuses on managing user data, posts, and interactions such as likes, comments, and followers while generating insights using SQL queries.

---

##  Table of Contents

* Project Overview
* Database Description
* Tables & Schema
* Features Implemented
* SQL Concepts Covered
* Key Insights
* How to Use
* Requirements

---

##  Project Overview

This project involves designing and implementing a **relational database** for a social media platform using SQL.

The main objective is to store and manage user activities such as posts, likes, comments, and followers, and to analyze user engagement through SQL queries.

---

##  Database Description

The database represents a simplified social media application where users can:

* Create posts
* Like and comment on posts
* Follow other users
* Analyze engagement and activity patterns

---

##  Tables & Schema

###  Users

* user_id (Primary Key)
* user_name
* email
* full_name
* dob

###  Posts

* post_id (Primary Key)
* user_id (Foreign Key)
* caption
* posted_at

###  Followers

* follower_id
* following_id
* follow_date

###  Comments

* comment_id (Primary Key)
* post_id
* user_id
* comment_text
* commented_at

###  Likes

* like_id (Primary Key)
* post_id
* user_id
* liked_at

###  Notifications

* user_id
* message
* created_at

---

##  Features Implemented

* Database creation using **DDL (CREATE TABLE)**
* Data insertion and manipulation using **DML (INSERT, UPDATE, DELETE)**
* Relationship management using **Primary and Foreign Keys**
* Querying and filtering using SQL conditions

---

##  SQL Concepts Covered

* Filtering: WHERE, LIKE, IN, BETWEEN, NULL checks
* Sorting & Grouping: ORDER BY, GROUP BY, HAVING, LIMIT
* Joins: INNER JOIN, LEFT JOIN
* Aggregate Functions: COUNT()
* Subqueries
* Views
* Stored Procedures
* User Defined Functions
* Triggers

---

##  Key Insights

* Some users are more active and post frequently
* Engagement levels vary across posts
* Certain posts have missing captions
* User activity changes over time
* Some users gain more followers, indicating higher popularity

---

##  How to Use

1. Import the SQL file into MySQL or any SQL database system
2. Run the CREATE TABLE scripts
3. Insert the sample data
4. Execute queries to analyze user activity and engagement

---

##  Requirements

* MySQL / SQL-compatible database system
* SQL editor (MySQL Workbench, pgAdmin, etc.)




