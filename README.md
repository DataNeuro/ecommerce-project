# E-commerce Project
### Overview
The project involved analyzing an extensive dataset containing information about grocery orders placed by Instacart users. 
### Dataset Used
The dataset contains a sample of over 3 million grocery orders from over 200,000 Instacart users. For each user, between 4 and 100 orders are available, along with a list of products purchased in each order. In addition, information is provided on the week and time of day the order was placed, as well as the relative time between orders.

https://www.kaggle.com/competitions/instacart-market-basket-analysis/data
### Data Model
![Data Model](https://github.com/DataNeuro/ecommerce-project/blob/main/E-commerce_Data%20model.jpg)


I used Python to create a database with tables: Aisle, Departments, Products, Orders, and Order_products. After setting up the structure, data was loaded into these tables to organize and manage the information efficiently(https://github.com/DataNeuro/ecommerce-project/blob/main/ecommerce_project_final.ipynb).

### Project Overview
In the first part of the project (covering queries 1-4), I focused on analyzing data related to the store's administrative structure. Initially, I created a list of departments along with the aisles assigned to each, and then determined the number of aisles associated with each department. The next step involved compiling a list of products, taking into account the aisles they are assigned to, and determining the number of products in each aisle. The information gathered in this way allowed for a precise visualization of the current organization of the store's space.

Queries 5 and 6 focused on identifying the users who placed the highest number of orders, which enabled the development of a loyalty program for the most active customers. Additionally, I conducted an analysis for a discount program: users with the most orders (first group) receive a 15% discount, the second group receives 10%, the third group 5%, while the remaining customers do not qualify for a discount.


