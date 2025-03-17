use TechShop

SELECT * FROM Customers
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM Inventory



--creating db tables
CREATE TABLE Customers(
CustomerID INT IDENTITY PRIMARY KEY,
FirstName VARCHAR(255),
LastName VARCHAR(255),
Email VARCHAR(255) UNIQUE,
Phone varchar(255),
Address varchar(255)
)

CREATE TABLE Products(
ProductID INT IDENTITY PRIMARY KEY,
ProductName VARCHAR(255),
Description VARCHAR(255),
Price decimal(15,4)
)

CREATE TABLE Orders(
OrderID INT IDENTITY PRIMARY KEY,
CustomerID int NOT NULL,
OrderDate DATE,
TotalAmount DECIMAL(15,4),
FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE CASCADE
)

CREATE TABLE OrderDetails(
OrderDetailID INT IDENTITY PRIMARY KEY,
OrderID int NOT NULL,
ProductID INT NOT NULL,
Quantity int,
FOREIGN KEY (OrderID) REFERENCES Orders(OrderId) ON DELETE CASCADE,
FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE CASCADE
)

CREATE TABLE Inventory(
InventoryID INT IDENTITY PRIMARY KEY,
ProductID int NOT NULL,
QuantityInStock int,
LastStockUpdate DATETIME,
FOREIGN KEY (ProductId) REFERENCES Products(ProductId) ON DELETE CASCADE
)

INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('harrish','m','harrish@gmail.com','987654321','chennai'),
('vishal','raj','vishal@gmail.com','8545987456','chennai'),
('rohan','bk','rohan@gmail.com','7893215015','chennai'),
('kishore','kumar','kishore@gmail.com','8620126488','vellore'),
('laavesh','parthiban','laavesh@gmail.com','8855669870','chennai'),
('arun','kumar','arun@gmail.com','8899784590','coimbatore'),
('aswin','as','aswin@gmail.com','8098742361','madurai'),
('aravind','raj','aravind@gmail.com','7598362584','bangalore'),
('ajay','raj','ajay@gmail.com','9944789654','bangalore'),
('herina','a','herina@gmail.com','9988765842','mumbai'),
('harini','e','harini@gmail.com','8823882365','hyderabad'),
('jyshree','s','jyshree@gmail.com','7859405777','coimbatore'),
('k7','s','k7@gmail.com','9585657777','chennai'),
('iys','r','iys@gmail.com','9632587412','kolkatta'),
('walter','white','walter@gmail.com','7658402625','albuquerque'),
('jesse','pinkman','jesse@gmail.com','9603258045','albuquerque')

INSERT INTO Products (ProductName, Description, Price) VALUES
('Laptop', 'alienware gaming laptop', 1200),
('Smartphone', 'samsung s25 ultra model smartphone', 800),
('Tablet', '10-inch screen tablet', 500),
('Headphones', 'Wireless headphones', 150),
('Keyboard', 'Mechanical gaming keyboard', 90),
('Mouse', 'Wireless mouse', 60),
('Monitor', '4K display monitor', 300),
('Smartwatch', 'Fitness tracking smartwatch', 200),
('Camera', 'DSLR camera', 900),
('Printer', 'High-speed printer', 250)

INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2025-03-01 10:00:00', 1200.00),
(2, '2025-03-02 12:30:00', 800.00),
(3, '2025-03-03 15:45:00', 1500.00),
(4, '2025-03-04 09:15:00', 200.00),
(5, '2025-03-05 17:25:00', 300.00),
(6, '2025-03-06 11:10:00', 500.00),
(7, '2025-03-07 14:00:00', 600.00),
(8, '2025-03-08 08:45:00', 1000.00),
(9, '2025-03-09 16:20:00', 250.00),
(10, '2025-03-10 13:10:00', 400.00)

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(1, 1, 1),
(2, 2, 1),
(3, 3, 2),
(3, 4, 1),
(4, 5, 2),
(5, 6, 3),
(6, 7, 1),
(7, 8, 2),
(8, 9, 1),
(9, 10, 1)

INSERT INTO Inventory (ProductID, QuantityInStock, LastStockUpdate) VALUES
(1, 50, '2025-02-25 08:00:00'),
(2, 100, '2025-02-25 08:00:00'),
(3, 75, '2025-02-25 08:00:00'),
(4, 200, '2025-02-25 08:00:00'),
(5, 120, '2025-02-25 08:00:00'),
(6, 150, '2025-02-25 08:00:00'),
(7, 80, '2025-02-25 08:00:00'),
(8, 95, '2025-02-25 08:00:00'),
(9, 30, '2025-02-25 08:00:00'),
(10, 40, '2025-02-25 08:00:00')


DELETE FROM Customers WHERE CustomerID IN (11,12,13,14,15,16)

SELECT * FROM Customers
SELECT * FROM Orders
SELECT * FROM Products
SELECT * FROM Orders
SELECT * FROM OrderDetails
SELECT * FROM Products
SELECT * FROM Inventory

-- 1. Write an SQL query to retrieve the names and emails of all customers.  
select FirstName, Email FROM Customers

--2. Write an SQL query to list all orders with their order dates and corresponding customer names. 
select orders.OrderID, orders.OrderDate, Customers.FirstName
from orders
join Customers on orders.CustomerID=Customers.CustomerID

--3. Write an SQL query to insert a new customer record into the "Customers" table. Include  customer information such as name, email, and address.
insert into Customers (FirstName, LastName, Email, Address) values
('walter','white','walter@gmail.com','145 Albuquerque ')

-- 4. Write an SQL query to update the prices of all electronic gadgets in the "Products" table by increasing them by 10%. 


-- 5. Write an SQL query to delete a specific order and its associated order details from the "Orders" and "OrderDetails" tables. Allow users to input the order ID as a parameter
delete from Orders
where OrderID=10

-- 6. Write an SQL query to insert a new order into the "Orders" table. Include the customer ID, order date, and any other necessary information. 
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(10, '2025-03-17 23:00:00', 2000)

-- 7. Write an SQL query to update the contact information (e.g., email and address) of a specific 
-- customer in the "Customers" table. Allow users to input the customer ID and new contact information. 
update Customers
set email='harrish7@gmail.com', Address='007, chennai'
where CustomerID=1

-- 8. Write an SQL query to recalculate and update the total cost of each order in the "Orders" 
-- table based on the prices and quantities in the "OrderDetails" table.

-- 9. Write an SQL query to delete all orders and their associated order details for a specific 
-- customer from the "Orders" and "OrderDetails" tables. Allow users to input the customer ID as a parameter.

-- 10. Write an SQL query to insert a new electronic gadget product into the "Products" table, 
-- including product name, category, price, and any other relevant details. 
INSERT INTO Products (ProductName, Description, Price)
VALUES ('iphone', '16 series is the latest model', 1499);

-- 11. Write an SQL query to update the status of a specific order in the "Orders" table (e.g., from 
-- "Pending" to "Shipped"). Allow users to input the order ID and the new status. 
alter table orders
add status varchar(255)

alter table Orders
add status varchar(255) default 'Pending';

update Orders
set status='Shipped'
where status is null

-- 12. Write an SQL query to calculate and update the number of orders placed by each customer 
-- in the "Customers" table based on the data in the "Orders" table

