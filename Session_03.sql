-- Problem 1

CREATE TABLE employee
(
    id INT,
    name VARCHAR(50),
    salary INT,
    department_id INT
);

CREATE TABLE department1
(
    id INT,
    dept_name VARCHAR(50)
);

INSERT INTO employee
VALUES
(1, 'JOE', 70000, 1),
(2, 'JIM', 90000, 1),
(3, 'HENRY', 80000, 2),
(4, 'SAM', 60000, 2),
(5, 'MAX', 90000, 1);

INSERT INTO department1
VALUES
(1, 'IT'),
(2, 'SALES');



SELECT E.DEPARTMENT_ID, E.NAME, E.SALARY
FROM EMPLOYEE E JOIN DEPARTMENT1 D
ON E.DEPARTMENT_ID = D.ID
WHERE E.SALARY IN (
	SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPARTMENT_ID HAVING DEPARTMENT_ID = E.DEPARTMENT_ID
)


-- Problem 2
  
SELECT D.DEPT_NAME, E.NAME, E.SALARY
FROM EMPLOYEE E JOIN DEPARTMENT1 D
ON E.DEPARTMENT_ID = D.ID
WHERE E.SALARY = (
	SELECT MAX(SALARY)
	FROM EMPLOYEE e2 WHERE E.DEPARTMENT_ID = DEPARTMENT_ID AND e2.salary < (
		SELECT MAX(SALARY) FROM EMPLOYEE WHERE DEPARTMENT_ID = E.DEPARTMENT_ID
	)
)


-- Problem 3
  
CREATE TABLE CUSTOMERS (
    ID INT PRIMARY KEY,
    NAME VARCHAR(50)
);


CREATE TABLE ORDERS1 (
    ID INT PRIMARY KEY,
    C_ID INT,
    FOREIGN KEY (C_ID) REFERENCES CUSTOMERS(ID)
);


INSERT INTO CUSTOMERS VALUES (1, 'NIMIT'), (2, 'REHANSH'), (3, 'PRIYA'), (4, 'NAMAN');
INSERT INTO ORDERS1 VALUES (1, 3), (2, 1);

--- Using Joins

select *
from customers c left join orders1 o on c.id = o.c_id
where o.c_id is null;

--- Using NOT EXITS

select *
from customers c
where not exists 
(
	select 1
	from orders1 where c_id = c.id
)



-- Problem 4

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  product_category VARCHAR(100)
);


CREATE TABLE Orders (
  product_id INT,
  order_date DATE,
  unit INT,
  FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Products VALUES 
(1, 'Leetcode Solutions', 'Book'),
(2, 'Jewels of Stringology', 'Book'),
(3, 'HP', 'Laptop'),
(4, 'Lenovo', 'Laptop'),
(5, 'Leetcode Kit', 'T-shirt');

INSERT INTO Orders VALUES 
(1, '2020-02-05', 60), (1, '2020-02-10', 70),
(2, '2020-01-18', 30), (2, '2020-02-11', 80),
(3, '2020-02-17', 2),  (3, '2020-02-24', 3),
(4, '2020-03-01', 20), (4, '2020-03-04', 30), (4, '2020-03-04', 60),
(5, '2020-02-25', 50), (5, '2020-02-27', 50), (5, '2020-03-01', 50);


--- Using Subqueries

select p.product_name,
(
	select sum(o.unit)
	from orders o
	where o.order_date between '2020-02-01' and '2020-02-29'
	group by o.product_id
	having o.product_id = p.product_id 
) as total_units
from products p
where (
	select sum(o.unit)
	from orders o
	where o.order_date between '2020-02-01' and '2020-02-29'
	group by o.product_id
	having o.product_id = p.product_id 
) >= 100


-- Using Joins
  
select p.product_name, sum(o.unit) as total_units
from products p join orders o
on o.product_id = p.product_id
where o.order_date between '2020-02-01' and '2020-02-29'
group by p.product_id
having sum(o.unit) >= 100
