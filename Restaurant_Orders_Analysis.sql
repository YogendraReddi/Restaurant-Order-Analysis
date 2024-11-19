USE restaurant_db;


-- 1. View the menu_items table. 
select * from menu_items;

-- 2. Find the number of items on the menu.
select count(*) from menu_items;

-- 3. What are the least and most expensive items on the menu?
select * from  menu_items
order by price desc;

-- 4. How many Italian dishes are on the menu?
select category, count(menu_item_id) as num_dishes
from menu_items
where category = "Italian"
group by category;
-- 5. 
select category, avg(menu_item_id) as avg_dishes
from menu_items
group by category;



-- ------------------
select * from order_details;
-- 2. What is the date range of the table?
select min(order_date),max(order_date) from order_details;


-- 3. How many orders were made within this date range?
select count(distinct(order_id)) from order_details;

-- 4. How many items were ordered within this date range?

select count(distinct(item_id)) from order_details;

-- 5. Which orders had the most number of items?
select order_id , count(item_id) as num_details from order_details
group by order_id 
order by num_details desc;

-- -6. How many orders had more than 12 items?
select count(*) from(
select order_id , count(item_id) as num_details from order_details
group by order_id 
having num_details >12
) as num_orders;
-- --------------

-- 1. Combine the menu_items and order_details tables into a single table.
select *
 from order_details od
 left join menu_items mi
 on od.item_id = mi.menu_item_id;

-- 2. What were the least and most ordered items? What categories were they in?

select item_name, category, count(order_details_id) as num_purch
 from order_details od
 left join menu_items mi
 on od.item_id = mi.menu_item_id
 group by item_name, category
 order by num_purch desc;
 


-- 3. What were the top 5 orders that spent the most money?

select order_id,sum(price) as total_spend
 from order_details od
 left join menu_items mi
 on od.item_id = mi.menu_item_id
 group  by order_id
 order by total_spend desc
 limit 5;

-- 4. View the details of the highest spend order. What insights can you gather from this
select category, count(item_id) as num_items
 from order_details od
 left join menu_items mi
 on od.item_id = mi.menu_item_id
 where order_id = 440
 group by category 
 ;

-- 5. View the details of the top 5 highest spend orders. What insights can you gather from this

select order_id,category, count(item_id) as num_items
 from order_details od
 left join menu_items mi
 on od.item_id = mi.menu_item_id
 where order_id in (440,2075,1957,330,2675)
 group by order_id,category 
 ;
