## WORKING ON CITYKART SUPERMART  SALES ##

create database citykart;
use citykart;
select * from citykart;
   ## CHANGING COLUMN NAME
ALTER TABLE citykart RENAME COLUMN `Item Visibility` TO Item_Visibility;
   ## EXCESS TO UPDATE SQL
set sql_safe_updates = 0;
   ## UPDATING VALUES IN COLUMN
Update citykart
set Item_Fat_Content = 
Case
when Item_Fat_Content IN ('LF','LOW FAT') then 'Low Fat'
when Item_Fat_Content = 'reg' then 'Regular'
else Item_Fat_Content 
end


   ## FINDING SUM OF SALES
select cast(sum(sales) / 1000000 as decimal(10,2)) as total_sales_millions from 
citykart;

   ## FINDING AVERAGE OF SALES
select cast(avg(sales)  as decimal(10,2)) as avg_sales from citykart;

  ## COUNTING NO OF ITEMS
select count(*) as no_of_items from citykart;

  ## FINDING AVERAGE RATING
select cast(avg(rating)  as decimal(10,2)) as avg_rating from citykart;

  ## FINDING TOTAL SALES BY FAT CONTENT
select Item_Fat_content,
  cast(sum(sales)/1000 as decimal(10,2)) as total_sales_thousands,
  cast(avg(sales) as decimal(10,2)) as avg_sales,
  count(*) as no_of_Items,
  cast(avg(rating) as decimal(10,2)) as avg_rating 
from citykart
group by item_fat_content
order by total_sales_thousands desc;

   ## FINDING TOTAL SALES BY ITEM TYPE
select Item_Type,
  cast(sum(sales) as decimal(10,2)) as total_sales,
  cast(avg(sales) as decimal(10,2)) as avg_sales,
  count(*) as no_of_Items,
  cast(avg(rating) as decimal(10,2)) as avg_rating 
from citykart
group by item_type
order by total_sales desc;

   ## FINDING FAT CONTENT BY OUTLET FOR TOTAL SALES
select Outlet_Location_type, Item_Fat_Content,
  cast(sum(sales)/1000 as decimal(10,2)) as total_sales,
  cast(avg(sales) as decimal(10,2)) as avg_sales,
  count(*) as no_of_Items,
  cast(avg(rating) as decimal(10,2)) as avg_rating 
from citykart
group by outlet_location_type,item_fat_content
order by total_sales asc ;


SELECT outlet_location_type,
   isnull([Low fat], 0) as low_fat,
   isnull([regular], 0) as regular 
from
(
  select outlet_location_type ,item_fat_content,
    cast(sum(total_sales) as decimal(10,2)) as total_sales 
  from blinkit_date
  group by outlet_location_type , item_fat_content
) as sourcetable
PIVOT
(
  sum(sales)
  for item_fat_content in([low fat],[regular])
) as pivottable
order by outlet_location_type; 

  ## FINDING TOTAL SALES BY OUTLET ESTABLISHMENT
select Outlet_Establishment_Year,
  cast(sum(sales) as decimal(10,2)) as total_sales,
  cast(avg(sales) as decimal(10,2)) as avg_sales,
  count(*) as no_of_Items,
  cast(avg(rating) as decimal(10,2)) as avg_rating 
from citykart
group by outlet_Establishment_Year
order by total_sales desc ;

 ## FINDING PERCENTAGE OF SALES BY OUTLET SIZE
select 
  Outlet_Size,
  cast(sum(sales) as decimal(10,2)) as total_sales ,
  cast((sum(sales)*100 / sum(sum(sales)) over()) as decimal(10,2)) as sales_percentage
from citykart
group by outlet_Size
order by total_sales desc ;

 ## FINDING SALES BY OUTLET LOCATION
select Outlet_location_type,
  cast(sum(sales) as decimal(10,2)) as total_sales,
  cast(avg(sales) as decimal(10,2)) as avg_sales,
  count(*) as no_of_Items,
  cast(avg(rating) as decimal(10,2)) as avg_rating 
from citykart
group by outlet_location_type
order by total_sales desc ;

  ## ALL METRICS BY OUTLET TYPE
select Outlet_Type,
  cast(sum(sales) as decimal(10,2)) as total_sales,
  cast((sum(sales)*100 / sum(sum(sales)) over()) as decimal(10,2)) as sales_percentage,
  cast(avg(sales) as decimal(10,2)) as avg_sales,
  count(*) as no_of_Items,
  cast(avg(rating) as decimal(10,2)) as avg_rating 
from citykart
group by outlet_type
order by total_sales desc ;





 







