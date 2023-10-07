/* 1 */
/* Create a query that shows the product number, product name, unit price, stock, and stock value.
stock value = (unit price) * (number of pieces in stock).
Add a "€" sign to the result.
Add the word "pieces" to the number of pieces in stock. (77) 
Concat puts two values together, so multiple fields in one column */ 
select productnumber, productname, concat(PricePerUnit, ' pieces') as 'PricePerUnit', concat(stock,' pieces') as 'Stock', concat(priceperunit * stock,' $') as 'Stock Value' from tblproducts;

/* 2 */ 
/* Create a query that shows the product number, product name, purchase price (priceperunit), and selling price.
The selling price is determined by a 15% profit margin on the purchase price.
Show the absolute profit in €.
Provide a clear and readable table (= intended for the company's marketing department). (77) */ 
Select ProductNumber, ProductName, Priceperunit as 'PurchasePrice', 
round(priceperunit * 1.15,2) as 'SellingPrice',priceperunit*1.15 - PricePerUnit as 'Profit'  from tblproducts;

/* 3 */ 
/* Create a query that selects all customers who live in Tienen and shows their customer number, name, and type. (7) */ 
Select customerId, name, type from tblcustomers where city = 'Tienen';

/* 4 */ 
/* Create a query that shows all product names of products in category 1. (12) */
select productname from tblproducts where categorynumber = 1; 

/*5*/ 
/* Create a query that shows all customer names of customers who live in Genk (postal code 3600). (9)
Then modify the query to show the number of people in Leuven (postal code 3000) (23).*/ 
select *  from tblcustomers where city = 'leuven'; 
select * from tblcustomers where city = 'Genk'; 

/*6*/ 
/* Create a query to show all individual customers (**type P**) who still have an outstanding balance (balance) and who live in Tienen. (2) */ 
select customerid, type, balance, city from tblcustomers where type = 'P' and  balance > 0 and city = 'Tienen'; 

/*7*/ 
/* Create a query that selects the customers who live in Leuven or Herent. Show customer name and city. (30) */
select customerid, city from tblcustomers where city = 'Leuven' or city = 'Herent';

/*8*/ 
/* Create the query that shows the main address information of the catering (type T) and retailers (type W). 
Show the postal code and the municipality in the same column (81)*/ 

select name, Address, type, concat(zipcode, city) as 'main adress' from tblcustomers where type = 'T' or type =  'W';

/*9*/ 
/* Create a query that shows all employees who were born before January 1, 1950.
The name and first name come in a column 'Full name'. (3)*/
select * from tblemployees where birthdate < '1950-01-01';







