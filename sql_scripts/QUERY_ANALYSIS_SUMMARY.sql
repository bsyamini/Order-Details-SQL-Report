Use RESTAURANT_ORDERS


--Beginner Level

--1.Retrieve the first 5 rows from the order_details table.
select top 5 * from order_details

/* OUTPUT
order_details_id	order_id	order_date	order_time			item_id
1					1			2023-01-01	11:38:36.0000000	109
2					2			2023-01-01	11:57:40.0000000	108
3					2			2023-01-01	11:57:40.0000000	124
4					2			2023-01-01	11:57:40.0000000	117
5					2			2023-01-01	11:57:40.0000000	129		 */

--2.Count the total number of records in the data.
select count(*) as Total_Records from order_details

/* OUTPUT
Total_Records
	12234	*/

--3.List all unique item_ids present in the orders.
select distinct item_id from order_details

/* OUTPUT Summary:
 This dataset shows the distinct item_id values identified in the order data.
 The item IDs range between 101 to 132, capturing various unique products or items.
 The presence of a NULL value indicates some records have missing or unspecified item IDs.
 Listing distinct items provides a foundational view of the product variety in the dataset.
 This summary aids in understanding the scope of inventory/items covered by the orders.
*/


--4.Find the number of orders recorded on '01-01-2023'.
select count(*) as Total_Orders from order_details where order_date = '01-01-2023'

/* OUTPUT
Total_Orders
	161		*/

--5.Retrieve all order details where item_id is NULL.
select * from order_details where item_id is null

/* OUTPUT Summary:
 This query fetches order details containing order IDs, dates, times, and item IDs.
 Data spans from January to March 2023 with orders recorded throughout the day.
 Note: item_id values are currently NULL and need verification.
*/

--6.Count number of different order_ids.
select count(distinct order_id) as Diff_Order_id from order_details

/* OUTPUT
Diff_Order_id
5370		 */

--7.Get all orders placed after 12 PM.
select * from order_details where order_time > '12:00:00'

/* OUTPUT Summary:
 This dataset contains order details including unique order detail IDs, associated order IDs, dates, times, and item IDs.
 Data spans from early January to late February 2023, showing the transaction timestamps.
 Majority of records have valid item IDs, allowing product-level analysis; however, some item ID values are NULL, indicating possible missing or incomplete data.
 The data is suitable for analyzing order patterns by date and time, identifying frequent items, and sales trends over the recorded period.
*/


--8.Find the earliest and latest order_date in the data.
select 
	min(order_date) as Earliest_order,
	max(order_date) as Latest_order
from order_details

/* OUTPUT
Earliest_order	Latest_order
2023-01-01		2023-03-31	 */

--all orders on the first day of quarter and New Year
select * from order_details where 
order_date = (select min(order_date) as Earliest_order from order_details)

/* OUTPUT Summary:
 The dataset contains detailed order information with columns for order_details_id, order_id, order_date, order_time, and item_id.
 Orders are recorded for January 1, 2023, with multiple items per order indicated by repeated order_id values.
 The data includes precise timestamps for order time down to milliseconds.
 Item IDs range mostly between 101 and 132, with occasional NULL values indicating missing item information.
 This order-level data supports analysis of order patterns over time, item popularity, and transactional details.
*/


--all the orders on the last day of the quarter
select * from order_details where 
order_date = (select max(order_date) as Latest_order from order_details)

/* OUTPUT Summary:
 The data consists of detailed order entries with columns for order_details_id, order_id, order_date, order_time, and item_id.
 Data covers orders placed on March 31, 2023, including multiple items per order differentiated by repeated order_id values.
 The dataset captures exact order times with high precision.
 Item IDs range between 101 and 132, representing the products ordered.
 The data supports detailed transactional analysis by order, item, and timestamp for a single day.
*/


--Intermediate Level 

--1.How many orders contained more than 5 items?
select 
	order_id
	from (
		select 
			order_id,
			count(item_id) over(partition by order_id) as Top5_Items
		from order_details
		) as TopItems 
		where Top5_Items>5 
		group by order_id

/* OUTPUT Summary:
This dataset includes order IDs with corresponding order counts.
The goal is to determine how many orders have more than 5 items.
These are all the orders having ore than 5 items
The data can be grouped by order_id, counting the number of items per order.
Orders with a count greater than 5 will be counted to give the final total.
This analysis helps understand the frequency of bulk orders or large transactions in the dataset.
*/


--if only count of orders is required
SELECT 
		COUNT(order_id) as Total_No_of_Orders 
FROM 
	(
		SELECT order_id, 
			COUNT(*) as total FROM order_details 
			GROUP BY order_id HAVING COUNT(*) > 5
	) as sub;

/* OUTPUT
Total_No_of_Orders
150				 */

--2.What is the most frequently ordered item_id?
select top 3
		item_id,
		max(count(item_id)) over(partition by item_id) as Most_Ordered
from order_details 
		group by item_id 
		order by Most_Ordered desc

/* OUTPUT
item_id		Most_Ordered
101			622
113			620
109			588 */

--3.List the top 5 order_ids based on the number of items per order.
select top 5 
		order_id,
		count(*) as Item_count 
from order_details
		group by order_id 
		order by Item_count desc

/* OUTPUT
order_id	Item_count
330			14
3473		14
2675		14
1957		14
440			14	 */


--4.Which day of the week had the highest number of orders?
select  
		DATENAME(WEEKDAY,order_date) as Week,
		COUNT(*) as Total
from order_details
	group by DATENAME(WEEKDAY,order_date)
	order by Total desc

/* OUTPUT
Week		Total
Monday		2010
Friday		1822
Tuesday		1788
Sunday		1776
Thursday	1689
Saturday	1618
Wednesday	1531 */


--5.Find the number of orders for each month.
select  
		DATEPART(MONTH,order_date) as Month_No,
		DATENAME(MONTH,order_date) as Months,
		COUNT(*) as Total_Items
from order_details
		group by DATEPART(MONTH,order_date),
		DATENAME(MONTH,order_date)
		order by Month_No

/* OUTPUT
Month_No	Months	Total_Items
1			January		4156
2			February	3892
3			March		4186	*/


--6.Identify the hour with the highest order placement.
select  top 2
		datepart(hour,order_time) as Highest_Hour,
		COUNT(*) as Orders
from order_details
		group by datepart(hour,order_time) 
		order by COUNT(*)  desc

/* OUTPUT
Highest_Hour	Orders
12				1672
13				1575	 */

--7.For each item_id, count the number of times it appears in the data.
select item_id,
		COUNT(*) as Total
from order_details
		group by item_id 
		order by 
		case when item_id is null then 1 else 0 end, item_id

/* OUTPUT Summary:
 This data shows the total count of occurrences for each item_id in the dataset.
 Item IDs range from 101 to 132, with corresponding totals varying from 123 to 622.
 The highest total is 622 for item_id 101, indicating it is the most frequently ordered or listed item.
 There are 137 records with NULL item_id, suggesting some missing or unrecorded item information.
 This summary assists in understanding item popularity and data completeness.
*/


--8.List all orders where item_id=101.0 and order_date is in February 2023.
select  * from order_details
		where item_id = 101 and 
		order_date between '02-01-2023' and '02-27-2023'

/* OUTPUT Summary:
 This dataset contains order details for the month of February 2023, including order_details_id, order_id, order_date, order_time, and item_id.
 All records pertain to February with detailed timestamps and associated item identifiers.
 The data helps analyze order activity, item popularity, and transaction timing specifically for February.
 It can be used to identify trends or performance metrics during this month.
*/


--Advanced Level

--1.Which order had the highest number of items, and what were the items?
select 
		order_id, 
		item_id, 
		order_date 
from order_details
where order_id in 
		( 
		select  top 1
			order_id
		from order_details 
		group by order_id 
		order by COUNT(*) desc
		)

/* OUTPUT
order_id	item_id	order_date
330			107		2023-01-06
330			103		2023-01-06
330			108		2023-01-06
330			108		2023-01-06
330			124		2023-01-06
330			125		2023-01-06
330			109		2023-01-06
330			112		2023-01-06
330			118		2023-01-06
330			120		2023-01-06
330			122		2023-01-06
330			122		2023-01-06
330			131		2023-01-06
330			114		2023-01-06	*/

--2.On which date was the highest number of orders placed?
select  top 1
		order_date,
		COUNT(distinct order_id)  as High_Orders
from order_details 
		group by order_date 
		order by High_Orders desc 

/* OUTPUT
order_date	High_Orders
2023-02-01		87		*/

--3.What proportion of orders have NULL in item_id?
select 
		cast(sum(case
		when order_id is null then 1 else 0
		end)/ COUNT(*) As Float) as Nulls_Proportion
from order_details

/* OUTPUT
Nulls_Proportion
	0		 */

--4.List the distribution of orders by hour, bucketed as Morning, Afternoon, Evening.
select 
	case
	when DATEPART(hour, order_time) < 12 then 'Morning'
	when DATEPART(hour, order_time) < 18 then 'Afternoon'
	else 'Evening'
	end as PartOfDay,
	COUNT(*) as Total_Orders
from order_details
	group by 
	case
	when datepart(hour, order_time) < 12 then 'Morning'
	when DATEPART(HOUR, order_time) < 18 then 'Afternoon'
	else 'Evening'
	end

/* OUTPUT
PartOfDay	Total_Orders
Evening		4209
Morning		635
Afternoon	7390 */

--5.For each day of the week, find average number of items per order.
select  
		DATEPART(WEEKDAY, MIN(order_date)) as Week_Num,
		DATENAME(weekday, order_date) as Week,
		AVG(Total_Items) as Avg_per_Order
	from
		(
		select
			order_id,
			order_date,
			COUNT(item_id) as Total_Items
from order_details
	group by order_id,
			 order_date
)as Sub
	group by datename(weekday, order_date)
	order by Week_Num;

/* OUTPUT
Week_Num	Week	Avg_per_Order
1			Sunday		2
2			Monday		2
3			Tuesday		2
4			Wednesday	2
5			Thursday	2
6			Friday		2
7			Saturday	2	*/

--6.Which item_id is most popular on weekends vs weekdays?
With DayType as (
select 
	case
		when datepart(weekday,order_date) in (1,7) then 'Weekend'
		else 'Weekday'
		end as Week_Type,
		item_id,
		COUNT(*) as Total_Items
from order_details
	group by  
			 case
		when datepart(weekday,order_date) in (1,7) then 'Weekend'
		else 'Weekday'
		end, item_id
),
MaxCount as (
select  Week_Type,
		max(Total_Items) as Total
from DayType
	group by Week_Type
)
select d.Week_Type, d.item_id, d.Total_Items
from DayType d join MaxCount m on d.Week_Type = m.Week_Type
							and d.Total_Items = m.Total;

/* OUTPUT
Week_Type	item_id		Total_Items
Weekday		113			451
Weekend		109			186		*/

		
--7.Calculate the moving average of daily total orders (7-day window)
with Moving_Avg as
(
	select order_date,
		COUNT(distinct order_id) as Total_Orders
	from order_details
		group by order_date
	)
	select order_date,
		AVG(count(distinct order_id))
		over(order by order_date rows between 6 preceding and current row) as Moving_Avg 
	from order_details 
		group by order_date;

/* OUTPUT Summary:
 This dataset presents a 7-day sliding window moving average of daily total orders from January 1, 2023, to March 31, 2023.
 The moving average smooths daily fluctuations to reveal trends over time.
 The data indicates initial variability, with values around 69 decreasing to around 56-61 towards the end of March.
 Analysis of this metric helps in understanding short-term sales trends and identifying periods of increased or decreased order activity.
*/


--8.Find all order_ids that span more than one day (if any).
select order_id
from (
   select order_id,
          count(distinct order_date) as day_count
   from order_details 
   	group by order_id
) as sub
where day_count > 1;

/* OUTPUT
order_id
		*/
