ALTER TABLE tblOrders CHANGE ShippingsCost ShippingCost double;
/* 1) Show the number of products per category. We are only interested in products that are more expensive than 50 euros. 
Provide a readable (user-friendly) table. (6) */ 
select categorynumber, concat(count(categorynumber), if(count(productname) = 1, " Product", " Products")) as "Number of products" from tblproducts where priceperunit > 50 group by categorynumber order by categorynumber ;
select categorynumber, count(*) from tblproducts where priceperunit > 50 group by categorynumber; 
/* it is the same if you use categorynumber, * or productnumber, because it doesn't matter what you select so it is better to use *  */ 
/* star can't be used everywhere */ 
/* alse need to adapt the word product / products depending on how many productw using the if-function with count  */ 

/* 2) Show the number of customers per city. Sort by count. (94) */ 
select city, count(city)  as "Number of Customers" from tblcustomers group by city order by count(city) desc; 

/* 3) Show the number of customers per city, only keep the cities where there are more than 3 customers. (16) */ 
select city, count(city) from tblcustomers group by city having count(city)  > 3 order by count(city) desc ; 
select city, count(*) from tblcustomers group by city having count(*) > 3 order by count(city) desc; 

/* 4) Provide an overview of the number of employees per job title. Sort by job title. (10) */ 
select jobtitle, count(*)   from tblemployees group by jobtitle order by jobtitle;

/* 5) Modify the above query to show the number of male and female employees per job title. (11) */ 
select jobtitle,  case gender when '2' then 'Female' when '1' then 'Male' else '?' end as 'Gender', count(*) from tblemployees group by jobtitle, gender ; 
/* use case when you have more than 2 conditions otherwise use if */ 

/* 6) Show the number of customers without a business number. (256) */ 
select * from tblcustomers where RegistrationNumber is null; 
select count(*) from tblcustomers where RegistrationNumber is null; /* here with count calculation */ 

/* 7) Display the count of products for each category along with the total value of the stock. 
In this query, include all products. ((8) Stock value per product = stock quantity * unit price. */ 

select CategoryNumber,count(CategoryNumber) as "number of products", sum(stock * priceperunit) as "Stock Value" from tblproducts group by categorynumber ;

/* Then, adjust the formatting of the stock value to display only 2 decimal places with € as the currency. */ 
select CategoryNumber,count(CategoryNumber) as "number of products", concat(round(sum(stock * priceperunit),2), " €") as "Stock Value" from tblproducts group by categorynumber ;

/* 8) Modify the above table to show the total stock value and product quantity per category number for supplier 4. (4) */ 
select suppliernumber, CategoryNumber,count(CategoryNumber) as "number of products", concat(round(sum(stock * priceperunit),2), " €") as "Stock Value" 
from tblproducts where suppliernumber = 4 group by categorynumber ;

/* 9) Show the total stock value and product quantity per category number for supplier 6. 
Only show rows where the total stock value exceeds 1000 €. (1) */ 
select categorynumber, suppliernumber, concat(count(*), " pieces") as "number of products", concat(round(sum(stock * priceperunit),2), " €") as "Stockvalue" 
from tblproducts where suppliernumber = 6 group by categorynumber having Stockvalue > 1000 ; 
/* it is not recommended to use here stock value but use the calculation */ 
select categorynumber, suppliernumber, concat(count(*), " pieces") as "number of products", concat(round(sum(stock * priceperunit),2), " €") as "Stockvalue" 
from tblproducts where suppliernumber = 6 group by categorynumber having sum(stock * priceperunit) > 1000 ; 

/* this way is correct because it will not give an error when words in the header are separated */ 
/* 10) 10. Display the yearly average for order delivery times
First get the results */ 
select year(orderdate), avg(datediff(deliverydate, orderdate)) from tblorders group by year(orderdate) order by year(orderdate);

/* 13)  Use the Person table to look up people with a middlename 'J' and a lastname 'Alexander' or 'Zhang'.
Show FirstName, MiddleName, LastName, and IDs. (13) */ 
select firstname, middlename, lastname, BusinessEntityID from person where middlename = 'J' and lastname in ('Alexander' , 'Zhang');
select firstname, middlename, lastname, BusinessEntityID from person where middlename = 'J' and (lastname = 'Alexander' or lastname = 'Zhang'); 

/* 14) Use the Product table to show all products (with ID, Name, Size, Color) where Size or Color is still NULL. (293) */ 
select productid, name, size, color from product where size is null or color is null;

/* 15) Count how many products have a Size AND a Color, and what the average size (of size) is.
Note: For some products, the size is set as 'M', 'L', 'S', or 'XL'. Do not count these */ 
select 'product info' as '', count(color) as 'number of products', round(avg(size),0)  as 'Average size'  from product where size not in ('M', 'L', 'S', 'XL');

/* 16) Show the people in the Person table whose LastName starts with a capital letter V or a capital letter W.
Show FirstName, MiddleName, and LastName. Sort them in descending order by LastName. Make sure you see the 1290 rows. */ 
select firstname, middlename, lastname from person  where lastname like  'V%' or  lastname like 'W%' order by lastname desc; 
select firstname, middlename, lastname from person where cast(lastname as binary) regexp '^[VW]'; 

/* Place the three name parts in one column called "FullName". 
However, what is noticeable now is that all concatenations with a NULL return a complete NULL.
/* We don't want that. */ 
/* You can solve it by replacing a NULL with an empty string (or another string like a space). Which function will you use for this?*/ 
select concat(firstname,' ', if(isnull(middlename), '', middlename),' ',lastname,' ') as Fullname from person  
where (lastname like  'V%' or  lastname like 'W%')  order by lastname desc; 

/* 17) Precede the above result with the BusinessEntityID number. 
This number is not a string but an INT. A conversion from INT to string is therefore necessary if we want to concatenate. 
However, you don't need to do a CAST for this. Reason: concat() takes care of the conversion. Test this.
 Now also sort the result in ascending order by BusinessEntityID. */ 
select concat(BusinessEntityID,': ',firstname,' ', if(isnull(middlename), '', middlename),' ',lastname,' ') as Fullname 
from person  where (lastname like  'V%' or  lastname like 'W%') order by BusinessEntityID asc; 


/* 18) In the Person table, there are 5 first names that remain the same when reversed (e.g. Bob). Can you find them? Hint: use a function. (5) */ 
select distinct firstname  from person where firstname = reverse(firstname);

/* 19) Use the SUBSTRING and LOCATE functions in the EmailAddress column of the ProductReview table to retrieve all domain names. (4)
    Refer to https://dev.mysql.com/doc/refman/8.0/en/string-functions.html.
    - With LOCATE, you can find the position of @.
    - With SUBSTRING, you can retrieve a part of a string (= the domain name) starting from this position. */  /* NOT ASKED ON THE EXAM!!! */
select * from productreview ;
select substring(EmailAddress, locate('@', EmailAddress) +1) as 'Domain' from productreview;

/* 20) 
here use distinct */ 

/* 21 contains like or regexp */ 

/* 22) total due average function + having greater than 50 */ 

 



