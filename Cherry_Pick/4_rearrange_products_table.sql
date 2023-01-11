-- https://leetcode.com/problems/rearrange-products-table/description/?envType=study-plan&id=sql-i

LeetCode : 1795. Rearrange Products Table  

Table: Products

+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| product_id  | int     |
| store1      | int     |
| store2      | int     |
| store3      | int     |
+-------------+---------+
product_id is the primary key for this table.
Each row in this table indicates the product's price in 3 different stores: store1, store2, and store3.
If the product is not available in a store, the price will be null in that store's column.
 

Write an SQL query to rearrange the Products table so that each row has (product_id, store, price). If a product is not available in a store, do not include a row with that product_id and store combination in the result table.

Return the result table in any order.

-- ---------------------------------------------------------------------

Create table If Not Exists Products (product_id int, store1 int, store2 int, store3 int)
Truncate table Products
insert into Products (product_id, store1, store2, store3) values ('0', '95', '100', '105')
insert into Products (product_id, store1, store2, store3) values ('1', '70', 'None', '80')

-- Solution 

select   product_id,
        'store1' as store, 
         store1 as price 
    from products where store1 is not null    
union 
select  product_id,
        'store2' as store, 
        store2 as price 
    from products where store2 is not null   
union
select  product_id,
       'store3' as store, 
        store3 as price 
    from products where store3 is not null;   


-- Good Question - To convert multiple columns as values of a single column 