CREATE TABLE products (
	product_id	INT PRIMARY KEY,
	product_name	TEXT,
	price	INT,
	type_Product	TEXT
);

CREATE TABLE customers (
	customer_id	INT PRIMARY KEY,
	first_name	TEXT,
	lastname	TEXT,
  gender TEXT
);

CREATE TABLE employees (
	employee_id	INT PRIMARY KEY,
	first_name	TEXT,
	lastname	TEXT,
  gender TEXT
);

CREATE TABLE stores (
	store_location_id	INT PRIMARY KEY,
	location	TEXT
);

CREATE TABLE sales (
	order_date	date,
	customers	INT,
	orders	INT,
	employees	INT,
	location INT,
  FOREIGN KEY(customers) references customers(customer_id),
  FOREIGN KEY(orders) references products(product_id),
  FOREIGN KEY(employees) references employees(employee_id),
  FOREIGN KEY(location) references stores(store_location_id)
);

INSERT INTO products VALUES
(1, 'Banana', 20, 'Fruit'),
(2, 'Orange', 10, 'Fruit'),
(3, 'Fried Egg', 15, 'Food'),
(4, 'Turkey', 40, 'Food'),
(5, 'Chocolate', 15, 'Snack'),
(6, 'Omelette', 15, 'Food'),
(7, 'Snake Soup', 80, 'Food'),
(8, 'Fried Frog', 60, 'Food');

INSERT INTO customers VALUES
(1, 'John', 'Banksy', 'Male'),
(2, 'Oras', 'Pasco', 'Female'),
(3, 'Lol', 'Lmao', 'Male');

INSERT INTO employees VALUES
(1, 'Yest', 'Reqo', 'Male'),
(2, 'Paqy', 'Poco', 'Female'),
(3, 'Mami', 'Dadi', 'Male');

INSERT INTO stores VALUES
(1, 'Siam'),
(2, 'Asok'),
(3, 'Bangna');

INSERT INTO sales VALUES 
('2022-08-01', 3, 5, 3, 3),
('2022-08-02', 2, 8, 2, 2),
('2022-08-03', 1, 7, 1, 1),
('2022-08-04', 3, 6, 3, 3),
('2022-08-05', 3, 5, 3, 3),
('2022-08-06', 2, 4, 2, 2),
('2022-08-07', 1, 3, 1, 1),
('2022-08-08', 3, 2, 3, 3);

.mode markdown
.header on 

select
 s.order_date,
 p.product_name,
 c.first_name,
 e.first_name,
 st.location
from sales as s
  join products as p on p.product_id = s.orders
  join customers as c on c.customer_id = s.customers
  join employees as e on e.employee_id = s.employees
  join stores as st on st.store_location_id = s.location;

select 
  *
from (
  select
   s.order_date as date,
   p.product_name as product_name,
   c.first_name as cus_name,
   e.first_name as emp_name,
   st.location as location
  from sales as s
    join products as p on p.product_id = s.orders
    join customers as c on c.customer_id = s.customers
    join employees as e on e.employee_id = s.employees
    join stores as st on st.store_location_id = s.location
) as sub
where location = 'Asok';

with bangna_customer as (
  select
   s.order_date as date,
   p.product_name as product_name,
   c.first_name as cus_name,
   c.gender as gender,
   e.first_name as emp_name,
   st.location as location
  from sales as s
    join products as p on p.product_id = s.orders
    join customers as c on c.customer_id = s.customers
    join employees as e on e.employee_id = s.employees
    join stores as st on st.store_location_id = s.location
  where st.location = 'Bangna'
)

select
  *
from bangna_customer
where gender = 'Male';

with customer as (
  select
    p.product_name as product,
    c.gender as gender,
    st.location as store
  from sales as s
    join products as p on p.product_id = s.orders
    join customers as c on c.customer_id = s.customers
    join stores as st on st.store_location_id = s.location
)

select
  *
from customer
where gender = 'Male' ;
