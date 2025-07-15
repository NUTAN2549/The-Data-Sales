use big_basket;
select * from customers;

# total no of customers
select count(*) from customers;

select FirstName,LastName,Status 
from customers;

select * from customers where region="North America";

select count(*) from customers
where status = "Active";

select count(*)
from customers
where region="Europe" and Status="Active";

SET SQL_SAFE_UPDATES=0 ;

UPDATE customers
SET JoinDate = STR_TO_DATE(JoinDate, '%d-%m-%y')
WHERE JoinDate LIKE '__-__-__';
 
UPDATE transactions
SET TransactionDate=
STR_TO_DATE(TransactionDate, '%d-%m-%y')
WHERE TransactionDate LIKE '__-__-__';

 SELECT  count(*)
 from customers
 where JoinDate between '2021-01-01' and '2021-12-31';

 select count(*) from customers where JoinDate > '01-01-2001';
 
 select count(*) from customers where JoinDate = 2021;
 
 SELECT DISTINCT JoinDate FROM customers ORDER BY JoinDate;
 

 SELECT COUNT(*)
FROM customers
WHERE YEAR(STR_TO_DATE(JoinDate, '%d-%m-%Y')) > 2021;

 select count(*) from customers where Email LIKE '%_example%';
 
 select count(*) from subscriptions where  PlanType =  'Annual' ;
  
 select count( *) from transactions where Amount>100 ;
 
 
  select count(c.CustomerID)
  from customers as c
  join subscriptions as s
  on c.CustomerID=s.CustomerID
  where PlanType =  'Annual' ;
 
  select *
  from customers as c
  join transactions as t
  on c.CustomerID=t.CustomerID
  where Amount>100 ;
 
 select avg(amount) from transactions;
 
  select c.FirstName,c.LastName,t.TransactionID,T.amount 
  from customers as c
  join transactions as t
  on c.CustomerID=t.CustomerID;
 
 Select * from Transactions order by TransactionID desc , TransactionDate desc limit 5;
 
 select distinct reason  from churn;
 
 select count(*), reason  from churn
 group by reason;
 
 -- Retrieve custID,fullname,email,plantype
 
  select c.CustomerID,concat(c.FirstName," ",c.LastName) as FullName,c.email,s.PlanType
  from customers as c
  join subscriptions as s
  on c.CustomerID=s.CustomerID ;
 
 select count(c.CustomerID)
  from customers as c
  join subscriptions as s
  on c.CustomerID=s.CustomerID
  where PlanType =  'Annual' and Status="Active" ;
  
  select ch.Reason, count(*) as ch_cust
  from customers as c
  join churn as ch
  on c.CustomerID=ch.CustomerID
  where c.Region="North America"
  Group by ch.Reason;
 
 select count(*)
  from churn as c
  join transactions as t
  on c.CustomerID=t.CustomerID;
  
 select count(c.CustomerID) 
  from customers as c
   left join transactions as t
  on c.CustomerID=t.CustomerID
  where TransactionID is null ;
 
 select count(c.CustomerID) 
  from customers as c
   join subscriptions as s
  on c.CustomerID=s.CustomerID
  where PlanType in ("Anual","Monthly") ;
 
  select count(c.CustomerID) 
  from customers as c
  left join subscriptions as s
  on c.CustomerID=s.CustomerID
  where subscriptionID is null ;
 
 -- 22. How many transactions made in last 6 months


-- 23. Find the customer full names, who had an annual plan and then churned



-- 24. Calculate the total reveue by region


-- 25. How many customers are there who do not have any subscription



-- 26. Calculate churn rate (%) per plan type


-- 27. How many such customers are there who made the purchases after their subscription ended.

-- 28. Identify churn reason by region & rank them by count
 
 
 select c.Region,ch.Reason,
 dense_rank() over (partition by c.Region order by count(*) desc) as 'dense_rank'
 from customers c
 join churn as ch
 on c.CustomerID = ch.CustomerID
 group by c.Region,ch.Reason
 order by c.Region,'dense_rank';
 
 -- for each month in 2024,show number of churn & total transaction value
 
 select  DATE_FORMAT(t.transactiondate,'%y-%m') as Month,
 count(distinct ch.customerID) as Churn_Count,
 sum(t.amount) as Total_Transactions
 
 from Transactions as  t LEFT JOIN Churn as ch
 on t.CustomerID = ch.CustomerID and date_format(t.transactiondate,'%y-%m')
 where year(t.transactiondate) = 2024
 Group by Month order by Month ;
 
 -- Identify the customer who made purchase after their subscription ended
 
 Select FirstName,LastName from customers where CustomerID in
 (select Distinct  t.CustomerID
 from Transactions as  t  JOIN subscriptions as s
 on t.CustomerID = s.CustomerID 
 where t.transactiondate>s.EndDate AND t.TransactionType = "Purchase");
 
#4. List customer names & dates if their subscription ended before they churned.
SELECT c.FirstName, s.EndDate, ch.churnDate
FROM  customers as c
join churn as ch
on c.CustomerID = ch.CustomerID 
join subscriptions as s
on s.CustomerID = ch.CustomerID 
WHERE s.EndDate < churnDate;
#5. Calculate the churn rate (%) per plan type
#6. Find Top 5 customers with the highest average monthly spend (based on purchases)
#7. For each month of 2024, show the total revenue from purchase

 