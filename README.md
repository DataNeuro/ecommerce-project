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
In the first part of the project (which covered queries 1-4), I focused on analysing data relating to the administrative structure of the store. First, I created a list of departments and the aisles assigned to them, and then determined the number of aisles associated with each department. The next step was to make a list of products, the aisles they were assigned to and the number of products in each aisle. The information gathered in this way provided an accurate visualisation of the current layout of the store.

Queries 5 and 6 focused on identifying the users who placed the highest number of orders, which made it possible to develop a loyalty programme for the most active customers. In addition, I analysed a discount programme: users with the most orders (first group) receive a 15% discount, the second group 10%, the third group 5%, while the remaining customers do not qualify for any discount.

In the third part of the project, I focused on a detailed analysis of product sales by department. In query 8, I carried out an analysis of the number of products sold by department, which allowed me to identify which departments had the highest sales performance.Then, in query 9, I compared the number of orders placed in each department, comparing the total number of orders with the number of orders placed during the week and at the weekend. This analysis allowed me to assess how different days of the week affect the number of orders in each department, which is crucial for understanding customer buying patterns. As a next step, in query 10, I identified the department that recorded the highest sales at the weekend. This finding allowed me to draw conclusions about the effectiveness of sales at different times, depending on the specifics of the department. In Query 11, I calculated the difference between weekday sales and weekend sales, which enabled me to identify which days of the week were most beneficial for sales in the department.To conclude this part of the analysis, in Query 12, I focused on identifying the ten avenues with the highest number of sales. This analysis allowed me to identify which areas of the shop generate the most shopping traffic and where to focus marketing and operational efforts to maximise sales.

In the fourth part of the project, I focused on analysing the most frequently ordered products, using different data extraction methods. I carried out this analysis in Queries 13 and 14, with Query 14 providing a more detailed analysis, taking into account additional aspects, which allowed for a more in-depth understanding of ordering patterns. Based on these analyses, I created a list of the 10 most frequently ordered products along with the number of orders for each product. Then, in Query 15, I calculated the average number of orders for each product, which provided a better understanding of their popularity. In Query 16, I compiled a list of the three products that were most frequently reordered, which provided important information about customer loyalty to specific products. The next step was to analyse the products that were not reordered (query 17), which helped identify potential issues with customer retention or the effectiveness of the offer. In the final part of the analysis, in query 18, I assessed what percentage of total sales the most frequently ordered product accounted for, which allowed me to identify its impact on overall sales and understand its importance in the context of the overall product offering.


