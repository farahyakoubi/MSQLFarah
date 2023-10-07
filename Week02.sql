/* 1) Create a query that generates the overview below. (269) */ 
select customerid, name, address, concat(zipcode, ' ',city) as 'Zipcode & City' from tblcustomers;

/* 2) Which customers have a balance between 150 and 300 euros, including these limits? Sort in descending order by balance. 
Create this query in 2 ways. (20) */ 
select customerid, name, address, concat(zipcode,' ',city) as 'Zipcode & City',balance  from tblcustomers where balance between "150" and "300" order by balance  desc; 
select customerid, name, address, concat(zipcode,' ',city) as 'Zipcode & City',balance from tblcustomers where balance >= "150" and balance <= 300 order by balance desc;

/* 3) Which employees have a birthday in July or August? You can also create the queries in various ways. (2) */ 
select lastname, birthdate from tblemployees where month(birthdate) = 7 or month(birthdate)= 8; 
select lastname, birthdate from tblemployees where monthname(birthdate) = 'July' or monthname(birthdate) = 'August'; 
select lastname, birthdate from tblemployees where month(birthdate) in (7,8); 

/* 4) Which employees do not have a birthday in July or August? (13) */ 
select lastname, birthdate from tblemployees where month(birthdate) not in (7,8); 

/* 5) Determine which employees were born between January 1, 1960 and January 27, 1966. Sort by birthdate. (8)
What happens if you do or do not enter the time in the expression? */ 
select birthdate from tblemployees where date(BirthDate) between '1960-01-01' and '1966-01-27'; 

/* 6) Which customers live in Leuven, Herent, Kessel-Lo or Heverlee?(69) */
select * from tblcustomers where city = 'Leuven' or city = 'Herent' or city ='Heverlee' or city='Kessel-Lo'; 
select * from tblcustomers where city in ('Leuven', 'Herent', 'Kessel-Lo','Heverlee'); 
/* watch out from spaces */

/* 7) Which customers do not live in Leuven, Herent, Kessel-Lo or Heverlee?(200) */ 
select * from tblcustomers where city not in ('Leuven', 'Herent', 'Kessel-Lo','Heverlee'); 

/* 8) Determine which products belong to the category Drinks (categorynumber 1), Spices (categorynumber 2), Sweets (categorynumber 3), 
Dairy (categorynumber 4), and Fish (categorynumber 8). Show the Dutch name with the product name in parentheses, followed by the category number of those products.
Sort according to categorynumber and Dutch name (59)*/ 
select * from tblproducts where categorynumber in(1,2,3,4,8);

/* 9) Which products are from the brand Louisiana. (tip: the brand 'Louisiana' appears in the product name). (2) */ 
select productname from tblproducts where productname like '%Louisiana%';

/* 10) Which products are packaged in bottles or boxes? (24) */ 
select QuantityPerUnit from tblproducts where QuantityPerUnit like '%bottles%' or QuantityPerUnit like '%boxes%';  

/* 11) Show these products (exercise 10) with a unit price below 32 €? The most expensive product is at the top (23) */ 
select productname from tblproducts where (QuantityPerUnit like '%bottle%' or QuantityPerUnit like '%boxes%') and priceperunit < 32 order by PricePerUnit asc; 
/* for the where you have to use brackets for the like function and then close it and start your new function 
you combine the or and then check the price of the unit, sometimes it mixes up not correctly */ 

/* 12) Find all customers whose name starts with 'Vander'. Show the name and city of the customer.(4) . */ 
select name, city from tblcustomers where name like '%Vander%'; 

/* 13) Now show only the customers whose name starts with 'Vander' and ends with a 't' (2) */ 
select name, city from tblcustomers where name like '%Vander%t';

/* 14) Find all customers who live on a street that contains 'dorp' in the name. (2)*/ 
select * from tblcustomers where address like '%dorp%';

/* 15) Display the suppliers whose name contains at least one of the following words: an, foot. (5) */ 
select * from tblsuppliers where Company like '%an%' or Company like '%foot%';

/* 16) Use a regular expression to search for products whose name starts with 'chef' and ends with 'mix'. (1) */
select * from tblproducts where ProductName REGEXP 'chef.*mix$';

/* 17 Show product names that contain a lowercase c. Product names with only an uppercase C and no lowercase c will not be displayed. 
Sort by product name. (25) */ 
select productname from tblproducts where cast(ProductName as binary) regexp binary 'c';

/* 18 Modify the previous query to show product names with lowercase c, lowercase y, or uppercase B (33) */
 SELECT ProductName from tblproducts where CAST(ProductName AS BINARY) REGEXP BINARY '[c,y,B]';
 
 /* 19) Show the customers who have an outstanding balance of 4 characters. (37) */ 
 SELECT * FROM tblcustomers WHERE LENGTH(Balance) = 4;

/* 20) Look at how the TaxPercentage is entered in tbltaxrate: one number - a period - two numbers. 
Create a regular expression that matches this pattern. (4) Test the REGEXP by querying all rates with this pattern.
Also test the inverse: modify the working pattern so that you don't get any data back. (0) */
select * from tbltaxrate where TaxPercentage regexp './...' ;

/* 21) Create a list of all caterers (=Type T) and shopkeepers (=Type W).
Ensure that in this list, all caterers are grouped together and all shopkeepers are grouped together. 
Sort the caterers alphabetically by name, and the shopkeepers alphabetically as well. (81) */ 
select name, type, city from tblcustomers where type='t'or type='w' order by type,name;

/* you can use like but it's better to use it when you search for something specific in a word*/ 
/* cannot be and but it has to be or because it needs to be one or the other */ 
SET sql_mode = 'ONLY_FULL_GROUP_BY'; 

/* 22) How can you ensure that the caterers are at the bottom of the list? (81) */ 
select name, type, city from tblcustomers where type='t'or type='w' order by type desc,name;

/* 23) Create a list of all customers who have debts (column Balance) and put the customers with the largest debts at the top. 
Pay attention to the € symbol. (174) */ 
select name, balance, customerid from tblcustomers where balance <> 0 order by balance desc;

/* 24) Create a list of all employees, sorted by birthdate so that the oldest ones are at the top. (15) */
select * from tblemployees order by BirthDate asc; 

/* 25) Which employees were hired in 1993? Sort in descending order by date.(5) */ 
SELECT * FROM tblemployees WHERE YEAR(employed) = 1993 ORDER BY employed DESC;

/* 26) Which customers (in alphabetical order) live in Leuven? (23) */ 
select * from tblcustomers where city = 'Leuven' order by city asc;
select name from tblcustomers where city = 'leuven' order by city asc;

/* 27) Show the first name and last name of the female employees from Leuven (2)
(Artemis is a somewhat outdated database. The 'gender' field indicates whether an employee is male or female.) */ 
 select firstname, lastname from tblemployees where Gender = 2 and City = 'Leuven';

/* 28) Show the first name and last name of the male employees who do not live in Kessel-lo, Herent, or Leuven. (9) */ 
select firstname, lastname from tblemployees where gender = 1 and city not in ('Kessel-lo', 'Herent', 'Leuven');

/* 29) Which customers (in alphabetical order) have a balance greater than 175 euros? (64) */
select name from tblcustomers where balance >= 175 order by name asc;

/* 30) Provide a list of customers whose name starts with 'Van' (29) */ 
select customerid, name from tblcustomers where name like  'Van%';  /* no percentage side at both side*/ 

/* 31) Show the last name and city - both in uppercase - 
of the representatives from the employees table who do not live in Leuven, Herent, Peer or Genk. 
Use UPPER to convert to uppercase (4). */ 
select upper(lastname) as LASTNAME, upper(city) as CITY from tblemployees where jobtitle = 'representative' and City not in ('Leuven', 'Herent', 'Peer', 'Genk'); 

/* 32) Display the names of the products that need to be reordered. 
A product needs to be reordered if the quantity Stock minus the quantity OnOrder (these are the shortages) 
is less than the reorder point (field in the database is 'shop').
Sort the list so that the products with the most urgent shortages are at the top. (18) */ 
select productname from tblproducts where (stock - onorder) < shop order by (stock - onorder) desc; 

/* 33) Display the suppliers who do not live in Spain or the United Kingdom. Limit the display to 5 suppliers in alphabetical order.
Display them as follows: */ 
select supplierid, company, country from tblsuppliers where Country not in ('Spain', 'United Kingdom') limit 5 ; 

/* 34) Create an alphabetical overview of the countries that have a supplier. Each country can only appear once in the list. (10) */ 
select distinct country from tblsuppliers order by country asc; 

/* 35) What is the debt balance of the customers with a registration number? (result= 7216)
How many customers is that? (#13) */ 
select sum(balance) as debt_balance, count(*) as number_of_customers from tblcustomers where RegistrationNumber is not null; 

/* 36) How many orders were placed on August 6, 2006? 
Take into account that an order could have been placed at a different time of the day, 
even if they are entered as time 0 in Artemis. (#3) */ 
SELECT COUNT(*) AS NumberOfOrders FROM tblorders WHERE DATE(OrderDate) = '2006-08-06';

/* 37) Show the average price per unit of all products after they have been increased by 10%. (result = 31.48) */ 
select round(avg(priceperunit * 1.10),2) as AveragePricePerUnit from tblproducts ; 

/* 38) Show the number of representatives who were hired before 1993. (#5) */ 
SELECT COUNT(*) AS NumberOfRepresentatives FROM tblemployees where Employed < '1993-01-01' and jobtitle = 'representative'; 

/* 39) Show the number of years difference between the oldest and youngest employee from Leuven. (result = 18) */ 
select cast(year(max(BirthDate)) - year(min(birthdate)) as signed) as 'difference' from tblemployees where city = 'Leuven' ; /* did not work at first but after adding cast it worked*/

/* 40) How many orders were placed in 2005? (#358) */ 
select count(*) as Number_of_orders from tblorders where year(orderdate) = 2005; 









