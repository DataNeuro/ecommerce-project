# E-commerce Project
### Overview
The project involved analyzing an extensive dataset containing information about grocery orders placed by Instacart users. 
### Dataset Used
The dataset contains a sample of over 3 million grocery orders from over 200,000 Instacart users. For each user, between 4 and 100 orders are available, along with a list of products purchased in each order. In addition, information is provided on the week and time of day the order was placed, as well as the relative time between orders.

https://www.kaggle.com/competitions/instacart-market-basket-analysis/data
### Data Model
![Data Model](https://github.com/DataNeuro/ecommerce-project/blob/main/E-commerce_Data%20model.jpg)


Python was used to create a database with the following tables: Aisle, Departments, Products, Orders, and Order_products. After setting up the structure, data was loaded into these tables to organize and manage the information efficiently.(https://github.com/DataNeuro/ecommerce-project/blob/main/ecommerce_project_final.ipynb)

### Project Overview
The project involved analysing various aspects of this data. Firstly, a list of departments and their associated aisles was identified and the number of aisles in each department was determined. The next step was to create a list of products with their associated aisles and determine the number of products in each aisle.

The analysis also included identifying the users who placed the highest number of orders. Based on this, a discount system was proposed: users with the highest number of orders (first group) receive a 15% discount, the second group 10%, the third group 5% and the remaining users receive no discount.

Next, the most frequently purchased products were analysed, highlighting the top 10 most purchased products and the top three most reordered products. A ranking of the top 10 products by highest turnover was also carried out. The distribution of orders per hour was examined to identify the hours with the highest and lowest number of orders. The top 10 orders with the highest number of products were also identified.

In addition, each order was analysed in detail, taking into account the products purchased and their department and aisle information. The average quantity of a particular product added to the basket was calculated, the number of products sold in each department was analysed and a list of products that were not re-ordered was compiled.

The number of orders for products was compared to the number of re-orders, along with the average quantity of the product added to the basket. The percentage of total orders that were for the top-selling product was determined.

Further analysis grouped orders by department and determined the total number of products purchased, compared the number of products purchased on weekdays versus weekends, and analysed the difference in sales between weekdays and weekends for each department. The department with the highest weekly sales was identified, as well as the top 10 aisles with the highest sales.

Finally, a summary was produced showing information on products, departments, aisles, total number of orders, re-orders, average number of items added to basket, total sales, weekday and weekend sales, and a comparison of the number of orders for each product with the maximum number of orders in the corresponding aisle.
